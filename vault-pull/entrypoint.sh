#!/usr/bin/env bash
set -eu

ENVIRONMENTS=$(vault list -format=json "$VAULT_SECRETS_PATH/$PROJECT/environments" | jq -r 'join(",")')

for ENVIRONMENT in ${ENVIRONMENTS//,/ }
do
  mkdir -p "/environments/${ENVIRONMENT}"
  gomplate -f "/work/secrets.tmpl.env" \
    -d secrets="vault:///$VAULT_SECRETS_PATH/$PROJECT/environments/$ENVIRONMENT" \
    -o "/environments/${ENVIRONMENT}/secrets.env"
done
