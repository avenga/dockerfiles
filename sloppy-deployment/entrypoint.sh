#!/bin/bash -eu

SLOPPY_OUTPUT_FILE="sloppy.yml"
safe_yaml="${SLOPPY_SAVE_SLOPPY_YAML:-}"

function cp_sloppy_yml () {
  if [[ $safe_yaml ]] ; then
     cp "$SLOPPY_OUTPUT_FILE" "$safe_yaml"
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
