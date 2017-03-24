#!/bin/bash -e

mkdir -p publish-docs

# Do not build  debian debconf for now, there're no Ocata packages at all.
INDEX=doc/install-guide/source/index.rst

TAGS="obs rdo ubuntu"
LINKCHECK=""
PDF_OPTION=""
while [[ $# > 0 ]] ; do
    option="$1"
    case $option in
        obs)
            TAGS=obs
            ;;
        rdo)
            TAGS=rdo
            ;;
        ubuntu)
            TAGS=ubuntu
            ;;
        --linkcheck)
            LINKCHECK="--linkcheck"
            ;;
        --pdf)
            PDF_OPTION="--pdf"
            ;;
    esac
    shift
done

# For translation work, we should have only one index file,
# because our tools generate translation resources from
# only one index file.
# Therefore, this tool uses one combined index file
# while processing title for each distribution.

# Save and restore the index file
cp -f ${INDEX} ${INDEX}.save
trap "mv -f ${INDEX}.save ${INDEX}" EXIT

# Set this to a sensible value if not set by OpenStack CI.
if [ -z "$ZUUL_REFNAME" ] ; then
    ZUUL_REFNAME="master"
fi

# This marker is needed for infra publishing.
# Note for stable branches, this needs to be the top of each manual.
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID Revision: $ZUUL_NEWREV"

for tag in $TAGS; do
    TARGET="ocata/install-guide-${tag}"
    if [[ "$tag" == "debconf" ]]; then
        # Build the guide with debconf
        # To use debian only contents, use "debian" tag.
        tools/build-rst.sh doc/install-guide-debconf  \
            --tag debian --target "$TARGET" $LINKCHECK $PDF_OPTION
    else
        ##
        # Because Sphinx uses the first heading as title regardless of
        # only directive, replace title directive with the proper title
        # for each distribution to set the title explicitly.

        title=$(grep -A 5 "^.. only:: ${tag}" ${INDEX} | \
                  head -n 6 | sed -n 4p | sed -e 's/^ *//g')
        sed -i -e "s/\.\. title::.*/.. title:: ${title}/" ${INDEX}

        # Build the guide
        tools/build-rst.sh doc/install-guide \
            --tag ${tag} --target "$TARGET" $LINKCHECK $PDF_OPTION
    fi
    # Add this for stable branches
    if [ "$ZUUL_REFNAME" != "master" ] ; then
        echo $MARKER_TEXT > publish-docs/$TARGET/.root-marker
    fi
done
