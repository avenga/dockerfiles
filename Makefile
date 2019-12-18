.PHONY: build push

.EXPORT_ALL_VARIABLES:

CI_REGISTRY ?= docker.io
IMAGE_PREFIX ?= $(CI_REGISTRY)/7val/
CURRENT_BRANCH ?= $(shell git symbolic-ref --short HEAD)
ONLY_BRANCH ?= master
# needed to mount files inside a container started inside a container
HOST_PATH=$(shell pwd)
# Unique image tag based on commit date and commit hash
VERSION ?= $(shell git show --quiet --format="%cd-%H" --date=short)
CACHE_FLAG ?= --no-cache
PULL_FLAG ?= --pull

.PHONY: help
help:
	@if tty -s ; then \
		grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'; \
	else \
		grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'; \
	fi

# TODO Add make traps for docker-compose

build:  ## Builds all changed images. `-e IMAGES="name"` builds single image.
	@docker-compose -f docker-compose.ops.yml build \
		${CACHE_FLAG} \
		${PULL_FLAG} \
		--force-rm \
		build-images

	@docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		build-images

# FIXME do not pull image! Or fail if image is not local!
.PHONY: test
test: ## Tests all changed images where tests exist. `-e IMAGES="name"` runs test for a single image.
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
		test-images || make clean
	@make clean

push: ## Pushes all changed images. `-e IMAGES="name"` pushes a single image.
	@docker-compose -f docker-compose.ops.yml build \
		${CACHE_FLAG} \
		${PULL_FLAG} \
		--force-rm \
		push-images
	@docker-compose -f docker-compose.ops.yml run --rm \
		-e IMAGE_PREFIX="$(IMAGE_PREFIX)" \
		-e CURRENT_BRANCH="$(CURRENT_BRANCH)" \
		-e ONLY_BRANCH="$(ONLY_BRANCH)" \
		push-images

.PHONY: clean
clean:  ## Removes the Docker network from the test target.
	@docker network rm test

.PHONY: build-all
build-all:  ## build all images
	$(MAKE) build -e IMAGES="$(shell ls -l | awk '/^d/ { print $$NF }')"

.PHONY: test-all
test-all:  ## test all images
	$(MAKE) test -e IMAGES="$(shell ls -l | awk '/^d/ { print $$NF }')"
