#!/usr/bin/env bash

# optionally set trace mode
[[ "$SETUP_VOLUMES_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

declare -a VOLUMES
VOLUMES=("${VOLUME_NAMES[@]}")

for VOLUME in "${VOLUMES[@]}"; do
  VOLUME_NAME="${VOLUME_PREFIX}${ENVIRONMENT}-${VOLUME}"
  if rancher volume -a --format '{{.Volume.Name}}-{{.Volume.Driver}}' | grep -Fxqs "${VOLUME_NAME}-rancher-nfs"
  then
    echo "Volume ${VOLUME_NAME} already exists."
  else
    echo "Create volume ${VOLUME_NAME} ..."
    rancher volume create --driver rancher-nfs "${VOLUME_NAME}"
  fi
done
