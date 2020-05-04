FROM debian:stable-slim AS release

# Install latest version of kubectl
RUN apt-get -qqq update \
    && apt-get install -qqq -y apt-transport-https gnupg2 curl \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list \
    && apt-get -qqqq update \
    && apt-get install -y -qqqq kubectl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt
# install and configure entrypoint
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
