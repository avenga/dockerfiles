ARG RANCHER_CLI_VERSION=v0.6.9
FROM rancher/cli:${RANCHER_CLI_VERSION} AS release
ARG DOCKER_COMPOSE_TEMPLATE_FILE="docker-compose.tmpl.yml"
ARG RANCHER_COMPOSE_TEMPLATE_FILE="rancher-compose.tmpl.yml"

# Used as rancher stack name
ENV ENVIRONMENT=""
ENV RANCHER_URL=""
ENV RANCHER_ENVIRONMENT=""
ENV RANCHER_ACCESS_KEY=""
ENV RANCHER_SECRET_KEY=""

# set to anything but not empty to just output the generated files
ENV DRY_RUN=""
ENV DOCKER_COMPOSE_TEMPLATE_FILE=${DOCKER_COMPOSE_TEMPLATE_FILE}
ENV RANCHER_COMPOSE_TEMPLATE_FILE=${RANCHER_COMPOSE_TEMPLATE_FILE}
# set to anything but not empty to setup volumes
ENV SETUP_VOLUMES=""

VOLUME /environments
WORKDIR /work
RUN apk add --no-cache bash
COPY --from=hairyhenderson/gomplate:v2.6.0-alpine /bin/gomplate /bin/gomplate
COPY entrypoint.sh setup-volumes.sh ./
ENTRYPOINT ["/bin/bash", "/work/entrypoint.sh"]
ONBUILD COPY ${DOCKER_COMPOSE_TEMPLATE_FILE} ./
ONBUILD COPY ${RANCHER_COMPOSE_TEMPLATE_FILE} ./
