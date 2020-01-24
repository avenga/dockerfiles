#!/usr/bin/env bash

# When set trace mode is activated. See `help set` in Bash.
[[ "$RANCHER2_DEPLOYMENT_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
### define/initialize script wide variables

PROGNAME="${0##*/}"
OUTPUT_FILE="./deployment.yml"
# Make a dry run
DRY_RUN="${DRY_RUN:-}"
RANCHER_PROJECT="${RANCHER_PROJECT:-$PROJECT}"
# Use $PROJECT as prefix to have unique namespaces inside Rancher2:
RANCHER_NAMESPACE="$(echo "${RANCHER_PROJECT}-${ENVIRONMENT}" | tr '[:upper:]' '[:lower:]')"
# Name of the directory (should be a host volume) to where a copy of
# $OUTPUT_FILE is saved.
RANCHER_SAVE_OUTPUT_DIR="${RANCHER_SAVE_OUTPUT_DIR:-}"
# When set it turns off printing the difference between new and current
# configuration to STDOUT.
RANCHER_NO_DIFF="${RANCHER_NO_DIFF:-}"

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
mkdir -p "/environments/${ENVIRONMENT}"

if [[ -z $DRY_RUN ]] ; then
    rancher login "$RANCHER_SERVER_URL" --token "$RANCHER_BEARER_TOKEN" --context "$RANCHER_CONTEXT"

    rancher context switch "$RANCHER_CONTEXT"

    if rancher namespace ls --format '{{.Namespace.Name}}' | grep -q "^${RANCHER_NAMESPACE}$" ; then
        echo "Namespace $RANCHER_NAMESPACE already exists."
    else
        rancher namespace create "$RANCHER_NAMESPACE"
    fi

    # Save the current k8s containers of the namespace and their docker image names to local file system.
    # This file could then processed in the project-specific template file to deploy only specific changes.
    rancher kubectl get pods --namespace "${RANCHER_NAMESPACE}" \
        -o go-template \
        --template='{{range .items}}{{range .spec.containers}}{{printf "%s: %s\n" .name .image}}{{end}}{{end}}' > "/environments/${ENVIRONMENT}/services.yml"
fi

# Generate a k8s yml file to describe a project's k8s resources.
gomplate -f "/work/${DEPLOYMENT_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
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
