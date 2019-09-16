# 7val/gitlab-runner

![pulls](https://img.shields.io/docker/pulls/7val/gitlab-runner.svg)
![size](https://images.microbadger.com/badges/image/7val/gitlab-runner.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/gitlab-runner.svg)](https://microbadger.com/images/7val/gitlab-runner)

A gitlab-runner with automatic registration.

## Usage

To spawn a runner locally just execute:
```bash
docker run -e CI_SERVER_URL=https://gitlab.com -e REGISTRATION_TOKEN=<your-token> 7val/gitlab-runner
```
You can pass all the environment variables defined by the [gitlab-runner commands](https://docs.gitlab.com/runner/commands/).
