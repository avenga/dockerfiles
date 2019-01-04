# 7val/docker-push

Push docker images to any registry. We use `docker push` inside docker to make sure to use the same docker version.

## Usage

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="nodejs-runner sloppy" 7val/docker-push
```
