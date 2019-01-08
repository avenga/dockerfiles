# Sevenval dockerfiles

[![Build Status](https://travis-ci.org/sevenval/dockerfiles.svg?branch=master)](https://travis-ci.org/sevenval/dockerfiles)

Public Sevenval Dockerfiles intended to serve as base images for our projects.

Opinionated conventions and best practices:
- use docker in docker itself to make sure to use the same docker version when building and pushing
- only build and push images that changed; based on [specific git diff command][0]

## Build docker images

```bash
make build
```

## Push docker images

```bash
make push
```

[0]: https://github.com/sevenval/dockerfiles/blob/74ece293784680f18c89d4955a0881f93fd791f6/docker-build/run.sh#L8
