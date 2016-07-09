.. _openstack-doc-test:

========================================
Validate OpenStack documentation content
========================================

To test the validity of the OpenStack documentation content, use
the :command:`openstack-doc-test [options]` command with the following
available options:

.. note::

   For option processing, the ``openstack-doc-test`` tool reads
   the `doc-test.conf` in the top-level directory of the git repository.

--api-site
  Special handling for api-site and other API repositories
  to handle WADL.

--build-file-exception BUILD_FILE_EXCEPTION
  File that will be skipped during delete and build checks to
  generate dependencies. This should be done for invalid XML files only.

--check-build
  Try to build books using modified files.

--check-deletions
  Check that deleted files are not used.

--check-links
  Check that linked URLs are valid and reachable.

--check-niceness
  Check the niceness of files, for example whitespace.

--check-syntax
  Check the syntax of modified files.

--check-all
  Run all checks (default if no arguments are given).

--config-file PATH
  Path to a config file to use. Multiple config files can be
  specified, with values in later files taking precedence.

--debug
  Enable debug code.

--file-exception FILE_EXCEPTION
  File that will be skipped during niceness and syntax validation.

--force
  Force the validation of all files and build all books.

-h, --help
  Show help message and exit.

--ignore-dir IGNORE_DIR
  Directory to ignore for building of manuals. The parameter can
  be passed multiple times to add several directories.

--language LANGUAGE, -l LANGUAGE
  Build translated manual for language in path generate/$LANGUAGE .

--only-book ONLY_BOOK
  Build each specified manual.

--parallel
  Build books in parallel (default).

--print-unused-files
  Print list of files that are not included anywhere as part of
  check-build.

--publish
  Setup content in publish-docs directory for publishing to
  external website.

--verbose
  Verbose execution.

--version
  Output version number.

Building of books generates the following output in the top-level directory
of the repository:

* The ``publish-docs`` directory with a copy of the build results.
* A log file for each book named ``build-${book}.log.gz``.
