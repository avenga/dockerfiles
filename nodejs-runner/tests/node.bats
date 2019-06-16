#!/usr/bin/env bats

@test "node version" {
    run docker run --rm 7val/nodejs-runner node --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output == "v10.15.3" ]]
}
