# 7val/rancher2-deployment

![pulls](https://img.shields.io/docker/pulls/7val/rancher2-deployment.svg)
![size](https://images.microbadger.com/badges/image/7val/rancher2-deployment.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/rancher2-deployment.svg)](https://microbadger.com/images/7val/rancher2-deployment)

Run a deployment to [Rancher 2][1] via generated `deployment.yml` file.
It generates this file based on Go's
[Package][2] `text/template` and processed with [Gomplate][3].
The template file `deployment.tmpl.yml` is copied with
an `ONBUILD` [trigger][4].


[1]: https://rancher.com/docs/rancher/v2.x/en/
[2]: https://golang.org/pkg/text/template/
[3]: https://docs.gomplate.ca/
[4]: https://docs.docker.com/engine/reference/builder/#onbuild