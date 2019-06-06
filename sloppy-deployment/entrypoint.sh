#!/bin/bash -eu

# Name of the Sloppy YAML configuration file
SLOPPY_OUTPUT_FILE="sloppy.yml"
# Name of the directory (which should be host volume) to where a copy of
# $SLOPPY_OUTPUT_FILE is saved.
SLOPPY_SAFE_OUTPUT_DIR="${SLOPPY_SAFE_OUTPUT_DIR:-}"

function cp_sloppy_yml () {
  if [[ $SLOPPY_SAFE_OUTPUT_DIR ]] ; then
     cp "$SLOPPY_OUTPUT_FILE" "$SLOPPY_SAFE_OUTPUT_DIR"
  fi
}

gomplate -f "/work/${SLOPPY_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${SLOPPY_OUTPUT_FILE}"

if [[ -n "$DRY_RUN" ]]; then
  cat "${SLOPPY_OUTPUT_FILE}"
  cp_sloppy_yml
else
  sloppy change -f $SLOPPY_OUTPUT_FILE
  cp_sloppy_yml
fi
