========================
Team and repository tags
========================

.. image:: https://governance.openstack.org/tc/badges/openstack-manuals.svg
    :target: https://governance.openstack.org/tc/reference/tags/index.html

.. Change things from this point on

OpenStack Manuals
+++++++++++++++++

This repository contains documentation for the OpenStack project.

For more details, see the `OpenStack Documentation Contributor
Guide <https://docs.openstack.org/contributor-guide/>`_.

It includes these manuals:

 * Administrator Guide
 * Architecture Design Guide
 * Command-Line Interface Reference
 * Configuration Reference
 * Documentation Contributor Guide
 * High Availability Guide
 * Installation Tutorials
 * Networking Guide
 * Operations Guide
 * Virtual Machine Image Guide

In addition to the guides, this repository contains:

 * docs.openstack.org contents: ``www``

Building
========

Various manuals are in subdirectories of the ``doc/`` directory.

Guides
------

Some pre-requisites are needed to build the guides. If you are using a Linux
operating system you can generate a report of missing local requirements with
the ``bindep`` command::

    $ tox -e bindep

All guides are in the RST format. You can use ``tox`` to prepare
virtual environment and build all guides (HTML only)::

    $ tox -e docs

You can also build a specific guide.

For example, to build *OpenStack Virtual Machine Image Guide*, use the
following command::

    $ tox -e build -- image-guide

You can find the root of the generated HTML documentation at::

    doc/image-guide/build/html/index.html

To build a specific guide with a PDF file, add a ``-pdf`` option like::

    $ tox -e build -- image-guide --pdf

The generated PDF file will be copied to the root directory of the
generated HTML documentation.

If you get this message `make: xelatex: No such file or directory` it means
your local environment does not have LaTeX installed. Read `Getting LaTeX
<https://www.latex-project.org/get/>`_ for instructions.

Testing of changes and building of the manual
=============================================

Install the Python tox package and run ``tox`` from the top-level
directory to use the same tests that are done as part of the OpenStack
CI jobs.

If you like to run individual tests, run:

* ``tox -e checkbuild`` - to actually build the manual
* ``tox -e checklang`` - to build translated manuals
* ``tox -e checkniceness`` - to run the niceness tests
* ``tox -e linkcheck`` - to run the tests for working remote URLs

The ``tox`` command uses the openstack-doc-tools package to run the
tests.


Generated files
---------------

Some documentation files are generated using tools. These files include
a ``do not edit`` header and should not be modified by hand.
Please see `Generated files
<https://docs.openstack.org/contributor-guide/doc-tools.html>`_.


Bugs
====

Bugs should be filed on Launchpad, not GitHub:

   https://bugs.launchpad.net/openstack-manuals


Installing
==========

Refer to https://docs.openstack.org to see where these documents are
published and to learn more about the OpenStack project.
