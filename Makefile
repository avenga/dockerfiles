.PHONY: build

IMAGE_PREFIX ?= 7val/
IMAGE ?= $(shell git diff --name-only @~..@ | sort -u | awk 'BEGIN {FS="/"} {print $$1}' | uniq)
IMAGE_TAG ?= latest

build:
	@if [ -d "$(IMAGE)" ]; then docker-compose run --rm -e IMAGE_PREFIX=$(IMAGE_PREFIX) -e IMAGE=$(IMAGE) build-local; fi

push:
	docker push $(IMAGE_PREFIX)$(IMAGE):$(IMAGE_TAG)
