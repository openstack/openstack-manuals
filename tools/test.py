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
import shutil
import subprocess
import sys
import urllib2

# These are files that are known to not be in DocBook format
FILE_EXCEPTIONS = ['st-training-guides.xml',
                   'ha-guide-docinfo.xml']

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
        checks.append(re.compile(".*<%s>\s+[\w\-().:!?{}\[\]]+.*\n"
                                 % element)),
        checks.append(re.compile(".*[\w\-().:!?{}\[\]]+\s+<\/%s>.*\n"
                                 % element))

    lc = 0
    affected_lines = []
    for line in open(docfile, 'r'):
        lc = lc + 1
        for check in checks:
            if check.match(line) and lc not in affected_lines:
                affected_lines.append(str(lc))

    if len(affected_lines) > 0:
        raise ValueError("trailing or unnecessary whitespaces "
                         "found in lines: %s"
                         % ", ".join(affected_lines))


def error_message(error_log):
    """Return a string that contains the error message.

    We use this to filter out false positives related to IDREF attributes
    """
    errs = [str(x) for x in error_log if x.type_name != 'DTD_UNKNOWN_ID']

    # Reverse output so that earliest failures are reported first
    errs.reverse()
    return "\n".join(errs)


def only_www_touched():
    """Check whether only files in www directory are touched"""

    try:
        git_args = ["git", "diff", "--name-only", "HEAD~1", "HEAD"]
        modified_files = check_output(git_args).strip().split()
    except (subprocess.CalledProcessError, OSError) as e:
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


def ha_guide_touched():
    """Check whether files in high-availability-guide directory are touched"""

    try:
        git_args = ["git", "diff", "--name-only", "HEAD~1", "HEAD"]
        modified_files = check_output(git_args).strip().split()
    except (subprocess.CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)

    ha_changed = False
    for f in modified_files:
        if f.startswith("doc/high-availability-guide/"):
            ha_changed = True

    return ha_changed


def check_modified_affects_all(rootdir, verbose):
    """Check whether special files were modified.

    There are some special files where we should rebuild all books
    if either of these is touched.
    """

    os.chdir(rootdir)

    try:
        git_args = ["git", "diff", "--name-only", "HEAD~1", "HEAD"]
        modified_files = check_output(git_args).strip().split()
    except (subprocess.CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)

    special_files = [
        "tools/test.py",
        "doc/pom.xml"
    ]
    for f in modified_files:
        if f in special_files:
            if verbose:
                print("File %s modified, this affects all books." % f)
            return True

    return False


def get_modified_files(rootdir, filtering=None):
    """Get modified files below doc directory"""

    # There are several tree traversals in this program that do a
    # chdir, we need to run this git command always from the rootdir,
    # so assure that.
    os.chdir(rootdir)

    try:
        git_args = ["git", "diff", "--name-only", "--relative", "HEAD~1",
                    "HEAD"]
        if filtering is not None:
            git_args.append(filtering)
        modified_files = check_output(git_args).strip().split()
    except (subprocess.CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)
    return modified_files


def check_deleted_files(rootdir, file_exceptions, verbose):
    """ Check whether files got deleted and verify that no other file
    references them.

    """
    print("Checking that no removed files are referenced...")
    deleted_files = get_modified_files(rootdir, "--diff-filter=D")
    if not deleted_files:
        print("No files were removed.\n")
        return

    if verbose:
        print(" Removed files:")
        for f in deleted_files:
            print ("   %s" % f)

    deleted_files = map(lambda x: os.path.abspath(x), deleted_files)
    no_checked_files = 0

    # Figure out whether files were included anywhere
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
                no_checked_files = no_checked_files + 1

                # Check for inclusion of files as part of imagedata
                for node in doc.findall(
                        '//{http://docbook.org/ns/docbook}imagedata'):
                    href = node.get('fileref')
                    if (f not in file_exceptions and
                            os.path.abspath(href) in deleted_files):
                        print("  File %s has imagedata href for deleted "
                              "file %s" % (f, href))
                        missing_reference = True

                        break

                # Check for inclusion of files as part of xi:include
                ns = {"xi": "http://www.w3.org/2001/XInclude"}
                for node in doc.xpath('//xi:include', namespaces=ns):
                    href = node.get('href')
                    if (os.path.abspath(href) in deleted_files):
                        print("  File %s has an xi:include on deleted file %s"
                              % (f, href))
                        missing_reference = True
    if missing_reference:
        print("Failed removed file check, %d files were removed, "
              "%d files checked.\n"
              % (len(deleted_files), no_checked_files))
        sys.exit(1)

    print("Passed removed file check, %d files were removed, "
          "%d files checked.\n"
          % (len(deleted_files), no_checked_files))


def validate_one_file(schema, rootdir, path, verbose,
                      check_syntax, check_niceness):
    """Validate a single file"""
    # We pass schema in as a way of caching it, generating it is expensive

    any_failures = False
    if verbose:
        print(" Validating %s" % os.path.relpath(path, rootdir))
    try:
        if check_syntax:
            doc = etree.parse(path)
            if validation_failed(schema, doc):
                any_failures = True
                print(error_message(schema.error_log))
            verify_section_tags_have_xmid(doc)
        if check_niceness:
            verify_nice_usage_of_whitespaces(path)
    except etree.XMLSyntaxError as e:
        any_failures = True
        print("  %s: %s" % (os.path.relpath(path, rootdir), e))
    except ValueError as e:
        any_failures = True
        print("  %s: %s" % (os.path.relpath(path, rootdir), e))

    return any_failures


def is_xml(filename):
    """Returns true if file ends with .xml and is not a pom.xml file"""

    return filename.endswith('.xml') and not filename.endswith('/pom.xml')


def validate_individual_files(rootdir, exceptions, verbose,
                              check_syntax=False, check_niceness=False,
                              ignore_errors=False):
    """Validate list of modified files."""

    schema = get_schema()
    any_failures = False
    no_validated = 0
    no_failed = 0

    # Do not select deleted files, just Added, Copied, Modified, Renamed,
    # or Type changed
    modified_files = get_modified_files(rootdir, "--diff-filter=ACMRT")

    modified_files = filter(is_xml, modified_files)
    if check_syntax and check_niceness:
        print("Checking syntax and niceness of xml files...")
    elif check_syntax:
        print("Checking syntax of xml files...")
    elif check_niceness:
        print("Checking niceness of xml files...")
    modified_files = map(lambda x: os.path.abspath(x), modified_files)

    for f in modified_files:
        base_f = os.path.basename(f)
        if (base_f == "pom.xml" or
                base_f in exceptions):
            continue
        any_failures = validate_one_file(schema, rootdir, f, verbose,
                                         check_syntax, check_niceness)
        if any_failures:
            no_failed = no_failed + 1
        no_validated = no_validated + 1

    if no_failed > 0:
        print("Check failed, validated %d xml files with %d failures.\n" % (no_validated, no_failed))
        if not ignore_errors:
            sys.exit(1)
    else:
        print("Check passed, validated %d xml files.\n" % no_validated)


def validate_all_files(rootdir, exceptions, verbose,
                       check_syntax, check_niceness=False,
                       ignore_errors=False):
    """Validate all xml files."""

    schema = get_schema()
    no_validated = 0
    no_failed = 0
    if check_syntax and check_niceness:
        print("Checking syntax and niceness of all xml files...")
    elif check_syntax:
        print("Checking syntax of all xml files...")
    elif check_niceness:
        print("Checking niceness of all xml files...")

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
                path = os.path.abspath(os.path.join(root, f))
                any_failures = validate_one_file(
                    schema, rootdir, path, verbose,
                    check_syntax, check_niceness)
                if any_failures:
                    no_failed = no_failed + 1
                no_validated = no_validated + 1

    if no_failed > 0:
        print("Check failed, validated %d xml files with %d failures.\n" % (no_validated, no_failed))
        if not ignore_errors:
            sys.exit(1)
    else:
        print("Check passed, validated %d xml files.\n" % no_validated)


def logging_build_book(result):
    """Callback for book building"""
    RESULTS_OF_BUILDS.append(result)


def build_book(book):
    """Build book(s) in directory book"""

    # Note that we cannot build in parallel several books in the same
    # directory like the Install Guide. Thus we build sequentially per
    # directory.
    os.chdir(book)
    result = True
    returncode = 0
    base_book = os.path.basename(book)
    try:
        # Clean first and then build so that the output of all guides
        # is available
        output = subprocess.check_output(
            ["mvn", "clean"],
            stderr=subprocess.STDOUT
        )
        if base_book == "install-guide":
            # Build Debian
            base_book = "install-guide (for debian)"
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B",
                 "-Doperating.system=apt-debian", "-Dprofile.os=debian"],
                stderr=subprocess.STDOUT
            )
            # Build Fedora
            base_book = "install-guide (for Fedora)"
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B",
                 "-Doperating.system=yum",
                 "-Dprofile.os=centos;fedora;rhel"],
                stderr=subprocess.STDOUT
            )
            # Build openSUSE
            base_book = "install-guide (for openSUSE)"
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B",
                 "-Doperating.system=zypper", "-Dprofile.os=opensuse;sles"],
                stderr=subprocess.STDOUT
            )
            # Build Ubuntu
            base_book = "install-guide (for Ubuntu)"
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B",
                 "-Doperating.system=apt", "-Dprofile.os=ubuntu"],
                stderr=subprocess.STDOUT
            )
            # Success
            base_book = "install-guide (for Debian, Fedora, openSUSE, Ubuntu)"
        elif base_book == "high-availability-guide":
            output = subprocess.check_output(
                ["../../tools/build-ha-guide.sh", ],
                stderr=subprocess.STDOUT
            )
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B"],
                stderr=subprocess.STDOUT
            )
        else:
            output = subprocess.check_output(
                ["mvn", "generate-sources", "-B"],
                stderr=subprocess.STDOUT
            )
    except subprocess.CalledProcessError as e:
        output = e.output
        returncode = e.returncode
        result = False

    return (base_book, result, output, returncode)


def is_book_master(filename):
    """Returns True if filename is one of the special filenames used for the
    book master files.

    We do not parse pom.xml for the includes directive to determine
    the top-level files and thus have to use a heuristic.
    """

    return ((filename.startswith(('bk-', 'bk_', 'st-'))
             and filename.endswith('.xml')) or
            filename == 'openstack-glossary.xml')


def find_affected_books(rootdir, book_exceptions, verbose,
                        force):
    """Check which books are affected by modified files.

    Returns a set with books.
    """
    book_root = rootdir

    books = []
    affected_books = set()

    build_all_books = force or check_modified_affects_all(rootdir, verbose)

    # Dictionary that contains a set of files.
    # The key is a filename, the set contains files that include this file.
    included_by = {}

    # Dictionary with books and their bk*.xml files
    book_bk = {}

    # 1. Iterate over whole tree and analyze include files.
    # This updates included_by, book_bk and books.
    for root, dirs, files in os.walk(rootdir):
        # Don't descend into 'target' subdirectories
        try:
            ind = dirs.index('target')
            del dirs[ind]
        except ValueError:
            pass

        if os.path.basename(root) in book_exceptions:
            break
        # Do not process files in doc itself
        elif root.endswith('doc'):
            continue
        elif "pom.xml" in files:
            books.append(root)
            book_root = root

        # No need to check single books if we build all, we just
        # collect list of books
        if build_all_books:
            continue

        # ha-guide uses asciidoc which we do not track.
        # Just check whether any file is touched in that directory
        if root.endswith('doc/high-availability-guide'):
            if ha_guide_touched():
                affected_books.add(book_root)

        for f in files:
            f_base = os.path.basename(f)
            f_abs = os.path.abspath(os.path.join(root, f))
            if is_book_master(f_base):
                book_bk[f_abs] = book_root
            if (f.endswith('.xml') and
                    f != "pom.xml" and
                    f != "ha-guide-docinfo.xml"):
                doc = etree.parse(f_abs)
                for node in doc.findall(
                        '//{http://docbook.org/ns/docbook}imagedata'):
                    href = node.get('fileref')
                    href_abs = os.path.abspath(os.path.join(root, href))
                    if href_abs in included_by:
                        included_by[href_abs].add(f_abs)
                    else:
                        included_by[href_abs] = set([f_abs])

                ns = {"xi": "http://www.w3.org/2001/XInclude"}
                for node in doc.xpath('//xi:include', namespaces=ns):
                    href = node.get('href')
                    href_abs = os.path.abspath(os.path.join(root, href))
                    if href_abs in included_by:
                        included_by[href_abs].add(f_abs)
                    else:
                        included_by[href_abs] = set([f_abs])

    if not build_all_books:
        # Generate list of modified_files
        # Do not select deleted files, just Added, Copied, Modified, Renamed,
        # or Type changed
        modified_files = get_modified_files(rootdir, "--diff-filter=ACMRT")
        modified_files = map(lambda x: os.path.abspath(x), modified_files)

        # 2. Find all modified files and where they are included

        # List of files that we have to iterate over, these are affected
        # by some modification
        new_files = modified_files

        # All files that are affected (either directly or indirectly)
        affected_files = set(modified_files)

        # 3. Iterate over files that have includes on modified files
        # and build a closure - the set of all files (affected_files)
        # that have a path to a modified file via includes.
        while len(new_files) > 0:
            new_files_to_check = new_files
            new_files = []
            for f in new_files_to_check:
                # Skip bk*.xml files
                if is_book_master(os.path.basename(f)):
                    book_modified = book_bk[f]
                    if book_modified not in affected_books:
                        affected_books.add(book_modified)
                    continue
                if f not in included_by:
                    continue
                for g in included_by[f]:
                    if g not in affected_files:
                        new_files.append(g)
                        affected_files.add(g)

    if build_all_books:
        print("Building all books.")
    elif affected_books:
        books = affected_books
    else:
        print("No books are affected by modified files. Building all books.")

    return books


def build_affected_books(rootdir, book_exceptions,
                         verbose, force=False, ignore_errors=False):
    """Build all the books which are affected by modified files.

    Looks for all directories with "pom.xml" and checks if a
    XML file in the directory includes a modified file. If at least
    one XML file includes a modified file the method calls
    "mvn clean generate-sources" in that directory.

    This will throw an exception if a book fails to build
    """

    books = find_affected_books(rootdir, book_exceptions,
                                verbose, force)

    # Remove cache content which can cause build failures
    shutil.rmtree(os.path.expanduser("~/.fop"),
                  ignore_errors=True)

    maxjobs = multiprocessing.cpu_count()
    # Jenkins fails sometimes with errors if too many jobs run, artificially
    # limit to 4 for now.
    # See https://bugs.launchpad.net/openstack-manuals/+bug/1221721
    if maxjobs > 4:
        maxjobs = 4
    pool = multiprocessing.Pool(maxjobs)
    print("Queuing the following books for building:")
    for book in sorted(books):
        print("  %s" % os.path.basename(book))
        pool.apply_async(build_book, (book, ),
                         callback=logging_build_book)
    pool.close()
    print("Building all queued %d books now..." % len(books))
    pool.join()

    any_failures = False
    for book, result, output, returncode in RESULTS_OF_BUILDS:
        if result:
            print(">>> Build of book %s succeeded." % book)
        else:
            any_failures = True

    if any_failures:
        for book, result, output, returncode in RESULTS_OF_BUILDS:
            if not result:
                print(">>> Build of book %s failed (returncode = %d)."
                      % (book, returncode))
                print("\n%s" % output)

        print("Building of books finished with failures.\n")
        if not ignore_errors:
            sys.exit(1)
    else:
        print("Building of books finished successfully.\n")


def main(args):

    if args.check_all:
        args.check_deletions = True
        args.check_syntax = True
        args.check_build = True
        args.check_niceness = True

    if not args.force and only_www_touched():
        print("Only files in www directory changed, nothing to do.\n")
        return

    if args.check_syntax or args.check_niceness:
        if args.force:
            validate_all_files(args.path, FILE_EXCEPTIONS, args.verbose,
                               args.check_syntax, args.check_niceness,
                               args.ignore_errors)
        else:
            validate_individual_files(args.path, FILE_EXCEPTIONS,
                                      args.verbose, args.check_syntax,
                                      args.check_niceness,
                                      args.ignore_errors)

    if args.check_deletions:
        check_deleted_files(args.path, FILE_EXCEPTIONS, args.verbose)

    if args.check_build:
        build_affected_books(args.path, BOOK_EXCEPTIONS,
                             args.verbose, args.force, args.ignore_errors)


def default_root():
    """Return the location of openstack-manuals/doc/

    The current working directory must be inside of the openstack-manuals
    repository for this method to succeed"""
    try:
        git_args = ["git", "rev-parse", "--show-toplevel"]
        gitroot = check_output(git_args).rstrip()
    except (subprocess.CalledProcessError, OSError) as e:
        print("git failed: %s" % e)
        sys.exit(1)

    return os.path.join(gitroot, "doc")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Validate XML files against "
                                     "the DocBook 5 RELAX NG schema")
    parser.add_argument('path', nargs='?', default=default_root(),
                        help="Root directory that contains DocBook files, "
                        "defaults to `git rev-parse --show-toplevel`/doc")
    parser.add_argument("--force", help="Force the validation of all files "
                        "and build all books", action="store_true")
    parser.add_argument("--check-build", help="Try to build books using "
                        "modified files", action="store_true")
    parser.add_argument("--check-syntax", help="Check the syntax of modified "
                        "files", action="store_true")
    parser.add_argument("--check-deletions", help="Check that deleted files "
                        "are not used.", action="store_true")
    parser.add_argument("--check-niceness", help="Check the niceness of "
                        "files, for example whitespace.",
                        action="store_true")
    parser.add_argument("--check-all", help="Run all checks "
                        "(default if no arguments are given)",
                        action="store_true")
    parser.add_argument("--ignore-errors", help="Do not exit on failures",
                        action="store_true")
    parser.add_argument("--verbose", help="Verbose execution",
                        action="store_true")
    prog_args = parser.parse_args()
    if (len(sys.argv) == 1):
        # No arguments given, use check-all
        prog_args.check_all = True
    main(prog_args)
