# avenga/nodejs-runner

![pulls](https://img.shields.io/docker/pulls/avenga/nodejs-runner.svg)
![size](https://images.microbadger.com/badges/image/avenga/nodejs-runner.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/nodejs-runner.svg)](https://microbadger.com/images/avenga/nodejs-runner)

Opinionated docker image to act as nodejs runtime only.

## Usage

As base image for nodejs apps.

```Dockerfile
FROM avenga/nodejs-runner:latest AS release
...
```
