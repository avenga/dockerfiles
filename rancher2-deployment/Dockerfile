FROM rancher/cli2 AS release

COPY --from=hairyhenderson/gomplate:alpine /bin/gomplate /bin/gomplate

RUN apk add --quiet --no-progress --no-cache bash curl \
    && curl -s -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl
VOLUME /environments
WORKDIR /work
COPY entrypoint.sh .
ENTRYPOINT ["entrypoint.sh"]
ONBUILD COPY deployment.yml
