#!/usr/bin/env bash

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

docker-compose build test

trap 'docker-compose down -v --remove-orphans' ERR EXIT
bats --tap tests/