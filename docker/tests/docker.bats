@test "-c env" {
    run docker run --rm 7val/docker -c env
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "WORKDIR=/work" ]]
}
