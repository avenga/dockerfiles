#!/usr/bin/env bash

# optionally set trace mode
[[ "$RANCHER2_DEPLOYMENT_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
### define/initialize script wide variables

PROGNAME="${0##*/}"
OUTPUT_FILE="./deployment.yml"
# Make a dry run:
DRY_RUN="${DRY_RUN:-}"
RANCHER_PROJECT="${RANCHER_PROJECT:-$PROJECT}"
# Use $PROJECT as prefix to have unique namespaces inside Rancher2:
RANCHER_NAMESPACE="$(echo "${RANCHER_PROJECT}-${ENVIRONMENT}" | tr '[:upper:]' '[:lower:]')"
# Name of the directory (should be a host volume) to where a copy of
# $OUTPUT_FILE is saved.
RANCHER_SAVE_OUTPUT_DIR="${RANCHER_SAVE_OUTPUT_DIR:-}"

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

echo "Deploy ${RANCHER_PROJECT} to ${RANCHER_NAMESPACE}"

gomplate -f "/work/${DEPLOYMENT_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${OUTPUT_FILE}"

if [[ -n $RANCHER_SAVE_OUTPUT_DIR ]] ; then
  cp "$OUTPUT_FILE" "$RANCHER_SAVE_OUTPUT_DIR"
fi

if [[ -n "$DRY_RUN" ]]; then
    cat "${OUTPUT_FILE}"
else
    # TODO: make context configurable:
    rancher login "$RANCHER_SERVER_URL" --token "$RANCHER_BEARER_TOKEN" --context "c-p8799:p-7xmzd"

    if rancher projects ls --format '{{.Project.Name}}' | grep -q "^${RANCHER_PROJECT}$" ; then
        echo "Project $RANCHER_PROJECT already exists."
    else
        rancher projects create "$RANCHER_PROJECT"
    fi
    rancher context switch "$RANCHER_PROJECT"
    if rancher namespace ls --format '{{.Namespace.Name}}' | grep -q "^${RANCHER_NAMESPACE}$" ; then
        echo "Namespace $RANCHER_NAMESPACE already exists."
    else
        rancher namespace create "$RANCHER_NAMESPACE"
    fi
    rancher kubectl apply --namespace "${RANCHER_NAMESPACE}" -f "${OUTPUT_FILE}"
fi

# vim: ts=4 sw=4 expandtab ft=sh
