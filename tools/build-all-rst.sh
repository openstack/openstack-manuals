#!/bin/bash -e

mkdir -p publish-docs

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

PDF_OPTION="--pdf"

# PDF targets for Install guides are dealt in build-install-guides-rst.sh
PDF_TARGETS=( 'arch-design' 'arch-design-draft' 'cli-reference'\
              'ha-guide' 'networking-guide'\
              'ops-guide' 'user-guide' )

for guide in admin-guide arch-design cli-reference contributor-guide \
    ha-guide image-guide ops-guide user-guide; do
    if [[ ${PDF_TARGETS[*]} =~ $guide ]]; then
        tools/build-rst.sh doc/$guide --build build \
            --target $guide $LINKCHECK $PDF_OPTION
    else
        tools/build-rst.sh doc/$guide --build build \
            --target $guide $LINKCHECK
    fi
done

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in networking-guide arch-design-draft config-reference; do
    if [[ ${PDF_TARGETS[*]} =~ $guide ]]; then
        tools/build-rst.sh doc/$guide --build build \
            --target "draft/$guide" $LINKCHECK $PDF_OPTION
    else
        tools/build-rst.sh doc/$guide --build build \
            --target "draft/$guide" $LINKCHECK
    fi
done

tools/build-install-guides-rst.sh $LINKCHECK

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID Revision: $ZUUL_NEWREV"
echo $MARKER_TEXT > publish-docs/.root-marker
