FROM alpine AS release
RUN apk --quiet --no-cache --no-progress add curl \
    && curl -sfL https://install.goreleaser.com/github.com/syntaqx/serve.sh | sh
WORKDIR /srv
ENTRYPOINT [ "/bin/serve", "--port", "2066" ]
