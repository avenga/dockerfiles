#!/bin/bash -eu

SLOPPY_OUTPUT_FILE="sloppy.yml"
SLOPPY_SAFE_OUTPUT="${SLOPPY_SAVE_OUTPUT:-}"

function cp_sloppy_yml () {
  if [[ $SLOPPY_SAFE_OUTPUT ]] ; then
     cp "$SLOPPY_OUTPUT_FILE" "$SLOPPY_SAFE_OUTPUT"
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
