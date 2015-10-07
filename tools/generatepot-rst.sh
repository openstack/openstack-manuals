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

REPOSITORY=$1
USE_DOC=$2
DOCNAME=$3

if [ $# -lt 3 ] ; then
    echo "usage $0 REPOSITORY USE_DOC DOCNAME"
    exit 1
fi

DIRECTORY=$DOCNAME
TOPDIR=""
if [ "$USE_DOC" = "1" ] ; then
    DIRECTORY="doc/$DOCNAME"
    TOPDIR="doc/"
fi


# We're not doing anything for this directory. But we need to handle
# it by this script so that the common-rst.pot file gets registered.
if [[ "$DOCNAME" = "common-rst" ]] ; then
    exit 0
fi

if [ "$REPOSITORY" = "openstack-manuals" ] ; then
    # Build Glossary
    tools/glossary2rst.py doc/common-rst/glossary.rst
fi
# First remove the old pot file, otherwise the new file will contain
# old references

rm -f ${DIRECTORY}/source/locale/$DOCNAME.pot

# We need to extract all strings, so add all supported tags
TAG=""
if [ ${DOCNAME} = "install-guide" ] ; then
    TAG="-t obs -t rdo -t ubuntu -t debian"
fi
if [ ${DOCNAME} = "firstapp" ] ; then
    TAG="-t libcloud  -t dotnet -t fog -t pkgcloud -t shade"
fi
sphinx-build -b gettext $TAG ${DIRECTORY}/source/ \
    ${DIRECTORY}/source/locale/

if [ "$REPOSITORY" = "openstack-manuals" ] ; then
    # Update common
    sed -i -e 's/^"Project-Id-Version: [a-zA-Z0-9\. ]+\\n"$/"Project-Id-Version: \\n"/' \
        ${DIRECTORY}/source/locale/common.pot
    # Create the common pot file
    msgcat --sort-by-file ${TOPDIR}common-rst/source/locale/common-rst.pot \
        ${DIRECTORY}/source/locale/common.pot | \
        sed -e 's/^"Project-Id-Version: [a-zA-Z0-9\. ]+\\n"$/"Project-Id-Version: \\n"/' | \
        awk '$0 !~ /^\# [a-z0-9]+$/' | awk '$0 !~ /^\# \#-\#-\#-\#-\# /' \
        > ${DIRECTORY}/source/locale/common-rst.pot
    mv -f ${DIRECTORY}/source/locale/common-rst.pot \
        ${TOPDIR}common-rst/source/locale/common-rst.pot
    rm -f ${DIRECTORY}/source/locale/common.pot

    # Simplify metadata
    rm -f ${TOPDIR}common-rst/source/locale/dummy.po
    cat << EOF > ${TOPDIR}common-rst/source/locale/dummy.po
msgid ""
msgstr ""
"Project-Id-Version: \n"
"Report-Msgid-Bugs-To: \n"
"POT-Creation-Date: 2015-01-01 01:01+0900\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
EOF
    msgmerge -N ${TOPDIR}common-rst/source/locale/dummy.po \
        ${TOPDIR}common-rst/source/locale/common-rst.pot \
        > ${TOPDIR}common-rst/source/locale/tmp.pot
    mv -f ${TOPDIR}common-rst/source/locale/tmp.pot \
        ${TOPDIR}common-rst/source/locale/common-rst.pot
    rm -f ${TOPDIR}common-rst/source/locale/dummy.po
else
    # common-rst is translated as part of openstack-manuals, do not
    # include the file in the combined tree.
    rm ${DIRECTORY}/source/locale/common.pot
fi

# Take care of deleting all temporary files so that
# "git add ${DIRECTORY}/source/locale" will only add the
# single pot file.
# Remove UUIDs, those are not necessary and change too often
msgcat --sort-by-file ${DIRECTORY}/source/locale/*.pot | \
  awk '$0 !~ /^\# [a-z0-9]+$/' > ${DIRECTORY}/source/$DOCNAME.pot
rm  ${DIRECTORY}/source/locale/*.pot
rm -rf ${DIRECTORY}/source/locale/.doctrees/
mv ${DIRECTORY}/source/$DOCNAME.pot ${DIRECTORY}/source/locale/$DOCNAME.pot
