# 7val/sloppy-deployment

## Test

```bash
docker-compose run test
```
This triggers a dry run of a sloppy deployment. That means it will only show the processed output of the `test/deployment/sloppy.tmpl.yml` file. For a real deployment to a `test` environment you need to remove the `DRY_RUN` env var from `docker-compose.yml`.
