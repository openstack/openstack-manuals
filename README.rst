========================
Team and repository tags
========================

.. image:: https://governance.openstack.org/badges/openstack-manuals.svg
    :target: https://governance.openstack.org/reference/tags/index.html

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

The :command:`tox` command uses the openstack-doc-tools package to run the
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
