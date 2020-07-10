@test "docker-compose version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" -c 'docker-compose --version'
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "docker-compose version 1" ]]
}

@test "jq version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" -c 'jq --version'
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "jq-master" ]]
}

@test "make version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" -c 'make --version'
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "GNU Make 4" ]]
}

@test "bash version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" -c 'bash --version'
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "GNU bash, version 5" ]]
}