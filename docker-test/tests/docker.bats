@test "docker-compose version" {
    run docker run --rm "avenga/docker-test:$VERSION" docker-compose --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ docker-compose\ version\ 1 ]]
}
