.PHONY: build

CI_REGISTRY ?= docker.io
IMAGE_PREFIX ?= $(CI_REGISTRY)/7val/
IMAGES ?= $(shell \
	git diff --name-only origin/master | \
	sort -u | \
	awk 'BEGIN {FS="/"} {print $$1}' | \
	uniq | \
	xargs -I % find . -type d -name % -exec basename {} \; \
)
IMAGE_TAG ?= latest
CURRENT_BRANCH ?= $(shell git symbolic-ref --short HEAD)
ONLY_BRANCH ?= master

build:
	docker-compose run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		-e IMAGES="$(IMAGES)" \
		-e IMAGE_TAG="$(IMAGE_TAG)" \
		build-images

push:
	docker-compose run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		-e IMAGES="$(IMAGES)" \
		-e CURRENT_BRANCH="$(CURRENT_BRANCH)" \
		-e ONLY_BRANCH="$(ONLY_BRANCH)" \
		push-images

# List images that needs to be rebuilt:
build-info:
	@echo "$(IMAGES)" | tr " " "\n"
