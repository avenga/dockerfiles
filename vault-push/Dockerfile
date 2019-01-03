ARG VAULT_IMAGE_TAG="1.0.1"
FROM vault:${VAULT_IMAGE_TAG} AS release
ENV PROJECT=""
ENV VAULT_SECRETS_PATH="projects"
ENV SECRETS_FILE="secrets.env"
WORKDIR /work
RUN apk --no-cache add bash
COPY entrypoint.sh ./
RUN vault --version
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
