#!/bin/bash

# This script needs to be called from the doc/high-availibilty-guide
# directory!

# Find location of db4-upgrade-xsl:
if [ -e /usr/share/xml/docbook/stylesheet/docbook5/db4-upgrade.xsl ] ; then
  DB_UPGRADE=/usr/share/xml/docbook/stylesheet/docbook5/db4-upgrade.xsl
elif [ -e  /usr/share/xml/docbook/stylesheet/upgrade/db4-upgrade.xsl ] ; then
  DB_UPGRADE=/usr/share/xml/docbook/stylesheet/upgrade/db4-upgrade.xsl
else
  echo "db4-upgrade.xsl not found"
  exit 1
fi

type -P asciidoc > /dev/null 2>&1 || { echo >&2 "asciidoc not installed.  Aborting."; exit 1; }
type -P xsltproc > /dev/null 2>&1 || { echo >&2 "xsltproc not installed.  Aborting."; exit 1; }
type -P xmllint > /dev/null 2>&1 || { echo >&2 "xmllint not installed.  Aborting."; exit 1; }

asciidoc -b docbook -d book -o - ha-guide.txt |  \
xsltproc -o - $DB_UPGRADE - | \
xmllint  --format - | \
sed -e 's,<book,<book xml:id="bk-ha-guide",' | \
sed -e 's,<info,<?rax pdf.url="../openstack-ha-guide-trunk.pdf"?><info,' \
    > bk-ha-guide.xml
