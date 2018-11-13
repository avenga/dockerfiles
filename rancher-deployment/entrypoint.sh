#!/bin/bash -eu

DOCKER_COMPOSE_OUTPUT_FILE="./docker-compose.yml"
RANCHER_COMPOSE_OUTPUT_FILE="./rancher-compose.yml"

STACK="${ENVIRONMENT}"

gomplate -f "/work/${DOCKER_COMPOSE_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${DOCKER_COMPOSE_OUTPUT_FILE}"

gomplate -f "/work/${RANCHER_COMPOSE_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${RANCHER_COMPOSE_OUTPUT_FILE}"

if [[ -n "$DRY_RUN" ]]; then
  cat "${DOCKER_COMPOSE_OUTPUT_FILE}"
  cat "${RANCHER_COMPOSE_OUTPUT_FILE}"
else
  if [[ -n "$SETUP_VOLUMES" ]]; then
    . ./setup-volumes.sh
  fi
  echo "Upgrading $ENVIRONMENT ..."
  rancher up -f "${DOCKER_COMPOSE_OUTPUT_FILE}" --rancher-file "${RANCHER_COMPOSE_OUTPUT_FILE}" --upgrade --pull -d --force-upgrade --stack "$STACK"
  rancher --wait-state upgraded wait
  rancher --wait-state healthy wait

  echo "Confirming upgrade for $ENVIRONMENT ..."
  rancher up -f "${DOCKER_COMPOSE_OUTPUT_FILE}" --rancher-file "${RANCHER_COMPOSE_OUTPUT_FILE}" --confirm-upgrade -d --stack "$STACK"
  rancher --wait-state active wait
  rancher --wait-state healthy wait
fi
