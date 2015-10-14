#!/bin/bash -e

mkdir -p publish-docs

TAGS=${1:-obs rdo ubuntu debian}

LINKCHECK=""
if [[ $# > 0 ]] ; then
    if [ "$1" = "--linkcheck" ] ; then
        LINKCHECK="$1"
    fi
fi

title_org=$(grep "title::" doc/install-guide/source/index.rst | \
              awk '{print substr($0, index($0, "::")+3)}')

trap "sed -i -e \"s/\.\. title::.*/.. title:: ${title_org}/\" \
  doc/install-guide/source/index.rst" EXIT

for tag in $TAGS; do
    GLOSSARY=""
    if [[ ! -e doc/common-rst/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi
    title=$(grep -m 1 -A 5 ".. only:: ${tag}" \
              doc/install-guide/source/index.rst | \
              sed -n 4p | sed -e 's/^ *//g')
    sed -i -e "s/\.\. title::.*/.. title:: ${title}/" \
      doc/install-guide/source/index.rst
    tools/build-rst.sh doc/install-guide  \
        $GLOSSARY --tag ${tag} --target "draft/install-guide-${tag}" \
        $LINKCHECK

    # Debian uses index-debian, rename it.
    if [[ "$tag" == "debian" ]]; then
        mv publish-docs/draft/install-guide-debian/index-debian.html \
            publish-docs/draft/install-guide-debian/index.html
    fi
    # Remove Debian specific content from other guides
    if [[ "$tag" != "debian" ]]; then
        rm -rf publish-docs/draft/install-guide-$tag/debconf
    fi
done
