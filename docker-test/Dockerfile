FROM avenga/docker AS release

# Install bats-core and other requirements
COPY --from=bats/bats:latest /opt/bats /opt/bats
COPY install_docker-compose.sh /tmp
RUN ln -s /opt/bats/bin/bats /usr/sbin/bats \
    && apk add --quiet --no-progress --no-cache python3 curl jq \
    && /tmp/install_docker-compose.sh \
    && rm /tmp/install_docker-compose.sh
#
# DEFAULTS
#
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV GIT_DIFF="@~..@"

COPY run.sh /
CMD ["/run.sh"]
