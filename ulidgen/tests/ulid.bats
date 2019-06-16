#!/usr/bin/env bats

@test "generate ULID" {
    run docker run --rm 7val/ulidgen
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $( echo -n "$output" | wc -m ) -eq 26 ]]
}
