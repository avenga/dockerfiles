# avenga/gitlab-runner

![pulls](https://img.shields.io/docker/pulls/avenga/gitlab-runner.svg)
![size](https://images.microbadger.com/badges/image/avenga/gitlab-runner.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/gitlab-runner.svg)](https://microbadger.com/images/avenga/gitlab-runner)

A gitlab-runner with automatic registration and unregistration.

## Usage

To spawn a runner just execute:
```bash
docker run -e CI_SERVER_URL=https://gitlab.com -e REGISTRATION_TOKEN=<your-token> avenga/gitlab-runner
```
You can pass all the environment variables defined by the
[gitlab-runner commands](https://docs.gitlab.com/runner/commands/).
