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

DOCNAME=$1

if [ -z "$DOCNAME" ] ; then
    echo "usage $0 DOCNAME"
    exit 1
fi

sphinx-build -b gettext doc/$DOCNAME/source/ doc/$DOCNAME/source/locale/

# Take care of deleting all temporary files so that git add
# doc/$DOCNAME/source/locale will only add the single pot file.
msgcat doc/$DOCNAME/source/locale/*.pot > doc/$DOCNAME/source/$DOCNAME.pot
rm doc/$DOCNAME/source/locale/*.pot
rm -rf doc/$DOCNAME/source/locale/*.doctrees/
mv doc/$DOCNAME/source/$DOCNAME.pot doc/$DOCNAME/source/locale/$DOCNAME.pot
