# 7val/rancher-deployment

## Test

```bash
docker-compose run test
```
This triggers a dry run of a rancher deployment. That means it will only show the processed output of the `example/deployment/docker-compose.tmpl.yml` and `example/deployment/rancher-compose.tmpl.yml` files.

## Deploy

For a real deployment to an environment you need to duplicate `docker-compose.override.example.yml` to `docker-compose.override.yml` and `.env.example` to `.env` and set the variables inside that file.

Then run:
```bash
docker-compose run deploy-test
```

## Usage as Rancher CLI

You can use this image as a replacement for the rancher cli tool.
E.g.:
```bash
docker run -it --rm --entrypoint /usr/bin/rancher -v "$HOME/.rancher":/rancher \
    7val/rancher-deployment --config /rancher/cli.json <your options>
```
