#!/usr/bin/env bats

@test "node version" {
    run docker run --rm "avenga/nodejs-runner:$VERSION" node --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output == "v10.15.3" ]]
}
