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

DOCNAME=$1

if [ -z "$DOCNAME" ] ; then
    echo "usage $0 DOCNAME"
    exit 1
fi

# We're not doing anything for this directory. But we need to handle
# it by this script so that the common-rst.pot file gets registered.
if [[ "$DOCNAME" = "common-rst" ]] ; then
    exit 0
fi

# Build Glossary
tools/glossary2rst.py doc/common-rst/glossary.rst
# First remove the old pot file, otherwise the new file will contain
# old references

rm -f doc/$DOCNAME/source/locale/$DOCNAME.pot

# We need to extract all strings, so add all supported tags
TAG=""
if [ ${DOCNAME} = "install-guide" ] ; then
    TAG="-t obs -t rdo -t ubuntu -t debian"
fi
sphinx-build -b gettext $TAG doc/$DOCNAME/source/ doc/$DOCNAME/source/locale/

# Update common
sed -i -e 's/^"Project-Id-Version: [a-zA-Z0-9\. ]+\\n"$/"Project-Id-Version: \\n"/' \
    doc/$DOCNAME/source/locale/common.pot
# Create the common pot file
msgcat --sort-by-file doc/common-rst/source/locale/common-rst.pot \
    doc/$DOCNAME/source/locale/common.pot | \
    sed -e 's/^"Project-Id-Version: [a-zA-Z0-9\. ]+\\n"$/"Project-Id-Version: \\n"/' | \
    awk '$0 !~ /^\# [a-z0-9]+$/' | awk '$0 !~ /^\# \#-\#-\#-\#-\# /' \
    > doc/$DOCNAME/source/locale/common-rst.pot
mv -f doc/$DOCNAME/source/locale/common-rst.pot doc/common-rst/source/locale/common-rst.pot
rm -f doc/$DOCNAME/source/locale/common.pot

# Simplify metadata
rm -f doc/common-rst/source/locale/dummy.po
cat << EOF > doc/common-rst/source/locale/dummy.po
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
msgmerge -N doc/common-rst/source/locale/dummy.po \
  doc/common-rst/source/locale/common-rst.pot > doc/common-rst/source/locale/tmp.pot
mv -f doc/common-rst/source/locale/tmp.pot doc/common-rst/source/locale/common-rst.pot
rm -f doc/common-rst/source/locale/dummy.po

# Take care of deleting all temporary files so that git add
# doc/$DOCNAME/source/locale will only add the single pot file.
# Remove UUIDs, those are not necessary and change too often
msgcat --sort-by-file doc/$DOCNAME/source/locale/*.pot | \
  awk '$0 !~ /^\# [a-z0-9]+$/' > doc/$DOCNAME/source/$DOCNAME.pot
rm  doc/$DOCNAME/source/locale/*.pot
rm -rf doc/$DOCNAME/source/locale/.doctrees/
mv doc/$DOCNAME/source/$DOCNAME.pot doc/$DOCNAME/source/locale/$DOCNAME.pot
