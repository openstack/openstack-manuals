OpenStack Manuals
+++++++++++++++++

This repository contains documentation for the OpenStack project.

For more details, see the `OpenStack Documentation Contributor
Guide <http://docs.openstack.org/doc-contrib-guide/>`_.

It includes these manuals:

 * Administrator Guide
 * Architecture Design Guide
 * Command-Line Interface Reference
 * Configuration Reference
 * Documentation Contributor Guide
 * End User Guide
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

All guides are in the RST format. You can use ``tox`` to prepare
virtual environment and build all guides::

    $ tox -e docs

You can also build a specific guide.

For example, to build *OpenStack End User Guide*, use the following command::

    $ tox -e build -- user-guide

You can find the root of the generated HTML documentation at::

    doc/user-guide/build/html/index.html


Testing of changes and building of the manual
=============================================

Install the Python tox package and run ``tox`` from the top-level
directory to use the same tests that are done as part of our Jenkins
gating jobs.

If you like to run individual tests, run:

 * ``tox -e checkbuild`` - to actually build the manual
 * ``tox -e checklang`` - to build translated manuals
 * ``tox -e checkniceness`` - to run the niceness tests
 * ``tox -e linkcheck`` - to run the tests for working remote URLs

tox will use the openstack-doc-tools package for execution of these
tests.


Contributing
============

Our community welcomes all people interested in open source cloud
computing, and encourages you to join the `OpenStack Foundation
<https://www.openstack.org/join>`_.

The best way to get involved with the community is to talk with others
online or at a meet up and offer contributions through our processes,
the `OpenStack wiki <https://wiki.openstack.org>`_, blogs, or on IRC at
``#openstack`` on ``irc.freenode.net``.

We welcome all types of contributions, from blueprint designs to
documentation to testing to deployment scripts.

If you would like to contribute to the documents, please see the
`OpenStack Documentation Contributor Guide
<https://docs.openstack.org/contributor-guide/>`_.

Generated files
---------------

Some documentation files are generated using tools. These files include
a ``do not edit`` header and should not be modified by hand.
Please see `Generated files
<http://docs.openstack.org/contributor-guide/doc-tools.html>`_.


Bugs
====

Bugs should be filed on Launchpad, not GitHub:

   https://bugs.launchpad.net/openstack-manuals


Installing
==========

Refer to http://docs.openstack.org to see where these documents are published
and to learn more about the OpenStack project.
