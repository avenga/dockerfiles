FROM alpine:3.8 AS release
RUN apk add --quiet --no-progress --no-cache curl \
        && curl -sfL https://install.goreleaser.com/github.com/syntaqx/serve.sh | sh
WORKDIR /srv
ENTRYPOINT [ "/bin/serve" ]
EXPOSE 8080
