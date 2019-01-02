ARG VAULT_IMAGE_TAG="1.0.1"
FROM vault:${VAULT_IMAGE_TAG} AS release
ENV PROJECT=""
ENV VAULT_SECRETS_PATH="projects"
ENV SECRETS_FILE="secrets.env"
WORKDIR /work
RUN apk --no-cache add bash jq
COPY --from=hairyhenderson/gomplate:v2.6.0-alpine /bin/gomplate /bin/gomplate
COPY entrypoint.sh ./
COPY secrets.tmpl.env ./
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
