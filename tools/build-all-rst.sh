#!/bin/bash -e

mkdir -p publish-docs

GLOSSARY="--glossary"

for guide in user-guide user-guide-admin networking-guide; do
    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
        --target $guide
    # Build it only the first time
    GLOSSARY=""
done

# Draft guides
for guide in admin-guide-cloud-rst; do
    tools/build-rst.sh doc/$guide --build build \
        --target "draft/$guide"
done
