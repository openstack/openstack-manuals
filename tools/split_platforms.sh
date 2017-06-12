#!/bin/bash
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

toolsdir=$(dirname $0)
install_guide=doc/install-guide/source

python3 $toolsdir/split_platforms.py doc/install-guide/source doc/install-guide \
        rdo obs ubuntu debian

# $ git grep 'only::' | cut -f2- -d: | sed 's/.*:: //g' | sort -ur
# ubuntu or debian
# ubuntu
# rdo or ubuntu or debian or obs
# rdo or ubuntu or debian
# rdo or ubuntu
# rdo or obs or ubuntu
# rdo or obs
# rdo or debian or obs
# rdo
# obs or ubuntu
# obs or rdo or ubuntu
# obs or rdo
# obs or debian
# obs
# debian or ubuntu
# debian
