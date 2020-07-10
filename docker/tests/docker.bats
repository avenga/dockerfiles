@test "-c env" {
    run docker run --rm "avenga/docker:$VERSION" -c env
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "WORKDIR=/work" ]]
}
@test "docker version" {
    run docker run --rm "avenga/docker:$VERSION" -c 'docker --version'
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ version\ 19 ]]
}
