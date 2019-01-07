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

COPY run.sh /
CMD ["/run.sh"]
