OpenStack Manuals
+++++++++++++++++

This repository contains documentation for the OpenStack project.

For more details, see the `OpenStack Documentation wiki page
<http://wiki.openstack.org/Documentation>`_.

It includes these manuals:

 * Installation Guides
 * Cloud Administrator Guide
 * High Availability Guide
 * Security Guide
 * Virtual Machine Image Guide
 * End User Guide
 * Admin User Guide
 * Training Guides

In addition to the guides, this repository contains:

 * docs.openstack.org: ``www``
 * tools for gating tests prior to merging documentation in this repo

Prerequisites
=============
`Apache Maven <http://maven.apache.org/>`_ must be installed to build the
documentation.

To install Maven 3 for Ubuntu 12.04 and later,and Debian wheezy and later::

    apt-get install maven

On Fedora 15 and later::

    yum install maven3

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

    openstack-manuals/doc/src/user-guide/target/docbkx/webhelp/user-guide/content/index.html


Contributing
============

Our community welcomes all people interested in open source cloud computing,
and encourages you to join the `OpenStack Foundation <http://www.openstack.org/join>`_.
The best way to get involved with the community is to talk with others online 
or at a meetup and offer contributions through our processes, the `OpenStack 
wiki <http://wiki.openstack.org>`_, blogs, or on IRC at ``#openstack`` 
on ``irc.freenode.net``.

We welcome all types of contributions, from blueprint designs to documentation
to testing to deployment scripts.


Installing
==========
Refer to http://docs.openstack.org to see where these documents are published
and to learn more about the OpenStack project.
