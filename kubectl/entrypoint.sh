#!/usr/bin/env bash

# When set trace mode is activated. See `help set` in Bash.
[[ "$KUBECTL_ENTRYPOINT_TRACE" ]] && set -x

# Bash Strict Mode
# - Exit immediately if a command exits with a non-zero status.
# - fails if a command fails at any part of a pipeline
# - Treat unset variables as an error when substituting.
# - IFS: word splitting is done by <newline> and <tab>, WITHOUT <space>.
# For more details s. `help set`, `man bash | less -p '   IFS '` and
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
### define/initialize script wide variables

PROGNAME="${0##*/}"
CONFIGURE_KUBECTL="${CONFIGURE_KUBECTL:-true}"
if [[ $CONFIGURE_KUBECTL == true ]] ; then
    KUBECTL_CLUSTER_URL="$KUBECTL_CLUSTER_URL"
    KUBECTL_TOKEN="$KUBECTL_TOKEN"
    KUBECTL_NAMESPACE="$KUBECTL_NAMESPACE"
    KUBECTL_CLUSTER_NAME="$KUBECTL_CLUSTER_NAME"
fi

################################################################################
### functions
# when echoing from functions use "${FUNCNAME[0]}: message"

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
# Configure kubectl
function kubectl_config () {
    kubectl config set-cluster "$KUBECTL_CLUSTER_NAME" "--server=$KUBECTL_CLUSTER_URL"
    kubectl config set-credentials "$KUBECTL_CLUSTER_NAME" "--token=$KUBECTL_TOKEN"
    kubectl config set-context \
        "$KUBECTL_CLUSTER_NAME" \
        "--cluster=$KUBECTL_CLUSTER_NAME" \
        "--user=$KUBECTL_CLUSTER_NAME" \
        "--namespace=$KUBECTL_NAMESPACE"
    kubectl config use-context "$KUBECTL_CLUSTER_NAME"

}
### main script

# run only when CONFIGURE_KUBECTL is set to true
if [[ $CONFIGURE_KUBECTL == true ]] ; then
    # print version
    kubectl version --client
    kubectl_config
fi
kubectl "$@"

# vim: ts=4 sw=4 expandtab ft=sh

