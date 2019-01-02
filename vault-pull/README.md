# vault-pull

You can pull secrets out of a vault KV secrets engine (v1) into local files in [.env-format][0].
It expects a volume mounted to `/environments` where the files will be stored. You must specify a project name in a `PROJECT` env var to fetch only the vault secrets that belong to this project. See the `example` directory and the `docker-compose.yml` for an example setup.
You could pass all [env vars][1] that the vault CLI accepts for authentication.

## Example

```bash
docker-compose run example
```
This will write the environment- and project-specific key-value pairs from vault into the matching `secrets.env` files under `example/environments`.
Go to http://localhost:8200 and login with the root token `myroot` to check the secrets.


[0]: https://docs.docker.com/compose/env-file/
[1]: https://www.vaultproject.io/docs/commands/#environment-variables
