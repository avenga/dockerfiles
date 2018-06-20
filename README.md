# Sevenval dockerfiles

Public Sevenval Dockerfiles intended to serve as base images for our projects.
Opinionated conventions and best practices.

## Build docker image with docker in docker

Local host:
```bash
docker-compose run --rm -e IMAGE=<dirname> build-local
```
e.g.
```bash
docker-compose run --rm -e IMAGE=nodejs-javascript-hello build-local
```

Remote host:
```bash
docker-compose run --rm -e IMAGE=<dirname> build-remote
```
