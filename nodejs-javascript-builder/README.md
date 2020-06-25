# avenga/nodejs-javascript-builder

![pulls](https://img.shields.io/docker/pulls/avenga/nodejs-javascript-builder.svg)
![size](https://images.microbadger.com/badges/image/avenga/nodejs-javascript-builder.svg)
![commit](https://images.microbadger.com/badges/commit/avenga/nodejs-javascript-builder.svg)

Opinionated docker image to build nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.

Expects `package.json`, `yarn.lock`, `src` dir, `test` dir and a `test:unit` entry in `package.json` `scripts`.
See [nodejs-javascript-hello][2] as an example.

## Usage

```Dockerfile
FROM avenga/nodejs-javascript-builder:latest AS build
FROM avenga/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
[2]: https://github.com/avenga/dockerfiles/tree/master/nodejs-javascript-hello
