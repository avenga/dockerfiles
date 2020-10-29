#!/usr/bin/env bats

@test "dry run" {
    run docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e IMAGES="$IMAGE_PREFIX/gitlab-job" -e DRY_RUN=1 "avenga/docker-push:$VERSION"
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "gitlab-job:latest" ]]
    [[ $output =~ "gitlab-job:${VERSION}" ]]
}
@test "make dry run" {
    cd ..
    run make push -e IMAGES=gitlab-job -e CURRENT_BRANCH=push-test "avenga/docker-push:$VERSION"
    echo "$output"
    [[ $status -eq 2 ]]
    [[ $output =~ "Skipping push" ]]
}
