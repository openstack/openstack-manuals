#!/bin/bash -e

mkdir -p publish-docs

TAGS=${1:-obs rdo ubuntu}
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
# while processing title for each distribution.

# Save and restore the index file
cp -f ${INDEX} ${INDEX}.save
trap "mv -f ${INDEX}.save ${INDEX}" EXIT

for tag in $TAGS; do
    GLOSSARY=""
    if [[ ! -e doc/common/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi

    ##
    # Because Sphinx uses the first heading as title regardless of
    # only directive, replace title directive with the proper title
    # for each distribution to set the title explicitly.

    title=$(grep -m 1 -A 5 "^.. only:: ${tag}" ${INDEX} | \
              sed -n 4p | sed -e 's/^ *//g')
    sed -i -e "s/\.\. title::.*/.. title:: ${title}/" ${INDEX}

    # Build the guide
    tools/build-rst.sh doc/install-guide  \
        $GLOSSARY --tag ${tag} --target "mitaka/install-guide-${tag}" \
        $LINKCHECK
done
