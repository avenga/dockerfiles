.PHONY: build push

CI_REGISTRY ?= docker.io
IMAGE_PREFIX ?= $(CI_REGISTRY)/7val/
CURRENT_BRANCH ?= $(shell git symbolic-ref --short HEAD)
ONLY_BRANCH ?= master

build:
	@docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		build-images

test:
	@docker-compose \
		--log-level ERROR \
		-f docker-compose.ops.yml \
		build \
		--force-rm \
		test-images
	@docker-compose \
		-f docker-compose.ops.yml \
		--log-level ERROR \
		run \
		--rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		test-images

push:
	@docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		-e CURRENT_BRANCH="$(CURRENT_BRANCH)" \
		-e ONLY_BRANCH="$(ONLY_BRANCH)" \
		push-images
