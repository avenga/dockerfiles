#!/usr/bin/env bats

@test "should create volume" {
    run docker-compose run --rm -e SETUP_VOLUMES="1" -e VOLUME_NAMES="media db" test
    echo "$output"
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Would create Volume test-media." ]]
}

@test "should not create volume" {
    run docker-compose run --rm -e SETUP_VOLUMES="1" -e VOLUME_NAMES="media db" -e TEST_VOLUME_NAME="media" test
    echo "$output"
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Volume test-media already exists." ]]
}

@test "should not set up volumes at all" {
    run docker-compose run --rm -e SETUP_VOLUMES="" -e VOLUME_NAMES="media db" test
    echo "$output"
    [[ $status -eq 0 ]]
    [[ ! "$output" =~ "Try to set up rancher volumes" ]]
}

@test "SETUP_VOLUMES not set should not fail" {
    run  docker-compose run --rm test
    echo "$output"
    [[ $status -eq 0 ]]
}
