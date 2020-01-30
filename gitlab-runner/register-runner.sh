#!/usr/bin/env bash

# gitlab-runner data directory
DATA_DIR="/etc/gitlab-runner"
CACHE_DIR="/cache"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
HOSTNAME=${HOSTNAME:-gitlab-runner}
# Default RUNNER_NAME=HOSTNAME
RUNNER_NAME=${RUNNER_NAME:-$HOSTNAME}

# Unregister the runner
function _unregister () {
    local name="$1"
    gitlab-runner unregister --name "$name"
}

gitlab-runner verify --name "${RUNNER_NAME}"
UNVERIFIED=$?
if [[ $UNVERIFIED -eq 0 ]]; then
  echo "Runner already registered."
else
  echo "Delete unverified runners from config file."
  gitlab-runner verify --delete --name "${RUNNER_NAME}"
  echo "Unregister runner."
  _unregister "$RUNNER_NAME"
  gitlab-runner register --non-interactive \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-volumes "${CACHE_DIR}"
fi

# gitlab-runner is stopped by SIGQUIT. Thus we catch that signal and unregister
# the runner. That way there are no stale runners in Gitlab.
trap '_unregister "$RUNNER_NAME"' SIGQUIT

# Launch gitlab-runner passing all arguments. Since this script runs under
# dumb-unit the runner doesn't have to run via "exec". Thus we can use above
# "trap" command.
gitlab-runner "$@"
