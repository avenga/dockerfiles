FROM alpine:3.8 as release
ARG BATS_VERSION="0.4.0-r2"
RUN apk add --no-cache bats=$BATS_VERSION
RUN bats --version
ENTRYPOINT ["bats"]
