#!/usr/bin/env bats

@test "HTTP 200 /" {
    run curl -s -o /dev/null -w "%{http_code}" "$MY_IP:8080"
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output -eq 200 ]]
}
