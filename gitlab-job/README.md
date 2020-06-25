# avenga/gitlab-job

![pulls](https://img.shields.io/docker/pulls/avenga/gitlab-job.svg)
![size](https://images.microbadger.com/badges/image/avenga/gitlab-job.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/gitlab-job.svg)](https://microbadger.com/images/avenga/gitlab-job)

Used in `.gitlab-ci.yml` to specify a Docker image to use for the gitlab job:

```yml
image: avenga/gitlab-job

services:
  - docker:dind

...
```
See https://docs.gitlab.com/ce/ci/yaml/#image for more infos.

The image contains `bash`, `make`, `python3` and `docker-compose`.
