#!/usr/bin/python

## copyright: B1 Systems GmbH   <info@b1-systems.de>,    2013.
##    author: Christian Berendt <berendt@b1-systems.de>, 2013.
##   license: Apache License, Version 2.0

# Call ./tools/cleanup/remove_unnecessary_spaces.py in the
# root of openstack-manuals.

import os
import re
import tempfile

# should be the same like in tools/validate.py
FILE_EXCEPTIONS = ['ha-guide-docinfo.xml','bk001-ch003-associate-general.xml']

elements = [
    'listitem',
    'para',
    'td',
    'th',
    'command',
    'literal',
    'title',
    'caption',
    'filename',
    'userinput',
    'programlisting'
]

checks = []
for element in elements:
    checks.append(re.compile("(.*<%s>)\s+([\w\-().:!?{}\[\]]+.*\n)" % element)),
    checks.append(re.compile("(.*[\w\-().:!?{}\[\]]+)\s+(<\/%s>.*\n)" % element))

for root, dirs, files in os.walk('doc/src/docbkx/'):
    for f in files:
        if (not (f.endswith('.xml') and
                 f != 'pom.xml' and
                 f not in FILE_EXCEPTIONS)):
            continue
        docfile = os.path.abspath(os.path.join(root, f))
        tmpfile = tempfile.mkstemp()
        tmpfd  = os.fdopen(tmpfile[0], "w")
        match = False
        for line in open(docfile, 'r'):
            for check in checks:
                if check.match(line):
                    line = check.sub(r"\1\2", line)
                    match = True
            tmpfd.write(line)
        tmpfd.close()
        if match:
            os.rename(tmpfile[1], docfile)
        else:
            os.unlink(tmpfile[1])
