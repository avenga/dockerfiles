#!/usr/bin/env bats

@test "generate ULID" {
    run docker run --rm "avenga/ulidgen:$VERSION"
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $( echo -n "$output" | wc -m ) -eq 26 ]]
}
