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
    echo "usage $0 (publish|build)"
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
        # We don't need these draft guides on the branch
        rm -rf publish-docs/$BRANCH/arch-design-to-archive
        rm -rf publish-docs/$BRANCH/ops-guide

        for f in $(find publish-docs/$BRANCH -name "atom.xml"); do
            sed -i -e "s|/draft/|/$BRANCH/|g" $f
        done
        for f in $(find publish-docs/$BRANCH -name "*.html"); do
            sed -i -e "s|/draft/|/$BRANCH/|g" $f
        done
    fi
}

mkdir -p publish-docs

# Build all RST guides including PDF files
tools/build-all-rst.sh --pdf

# Build the www pages so that openstack-indexpage creates a link to
# www/www-index.html.
if [ "$PUBLISH" = "build" ] ; then
    python tools/www-generator.py --source-directory www/ \
        --output-directory publish-docs/www/
    rsync -a www/static/ publish-docs/www/
    # publish-docs/www-index.html is the trigger for openstack-indexpage
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

# For publishing to both /draft and /BRANCH
#if [ "$PUBLISH" = "publish" ] ; then
#    # For publishing to both /draft and /BRANCH
#    copy_to_branch ocata
#fi

if [ "$PUBLISH" = "build" ] ; then
    # Create index page for viewing
    openstack-indexpage publish-docs
fi
