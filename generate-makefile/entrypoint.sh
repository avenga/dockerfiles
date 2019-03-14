#!/bin/bash

set -euo pipefail

TEMPLATE_FILE="/work/Makefile.tmpl"
OUTPUT_FILE="/project/Makefile"

if [[ -n "$DRY_RUN" ]]; then
  gomplate -f "${TEMPLATE_FILE}"
else
  # Do not overwrite existing Makefile:
  if [[ -e ${OUTPUT_FILE} ]]
  then
    echo "Error: Makefile already exists."
    exit 1
  else
    gomplate -f "${TEMPLATE_FILE}" -o "${OUTPUT_FILE}"
  fi
fi
