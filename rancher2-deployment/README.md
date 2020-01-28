# 7val/rancher2-deployment

![pulls](https://img.shields.io/docker/pulls/7val/rancher2-deployment.svg)
![size](https://images.microbadger.com/badges/image/7val/rancher2-deployment.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/rancher2-deployment.svg)](https://microbadger.com/images/7val/rancher2-deployment)

Run a deployment to [Rancher 2][1] via generated `deployment.yml` file.  It
generates this file based on Go's [Package][2] `text/template` and processed
with [Gomplate][3].

To use this image create a `Dockerfile` with the following content:
```
FROM 7val/rancher2-deployment
```
The template file `deployment.tmpl.yml` is copied with an
`ONBUILD` [trigger][4]. This file should reside in the same directory as the
`Dockerfile`.

By default `kubectl diff` is run and the output printed to STDOUT. Thus there is
always a diff available in the CI/CD system to see what was changed.
If a namespace doesn't exist it will be created.

An example configration can be found under `examples/`.

## Variables

With the following variables the behaviour can be changed.

### Mandatory variables

* `RANCHER_PROJECT`: Sets the project name in Rancher2. If not set the value of
  `PROJECT` is used.
* `PROJECT`: Sets the Rancher2 project name. Can be overriden by
  `RANCHER_PROJECT`.
* `ENVIRONMENT`: Defines the folder under `environment/` which is used by
  Gomplate. Gomplate sources all files in that folder to configure any
  environment variables, which are then used to seed the template. Additionally
  it is used together with `PROJECT`/`RANCHER_PROJECT` to build the name of the
  K8s namespace. Namespace becomes PROJECT-ENVIRONMENT in lower case letters.
* `RANCHER_SERVER_URL`: URL under which the Rancher2 server is found. Used by
  `rancher login`.
* `RANCHER_BEARER_TOKEN`: Token to access Rancher2 and the specific project.
  Used by `rancher login`.
* `RANCHER_CONTEXT`: Tells `rancher login` which cluster and which project
  should be accessed. Uses the IDs and not the names. E.g. `c-p8799:p-mq89d`.

### Optional variables

* `RANCHER2_DEPLOYMENT_TRACE`: Enables trace mode when set to any value. See
  `help set` in Bash. Default: off
* `DRY_RUN`: Don't do anything except print the parsed k8s configuration to
  STDOUT.  Activate by setting to any value. Default: off
* `RANCHER_SAVE_OUTPUT_DIR`: Name of the directory (should be a host volume) to
  where a copy of the rendered K8s configuration is saved. Name of the file is
  `deployment.yml`.
* `RANCHER_NO_DIFF`: Turn off the `kubectl diff` command.

[1]: https://rancher.com/docs/rancher/v2.x/en/
[2]: https://golang.org/pkg/text/template/
[3]: https://docs.gomplate.ca/
[4]: https://docs.docker.com/engine/reference/builder/#onbuild
