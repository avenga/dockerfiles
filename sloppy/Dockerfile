FROM alpine:3.8 as release

ARG BUILD_DATE=""
ARG VCS_REF=""

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/sevenval/dockerfiles.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

ARG SLOPPY_CLI_VERSION=v1.13.1
ENV SLOPPY_CLI_VERSION=${SLOPPY_CLI_VERSION}
ENV SLOPPY_APITOKEN=""
WORKDIR /work
RUN apk add --no-cache ca-certificates
ADD https://github.com/sloppyio/cli/releases/download/${SLOPPY_CLI_VERSION}/sloppy-linux-amd64 /bin/sloppy
RUN chmod +x /bin/sloppy && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
    # ^ Hack: https://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
RUN sloppy version
ENTRYPOINT ["sloppy"]
CMD ["version"]
