# Sevenval nodejs-javascript-builder

Opinionated docker image to build nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.

Expects `package.json`, `yarn.lock`, `lib` dir, `test` dir and a `test` script in `package.json`.

## Usage

```Dockerfile
FROM 7val/nodejs-javascript-builder:latest AS build
FROM 7val/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
