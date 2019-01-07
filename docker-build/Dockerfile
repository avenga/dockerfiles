FROM koalaman/shellcheck-alpine:v0.6.0 as test
COPY *.sh ./
RUN find . -name "*.sh" | xargs shellcheck

FROM 7val/docker AS release
#
# DEFAULTS
#
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV IMAGE_TAG="latest"
ENV TARGET="release"
ENV LABEL_VENDOR=""
ENV LABEL_VCS_URL=""
ENV GIT_DIFF="@~..@"
# set to anything but not empty to list the images that need a rebuild:
ENV DRY_RUN=""
# set to anything but not empty to build with cache:
ENV CACHE=""
# set to anything but not empty to avoid pulling newer versions:
ENV NO_PULL=""

COPY run.sh /
CMD ["/run.sh"]
