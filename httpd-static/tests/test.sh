#!/usr/bin/env bash

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

_cleanup () {
    docker rm -f avenga-static
}

docker run -d --rm --name avenga-static --network test "avenga/httpd-static:$VERSION"
trap _cleanup ERR EXIT

sleep 1

MY_IP="$(docker inspect avenga-static | jq -r '.[0].NetworkSettings.Networks.test.IPAddress')"
export MY_IP
bats --tap ./tests
