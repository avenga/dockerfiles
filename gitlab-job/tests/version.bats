@test "docker-compose --version" {
    run docker run --rm "avenga/gitlab-job:$VERSION" docker-compose --version
    echo "$output"
    [[ $output =~ "docker-compose version" ]]
    [[ $status -eq 0 ]]
}
