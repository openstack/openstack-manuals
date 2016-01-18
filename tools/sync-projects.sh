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
    for lang in ja ; do
        TARGET=$PROJECT_DIR/$target/source/locale/$lang/LC_MESSAGES
        mkdir -p $TARGET
        cp doc/common-rst/source/locale/$lang/LC_MESSAGES/common-rst.po \
            $TARGET
    done
    (cd $PROJECT_DIR; git add $target/source/locale/)
}

function copy_rst {
    target=$1
    # Copy over some RST files
    mkdir -p $PROJECT_DIR/$target
    tools/glossary2rst.py $PROJECT_DIR/$target/glossary.rst

    for filename in app_support.rst conventions.rst; do
        cp doc/common-rst/$filename $PROJECT_DIR/$target
    done
    (cd $PROJECT_DIR; git add $target)
}


function copy_glossary_xml {
    GLOSSARY_SUB_DIR=$1
    ENT_DIR=$2
    CHECK_MARK_DIR=$3

    GLOSSARY_DIR="$PROJECT_DIR/$GLOSSARY_SUB_DIR"

    cp doc/glossary/glossary-terms.xml $GLOSSARY_DIR/
    # Copy only Japanese and zh_CN translations since ha-guide,
    # security-guide, and operations-guide are only translated to Japanese
    # currently while the ha-guide is additionally translated to zh_CN.
    # Training-guides is not translated at all.
    cp doc/glossary/locale/{ja,zh_CN}.po $GLOSSARY_DIR/locale/
    sed -i -e "s|\"../common/entities/openstack.ent\"|\"../$ENT_DIR/openstack.ent\"|" \
        $GLOSSARY_DIR/glossary-terms.xml
    (cd $PROJECT_DIR; git add $GLOSSARY_SUB_DIR)

    # Sync entitites file
    cp doc/common/entities/openstack.ent $GLOSSARY_DIR/../$ENT_DIR/

    # Add files
    (cd $PROJECT_DIR; git add $GLOSSARY_SUB_DIR \
        $GLOSSARY_SUB_DIR/../$ENT_DIR/openstack.ent)
}

case "$PROJECT_DIR" in
    api-site)
        copy_rst common-rst
        copy_rst_trans common-rst
        ;;
    ha-guide)
        copy_rst doc/common-rst
        # TODO(jaegerandi): Copy over once translations are ready
        #copy_rst_trans doc/common-rst
        ;;
    operations-guide)
        copy_glossary_xml "doc/glossary" "openstack-ops" "figures"
        ;;
    security-doc)
        copy_rst common-rst
        copy_rst_trans common-rst
        ;;
    *)
        echo "$PROJECT_DIR not handled"
        exit 1
        ;;
esac
