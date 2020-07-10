FROM avenga/sloppy:1.13.1 as release
ARG SLOPPY_TEMPLATE_FILE="sloppy.tmpl.yml"
ENV SLOPPY_TEMPLATE_FILE=${SLOPPY_TEMPLATE_FILE}
ENV SLOPPY_APITOKEN=""
ENV ENVIRONMENT=""
# set to anything but not empty to just output the generated sloppy.yml
ENV DRY_RUN=""
# entrypoint.sh will check for datasources in this mounted volume
VOLUME /environments
WORKDIR /work
RUN apk add --no-cache bash
COPY --from=hairyhenderson/gomplate:v3.5.0-alpine /bin/gomplate /bin/gomplate
COPY entrypoint.sh ./
ENTRYPOINT ["/bin/bash", "/work/entrypoint.sh"]
ONBUILD COPY ${SLOPPY_TEMPLATE_FILE} ./
