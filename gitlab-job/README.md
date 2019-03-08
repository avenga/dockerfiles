# 7val/gitlab-job

Used in `.gitlab-ci.yml` to specify a Docker image to use for the gitlab job:

```yml
image: 7val/gitlab-job

services:
  - docker:dind

...
```
See https://docs.gitlab.com/ce/ci/yaml/#image for more infos.

The image contains `make`, `python3` and `docker-compose`.
