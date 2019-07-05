#!/usr/bin/env bash

[[ "$SLOPPY_DEPLOYMENT_TRACE" ]] && set -x

### FIXME needs to be thoroughly tested before activated
#set -euo pipefail
#IFS=$'\n\t'

# Name of the Sloppy YAML configuration file
SLOPPY_OUTPUT_FILE="sloppy.yml"
# Name of the directory (which should be host volume) to where a copy of
# $SLOPPY_OUTPUT_FILE is saved.
SLOPPY_SAVE_OUTPUT_DIR="${SLOPPY_SAVE_OUTPUT_DIR:-}"

gomplate -f "/work/${SLOPPY_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${SLOPPY_OUTPUT_FILE}"

if [[ $SLOPPY_SAVE_OUTPUT_DIR ]] ; then
  cp "$SLOPPY_OUTPUT_FILE" "$SLOPPY_SAVE_OUTPUT_DIR"
fi

if [[ -n "$DRY_RUN" ]]; then
  cat "${SLOPPY_OUTPUT_FILE}"
else
  sloppy change -f $SLOPPY_OUTPUT_FILE
fi
