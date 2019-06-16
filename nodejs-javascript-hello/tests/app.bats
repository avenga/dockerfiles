#!/usr/bin/env bats

@test "run integration tests" {
    run docker-compose up --abort-on-container-exit --build --force-recreate hello-test
    echo "$output"
    [[ $status -eq 0 ]]
}
