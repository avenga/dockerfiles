@test "docker-compose --version" {
    run docker run --rm 7val/gitlab-job docker-compose --version
    echo "$output"
    [[ $output =~ "docker-compose version" ]]
    [[ $status -eq 0 ]]
}
