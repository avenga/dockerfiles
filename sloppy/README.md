# avenga/sloppy

![pulls](https://img.shields.io/docker/pulls/avenga/sloppy.svg)
![size](https://images.microbadger.com/badges/image/avenga/sloppy.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/sloppy.svg)](https://microbadger.com/images/avenga/sloppy)

A command line tool for sloppy.io, a container as a service provider.

https://github.com/sloppyio/cli


## Build releases

You can pass `--build-arg SLOPPY_CLI_VERSION=x.y.z` to build an image of the specific `x.y.z` version of the sloppy cli:
```bash
docker build --build-arg SLOPPY_CLI_VERSION=1.11.1 --no-cache --pull -t avenga/sloppy:1.11.1 .
```
Be aware that `x.y.z` is the exact tag as it is used on the release page: https://github.com/sloppyio/cli/releases

## Push releases
Make sure to use the same image tag (e.g. `avenga/sloppy:1.11.1`) that was used in the docker build step before:
```bash
docker login
docker push avenga/sloppy:1.11.1
```
