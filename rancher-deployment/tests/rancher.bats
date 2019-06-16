#!/usr/bin/env bats

@test "d-c run test" {
    run docker-compose run --rm rancher-test
    echo "$output"
    [[ $status -eq 0 ]]
}
