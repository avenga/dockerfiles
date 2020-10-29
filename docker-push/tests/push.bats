#!/usr/bin/env bats

@test "dry run" {
    run docker run --rm -e IMAGES=gitlab-job -e DRY_RUN=1 "avenga/docker-push:$VERSION"
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output == "gitlab-job" ]]
}
@test "make dry run" {
    cd ..
    run make push -e IMAGES=gitlab-job -e CURRENT_BRANCH=push-test "avenga/docker-push:$VERSION"
    echo "$output"
    [[ $status -eq 2 ]]
    [[ $output =~ "Skipping since not on ONLY_BRANCH master" ]]
}
