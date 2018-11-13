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
