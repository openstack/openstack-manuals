#!/bin/bash -xe
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

PUBLISH=$1

if [[ -z "$PUBLISH" ]] ; then
    echo "usage $0 (publish|check)"
    exit 1
fi

# Copy files from draft to named branch and replace all links from
# draft with links to the branch
function copy_to_branch {
    BRANCH=$1

    if [ -e publish-docs/draft ] ; then

        # Copy files over
        mkdir -p publish-docs/$BRANCH
        cp -a publish-docs/draft/* publish-docs/$BRANCH/
        # We don't need this file
        rm -f publish-docs/$BRANCH/draft-index.html

        for f in $(find publish-docs/$BRANCH -name "atom.xml"); do
            sed -i -e "s|/draft/|/$BRANCH/|g" $f
        done
        for f in $(find publish-docs/$BRANCH -name "*.html"); do
            sed -i -e "s|/draft/|/$BRANCH/|g" $f
        done
    fi
}

mkdir -p publish-docs

GLOSSARY="--glossary"
for guide in user-guide user-guide-admin networking-guide; do
    tools/build-rst.sh doc/$guide $GLOSSARY --build build \
        --target $guide
    # Build it only the first time
    GLOSSARY=""
done

# Build the www pages so that openstack-doc-test creates a link to
# www/www-index.html.
if [ "$PUBLISH" = "build" ] ; then
    python tools/www-generator.py --source-directory www/ \
        --output-directory publish-docs/www/
    rsync -a www/static/ publish-docs/www/
    # publish-docs/www-index.html is the trigger for openstack-doc-test
    # to include the file.
    mv publish-docs/www/www-index.html publish-docs/www-index.html
fi
if [ "$PUBLISH" = "publish" ] ; then
    python tools/www-generator.py --source-directory www/ \
        --output-directory publish-docs
    rsync -a www/static/ publish-docs/
    # Don't publish this file
    rm publish-docs/www-index.html
fi

# We only publish changed manuals.
if [ "$PUBLISH" = "publish" ] ; then
    openstack-doc-test --check-build --publish
    # For publishing to both /draft and /BRANCH
    copy_to_branch kilo
else
    openstack-doc-test --check-build
fi
