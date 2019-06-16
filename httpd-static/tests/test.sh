#!/usr/bin/env bash

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

_cleanup () {
    docker rm -f 7val-static
}

docker run -d --rm --name 7val-static --network test 7val/httpd-static
trap _cleanup ERR EXIT

sleep 1

MY_IP="$(docker inspect 7val-static | jq -r '.[0].NetworkSettings.Networks.test.IPAddress')"
export MY_IP
bats --tap ./tests
