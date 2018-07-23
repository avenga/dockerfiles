# Sevenval docker-build

Build docker images inside docker to make sure to use the same docker version.

## Usage

```bash
docker run --rm -v $PWD:/work -v /var/run/docker.sock:/var/run/docker.sock -e IMAGE=nodejs-runner 7val/docker-build
```
