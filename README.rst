OpenStack Manuals
+++++++++++++++++

This repository contains documentation for the OpenStack project.

For more details, see the `OpenStack Documentation wiki page
<http://wiki.openstack.org/Documentation>`_.

It includes these manuals:

 * Admin User Guide
 * Architecture Design Guide
 * Cloud Administrator Guide
 * Command-Line Interface Reference
 * Configuration Reference
 * End User Guide
 * High Availability Guide
 * Installation Guides
 * Virtual Machine Image Guide

In addition to the guides, this repository contains:

 * docs.openstack.org: ``www``

Prerequisites
=============
`Apache Maven <http://maven.apache.org/>`_ must be installed to build the
documentation.

To install Maven 3 for Ubuntu 12.04 and later, and Debian wheezy and later::

    apt-get install maven

On Fedora 20 and later::

    yum install maven

On openSUSE 13.1 and later::

    zypper ar http://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_13.1/devel:tools:building.repo
    zypper install maven

Building
========
The different manuals are in subdirectories of the
``openstack-manuals/doc/`` directory.

For example, the root directory of the *OpenStack User Guide*
is ``openstack-manuals/doc/user-guide``.

To build a specific guide, look for a ``pom.xml`` file within a subdirectory,
then run the ``mvn`` command in that directory. For example::

    cd openstack-manuals/doc/user-guide/
    mvn clean generate-sources

The generated PDF documentation file is::

    openstack-manuals/doc/user-guide/target/docbkx/webhelp/user-guide.pdf

The root of the generated HTML documentation is::

    openstack-manuals/doc/user-guide/target/docbkx/webhelp/user-guide/content/index.html

Testing of changes and building of the manual
=============================================

Install the python tox package and run ``tox`` from the top-level
directory to use the same tests that are done as part of our Jenkins
gating jobs.

If you like to run individual tests, run:

 * ``tox -e checkniceness`` - to run the niceness tests
 * ``tox -e checksyntax`` - to run syntax checks
 * ``tox -e checkdeletions`` - to check that no deleted files are referenced
 * ``tox -e checkbuild`` - to actually build the manual

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
`Documentation HowTo <https://wiki.openstack.org/wiki/Documentation/HowTo>`_.


Bugs
====

Bugs should be filed on Launchpad, not GitHub:

   https://bugs.launchpad.net/openstack-manuals


Installing
==========
Refer to http://docs.openstack.org to see where these documents are published
and to learn more about the OpenStack project.
