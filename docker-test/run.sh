#!/bin/bash

set -euo pipefail

CHANGES=$(git diff --name-only "$GIT_DIFF" | \
    sort -u | \
    awk 'BEGIN {FS="/"} {print $1}' | \
    uniq | \
    xargs -I % find . -type d -name % -maxdepth 1 -exec basename {} \; \
)
IMAGES="${IMAGES:-$CHANGES}"

if [[ -z $IMAGES ]] ; then
    echo "Nothing to test."
    exit 0
fi

while IFS= read -r IMAGE_NAME
do
    ( cd "$IMAGE_NAME"
    if [[ -d ./tests ]] ; then
        if [[ -f tests/test.sh ]] ; then
            ./tests/test.sh
        else
            bats --tap ./tests
        fi
    else
        echo "No tests found for $IMAGE_NAME"
    fi )
done < <(echo "$IMAGES" | tr " " "\n")
