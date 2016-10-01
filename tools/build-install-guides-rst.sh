#!/bin/bash -e

mkdir -p publish-docs

TAGS=${1:-obs rdo ubuntu debian}
INDEX=doc/install-guide/source/index.rst

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

# For translation work, we should have only one index file,
# because our tools generate translation resources from
# only one index file.
# Therefore, this tool uses one combined index file
# while processing title and toctree for each distribution.

# Save and restore the index file
cp -f ${INDEX} ${INDEX}.save
trap "mv -f ${INDEX}.save ${INDEX}" EXIT

# This marker is needed for infra publishing
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID"

for tag in $TAGS; do
    GLOSSARY=""
    if [[ ! -e doc/common-rst/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi

    ##
    # Because Sphinx uses the first heading as title regardless of
    # only directive, replace title directive with the proper title
    # for each distribution to set the title explicitly.

    title=$(grep -m 1 -A 5 "^.. only:: ${tag}" ${INDEX} | \
              sed -n 4p | sed -e 's/^ *//g')
    sed -i -e "s/\.\. title::.*/.. title:: ${title}/" ${INDEX}

    ##
    # Sphinx builds the navigation before processing directives,
    # so the conditional toctree does not work.
    # We need to prepare toctree depending on distribution
    # only with one toctree before exectuing sphinx-build.

    # Get line number of each tag
    lineno_start=$(grep -n "^Contents" ${INDEX} | sed -e 's/:.*//')
    lineno_end=$(grep -n "^.. end of contents" ${INDEX} | sed -e 's/:.*//')
    lineno_debian=$(grep -n "^.. only:: debian" ${INDEX} \
        | tail -1 | sed -e 's/:.*//')
    lineno_notdebian=$(grep -n "^.. only:: [^d]" ${INDEX} \
        | tail -1 | sed -e 's/:.*//')

    # Remove indent for pseudo only directive
    sed -i "${lineno_start},${lineno_end} s/^  *\.\. toctree/.. toctree/" ${INDEX}
    sed -i "${lineno_start},${lineno_end} s/^  */   /" ${INDEX}

    # Remove unnecessary toctree for each distribution
    if [[ "$tag" == "debian" ]]; then
        sed -i "${lineno_notdebian},${lineno_debian}d" ${INDEX}
    else
        sed -i "${lineno_debian},$((${lineno_end}-1))d" ${INDEX}
        sed -i "${lineno_notdebian}d" ${INDEX}
    fi

    # Build the guide
    tools/build-rst.sh doc/install-guide  \
        $GLOSSARY --tag ${tag} --target "liberty/install-guide-${tag}" \
        $LINKCHECK
    echo $MARKER_TEXT > publish-docs/liberty/install-guide-${tag}/.root-marker

    # Restore the index file
    cp -f ${INDEX}.save ${INDEX}

    ##
    # Remove Debian specific content from other guides
    if [[ "$tag" != "debian" ]]; then
        rm -rf publish-docs/liberty/install-guide-$tag/debconf
    fi
done
