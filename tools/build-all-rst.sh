#!/bin/bash -e

mkdir -p publish-docs

GLOSSARY="--glossary"

for guide in user-guide user-guide-admin networking-guide admin-guide-cloud; do
    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
        --target $guide
    # Build it only the first time
    GLOSSARY=""
done

# Draft guides
for guide in contributor-guide; do
    tools/build-rst.sh doc/$guide --build build \
        --target "draft/$guide"
done

tools/build-install-guides-rst.sh
