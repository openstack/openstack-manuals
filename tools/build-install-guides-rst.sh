#!/bin/bash -e

mkdir -p publish-docs

for tag in obs rdo ubuntu; do
    GLOSSARY=""
    if [[ ! -e doc/common-rst/glossary.rst ]] ; then
        GLOSSARY="--glossary"
    fi
    tools/build-rst.sh doc/install-guide-rst  \
        $GLOSSARY --tag ${tag} --target "draft/install-guide-rst-${tag}"
done
