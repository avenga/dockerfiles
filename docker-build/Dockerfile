FROM docker:18.03.1-ce-git AS release

# defaults
ENV WORKDIR=/work
ENV IMAGE_PREFIX=""
ENV IMAGE_TAG="latest"
ENV TARGET="release"

RUN apk --no-cache add bash

WORKDIR /work
VOLUME  /work
COPY ./build.sh /
ENTRYPOINT ["/bin/bash"]
CMD ["/build.sh"]
