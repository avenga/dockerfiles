# Sevenval dockerfiles

[![Build Status](https://travis-ci.org/sevenval/dockerfiles.svg?branch=master)](https://travis-ci.org/sevenval/dockerfiles)

Public Sevenval Dockerfiles intended to serve as base images for our projects.

Opinionated conventions and best practices:
- use docker in docker itself to make sure to use the same docker version when building and pushing
- only build and push images that changed; based on [specific git diff command][0]

## Images

### [7val/docker-build]
![pulls](https://img.shields.io/docker/pulls/7val/docker-build.svg)
![size](https://img.shields.io/microbadger/image-size/7val/docker-build/latest.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/docker-build.svg)](https://microbadger.com/images/7val/docker-build)


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
make build -e IMAGES="wordpress"
```

[0]: https://github.com/sevenval/dockerfiles/blob/74ece293784680f18c89d4955a0881f93fd791f6/docker-build/run.sh#L8

[7val/docker-build]: https://cloud.docker.com/u/7val/repository/docker/7val/docker-build
