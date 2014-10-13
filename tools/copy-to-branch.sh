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
#
# Copy files from trunk to named branch and replace all links from
# trunk with links to the branch

BRANCH=$1

if [ -z "$BRANCH" ] ; then
    echo "usage $0 BRANCH"
    exit 1
fi

if [ -e publish-docs/trunk ] ; then

    # Copy files over
    cp -a publish-docs/trunk publish-docs/$BRANCH

    for f in $(find publish-docs/$BRANCH -name "atom.xml") ; do
        sed -i -e "s|/trunk/|/$BRANCH/|g" $f
    done
    for f in $(find publish-docs/$BRANCH -name "*.html") ; do
        sed -i -e "s|/trunk/|/$BRANCH/|g" $f
    done
fi
