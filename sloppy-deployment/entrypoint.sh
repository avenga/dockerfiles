#!/bin/bash -eu

SLOPPY_OUTPUT_FILE="sloppy.yml"

gomplate -f "/work/${SLOPPY_TEMPLATE_FILE}" \
  -d environment="file:///environments/${ENVIRONMENT}/" \
  -d globals="file:///environments/" \
  -o "${SLOPPY_OUTPUT_FILE}"

if [[ -n "$DRY_RUN" ]]; then
  cat "${SLOPPY_OUTPUT_FILE}"
else
  sloppy change -f $SLOPPY_OUTPUT_FILE
fi
