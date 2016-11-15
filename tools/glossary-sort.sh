#!/bin/bash -xe

# Check that doc/common/glossary entries are alphabetized and prints
# list of entries that should be sorted.

export TMPDIR=`/bin/mktemp -d`
trap "rm -rf $TMPDIR" EXIT

pushd $TMPDIR
GLOSSARY=$OLDPWD/doc/common/glossary.rst

grep '^   [a-zA-Z0-9]' $GLOSSARY > glossary_entries

LC_ALL=C sort --ignore-case glossary_entries -o glossary_entries.sorted

if ! diff glossary_entries glossary_entries.sorted > glossary_entries.diff; then
    echo "The following entries should be alphabetized: "
    cat glossary_entries.diff | grep -e '> '
    exit 1
else
    echo "Glossary alphabetized."
fi

popd
