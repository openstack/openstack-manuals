#!/bin/bash -xe

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

PROJECT_DIR=$1

if [ -z "$PROJECT_DIR" ] ; then
    echo "Usage: $0 PROJECT_DIR"
    exit 1
fi

function copy_rst_trans {
    target=$1
    # Copy over some RST files
    mkdir -p $PROJECT_DIR/$target/source/locale
    for lang in id ja ; do
        TARGET=$PROJECT_DIR/$target/source/locale/$lang/LC_MESSAGES
        mkdir -p $TARGET
        cp doc/common/source/locale/$lang/LC_MESSAGES/common.po \
            $TARGET
    done
    (cd $PROJECT_DIR; git add $target/source/locale/)
}

function copy_rst {
    target=$1
    # Copy over some RST files
    mkdir -p $PROJECT_DIR/$target

    for filename in app-support.rst conventions.rst glossary.rst; do
        cp doc/common/$filename $PROJECT_DIR/$target
    done
    (cd $PROJECT_DIR; git add $target)
}


case "$PROJECT_DIR" in
    security-doc)
        copy_rst common
        copy_rst_trans common
        ;;
    ha-guide|operations-guide)
        copy_rst doc/source/common
        ;;
    *)
        echo "$PROJECT_DIR not handled"
        exit 1
        ;;
esac
