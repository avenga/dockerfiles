.PHONY: build

IMAGE_PREFIX ?= 7val/
IMAGE ?= $(shell \
	git diff --name-only master | \
	sort -u | \
	awk 'BEGIN {FS="/"} {print $$1}' | \
	uniq | \
	xargs -I % find . -type d -name % -exec basename {} \; \
)
IMAGE_TAG ?= latest

build:
	docker-compose run --rm -e IMAGE_PREFIX="$(IMAGE_PREFIX)" -e IMAGE="$(IMAGE)" build-local

push:
	docker-compose run --rm -e IMAGE_PREFIX="$(IMAGE_PREFIX)" -e IMAGE="$(IMAGE)" -e IMAGE_TAG="$(IMAGE_TAG)" push-images

build-info:
	@echo "$(IMAGE)" | tr " " "\n"
