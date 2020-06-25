# avenga/docker-push

![pulls](https://img.shields.io/docker/pulls/avenga/docker-push.svg)
![size](https://images.microbadger.com/badges/image/avenga/docker-push.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/docker-push.svg)](https://microbadger.com/images/avenga/docker-push)

Push docker images to any registry. We use `docker push` inside docker to make
sure to use the same docker version.

## Usage

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="nodejs-runner sloppy" avenga/docker-push
```
