#!/bin/bash -e

mkdir -p publish-docs

# Do not build  debian debconf for now, there're no Ocata packages at all.
INDEX=doc/install-guide/source/index.rst

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

# Set this to a sensible value if not set by OpenStack CI.
if [ -z "$ZUUL_REFNAME" ] ; then
    ZUUL_REFNAME="master"
fi

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID Revision: $ZUUL_NEWREV"

# Build the guide
tools/build-rst.sh doc/install-guide \
                   --target "draft/install-guide" $LINKCHECK $PDF_OPTION
