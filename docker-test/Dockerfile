FROM avenga/docker AS release

# Install bats-core and other requirements
COPY --from=bats/bats:latest /opt/bats /opt/bats
RUN ln -s /opt/bats/bin/bats /usr/sbin/bats \
    && apk --quiet --no-progress --no-cache add docker-compose curl jq make
#
# DEFAULTS
#
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV GIT_DIFF="@~..@"

COPY run.sh /
CMD ["/run.sh"]
