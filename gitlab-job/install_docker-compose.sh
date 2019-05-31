#!/usr/bin/env sh

# Supposed to run under Alpines Busybox SH

INSTALL_DOCKER_COMPOSE_TRACE=1

# optionally set trace mode
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

if [[ ! -f /.dockerenv ]] ; then
    _bail "Not running inside a Docker container"
fi

# Ugly but fast hack to get docker-compose running under Alpine
apk add --quiet --no-cache --no-progress curl
curl -s https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest \
    | grep -E '^[ ]*"browser_download_url": "https://.*/glibc-[^-]+-r\d\.apk"$' \
    | cut -d '"' -f 4 \
    | xargs curl -sL -o /tmp/glibc.apk
curl -s https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest \
    | grep -E '^[ ]*"browser_download_url": "https://.*/glibc-bin-[^-]+-r\d\.apk"$' \
    | cut -d '"' -f 4 \
    | xargs curl -sL -o /tmp/glibc-bin.apk
apk add --quiet --no-progress --allow-untrusted --no-cache \
    /tmp/glibc.apk /tmp/glibc-bin.apk
rm /tmp/glibc*.apk
curl -s https://api.github.com/repos/docker/compose/releases/latest \
    | grep -E '^[ ]*"browser_download_url": "https://.*Linux-x86_64"$' \
    | cut -d '"' -f 4 \
    | xargs curl -sL -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


# vim: ts=4 sw=4 expandtab ft=sh
