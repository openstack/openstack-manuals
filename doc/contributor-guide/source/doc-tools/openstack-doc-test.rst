.. _openstack-doc-test:

==================
openstack-doc-test
==================

OpenStack Validation tool
~~~~~~~~~~~~~~~~~~~~~~~~~

SYNOPSIS
--------

openstack-doc-test [options]

DESCRIPTION
-----------

openstack-doc-test allows to test the validity of the OpenStack
documentation content.

OPTIONS
-------

**General options**

**--api-site**
   Special handling for api-site and other API repositories
   to handle WADL.

**--build-file-exception BUILD_FILE_EXCEPTION**
   File that will be skipped during delete and build checks to
   generate dependencies. This should be done for invalid XML files
   only.

**--check-build**
   Try to build books using modified files.

**--check-deletions**
   Check that deleted files are not used.

**--check-links**
   Check that linked URLs are valid and reachable.

**--check-niceness**
   Check the niceness of files, for example whitespace.

**--check-syntax**
   Check the syntax of modified files.

**--check-all**
   Run all checks (default if no arguments are given).

**--config-file PATH**
   Path to a config file to use. Multiple config files can be
   specified, with values in later files taking precedence.

**--debug**
   Enable debug code.

**--file-exception FILE_EXCEPTION**
   File that will be skipped during niceness and syntax validation.

**--force**
   Force the validation of all files and build all books.

**-h, --help**
   Show help message and exit.

**--ignore-dir IGNORE_DIR**
   Directory to ignore for building of manuals. The parameter can
   be passed multiple times to add several directories.

**--language LANGUAGE, -l LANGUAGE**
   Build translated manual for language in path generate/$LANGUAGE .

**--only-book ONLY_BOOK**
   Build each specified manual.

**--parallel**
   Build books in parallel (default).

**--print-unused-files**
   Print list of files that are not included anywhere as part of
   check-build.

**--publish**
   Setup content in publish-docs directory for publishing to
   external website.

**--verbose**
   Verbose execution.

**--version**
   Output version number.

FILES
-----

Reads the file `doc-test.conf` in the top-level directory of the git
repository for option processing.

Building of books will generate in the top-level directory of the git
repository:

* a directory `publish-docs` with a copy of the build results.
* for each book build a log file named `build-${book}.log.gz`.

SEE ALSO
--------

* `OpenStack Documentation <http://wiki.openstack.org/wiki/Documentation>`_

Bugs
----

* openstack-doc-tools is hosted on Launchpad so you can view current
  bugs at `openstack-manuals <https://bugs.launchpad.net/openstack-manuals/>`_
