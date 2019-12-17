# Sevenval dockerfiles

[![Build Status](https://travis-ci.org/sevenval/dockerfiles.svg?branch=master)](https://travis-ci.org/sevenval/dockerfiles)

Public Sevenval Dockerfiles intended to serve as base images for our projects.

Opinionated conventions and best practices:
- use docker in docker itself to make sure to use the same docker version when building and pushing
- only build and push images that changed; based on [specific git diff command][0]

## Images

* [7val/docker]: Base image for all docker related tasks.
* [7val/docker-build]: Build docker images inside docker.
* [7val/docker-push]: Push docker images to any registry.
* [7val/gitlab-job]: Execute jobs in the Gitlab runner.
* [7val/gitlab-runner]: A gitlab-runner with automatic registration.
* [7val/httpd-static]: Simple http server for static files.
* [7val/net-tools]: Image with networking tools.
* [7val/nodejs-javascript-app]: Opinionated docker image to run production-ready
  nodejs apps written in javascript.
* [7val/nodejs-javascript-builder]: Opinionated docker image to build nodejs
  apps written in javascript.
* [7val/nodejs-runner]: Opinionated docker image to act as nodejs runtime only.
* [7val/rancher-deployment]: Run a deployment to [Rancher][1] via generated
  `docker-compose.yml` and `rancher-compose.yml` files.
* [7val/sloppy]: Provides the Slopp.io CLI in a container
* [7val/sloppy-deployment]: Run a Sloppy.io deployment with the help of template
  configuration and environment variables.
* [7val/sloppy-rollout]: Enhances `7val/sloppy-deployment`. Plain JSON/YAML
  files can be deployed too.
* [7val/wordpress]: Wordpress image with some extras.

## Build

Build all docker images that changed:
```bash
make build
```

Build specific docker images:
```bash
make build -e IMAGES="wordpress"
```

## Push

Push all docker images that changed:
```bash
make push
```

Push specific docker images:
```bash
make push -e IMAGES="wordpress"
```

## Test

All tests are
[bats](https://github.com/bats-core/bats-core)-tests. They reside in a directory
inside the image direcotry named `tests/`. There can be two types of
tests. Pure Bats-tests or a Bash script called `test.sh`.

### `test.sh`

If a script called `test.sh` resides inside `<imagename>/tests` it is executed.
`test.sh` is necessary when some preparations have to be made to run the Bats
tests. Thus first all preparations are run and then the Bats tests.
If there are any Bats tests they won't be executed by the test itself. Exceution
must be done inside `test.sh`.

One example is an image which delivers a networked service like a HTTP-server.
This server is tested via HTTP. Thus a functioning network is necessary and the
prep-code takes care of this. The tests of the Wordpress image leverage this.

### Bats tests

All Bats files under `<imagename>/tests` are executed.

## Development

* Branches are always created from the master
* Branch naming: `<image>/<short description of the change>`
* PRs have the same name as the branch
* per PR ony small changes

0. update master
1. create a branch from master
2. make your changes
3. build and test your changes
4. commit, push and create PR
5. Review required



[0]: https://github.com/sevenval/dockerfiles/blob/74ece293784680f18c89d4955a0881f93fd791f6/docker-build/run.sh#L8
[7val/docker]: https://cloud.docker.com/u/7val/repository/docker/7val/docker
[7val/docker-build]: https://cloud.docker.com/u/7val/repository/docker/7val/docker-build
[7val/docker-push]: https://cloud.docker.com/u/7val/repository/docker/7val/docker-push
[7val/gitlab-job]: https://cloud.docker.com/u/7val/repository/docker/7val/gitlab-job
[7val/gitlab-runner]: https://cloud.docker.com/u/7val/repository/docker/7val/gitlab-runner
[7val/httpd-static]: https://cloud.docker.com/u/7val/repository/docker/7val/httpd-static
[7val/nodejs-javascript-app]: https://cloud.docker.com/u/7val/repository/docker/7val/nodejs-javascript-app
[7val/nodejs-javascript-builder]: https://cloud.docker.com/u/7val/repository/docker/7val/nodejs-javascript-builder
[7val/nodejs-runner]: https://cloud.docker.com/u/7val/repository/docker/7val/nodejs-runner
[7val/rancher-deployment]: https://cloud.docker.com/u/7val/repository/docker/7val/rancher-deployment
[7val/sloppy]: https://cloud.docker.com/u/7val/repository/docker/7val/sloppy
[7val/sloppy-deployment]: https://cloud.docker.com/u/7val/repository/docker/7val/sloppy-deployment
[7val/wordpress]: https://cloud.docker.com/u/7val/repository/docker/7val/wordpress
[7val/sloppy-rollout]: https://cloud.docker.com/u/7val/repository/docker/7val/sloppy-rollout
