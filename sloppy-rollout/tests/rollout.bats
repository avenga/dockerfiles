#!/usr/bin/env bats

@test "d-c run template test" {
    run docker-compose run template-test
    echo "$output"
    [[ $status -eq 0 ]]
}

@test "diff templated sloppy.yml" {
    run diff ./tests/deployment/resulting_sloppy.yml ./tests/tmp/sloppy.yml
    echo "$output"
    [[ $status -eq 0 ]]
}

@test "d-c run file test" {
    run docker-compose run file-test
    echo "$output"
    [[ $status -eq 0 ]]
}

@test "diff file sloppy.json" {
    run diff ./tests/pure-file/sloppy.json ./tests/tmp/sloppy.json
    echo "$output"
    [[ $status -eq 0 ]]
}
