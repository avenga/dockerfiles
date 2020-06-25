#!/usr/bin/env bats

@test "dry run" {
    run docker run --rm -e IMAGES=gitlab-job -e DRY_RUN=1  "avenga/docker-build:$VERSION"
    [[ $status -eq 0 ]]
    [[ $output == "gitlab-job" ]]
}
