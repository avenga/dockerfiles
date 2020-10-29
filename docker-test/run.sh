#!/usr/bin/env bash
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

# for all images
for image in $IMAGES; do
    if [[ ! -d "$image/tests" ]] ; then
        echo "No tests found for $image"
        continue
    fi
    
    echo "Running test for $image"
    pushd "$image"
    if [[ -f tests/test.sh ]] ; then
        ./tests/test.sh
    else
        bats --tap ./tests
    fi
    popd
done