#!/usr/bin/env sh

# Supposed to run under Alpines Busybox SH

INSTALL_DOCKER_COMPOSE_TRACE=1

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

apk add -t d-c-install py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
pip install docker-compose
rm -rf /root/.cache/
apk del d-c-install

# vim: ts=4 sw=4 expandtab ft=sh
