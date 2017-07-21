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

if [ "$PUBLISH" = "build" ] ; then
    # Create index page for viewing
    openstack-indexpage publish-docs
fi
