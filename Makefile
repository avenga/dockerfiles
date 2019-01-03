.PHONY: build

CI_REGISTRY ?= docker.io
IMAGE_PREFIX ?= $(CI_REGISTRY)/7val/
IMAGE ?= $(shell \
	git diff --name-only master | \
	sort -u | \
	awk 'BEGIN {FS="/"} {print $$1}' | \
	uniq | \
	xargs -I % find . -type d -name % -exec basename {} \; \
)
IMAGE_TAG ?= latest

build:
	docker-compose run --rm -e IMAGE_PREFIX="$(IMAGE_PREFIX)" -e IMAGE="$(IMAGE)" build-images

push:
	docker-compose run --rm -e IMAGE_PREFIX="$(IMAGE_PREFIX)" -e IMAGE="$(IMAGE)" push-images

# List images that needs to be rebuilt:
build-info:
	@echo "$(IMAGE)" | tr " " "\n"
