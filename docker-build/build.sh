#!/bin/bash -eu

VERSION=$(git show --quiet --format="%cd-%h" --date=short --abbrev=8)

while IFS= read -r LINE
do
  if [ -d "$LINE" ]
  then
    DOCKERFILE="${DOCKERFILE:-$WORKDIR/$LINE/Dockerfile}"
    CONTEXT="${CONTEXT:-$WORKDIR/$LINE}"
    TAG=$IMAGE_PREFIX$LINE:$IMAGE_TAG
    COMMIT_TAG=$IMAGE_PREFIX$LINE:$VERSION
    DOCKERFILE_FLAG=""
    if [ -e $DOCKERFILE ]
    then
      DOCKERFILE_FLAG="--file $DOCKERFILE"
    fi
    docker build --pull --no-cache \
      --build-arg IMAGE_PREFIX=$IMAGE_PREFIX \
      --tag $TAG \
      --tag $COMMIT_TAG \
      --target $TARGET \
      $DOCKERFILE_FLAG \
      $CONTEXT
  fi
done < <(echo "$IMAGE" | tr " " "\n")
