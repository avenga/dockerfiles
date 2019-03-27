#!/usr/bin/env bats


@test "compose up" {
    run docker-compose up -d --build --force-recreate
    echo "$output"
    [[ $status -eq 0 ]]
}

@test "blah" {
    sleep 20
    run curl localhost:8008
    echo "$output"
    [[ $output == blubb ]]
}

@test "wp GET /" {
    # FIXME use something like wait-for-it
    #sleep 20
    run curl -s -o /dev/null -w "%{http_code}" localhost:8008
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output == 200 ]]
}

@test "compose down" {
    run docker-compose down -v --remove-orphans
    echo "$output"
    [[ $status -eq 0 ]]
}
