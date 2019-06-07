#!/usr/bin/env bats


@test "wp GET / on 80" {
    # FIXME use something like wait-for-it
    #sleep 20
    run curl -s -o /dev/null -w "%{http_code}" "$MY_IP:80"
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output -eq 301 ]]
}
