#!/bin/bash -e

mkdir -p publish-docs

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi
# Set this to a sensible value if not set by OpenStack CI.
if [ -z "$ZUUL_BRANCH" ] ; then
    ZUUL_BRANCH="stable/mitaka"
fi

# Do not build for stable/mitaka, these are only published from master
#for guide in user-guide admin-guide cli-reference; do
#   tools/build-rst.sh doc/$guide --build build \
#       --target "mitaka/$guide" $LINKCHECK
#done

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_BRANCH Build: $ZUUL_UUID Revision: $ZUUL_NEWREF"

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in user-guide admin-guide cli-reference networking-guide config-reference ; do
    tools/build-rst.sh doc/$guide --build build \
        --target "mitaka/$guide" $LINKCHECK
    echo $MARKER_TEXT > publish-docs/mitaka/$guide/.root-marker
done

tools/build-install-guides-rst.sh $LINKCHECK
