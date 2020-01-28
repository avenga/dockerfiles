#!/usr/bin/env bash

# When set trace mode is activated. See `help set` in Bash.
[[ "$RANCHER2_DEPLOYMENT_TRACE" ]] && set -x

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

# This programs name without any leading slashes (i.e same as basename).
PROGNAME="${0##*/}"
# Name of the resulting K8s YAML file which gomplate will create.
OUTPUT_FILE="./deployment.yml"
# If set, make a dry run
DRY_RUN="${DRY_RUN:-}"
# No Rancher login and do not fetch pod infos:
NO_LOGIN="${NO_LOGIN:-}"
# Define the Rancher2 project name. When not set the value of PROJECT is used.
RANCHER_PROJECT="${RANCHER_PROJECT:-$PROJECT}"
# Use RANCHER_PROJECT as prefix and ENVIRONMENT as suffix to have unique
# namespaces inside Rancher2
RANCHER_NAMESPACE="$(echo "${RANCHER_PROJECT}-${ENVIRONMENT}" | tr '[:upper:]' '[:lower:]')"
# Name of the directory (should be a host volume) to where a copy of
# $OUTPUT_FILE is saved. The copy/backup is only done when this variable is set.
RANCHER_SAVE_OUTPUT_DIR="${RANCHER_SAVE_OUTPUT_DIR:-}"
# When set it turns off printing the difference between new and current
# configuration to STDOUT.
RANCHER_NO_DIFF="${RANCHER_NO_DIFF:-}"

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

### main script

echo "Deploy ${RANCHER_PROJECT} to ${RANCHER_NAMESPACE}"

echo "Create ${CI_PROJECT_DIR}/environments/${ENVIRONMENT} if not present"
mkdir -p "${CI_PROJECT_DIR}/environments/${ENVIRONMENT}"

if [[ -z $NO_LOGIN ]] ; then
    rancher login "${RANCHER_SERVER_URL}" --token "${RANCHER_BEARER_TOKEN}" --context "${RANCHER_CONTEXT}"

    rancher context switch "${RANCHER_CONTEXT}"

    echo "Check if namespace ${RANCHER_NAMESPACE} exists..."
    set +e
    rancher kubectl get namespace "${RANCHER_NAMESPACE}"
    set -e

    # Check if last command was successful:
    if [[ $? -eq 0 ]] ; then
        echo "Namespace ${RANCHER_NAMESPACE} already exists."
    else
        rancher namespace create "${RANCHER_NAMESPACE}"
    fi

    # Save the current k8s containers of the namespace and their docker image names to local file system.
    # This file could then processed in the project-specific template file to deploy only specific changes.
    rancher kubectl get pods --namespace "${RANCHER_NAMESPACE}" \
        -o go-template \
        --template='{{range .items}}{{range .spec.containers}}{{printf "%s: %s\n" .name .image}}{{end}}{{end}}' > "${CI_PROJECT_DIR}/environments/${ENVIRONMENT}/services.yml"
fi

# Generate a k8s yml file to describe a project's k8s resources.
gomplate -f "/work/${DEPLOYMENT_TEMPLATE_FILE}" \
  -d environment="file://${CI_PROJECT_DIR}/environments/${ENVIRONMENT}/" \
  -d globals="file://${CI_PROJECT_DIR}/environments/" \
  -o "${OUTPUT_FILE}"

# Save generated k8s yml file to a specific directory:
if [[ -n $RANCHER_SAVE_OUTPUT_DIR ]] ; then
  cp "$OUTPUT_FILE" "$RANCHER_SAVE_OUTPUT_DIR"
fi

# Show diff between current and new configuration. Fails if the configuration
# contains syntax or logical errors.
if [[ -z "$RANCHER_NO_DIFF" ]] ; then
    # Turn off exiting when a command fails, since if there is a diff found
    # kubectl diff will exit non-zero.
    set +e
    rancher kubectl diff --namespace "${RANCHER_NAMESPACE}" -f "${OUTPUT_FILE}"
    set -e
fi

if [[ -n "$DRY_RUN" ]]; then
    # No kubectl apply is executed. Instead send generated k8s yml file to
    # STDOUT
    cat "${OUTPUT_FILE}"
else
    rancher kubectl apply --namespace "${RANCHER_NAMESPACE}" -f "${OUTPUT_FILE}"
fi

# vim: ts=4 sw=4 expandtab ft=sh
