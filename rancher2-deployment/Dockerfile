FROM rancher/cli2 AS release

# This image's main purpose is to run deployments to a Rancher2 cluster. It
# leverages the rancher2-cli, kubectl and gomplate to accomplish that.


########################################################################
# Mandatory variables

# Define the name of k8s configuration.
ENV DEPLOYMENT_TEMPLATE_FILE="deployment.tmpl.yml"

# Sets the rancher context containing of <cluster-id>:<project-id>.
ENV RANCHER_CONTEXT=""

# Sets the project name. Must be the name of the Rancher2 project. The value
# is used together with the value of ENVIRONMENT to construct the name of the
# K8s namespace.
ENV PROJECT=""

# Optional. Overrides PROJECT.
ENV RANCHER_PROJECT=""

# Sets environment name. Together with PROJECT it defines the name of the K8s
# namespace.
ENV ENVIRONMENT=""

# Set to anything but empty to not login to rancher:
ENV NO_LOGIN=""

# Sets the URL under which the Rancher2-API is available.
ENV RANCHER_SERVER_URL=""

# Sets the token to access rancher in context defined in RANCHER_CONTEXT.
ENV RANCHER_BEARER_TOKEN=""

# Used to mount build volumes in GitLab CI pipeline:
ENV CI_PROJECT_DIR=""

# END mandatory variables
########################################################################

# Install gomplate by copying it from the upstream Docker image.
COPY --from=hairyhenderson/gomplate:v3.5.0-alpine /bin/gomplate /bin/gomplate

# Install bash and kubectl
RUN apk add --quiet --no-progress --no-cache bash curl \
    && curl -s -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del --quiet --no-progress --no-cache curl

# Defines the mountpoint where the folder containing the files reside, which
# define the environment.
VOLUME /environments

# From here on all commands run in WORKDIR.
WORKDIR /work

# Copy and set the ENTRYPOINT script
COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

# When an image is build with this image as base the file defined in
# DEPLOYMENT_TEMPLATE_FILE is copied into the WORKDIR.
ONBUILD COPY ${DEPLOYMENT_TEMPLATE_FILE} ./
