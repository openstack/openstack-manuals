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

mkdir -p publish-docs

# We only publish changed manuals.
# For kilo, only publish Install Guide and Config Reference
if [ "$PUBLISH" = "publish" ] ; then
    openstack-doc-test --check-build --publish --only-book install-guide --only-book config-reference
else
    openstack-doc-test --check-build --only-book install-guide --only-book config-reference
fi
