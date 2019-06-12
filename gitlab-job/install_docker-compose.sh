#!/usr/bin/env sh

# Supposed to run under Alpines Busybox SH

# optionally set trace mode
# shellcheck disable=SC2039
[[ "$INSTALL_DOCKER_COMPOSE_TRACE" ]] && set -x

# Sort'a strict mode
set -euo pipefail

###############################################################################
### define/initialize script wide variables

PROGNAME="${0##*/}"

################################################################################
### functions
# when echoing use "${FUNCNAME[0]}: message"

# echo to STDERR
_err_echo () {
    msg="$*"
    echo "$PROGNAME: $msg" >&2
}
# echo to STDERR and exit
_bail () {
    message="$*"
    _err_echo "$message"
    exit 2
}

### main script

# shellcheck disable=SC2039
if [[ ! -f /.dockerenv ]] ; then
    _bail "Not running inside a Docker container"
fi

apk add --quiet --no-progress --no-cache -t d-c-install python3-dev libffi-dev \
    openssl-dev gcc libc-dev make
pip3 -qqq --no-cache-dir install docker-compose
apk del d-c-install

# vim: ts=4 sw=4 expandtab ft=sh
