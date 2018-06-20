# Sevenval nodejs-javascript-hello

Example app with multi-stage builds and integration tests.

## Run integration tests

```bash
docker-compose up --abort-on-container-exit --build --force-recreate hello-test
```
This could be used in any CI pipeline.
