FROM docker:stable-git AS release

COPY install_docker-compose.sh /tmp
RUN apk add --quiet --no-progress --no-cache make python3 bash curl jq coreutils \
    && sh /tmp/install_docker-compose.sh \
    && rm /tmp/install_docker-compose.sh \
    && sed -i 's|ash$|bash|g' /etc/passwd
