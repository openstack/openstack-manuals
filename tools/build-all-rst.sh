#!/bin/bash -e

mkdir -p publish-docs

GLOSSARY="--glossary"

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

for guide in user-guide user-guide-admin admin-guide-cloud \
    contributor-guide image-guide arch-design cli-reference; do
    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
        --target $guide $LINKCHECK
    # Build it only the first time
    GLOSSARY=""
done

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in networking-guide arch-design-draft config-reference; do
    tools/build-rst.sh doc/$guide --build build \
        --target "draft/$guide" $LINKCHECK
done

tools/build-install-guides-rst.sh $LINKCHECK
