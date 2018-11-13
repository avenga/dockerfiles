#!/bin/bash -eu

VOLUMES=($VOLUME_NAMES)

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
