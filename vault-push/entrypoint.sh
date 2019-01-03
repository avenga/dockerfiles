#!/bin/bash -eu

ENVIRONMENTS_PATH=/environments
ENVIRONMENTS=$(find $ENVIRONMENTS_PATH/* -type d -maxdepth 1 -print0 | xargs -0 -n 1 basename)

vault secrets enable -version=1 -path=$VAULT_SECRETS_PATH kv || true

for ENVIRONMENT in ${ENVIRONMENTS}
do
  PAIRS=()
  while IFS= read -r LINE; do PAIRS+=($LINE); done < "${ENVIRONMENTS_PATH}/${ENVIRONMENT}/${SECRETS_FILE}"
  vault write "$VAULT_SECRETS_PATH/$PROJECT/environments/$ENVIRONMENT" "${PAIRS[@]}"
done
