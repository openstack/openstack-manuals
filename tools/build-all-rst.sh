#!/bin/bash -e

mkdir -p publish-docs

GLOSSARY="--glossary"

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

# For stable branches, we only have the Install Guide to publish.
# All others are uncommented but left for reference.

#for guide in user-guide user-guide-admin networking-guide admin-guide-cloud contributor-guide; do
#    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
#        --target $guide $LINKCHECK
#    # Build it only the first time
#    GLOSSARY=""
#done
#
# Versioned RST guides
for guide in networking-guide; do
    tools/build-rst.sh doc/$guide --glossary --build build \
        --target "liberty/$guide" $LINKCHECK
done

tools/build-install-guides-rst.sh $LINKCHECK
