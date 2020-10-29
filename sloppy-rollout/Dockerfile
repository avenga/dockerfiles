ARG IMAGE_PREFIX="avenga/"
ARG VERSION="latest"
FROM ${IMAGE_PREFIX}sloppy:${VERSION} AS release
ENV SLOPPY_APITOKEN=""
# If templating is used, files from this environment are used.
ENV TEMPLATE_ENVIRONMENT=""
# set to anything but not empty to just output the generated sloppy.yml
ENV DRY_RUN=""
# If set templating isn't done
ENV SLOPPY_MODE=""
# entrypoint.sh will check for datasources in this mounted volume
VOLUME /environments
WORKDIR /work
RUN apk add --no-cache --quiet --no-progress bash
COPY --from=hairyhenderson/gomplate:v3.5.0-alpine /bin/gomplate /bin/gomplate
COPY entrypoint.sh ./
ENTRYPOINT ["/bin/bash", "/work/entrypoint.sh"]

