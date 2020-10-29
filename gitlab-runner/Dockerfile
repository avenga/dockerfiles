ARG GITLAB_RUNNER_IMAGE_TAG=alpine
FROM gitlab/gitlab-runner:${GITLAB_RUNNER_IMAGE_TAG} AS release
ARG IMAGE_PREFIX="avenga/"
ARG VERSION="latest"

# Defaults:
ENV RUNNER_LIMIT="1"
ENV RUNNER_REQUEST_CONCURRENCY="1"
ENV RUNNER_EXECUTOR="docker"
ENV DOCKER_IMAGE="${IMAGE_PREFIX}/gitlab-job:${VERSION}"

COPY register-runner.sh /
ENTRYPOINT ["/usr/bin/dumb-init", "/register-runner.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
