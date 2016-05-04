#!/bin/bash -e

mkdir -p publish-docs

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

# Do not build from stable/mitaka
#for guide in user-guide admin-guide \
#    contributor-guide image-guide arch-design cli-reference; do
#    tools/build-rst.sh doc/$guide --build build \
#        --target $guide $LINKCHECK
#done

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in networking-guide config-reference ; do
    tools/build-rst.sh doc/$guide --build build \
        --target "mitaka/$guide" $LINKCHECK
done

tools/build-install-guides-rst.sh $LINKCHECK
