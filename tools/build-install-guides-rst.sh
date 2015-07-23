#!/bin/bash -e

mkdir -p publish-docs

title_org=$(grep "title::" doc/install-guide-rst/source/index.rst | \
              awk '{print substr($0, index($0, "::")+3)}')

for tag in obs rdo ubuntu; do
    GLOSSARY=""
    if [[ ! -e doc/common-rst/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi
    title=$(grep -m 1 -A 5 ".. only:: ${tag}" \
              doc/install-guide-rst/source/index.rst | \
              sed -n 4p | sed -e 's/^ *//g')
    sed -i -e "s/\.\. title::.*/.. title:: ${title}/" \
      doc/install-guide-rst/source/index.rst
    tools/build-rst.sh doc/install-guide-rst  \
        $GLOSSARY --tag ${tag} --target "draft/install-guide-rst-${tag}"
done

sed -i -e "s/\.\. title::.*/.. title:: ${title_org}/" \
  doc/install-guide-rst/source/index.rst
