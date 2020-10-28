ARG IMAGE_PREFIX="avenga/"
ARG VERSION="latest"
FROM ${IMAGE_PREFIX}docker:${VERSION} AS release
RUN apk --quiet --no-progress --no-cache add make coreutils curl jq docker-compose \
    && sed -i 's|ash$|bash|g' /etc/passwd
RUN docker-compose --version