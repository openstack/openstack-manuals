#!/bin/bash -e

mkdir -p publish-docs

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

for guide in user-guide admin-guide cli-reference; do
   tools/build-rst.sh doc/$guide --build build \
       --target "mitaka/$guide" $LINKCHECK
done

# This marker is needed for infra publishing
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID"

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in networking-guide config-reference ; do
    tools/build-rst.sh doc/$guide --build build \
        --target "mitaka/$guide" $LINKCHECK
    echo $MARKER_TEXT > publish-docs/mitaka/$guide/.root-marker
done

tools/build-install-guides-rst.sh $LINKCHECK
