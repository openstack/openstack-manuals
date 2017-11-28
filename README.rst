OpenStack Manuals
+++++++++++++++++

This repository contains documentation for the OpenStack project.

For more details, see the `OpenStack Documentation Contributor
Guide <http://docs.openstack.org/contributor-guide/>`_.

It includes these manuals:

 * Administrator Guide
 * Architecture Design Guide
 * Command-Line Interface Reference
 * Configuration Reference
 * Documentation Contributor Guide
 * End User Guide
 * Installation Guides
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
Various guides are in the RST format. You can use tox to prepare
virtual environment and build all RST based guides::

    tox -e docs

You can also build a specific guide.
For example, to build the *OpenStack End User Guide*, use the following
command::

    tox -e build -- user-guide

You can find the root of the generated HTML documentation at::

    doc/user-guide/build/html/index.html

Glossary
--------

`Apache Maven <http://maven.apache.org/>`_ must be installed to build the
glossary.

To install Maven 3 for Ubuntu 12.04 and later, and Debian wheezy and later::

    apt-get install maven

On Fedora 20 and later::

    yum install maven

On openSUSE Leap::

    zypper ar http://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_42.1/devel:tools:building.repo
    zypper install maven

To build the glossary, move to ``doc/glossary``,
then run the ``mvn`` command in that directory::

    cd doc/glossary
    mvn clean generate-sources

The generated PDF documentation file is::

    doc/glossary/target/docbkx/webhelp/glossary/openstack-glossary.pdf

The root of the generated HTML documentation is::

    doc/glossary/target/docbkx/webhelp/glossary/content/index.html


Testing of changes and building of the manual
=============================================

Install the python tox package and run ``tox`` from the top-level
directory to use the same tests that are done as part of our Jenkins
gating jobs.

If you like to run individual tests, run:

 * ``tox -e checklinks`` - to run the tests for working remote URLs
 * ``tox -e checkniceness`` - to run the niceness tests
 * ``tox -e checksyntax`` - to run syntax checks
 * ``tox -e checkdeletions`` - to check that no deleted files are referenced
 * ``tox -e checkbuild`` - to actually build the manual
 * ``tox -e checklang`` - to build translated manuals

tox will use the openstack-doc-tools package for execution of these
tests.


Contributing
============

Our community welcomes all people interested in open source cloud
computing, and encourages you to join the `OpenStack Foundation
<http://www.openstack.org/join>`_.

The best way to get involved with the community is to talk with others
online or at a meet up and offer contributions through our processes,
the `OpenStack wiki <http://wiki.openstack.org>`_, blogs, or on IRC at
``#openstack`` on ``irc.freenode.net``.

We welcome all types of contributions, from blueprint designs to
documentation to testing to deployment scripts.

If you would like to contribute to the documents, please see the
`OpenStack Documentation contributor guide
<http://docs.openstack.org/contributor-guide/>`_.

Generated files
---------------

Some documentation files are generated using tools. These files include
a ``do not edit`` header and should not be modified by hand. Please see
`Generated files
<http://docs.openstack.org/contributor-guide/tools-and-content-overview.html#Generated-files/>`_.


Bugs
====

Bugs should be filed on Launchpad, not GitHub:

   https://bugs.launchpad.net/openstack-manuals


Installing
==========

Refer to http://docs.openstack.org to see where these documents are published
and to learn more about the OpenStack project.
