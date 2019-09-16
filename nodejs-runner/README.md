# Sevenval nodejs-runner

![pulls](https://img.shields.io/docker/pulls/7val/nodejs-runner.svg)
![size](https://images.microbadger.com/badges/image/7val/nodejs-runner.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/nodejs-runner.svg)](https://microbadger.com/images/7val/nodejs-runner)

Opinionated docker image to act as nodejs runtime only.

## Usage

As base image for nodejs apps.

```Dockerfile
FROM 7val/nodejs-runner:latest AS release
...
```
