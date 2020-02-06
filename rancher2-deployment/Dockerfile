FROM rancher/cli2 AS release
ARG DEPLOYMENT_TEMPLATE_FILE="deployment.tmpl.yml"
ENV DEPLOYMENT_TEMPLATE_FILE=${DEPLOYMENT_TEMPLATE_FILE}

# Mandatory rancher context:
ENV RANCHER_CONTEXT=""

# Mandatory project name:
ENV PROJECT=""

# Mandatory environment name:
ENV ENVIRONMENT=""

# Set to anything but empty to not login to rancher:
ENV NO_LOGIN=""

COPY --from=hairyhenderson/gomplate:alpine /bin/gomplate /bin/gomplate

RUN apk add --quiet --no-progress --no-cache bash curl \
    && curl -s -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl
VOLUME /environments
WORKDIR /work
COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]
ONBUILD COPY ${DEPLOYMENT_TEMPLATE_FILE} ./
