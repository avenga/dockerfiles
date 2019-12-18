@test "-c env" {
    run docker run --rm --entrypoint /bin/bash "7val/rancher2-deployment:$VERSION" -c env
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ "DEPLOYMENT_TEMPLATE_FILE=deployment.tmpl.yml" ]]
}
@test "rancher version" {
    run docker run --rm --entrypoint /bin/bash "7val/rancher2-deployment:$VERSION" -c rancher --version
    echo "$output"
    [[ $status -eq 0 ]]
    [[ $output =~ Version:\ v2.3.2 ]]
}

@test "dry run" {
    run  docker-compose run --rm test
    echo "$output"
    [[ $status -eq 0 ]]
}