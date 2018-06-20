# Sevenval nodejs-javascript-app

Opinionated docker image to run nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.
Expects a `build` stage with `/app/package.json`, `/app/lib` and package dependencies in `/prod_node_modules`.

## Usage

```Dockerfile
FROM sevenval/nodejs-javascript-builder:latest AS build
FROM sevenval/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
