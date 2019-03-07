# Sevenval nodejs-javascript-app

Opinionated docker image to run production-ready nodejs apps written in javascript.
Only used as a stage in a [multi-stage][1] build.

Expects a `build` stage with `/app/package.json`, `/app/src` and package dependencies in `/prod_node_modules`.
See [nodejs-javascript-hello][2] as an example.

## Usage

```Dockerfile
FROM 7val/nodejs-javascript-builder:latest AS build
FROM 7val/nodejs-javascript-app:latest AS release
```

[1]: https://docs.docker.com/develop/develop-images/multistage-build/
[2]: https://github.com/sevenval/dockerfiles/tree/master/nodejs-javascript-hello
