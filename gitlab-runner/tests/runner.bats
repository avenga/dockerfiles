#!/usr/bin/env bats

@test "gitlab-runner --version" {
    run docker run --rm --entrypoint gitlab-runner "avenga/gitlab-runner:$VERSION" --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ Version:.*13.[:digit:]*.[:digit:]* ]]
}
