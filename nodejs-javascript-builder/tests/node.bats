#!/usr/bin/env bats

@test "yarn version" {
    run docker run --rm "7val/nodejs-javascript-builder:$VERSION" yarn --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output == "1.15.0" ]]
}
