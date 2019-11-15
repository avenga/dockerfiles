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
    echo "Nothing to build."
    exit 0
fi

if [[ -n "$DRY_RUN" ]]; then
    echo "$IMAGES"
    exit 0
else
    BUILD_DATE=$(date -u +%FT%H:%M:%SZ)

    while IFS= read -r IMAGE_NAME
    do
        if [ -d "$IMAGE_NAME" ]
        then
            DOCKERFILE="$WORKDIR/$IMAGE_NAME/Dockerfile"
            CONTEXT="$WORKDIR/$IMAGE_NAME"
            TAG=$IMAGE_PREFIX$IMAGE_NAME:$IMAGE_TAG
            COMMIT_TAG=$IMAGE_PREFIX$IMAGE_NAME:$VERSION
            DOCKERFILE_FLAG=""
            if [ -e "$DOCKERFILE" ]
            then
                DOCKERFILE_FLAG="--file $DOCKERFILE"
            fi
            CACHE_FLAG="--no-cache"
            if [[ -n "$CACHE" ]]
            then
                CACHE_FLAG=""
            fi
            PULL_FLAG="--pull"
            if [[ -n "$NO_PULL" ]]
            then
                PULL_FLAG=""
            fi

            COMMAND="docker build $PULL_FLAG $CACHE_FLAG \\
            --build-arg IMAGE_PREFIX=$IMAGE_PREFIX \\
            --tag $TAG \\
            --tag $COMMIT_TAG \\
            --target $TARGET \\
            --label org.opencontainers.image.created=\"$BUILD_DATE\" \\
            --label org.opencontainers.image.revision=\"$VERSION\" \\
            --label org.opencontainers.image.url=\"$LABEL_VCS_URL\" \\
            $DOCKERFILE_FLAG \\
            $CONTEXT"
            echo "$COMMAND"
            eval "$COMMAND"
        fi
    done < <(echo "$IMAGES" | tr " " "\n")
fi
