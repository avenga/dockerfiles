FROM docker:stable-git AS release
RUN apk add --quiet --no-progress --no-cache make python3 bash \
    && pip3 -q install docker-compose
