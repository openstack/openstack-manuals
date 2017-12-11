#!/bin/bash -e

mkdir -p publish-docs

# Set this to a sensible value if not set by OpenStack CI.
if [ -z "$ZUUL_BRANCH" ] ; then
    ZUUL_BRANCH="stable/ocata"
fi

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_BRANCH Build: $ZUUL_UUID Revision: $ZUUL_NEWREF"

LINKCHECK=""
PDF_OPTION=""
while [[ $# > 0 ]] ; do
    option="$1"
    case $option in
        --linkcheck)
            LINKCHECK="--linkcheck"
            ;;
        --pdf)
            PDF_OPTION="--pdf"
            ;;
    esac
    shift
done

# PDF targets for Install guides are dealt in build-install-guides-rst.sh
PDF_TARGETS=( 'arch-design'\
              'ha-guide' 'image-guide' 'networking-guide'\
              'ops-guide' 'user-guide' )

# Note that these guides are only build for master branch, donot build for stable/ocata
#for guide in admin-guide arch-design cli-reference contributor-guide \
#    ha-guide ha-guide-draft image-guide ops-guide user-guide; do
#    if [[ ${PDF_TARGETS[*]} =~ $guide ]]; then
#        tools/build-rst.sh doc/$guide --build build \
#            --target $guide $LINKCHECK $PDF_OPTION
#    else
#        tools/build-rst.sh doc/$guide --build build \
#            --target $guide $LINKCHECK
#    fi
# done

# Draft guides
# This includes guides that we publish from stable branches
# as versioned like the networking-guide.
for guide in user-guide admin-guide cli-reference networking-guide config-reference; do
    if [[ ${PDF_TARGETS[*]} =~ $guide ]]; then
        tools/build-rst.sh doc/$guide --build build \
            --target "ocata/$guide" $LINKCHECK $PDF_OPTION
    else
        tools/build-rst.sh doc/$guide --build build \
            --target "ocata/$guide" $LINKCHECK
    fi
    echo $MARKER_TEXT > publish-docs/ocata/$guide/.root-marker
done

tools/build-install-guides-rst.sh $LINKCHECK $PDF_OPTION
