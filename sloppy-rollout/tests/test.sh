#!/usr/bin/env bash

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

function _trap () {
    set +u
    run="${run:-}"
    set -u
    if [[ -z $run ]] ; then
        run=1
        docker-compose down -v --remove-orphans
        rm -f tests/tmp/*
    fi
}
docker-compose build template-test
trap '_trap' ERR EXIT
bats --tap tests/
