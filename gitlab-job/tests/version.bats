@test "docker-compose version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" docker-compose --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "docker-compose version 1" ]]
}

@test "jq version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" jq --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "jq-master" ]]
}

@test "make version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" make --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "GNU Make 4" ]]
}

@test "bash version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" bash --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "GNU bash, version 5" ]]
}
# Prevent DEVOPS-298
@test "sh shell works" {
    run docker run --rm "avenga/docker:$VERSION" /bin/sh -c env
    echo "$output"
    [[ $status -eq 0 ]]
}
# Prevent DEVOPS-298
@test "bash shell works" {
    run docker run --rm "avenga/docker:$VERSION" /bin/bash -c env
    echo "$output"
    [[ $status -eq 0 ]]
}
