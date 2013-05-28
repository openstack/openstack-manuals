#!/usr/bin/env python
'''

Usage:
    validate.py [path]

Validates all xml files against the DocBook 5 RELAX NG schema.

Options:
    path     Root directory, defaults to <repo root>/doc/src/doc/docbkx

Ignores pom.xml files and subdirectories named "target".

Requires Python 2.7 or greater (for argparse) and the lxml Python library.

'''
from lxml import etree

import argparse
import os
import subprocess
import sys
import urllib2

# These are files that are known to not be in DocBook format
EXCEPTIONS = ['ha-guide-docinfo.xml']


def get_schema():
    """Return the DocBook RELAX NG schema"""
    url = "http://www.docbook.org/xml/5.0/rng/docbookxi.rng"
    relaxng_doc = etree.parse(urllib2.urlopen(url))
    return etree.RelaxNG(relaxng_doc)


def validation_failed(schema, doc):
    """Return True if the parsed doc fails against the schema

    This will ignore validation failures of the type: IDREF attribute linkend
    references an unknown ID. This is because we are validating individual
    files that are being imported, and sometimes the reference isn't present
    in the current file."""
    return not schema.validate(doc) and \
        any(log.type_name != "DTD_UNKNOWN_ID" for log in schema.error_log)


def verify_section_tags_have_xmid(doc):
    """Check that all section tags have an xml:id attribute

    Will throw an exception if there's at least one missing"""
    ns = {"docbook": "http://docbook.org/ns/docbook"}
    for node in doc.xpath('//docbook:section', namespaces=ns):
        if "{http://www.w3.org/XML/1998/namespace}id" not in node.attrib:
            raise ValueError("section missing xml:id attribute, line %d" %
                             node.sourceline)


def error_message(error_log):
    """Return a string that contains the error message.

    We use this to filter out false positives related to IDREF attributes
    """
    errs = [str(x) for x in error_log if x.type_name != 'DTD_UNKNOWN_ID']

    # Reverse output so that earliest failures are reported first
    errs.reverse()
    return "\n".join(errs)


def main(rootdir):
    schema = get_schema()

    any_failures = False

    for root, dirs, files in os.walk(rootdir):
        # Don't descend into 'target' subdirectories
        try:
            ind = dirs.index('target')
            del dirs[ind]
        except ValueError:
            pass

        for f in files:
            # Ignore maven files, which are called pom.xml
            if f.endswith('.xml') and f != 'pom.xml' and f not in EXCEPTIONS:
                try:
                    path = os.path.abspath(os.path.join(root, f))
                    doc = etree.parse(path)
                    if validation_failed(schema, doc):
                        any_failures = True
                        print error_message(schema.error_log)
                    verify_section_tags_have_xmid(doc)
                except etree.XMLSyntaxError as e:
                    any_failures = True
                    print "%s: %s" % (path, e)
                except ValueError as e:
                    any_failures = True
                    print "%s: %s" % (path, e)

        if any_failures:
            sys.exit(1)


def default_root():
    """Return the location of openstack-manuals/doc/src/docbkx

    The current working directory must be inside of the openstack-manuals
    repository for this method to succeed"""
    args = ["git", "rev-parse", "--show-toplevel"]
    gitroot = subprocess.check_output(args).rstrip()
    return os.path.join(gitroot, "doc/src/docbkx")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Validate XML files against "
                                     "the DocBook 5 RELAX NG schema")
    parser.add_argument('path', nargs='?', default=default_root(),
                        help="Root directory that contains DocBook files, "
                        "defaults to `git rev-parse --show-toplevel`/doc/src/"
                        "docbkx")
    args = parser.parse_args()
    main(args.path)
