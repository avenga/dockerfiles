FROM alpine:3.9 AS release
# Set to anything but not empty to just output the generated Makefile:
ENV DRY_RUN=""

##
# Mandatory
##
ENV PROJECT=""

##
# Defaults
##
ENV DEFAULT_ENVIRONMENT="development"
ENV DEFAULT_DOCKER_REGISTRY="registry.office.sevenval.de"
ENV DEFAULT_SERVICE="backend"

WORKDIR /work
RUN apk add --no-cache bash
COPY --from=hairyhenderson/gomplate:v2.6.0-alpine /bin/gomplate /bin/gomplate
COPY entrypoint.sh Makefile.tmpl ./
ENTRYPOINT ["/bin/bash", "/work/entrypoint.sh"]
VOLUME /project
