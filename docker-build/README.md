# 7val/docker-build

[![](https://images.microbadger.com/badges/image/7val/docker-build.svg)](https://microbadger.com/images/7val/docker-build "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/7val/docker-build.svg)](https://microbadger.com/images/7val/docker-build "Get your own commit badge on microbadger.com")

Build docker images inside docker to make sure to use the same docker version and to set specific labels.

## Usage

You must pass `IMAGES` to point to one or more directories with a `Dockerfile` inside.
The `IMAGES` can be a space delimited list of images to build at once.
The `Dockerfile` must have at least one `FROM ... AS release` line to support multi-stage builds.

Example:

```bash
docker run --rm -v $PWD:/work -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="nodejs-runner sloppy" 7val/docker-build
```
