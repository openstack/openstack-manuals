Openstack Manuals
+++++++++++++++++

This repository contains the cloud administrator documentation for the
OpenStack project. It includes documentation for:

 * OpenStack Compute
 * OpenStack Identity Service
 * OpenStack Image Service
 * OpenStack Object Storage
 * OpenStack Dashboard
 * OpenStack Network Connectivity

For more details, see the `OpenStack Documentation HowTo wiki page
<http://wiki.openstack.org/Documentation/HowTo>`_.

In addtion to the guides, this repository contains:

 * api.openstack.org: ``doc/src/docbkx/openstack-api-site``
 * docs.openstack.org: ``www``


Prerequisites
=============
`Apache Maven <http://maven.apache.org/>`_ must be installed to build the
documentation.

To install Maven 3 for Ubuntu 12.04 and later, and Debian wheezy and later::

    apt-get install maven

On Fedora 15 and later::

    yum install maven3

Building
========
The different manuals are in subdirectories of the
``openstack-manuals/doc/src/docbkx`` directory.

For example, the root directory of the *OpenStack Compute Administration Guide*
is ``openstack-manuals/doc/src/docbkx/openstack-compute-admin``.

To build a specific guide, look for a ``pom.xml`` file within a subdirectory,
then run the ``mvn`` command in that directory. For example::

    cd openstack-manuals/doc/src/docbkx/openstack-compute-admin
    mvn clean generate-sources

The generated PDF documentation file is::

    openstack-manuals/doc/src/docbkx/openstack-compute-admin/target/docbkx/webhelp/trunk/openstack-compute/admin/os-compute-adminguide-trunk.pdf

The root of the generated HTML documentation is::

    openstack-manuals/doc/src/docbkx/openstack-compute-admin/target/docbkx/webhelp/os-compute-adminguide/content/index.html


Contributing
============
Our community welcomes all people interested in open source cloud computing,
and there are no formal membership requirements. The best way to join the
community is to talk with others online or at a meetup and offer contributions
through Launchpad, the `OpenStack wiki <http://wiki.openstack.org>`_, blogs,
or on IRC at ``#openstack`` on ``irc.freenode.net``.

We welcome all types of contributions, from blueprint designs to documentation
to testing to deployment scripts.


Installing
==========
Refer to http://docs.openstack.org to see where these documents are published
and to learn more about the OpenStack project.
