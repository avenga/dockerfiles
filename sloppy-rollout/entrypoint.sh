#!/usr/bin/env bash

[[ "$SLOPPY_ROLLOUT_TRACE" ]] && set -x

set -euo pipefail
IFS=$'\n\t'

# set default empty
DRY_RUN="${DRY_RUN:-}"
# In which mode should we run.
SLOPPY_MODE="${SLOPPY_MODE}"
# Name of the Sloppy configuration file which is used by sloppy change
SLOPPY_CONFIG_FILE="${SLOPPY_CONFIG_FILE}"
# Name of the directory (which should be a host volume) to where a copy of
# $SLOPPY_OUTPUT_FILE is saved.
SLOPPY_SAVE_OUTPUT_DIR="${SLOPPY_SAVE_OUTPUT_DIR:-}"

if [[ $SLOPPY_MODE == "file" ]] ; then
  SLOPPY_OUTPUT_FILE="$SLOPPY_CONFIG_FILE"
elif [[ $SLOPPY_MODE == "template" ]] ; then
  SLOPPY_OUTPUT_FILE="sloppy.yml"
  gomplate -f "/work/${SLOPPY_CONFIG_FILE}" \
    -d environment="file:///environments/${TEMPLATE_ENVIRONMENT}/" \
    -d globals="file:///environments/" \
    -o "${SLOPPY_OUTPUT_FILE}"
else
  echo "Unknown mode $SLOPPY_MODE" >&2
  exit 1
fi

# If wished, save Sloppy config.
if [[ $SLOPPY_SAVE_OUTPUT_DIR ]] ; then
  cp "$SLOPPY_OUTPUT_FILE" "$SLOPPY_SAVE_OUTPUT_DIR"
fi

if [[ -n "$DRY_RUN" ]]; then
  cat "${SLOPPY_OUTPUT_FILE}"
else
  sloppy change -f "$SLOPPY_OUTPUT_FILE"
fi
