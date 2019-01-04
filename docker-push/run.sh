#!/bin/bash -eu

# only push images if specific branch
if [[ "$CURRENT_BRANCH" == "$ONLY_BRANCH" ]]
then
  echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" "$CI_REGISTRY" --password-stdin
  while IFS= read -r IMAGE_NAME
  do
    docker push "$IMAGE_PREFIX$IMAGE_NAME"
  done < <(echo "$IMAGES" | tr " " "\n")
fi
