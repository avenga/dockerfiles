FROM koalaman/shellcheck-alpine:v0.6.0 as test
COPY *.sh ./
RUN find . -name "*.sh" | xargs shellcheck

FROM 7val/docker AS release
#
# DEFAULTS
#
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV CURRENT_BRANCH=""
ENV ONLY_BRANCH="master"
ENV GIT_DIFF="@~..@"
# Only list the images that will be pushed when set to anything but not empty
ENV DRY_RUN=""

COPY run.sh /
CMD ["/run.sh"]
