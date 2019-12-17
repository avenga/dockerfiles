* schedule regular rebuilds
// document local development
// long Git hash in docker-build/run.sh (anywhere else?)
// all tests do not use "latest", since it might be from upstream and not from
  the just build images
// switch to opencontainer labels
// !!!! make `--pull` the default in `docker-build/run.sh`
* gitlab-job might use 7val/docker as base
* some tests build the images by themselves


FAILURE!?
https://travis-ci.org/sevenval/dockerfiles/jobs/605426043
```
$ make build

fatal: ref HEAD is not a symbolic ref

Building build-images
```
Vermutlich die Zeile
```
  7 CURRENT_BRANCH ?= $(shell git symbolic-ref --short HEAD)¬
```
