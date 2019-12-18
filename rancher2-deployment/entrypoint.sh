#!/usr/bin/env bash

# optionally set trace mode
[[ "$RANCHER2_DEPLOYMENT_TRACE" ]] && set -x

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
    return 2
}

### main script


rancher login "$RANCHER_SERVER_URL" --token "$RANCHER_BEARER_TOKEN"
rancher context switch "$RANCHER_PROJECT"

RANCHER_NAMESPACE="$(echo "$RANCHER_PROJECT" | tr '[:upper:]' '[:lower:]')"
if rancher namespace ls --format '{{.Namespace.Name}}' | grep -q "^${RANCHER_NAMESPACE}$" ; then
    echo "Namespace $RANCHER_NAMESPACE already exists."
else
    rancher namespace create "$RANCHER_NAMESPACE"
fi

rancher kubectl apply --namespace "$RANCHER_NAMESPACE" -f ./deployment.yml

# vim: ts=4 sw=4 expandtab ft=sh
