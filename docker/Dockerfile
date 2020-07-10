FROM docker:stable-git AS release
ENV WORKDIR=/work
WORKDIR ${WORKDIR}
VOLUME ${WORKDIR}
RUN apk --quiet --no-progress --no-cache add bash
ENTRYPOINT ["bash"]
