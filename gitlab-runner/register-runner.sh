#!/usr/bin/env bash

# gitlab-runner data directory
DATA_DIR="/etc/gitlab-runner"
CACHE_DIR="/cache"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
HOSTNAME=${HOSTNAME:-gitlab-runner}
# Default RUNNER_NAME=HOSTNAME
RUNNER_NAME=${RUNNER_NAME:-$HOSTNAME}

gitlab-runner verify --name "${RUNNER_NAME}"
UNVERIFIED=$?
if [[ $UNVERIFIED -eq 0 ]]; then
  echo "Runner already registered."
else
  echo "Delete unverified runners from config file."
  gitlab-runner verify --delete --name "${RUNNER_NAME}"
  echo "Unregister runner."
  gitlab-runner unregister --name "${RUNNER_NAME}"
  gitlab-runner register --non-interactive \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-volumes "${CACHE_DIR}"
fi

# launch gitlab-runner passing all arguments
exec gitlab-runner "$@"
