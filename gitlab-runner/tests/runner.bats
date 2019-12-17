#!/usr/bin/env bats

@test "gitlab-runner --version" {
    run docker run --rm --entrypoint gitlab-runner 7val/gitlab-runner --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ Version:.*12.5.0 ]]
}
