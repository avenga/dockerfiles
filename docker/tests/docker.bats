@test "-c env" {
    run docker run --rm "avenga/docker:$VERSION" env
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "WORKDIR=/work" ]]
}
@test "docker version" {
    run docker run --rm "avenga/docker:$VERSION" docker --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ version\ 19 ]]
}
# Prevent DEVOPS-298
@test "sh shell works" {
    run docker run --rm "avenga/docker:$VERSION" /bin/sh -c env
    echo "$output"
    [[ $status -eq 0 ]]
}
