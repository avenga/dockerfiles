#!/usr/bin/env bash
set -eu

IMAGES="${IMAGES:-}"
DRY_RUN="${DRY_RUN:-}"

if [[ -z $IMAGES ]] ; then
    IMAGES=$(git diff --name-only "$GIT_DIFF" | \
        sort -u | \
        awk 'BEGIN {FS="/"} {print $1}' | \
        uniq | \
        xargs -I % find . -type d -name % -maxdepth 1 -exec basename {} \; \
    )
fi

if [[ -z $IMAGES ]]; then
    echo "Nothing to push."
    exit 0
fi

# only push images if specific branch and not dry run
if [[ -n "$DRY_RUN" ]] || [[ "$CURRENT_BRANCH" != "$ONLY_BRANCH" ]]; then
    [[ "$CURRENT_BRANCH" != "$ONLY_BRANCH" ]] && echo "Skipping push since CURRENT_BRANCH $CURRENT_BRANCH is not equal to ONLY_BRANCH $ONLY_BRANCH"
    # for all images
    for image in $IMAGES; do
        # for all tags that are equal to latest
        for tagged_image in $(docker image inspect --format $'{{range .RepoTags}}{{.}} {{end}}' "$IMAGE_PREFIX$image:latest"); do
            # print it
            echo "$tagged_image"
        done
    done
    exit 0
fi
  

echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" "$CI_REGISTRY" --password-stdin

# for all images
for image in $IMAGES; do
    # for all tags that are equal to latest
    for tagged_image in $(docker image inspect --format $'{{range .RepoTags}}{{.}} {{end}}' "$IMAGE_PREFIX$image"); do
        # push it
        docker push "$tagged_image"
    done
done
