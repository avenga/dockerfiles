#!/bin/bash -eu

[[ "$RANCHER_DEPLOYMENT_TRACE" ]] && set -x

DOCKER_COMPOSE_OUTPUT_FILE="./docker-compose.yml"
RANCHER_COMPOSE_OUTPUT_FILE="./rancher-compose.yml"

# Should we make a dry run
DRY_RUN="${DRY_RUN:-}"
# Should we setup any volumes
SETUP_VOLUMES="${SETUP_VOLUMES:-}"
# Name of the directory (should be a host volume) to where a copy of
# $DOCKER_COMPOSE_OUTPUT_FILE and RANCHER_COMPOSE_OUTPUT_FILE is saved.
RANCHER_SAVE_OUTPUT_DIR="${RANCHER_SAVE_OUTPUT_DIR:-}"

STACK="${ENVIRONMENT}"

gomplate -f "/work/${DOCKER_COMPOSE_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${DOCKER_COMPOSE_OUTPUT_FILE}"

gomplate -f "/work/${RANCHER_COMPOSE_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${RANCHER_COMPOSE_OUTPUT_FILE}"

if [[ -n $RANCHER_SAVE_OUTPUT_DIR ]] ; then
  cp "$DOCKER_COMPOSE_OUTPUT_FILE" "$RANCHER_SAVE_OUTPUT_DIR"
  cp "$RANCHER_COMPOSE_OUTPUT_FILE" "$RANCHER_SAVE_OUTPUT_DIR"
fi

if [[ -n "$SETUP_VOLUMES" ]]; then
    # shellcheck disable=SC1091
    . ./setup-volumes.sh
fi

if [[ -n "$DRY_RUN" ]]; then
  cat "${DOCKER_COMPOSE_OUTPUT_FILE}"
  echo "---" # signal the start of another document
  cat "${RANCHER_COMPOSE_OUTPUT_FILE}"
else
  echo "Upgrading $ENVIRONMENT ..."
  rancher up -f "${DOCKER_COMPOSE_OUTPUT_FILE}" --rancher-file "${RANCHER_COMPOSE_OUTPUT_FILE}" --upgrade --pull -d --force-upgrade --stack "$STACK" "$SERVICE"
  rancher --wait-state upgraded wait
  rancher --wait-state healthy wait

  echo "Confirming upgrade for $ENVIRONMENT ..."
  rancher up -f "${DOCKER_COMPOSE_OUTPUT_FILE}" --rancher-file "${RANCHER_COMPOSE_OUTPUT_FILE}" --confirm-upgrade -d --stack "$STACK" "$SERVICE"
  rancher --wait-state active wait
  rancher --wait-state healthy wait
fi
