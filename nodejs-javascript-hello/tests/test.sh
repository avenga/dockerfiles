#!/usr/bin/env bash

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

_cleanup () {
    docker-compose down -v --remove-orphans
}

trap _cleanup ERR EXIT

bats --tap tests/
