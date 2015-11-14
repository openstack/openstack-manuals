#!/bin/bash -e

mkdir -p publish-docs

GLOSSARY="--glossary"

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

for guide in user-guide user-guide-admin networking-guide admin-guide-cloud contributor-guide; do
    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
        --target $guide $LINKCHECK
    # Build it only the first time
    GLOSSARY=""
done

# Draft guides
for guide in arch-design-rst config-ref-rst image-guide-rst; do
    tools/build-rst.sh doc/$guide --build build \
        --target "draft/$guide" $LINKCHECK
done

tools/build-install-guides-rst.sh $LINKCHECK
