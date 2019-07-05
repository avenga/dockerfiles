#!/usr/bin/env bash

SETUP_VOLUMES_TRACE="${SETUP_VOLUMES_TRACE:-}"
# optionally set trace mode
[[ -n "$SETUP_VOLUMES_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# VOLUME_NAMES is a normal variable with space-separated values
# shellcheck disable=SC2153
VOLUMES="$( echo "$VOLUME_NAMES" | tr ' ' '\n' )"
VOLUME_PREFIX="${VOLUME_PREFIX:-}" # optional; default is empty

echo "Try to set up rancher volumes: ${VOLUME_NAMES}"
for VOLUME in $VOLUMES; do
  VOLUME_NAME="${VOLUME_PREFIX}${ENVIRONMENT}-${VOLUME}"
  if [[ -n "$DRY_RUN" ]]; then
    vol="${VOLUME_PREFIX}${ENVIRONMENT}-${TEST_VOLUME_NAME}-rancher-nfs"
    echo "DRY RUN: Test if '${VOLUME}' matches '${TEST_VOLUME_NAME}'."
  else
    echo "Check if volume ${VOLUME_NAME} exists ..."
    vol="$( rancher volume -a --format '{{.Volume.Name}}-{{.Volume.Driver}}' )"
  fi
  if [[ $vol =~  ${VOLUME_NAME}-rancher-nfs ]]
  then
    echo "Volume ${VOLUME_NAME} already exists."
  else
    if [[ -n "$DRY_RUN" ]]; then
      echo "DRY RUN: Would create Volume ${VOLUME_NAME}."
    else
      echo "Create volume ${VOLUME_NAME} ..."
      rancher volume create --driver rancher-nfs "${VOLUME_NAME}"
      echo "Volume ${VOLUME_NAME} created."
    fi
  fi
done
