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

## Shell Opts
set -e -u -x

mkdir -p publish-docs/html

# Build all RST guides including PDF files
tools/build-all-rst.sh --pdf

# Build website
python3 tools/www-generator.py --source-directory www/ \
    --output-directory publish-docs/html --publish
rsync -a www/static/ publish-docs/html/

# Don't publish these files
rm -rf publish-docs/html/project-data
