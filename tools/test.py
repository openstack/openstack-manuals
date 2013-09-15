#!/usr/bin/env python
'''

Usage:
    test.py [path]

Validates all xml files against the DocBook 5 RELAX NG schema, and
attempts to build all books.

Options:
    path     Root directory, defaults to <repo root>/doc

Ignores pom.xml files and subdirectories named "target".

Requires:
    - Python 2.7 or greater (for argparse)
    - lxml Python library
    - Maven

'''
from lxml import etree

import argparse
import multiprocessing
import os
import re
import subprocess
import sys
import urllib2

# These are files that are known to not be in DocBook format
FILE_EXCEPTIONS = ['st-training-guides.xml', 'ha-guide-docinfo.xml', 'bk001-ch003-associate-general.xml', 'basic-install-pom.xml']

# These are books that we aren't checking yet
BOOK_EXCEPTIONS = []

RESULTS_OF_BUILDS = []

# NOTE(berendt): check_output as provided in Python 2.7.5 to make script
#                usable with Python < 2.7
def check_output(*popenargs, **kwargs):
    """Run command with arguments and return its output as a byte string.

    If the exit code was non-zero it raises a CalledProcessError.  The
    CalledProcessError object will have the return code in the returncode
    attribute and output in the output attribute.
    """
    if 'stdout' in kwargs:
        raise ValueError('stdout argument not allowed, it will be overridden.')
    process = subprocess.Popen(stdout=subprocess.PIPE, *popenargs, **kwargs)
    output, unused_err = process.communicate()
    retcode = process.poll()
    if retcode:
        cmd = kwargs.get("args")
        if cmd is None:
            cmd = popenargs[0]
        raise subprocess.CalledProcessError(retcode, cmd, output=output)
    return output


def get_schema():
    """Return the DocBook RELAX NG schema"""
    url = "http://docbook.org/xml/5.1CR1/rng/docbookxi.rng"
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


def verify_nice_usage_of_whitespaces(docfile):
    """Check that no unnecessary whitespaces are used"""
    checks = [
        re.compile(".*\s+\n$"),
    ]

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

    for element in elements:
        checks.append(re.compile(".*<%s>\s+[\w\-().:!?{}\[\]]+.*\n" % element)),
        checks.append(re.compile(".*[\w\-().:!?{}\[\]]+\s+<\/%s>.*\n" % element))

    lc = 0
    affected_lines = []
    for line in open(docfile, 'r'):
        lc = lc + 1
        for check in checks:
            if check.match(line) and lc not in affected_lines:
                affected_lines.append(str(lc))

    if len(affected_lines) > 0:
        raise ValueError("trailing or unnecessary whitespaces "
            "in following lines: %s" % ", ".join(affected_lines))


def error_message(error_log):
    """Return a string that contains the error message.

    We use this to filter out false positives related to IDREF attributes
    """
    errs = [str(x) for x in error_log if x.type_name != 'DTD_UNKNOWN_ID']

    # Reverse output so that earliest failures are reported first
    errs.reverse()
    return "\n".join(errs)


# Check whether only files in www got updated
def only_www_touched():
    try:
        args = ["git", "diff", "--name-only", "HEAD", "HEAD~1"]
        modified_files = check_output(args).strip().split()
    except (CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)

    www_changed = False
    other_changed = False
    for f in modified_files:
        if f.startswith("www/"):
            www_changed = True
        else:
            other_changed = True

    return www_changed and not other_changed

def get_modified_files():
    try:
        args = ["git", "diff", "--name-only", "--relative", "HEAD", "HEAD~1"]
        modified_files = check_output(args).strip().split()
    except (subprocess.CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)
    return modified_files

def check_deleted_files(rootdir, file_exceptions):
    """ Check whether files got deleted and verify that no other file references them.

    """
    print("\nChecking for removed files")
    modified_files = get_modified_files()
    deleted_files = []
    any_removed = False
    for f in modified_files:
        full = os.path.abspath(f)
        if not os.path.exists(full):
            print("  Removed file: %s" % f)
            deleted_files.append(full)
            any_removed = True

    if any_removed:
        # Figure out whether this file was included anywhere
        missing_reference = False

        for root, dirs, files in os.walk(rootdir):
            # Don't descend into 'target' subdirectories
            try:
                ind = dirs.index('target')
                del dirs[ind]
            except ValueError:
                pass

            os.chdir(root)

            for f in files:
                if (f.endswith('.xml') and
                    f != 'pom.xml' and
                    f not in file_exceptions):
                    path = os.path.abspath(os.path.join(root, f))
                    doc = etree.parse(path)
                    ns = {"xi": "http://www.w3.org/2001/XInclude"}
                    for node in doc.xpath('//xi:include', namespaces=ns):
                        href = node.get('href')
                        if (href.endswith('.xml') and
                            os.path.abspath(href) in deleted_files):
                            print("  File %s has an xi:include on deleted file %s " % (f, href))
                            missing_reference = True
            if missing_reference:
                sys.exit(1)

def validate_individual_files(rootdir, exceptions, force=False, niceness=False, voting=True):
    schema = get_schema()

    any_failures = False
    modified_files = get_modified_files()
    if force:
        print("\nValidating all files")
    else:
        modified_files = get_modified_files()
        print("\nFollowing files will be validated:")
        for f in modified_files:
            print(">>> %s" % f)
        modified_files = map(lambda x: os.path.abspath(x), modified_files)

    for root, dirs, files in os.walk(rootdir):
        # Don't descend into 'target' subdirectories
        try:
            ind = dirs.index('target')
            del dirs[ind]
        except ValueError:
            pass

        for f in files:
            # Ignore maven files, which are called pom.xml
            if (f.endswith('.xml') and
                f != 'pom.xml' and
                f not in exceptions):
                try:
                    path = os.path.abspath(os.path.join(root, f))
                    if not force and path not in modified_files:
                        continue
                    doc = etree.parse(path)
                    if validation_failed(schema, doc):
                        any_failures = True
                        print(error_message(schema.error_log))
                    verify_section_tags_have_xmid(doc)
                    if niceness:
                        verify_nice_usage_of_whitespaces(os.path.join(root, f))
                except etree.XMLSyntaxError as e:
                    any_failures = True
                    print("%s: %s" % (path, e))
                except ValueError as e:
                    any_failures = True
                    print("%s: %s" % (path, e))

    if voting and any_failures:
        sys.exit(1)
    print("Validation passed.\n")



def logging_build_book(result):
    RESULTS_OF_BUILDS.append(result)


def build_book(rootdir, book):
    os.chdir(book)
    result = True
    returncode = 0
    try:
        output = subprocess.check_output(
            ["mvn", "clean", "generate-sources"],
            stderr=subprocess.STDOUT
        )
    except subprocess.CalledProcessError as e:
        output = e.output
        returncode = e.returncode
        result = False

    return (os.path.basename(book), result, output, returncode)


def build_affected_books(rootdir, book_exceptions, file_exceptions, force=False, voting=True):
    """Build all the books which are affected by modified files.

    Looks for all directories with "pom.xml" and checks if a
    XML file in the directory includes a modified file. If at least
    one XML file includes a modified file the method calls
    "mvn clean generate-sources" in that directory.

    This will throw an exception if a book fails to build
    """
    modified_files = get_modified_files()
    modified_files = map(lambda x: os.path.abspath(x), modified_files)
    affected_books = []
    books = []
    book_root = rootdir
    for root, dirs, files in os.walk(rootdir):
        # Don't descend into 'target' subdirectories
        try:
            ind = dirs.index('target')
            del dirs[ind]
        except ValueError:
            pass

        if os.path.basename(root) in book_exceptions:
            break
        elif "pom.xml" in files:
            books.append(root)
            book_root = root

        os.chdir(root)

        for f in files:
            if (f.endswith('.xml') and
                f != 'pom.xml' and
                f not in file_exceptions):
                path = os.path.abspath(os.path.join(root, f))
                doc = etree.parse(path)
                ns = {"xi": "http://www.w3.org/2001/XInclude"}
                for node in doc.xpath('//xi:include', namespaces=ns):
                    href = node.get('href')
                    if (href.endswith('.xml') and
                        f not in file_exceptions and
                        os.path.abspath(href) in modified_files):
                        affected_books.append(book_root)
                        break
            if book_root in affected_books:
                break

    if not force and affected_books:
        books = affected_books
    else:
        print("No books are affected by modified files. Building all books.")

    maxjobs = multiprocessing.cpu_count()
    # Jenkins fails sometimes with errors if too many jobs run, artificially
    # limit to 4 for now.
    # See https://bugs.launchpad.net/openstack-manuals/+bug/1221721
    if maxjobs > 4:
        maxjobs = 4
    pool = multiprocessing.Pool(maxjobs)
    print("Queuing the following books for building:")
    for book in books:
        print("  %s" % os.path.basename(book))
        pool.apply_async(build_book, (rootdir, book), callback = logging_build_book)
    pool.close()
    print("Building all books now...")
    pool.join()

    any_failures = False
    for book, result, output, returncode in RESULTS_OF_BUILDS:
        if result:
            print(">>> Build of book %s succeeded." % book)
        else:
            any_failures = True
            print(">>> Build of book %s failed (returncode = %d)." % (book, returncode))
            print("\n%s" % output)

    if voting and any_failures:
        sys.exit(1)


def main(args):

    if not force and only_www_touched():
        print("Only files in www directory changed, nothing to do.")
        return

    if args.check_syntax:
        validate_individual_files(args.path, FILE_EXCEPTIONS, args.force, args.with_niceness, args.non_voting)

    if args.check_delete:
        check_deleted_files(args.path, FILE_EXCEPTIONS)

    if args.check_build:
        build_affected_books(args.path, BOOK_EXCEPTIONS, FILE_EXCEPTIONS, args.force, args.non_voting)


def default_root():
    """Return the location of openstack-manuals/doc/

    The current working directory must be inside of the openstack-manuals
    repository for this method to succeed"""
    try:
        args = ["git", "rev-parse", "--show-toplevel"]
        gitroot = check_output(args).rstrip()
    except (CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)

    return os.path.join(gitroot, "doc")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Validate XML files against "
                                     "the DocBook 5 RELAX NG schema")
    parser.add_argument('path', nargs='?', default=default_root(),
                        help="Root directory that contains DocBook files, "
                        "defaults to `git rev-parse --show-toplevel`/doc")
    parser.add_argument("--force", help="force the validation of all files "
                        "and build all books", action="store_true")
    parser.add_argument("--check-build", help="try to build books using "
                        "modified files", action="store_true")
    parser.add_argument("--check-syntax", help="check the syntax of modified "
                        "files", action="store_true")
    parser.add_argument("--check-delete", help="check that deleted files "
                        "are not used", action="store_true")
    parser.add_argument("--with-niceness", help="when checking the syntax "
                        "also check the niceness of the syntax",
                        action="store_true")
    parser.add_argument("--non-voting", help="do not exit on failures",
                        action="store_false")
    args = parser.parse_args()
    main(args)
