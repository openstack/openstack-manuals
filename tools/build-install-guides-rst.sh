#!/bin/bash -e

mkdir -p publish-docs

for distro in obs rdo ubuntu; do
    TAG="${distro}_based"
    GLOSSARY=""
    if [[ ! -e doc/common-rst/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi
    tools/build-rst.sh doc/install-guide-rst  \
        $GLOSSARY --tag $TAG --target "draft/install-guide-rst-${TAG}"
done
