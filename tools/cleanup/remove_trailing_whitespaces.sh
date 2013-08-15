#!/bin/sh

## copyright: B1 Systems GmbH   <info@b1-systems.de>,    2013.
##    author: Christian Berendt <berendt@b1-systems.de>, 2013.
##   license: Apache License, Version 2.0

# Call ./tools/cleanup/remove_trailing_whitespaces.sh in the
# root of openstack-manuals.

files=$(find doc/src/docbkx -name *.xml -not -name pom.xml)
for file in $files; do
    sed -i -e 's/[[:space:]]*$//' $file
done
