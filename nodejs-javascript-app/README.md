# avenga/nodejs-javascript-app

![pulls](https://img.shields.io/docker/pulls/avenga/nodejs-javascript-app.svg)
![size](https://images.microbadger.com/badges/image/avenga/nodejs-javascript-app.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/nodejs-javascript-app.svg)](https://microbadger.com/images/avenga/nodejs-javascript-app)

Opinionated docker image to run production-ready nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.

Expects a `build` stage with `/app/package.json`, `/app/src` and package dependencies in `/prod_node_modules`.
See [nodejs-javascript-hello][2] as an example.

## Usage

```Dockerfile
FROM avenga/nodejs-javascript-builder:latest AS build
FROM avenga/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
[2]: https://github.com/avenga/dockerfiles/tree/master/nodejs-javascript-hello
