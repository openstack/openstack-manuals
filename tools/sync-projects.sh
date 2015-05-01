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

function copy_rst {
    target=$1
    # Copy over some RST files
    mkdir -p $target
    tools/glossary2rst.py $PROJECT_DIR/$target

    for filename in doc/users-guides/source/common/app_support.rst; do
        cp $filename $PROJECT_DIR/$target
    done
    (cd $PROJECT_DIR; git add $target)
}

case "$PROJECT_DIR" in
    api-site)
        copy_rst firstapp/source/imported/
        ;;
    ha-guide)
        copy_rst doc/ha-guide/source/imported
        GLOSSARY_SUB_DIR="doc/glossary"
        ENT_DIR="high-availability-guide"
        CHECK_MARK_DIR="figures"
        ;;
    operations-guide)
        GLOSSARY_SUB_DIR="doc/glossary"
        ENT_DIR="openstack-ops"
        CHECK_MARK_DIR="figures"
        ;;
    security-doc)
        GLOSSARY_SUB_DIR="glossary"
        ENT_DIR="security-guide"
        CHECK_MARK_DIR="static"
        ;;
    *)
        echo "$PROJECT_DIR not handled"
        exit 1
        ;;
esac

if [[ "$PROJECT" != "api-site" ]] ; then
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
    sed -i -e "s|imagedata fileref=\"../common/figures|imagedata fileref=\"$CHECK_MARK_DIR|" \
        $GLOSSARY_DIR/../$ENT_DIR/openstack.ent

    # Add files
    (cd $PROJECT_DIR; git add $GLOSSARY_SUB_DIR \
        $GLOSSARY_SUB_DIR/../$ENT_DIR/openstack.ent)
fi
