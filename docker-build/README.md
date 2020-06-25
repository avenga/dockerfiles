# avenga/docker-build

![pulls](https://img.shields.io/docker/pulls/avenga/docker-build.svg)
![size](https://images.microbadger.com/badges/image/avenga/docker-build.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/docker-build.svg)](https://microbadger.com/images/avenga/docker-build)

Build docker images inside docker to make sure to use the same docker version and to set specific labels.

## Usage

You must pass `IMAGES` to point to one or more directories with a `Dockerfile` inside.
The `IMAGES` can be a space delimited list of images to build at once.
The `Dockerfile` must have at least one `FROM ... AS release` line to support multi-stage builds.

Example:

```bash
docker run --rm -v $PWD:/work -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="nodejs-runner sloppy" avenga/docker-build
```
