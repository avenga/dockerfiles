#!/bin/bash -eu

CHANGES=$(git diff --name-only "$GIT_DIFF" | \
	sort -u | \
	awk 'BEGIN {FS="/"} {print $1}' | \
	uniq | \
	xargs -I % find . -type d -name % -exec basename {} \; \
)
IMAGES="${IMAGES:-$CHANGES}"

# only push images if specific branch
if [[ "$CURRENT_BRANCH" == "$ONLY_BRANCH" ]]
then
  echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" "$CI_REGISTRY" --password-stdin
  while IFS= read -r IMAGE_NAME
  do
		# push all tags:
    docker push "$IMAGE_PREFIX$IMAGE_NAME"
  done < <(echo "$IMAGES" | tr " " "\n")
fi
