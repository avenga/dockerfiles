FROM docker:18.03.1-ce-git AS release

# defaults
ENV WORKDIR=/work
ENV IMAGE_PREFIX=""
ENV VERSION=latest
ENV TARGET=release

WORKDIR /work
VOLUME  /work
COPY ./build.sh /
ENTRYPOINT ["/bin/sh"]
CMD ["/build.sh"]
