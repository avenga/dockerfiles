FROM 7val/docker AS release

# Install bats-core
COPY --from=bats/bats:latest /opt/bats /opt/bats
RUN ln -s /opt/bats/bin/bats /usr/sbin/bats \
    && apk add --quiet --no-progress --no-cache python3 curl \
    && pip3 -q install docker-compose

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
