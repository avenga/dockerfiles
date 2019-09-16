# 7val/nodejs-javascript-builder

![pulls](https://img.shields.io/docker/pulls/7val/nodejs-javascript-builder.svg)
![size](https://images.microbadger.com/badges/image/7val/nodejs-javascript-builder.svg)
![commit](https://images.microbadger.com/badges/commit/7val/nodejs-javascript-builder.svg)

Opinionated docker image to build nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.

Expects `package.json`, `yarn.lock`, `src` dir, `test` dir and a `test:unit` entry in `package.json` `scripts`.
See [nodejs-javascript-hello][2] as an example.

## Usage

```Dockerfile
FROM 7val/nodejs-javascript-builder:latest AS build
FROM 7val/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
[2]: https://github.com/sevenval/dockerfiles/tree/master/nodejs-javascript-hello
