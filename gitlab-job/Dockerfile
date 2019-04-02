FROM docker:stable-git AS release

COPY install_docker-compose.sh /tmp
RUN apk add --quiet --no-progress --no-cache make python3 bash \
    && sh /tmp/install_docker-compose.sh \
    && rm /tmp/install_docker-compose.sh
