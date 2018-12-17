# 7val/gitlab-runner

A gitlab-runner with automatic registration.

## Usage

To spawn a runner locally just execute:
```bash
docker run -e CI_SERVER_URL=https://gitlab.com -e REGISTRATION_TOKEN=<your-token> 7val/gitlab-runner
```
You can pass all the environment variables defined by the [gitlab-runner commands](https://docs.gitlab.com/runner/commands/).
