# 7val/docker-push

![pulls](https://img.shields.io/docker/pulls/7val/docker-push.svg)
![size](https://images.microbadger.com/badges/image/7val/docker-push.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/docker-push.svg)](https://microbadger.com/images/7val/docker-push)

Push docker images to any registry. We use `docker push` inside docker to make
sure to use the same docker version.

## Usage

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="nodejs-runner sloppy" 7val/docker-push
```
