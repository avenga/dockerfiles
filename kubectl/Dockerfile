FROM alpine:latest AS release
RUN apk --quiet --no-progress --no-cache add bash curl
RUN curl -LO \
  https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl
# test kubectl installation:
RUN kubectl version --client
# install and configure entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]