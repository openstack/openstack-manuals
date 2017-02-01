#!/bin/bash -e

mkdir -p publish-docs

# Set this to a sensible value if not set by OpenStack CI.
if [ -z "$ZUUL_REFNAME" ] ; then
    ZUUL_REFNAME="master"
fi

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID Revision: $ZUUL_NEWREV"

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

PDF_OPTION="--pdf"

# PDF targets for Install guides are dealt in build-install-guides-rst.sh
PDF_TARGETS=( 'arch-design'\
              'ha-guide' 'image-guide' 'networking-guide'\
              'ops-guide' 'user-guide' )

# Note that these guides are only build for master branch
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
    # For stable branches, we need to mark the specific guides.
    if [ "$ZUUL_REFNAME" != "master" ] ; then
        echo $MARKER_TEXT > publish-docs/draft/$guide/.root-marker
    fi
done

tools/build-install-guides-rst.sh $LINKCHECK

# For master, just mark the root
if [ "$ZUUL_REFNAME" = "master" ] ; then
    echo $MARKER_TEXT > publish-docs/.root-marker
fi
