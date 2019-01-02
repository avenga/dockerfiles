# vault-push

You can push files in [.env-format][0] to a vault KV secrets engine (v1).
It will parse the container's `/environments` directory for subdirectories with specific .env-files (default: `secrets.env`) and push them as key-value pairs to a vault server. See the `example` directory for an example setup.
You could pass all [env vars][1] that the vault CLI accepts for authentication.

## Example

```bash
docker-compose run example
```
Go to http://localhost:8200 and login with the root token `myroot` to check the secrets.


[0]: https://docs.docker.com/compose/env-file/
[1]: https://www.vaultproject.io/docs/commands/#environment-variables
