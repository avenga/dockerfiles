#!/bin/bash -eu

IMAGES="${IMAGES:-}"
if [[ -z $IMAGES ]] ; then
    IMAGES=$(git diff --name-only "$GIT_DIFF" | \
        sort -u | \
        awk 'BEGIN {FS="/"} {print $1}' | \
        uniq | \
        xargs -I % find . -type d -name % -maxdepth 1 -exec basename {} \; \
    )
fi

if [[ -z $IMAGES ]]
then
    echo "Nothing to push."
    exit 0
fi

if [[ -n "$DRY_RUN" ]]; then
    echo "$IMAGES"
    exit 0
else
    # only push images if specific branch
    if [[ "$CURRENT_BRANCH" == "$ONLY_BRANCH" ]]
    then
        echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" "$CI_REGISTRY" --password-stdin
        while IFS= read -r IMAGE_NAME
        do
            # push all tags:
            docker push "$IMAGE_PREFIX$IMAGE_NAME"
        done < <(echo "$IMAGES" | tr " " "\n")
    else
        echo "Skipping since not on ONLY_BRANCH $ONLY_BRANCH"
    fi
fi
