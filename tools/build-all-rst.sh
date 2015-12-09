#!/bin/bash -e

mkdir -p publish-docs

# Kilo versioned guides
for guide in networking-guide; do
    tools/build-rst.sh doc/$guide --glossary --build build \
        --target "kilo/$guide"
done
