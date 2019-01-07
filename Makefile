.PHONY: build

CI_REGISTRY ?= docker.io
IMAGE_PREFIX ?= $(CI_REGISTRY)/7val/
CURRENT_BRANCH ?= $(shell git symbolic-ref --short HEAD)
ONLY_BRANCH ?= master

build:
	docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		build-images

push:
	docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		-e CURRENT_BRANCH="$(CURRENT_BRANCH)" \
		-e ONLY_BRANCH="$(ONLY_BRANCH)" \
		push-images
