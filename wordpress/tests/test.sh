#!/usr/bin/env bash

# optionally set trace mode
[[ "$INSERT_PROGNAME_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
### define/initialize script wide variables

PROGNAME="${0##*/}"

################################################################################
### functions
# when echoing use "${FUNCNAME[0]}: message"

# echo to STDERR
function _err_echo () {
    local msg
    msg="$*"
    echo "$PROGNAME: $msg" >&2
}
# echo to STDERR and exit
function _bail () {
    local message
    message="$*"
    _err_echo "$message"
    exit 2
}

### main script

_cleanup () {
    docker-compose down -v --remove-orphans
}

docker-compose up -d --build --force-recreate

# TODO add clean trap here
trap _cleanup ERR EXIT

sleep 20
MY_IP="$(docker inspect avenga-wp | jq -r '.[0].NetworkSettings.Networks.test.IPAddress')"
export MY_IP
bats --tap ./tests

# vim: ts=4 sw=4 expandtab ft=sh
