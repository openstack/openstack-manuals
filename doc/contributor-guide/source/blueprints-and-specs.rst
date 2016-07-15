.. _content-specs:

=====================
Content specification
=====================

Blueprints and specifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Documentation team uses specifications in the `docs-specs repository
<http://git.openstack.org/cgit/openstack/docs-specs>`_ to maintain large
changes. Approved specifications are published at `Documentation Program
Specifications <http://specs.openstack.org/openstack/docs-specs>`_.
For tracking purposes, a blueprint is created for each specification.

Use blueprints and specifications:

* When adding large sections to an existing document to ensure involvement
  of the docs core team.
* When adding an entirely new deliverable to the docs project.
* For any work that requires both content and tooling changes, such as
  addition of the API reference site.
* For any large reorganization of a deliverable or set of deliverables.
* For automation work that needs to be designed prior to proposing a patch.
* For work that should definitely be discussed at a summit.

A specification needs two +2 votes from the docs-specs-core team.
See the current list of `docs-specs core team
<https://review.openstack.org/#/admin/groups/384,members>`_.
For more information, see `Blueprints and specifications
<https://wiki.openstack.org/wiki/Blueprints#Blueprints_and_Specs>`_.

Use bugs against openstack-manuals or openstack-api-site:

* For known content issues, even if you have to do multiple patches to close
  the bug.
* To add content that is just missing.
* For known errors in a document.

For more information, see :ref:`doc_bugs`.

Release-specific documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Installation Guides, Configuration Reference, and Networking Guide
are released at release time, with draft material published to
https://docs.openstack.org/draft/draft-index.html.
The rest of the guides are continuously released.

To patch for the release-specific documentation, you should generally patch to
master branch with "backport: xxxx" (for example, backport: kilo) in the commit
message.

Installation Guides
-------------------

The OpenStack Installation Guide describes a manual install process for
multiple distributions based on the following packaging systems:

* `Installation Guide for openSUSE and SUSE Linux Enterprise Server
  <http://docs.openstack.org/mitaka/install-guide-obs/>`_
* `Installation Guide for Red Hat Enterprise Linux and CentOS
  <http://docs.openstack.org/mitaka/install-guide-rdo/>`_
* `Installation Guide for Ubuntu
  <http://docs.openstack.org/mitaka/install-guide-ubuntu/>`_

Guides for deployers and administrators
---------------------------------------

* `OpenStack Configuration Reference
  <http://docs.openstack.org/mitaka/config-reference/>`_:
  Contains a reference listing of all configuration options for OpenStack
  services by release version.
* `OpenStack Networking Guide
  <http://docs.openstack.org/mitaka/networking-guide/>`_:
  This guide targets OpenStack administrators seeking to deploy and manage
  OpenStack Networking (neutron).

Continuously released documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These guides cover multiple versions and we follow the general
`release information <https://wiki.openstack.org/wiki/Releases>`_.
The guides cover the latest two versions, for
example Juno and Kilo. The following exceptions apply:

* Operations Guide: Icehouse target, revised specifically to target that
  release
* HA Guide: Updated last at Havana timeframe, still needs updates

Guides for deployers and administrators
---------------------------------------

* `OpenStack Architecture Design Guide
  <http://docs.openstack.org/arch-design/>`_:
  Contains information on how to plan, design and architect
  an OpenStack cloud.
* `OpenStack Administrator Guide <http://docs.openstack.org/admin-guide/>`_:
  Contains how-to information for managing an OpenStack cloud as needed for
  your use cases, such as storage, computing, or software-defined-networking.
* `OpenStack High Availability Guide <http://docs.openstack.org/ha-guide/>`_:
  Describes potential strategies for making your OpenStack services and
  related controllers and data stores highly available.
* `OpenStack Security Guide <http://docs.openstack.org/sec>`_:
  Provide best practices and conceptual
  information about securing an OpenStack cloud.
* `Virtual Machine Image Guide <http://docs.openstack.org/image-guide>`_:
  Shows you how to obtain, create, and modify virtual machine images that
  are compatible with OpenStack.

Guides for end users
--------------------

* `OpenStack End User Guide <http://docs.openstack.org/user-guide/>`_:
  Shows OpenStack end users how to create and manage resources in an
  OpenStack cloud with the OpenStack dashboard and OpenStack client commands.
* `OpenStack API Guide
  <http://developer.openstack.org/api-guide/quick-start/>`_:
  A brief overview of how to send REST API requests to endpoints for
  OpenStack services.
* `OpenStack Command-Line Interface Reference
  <http://docs.openstack.org/cli-reference/>`_:
  Automatically generates help text for CLI commands and subcommands.

API documentation
-----------------

* `Complete API Reference <http://developer.openstack.org/api-ref.html>`_:
  Complete reference listing of OpenStack REST APIs
  with example requests and responses.
* `API specifications <http://specs.openstack.org/>`_:
  Within project's specification repos, some have opted
  to document API specifications, such as Identity.
* `Object Storage API v1
  <http://docs.openstack.org/developer/swift/#object-storage-v1-rest-api-documentation>`_

Guides for contributors
-----------------------

* `Infrastructure User Manual <http://docs.openstack.org/infra/manual>`_:
  Reference documentation for tools and processes used for all
  contributors to OpenStack projects. It includes instructions on how
  to create all the necessary accounts, setup development environment,
  use gerrit review workflow. The manual also covers more
  advanced topics, like how to create new git repositories. The manual is
  maintained by the OpenStack Infrastructure team.

Licenses
~~~~~~~~

This section shows the license indicators as of March 20, 2015.

* OpenStack Architecture Design Guide: Apache 2.0 and CC-by-sa 3.0
* OpenStack Administrator Guide: Apache 2.0 and CC-by-sa 3.0

* OpenStack Install Guides (all): Apache 2.0
* OpenStack High Availability Guide: Apache 2.0
* OpenStack Configuration Reference: Apache 2.0
* OpenStack Networking Guide: Apache 2.0

* OpenStack Security Guide: CC-by 3.0
* Virtual Machine Image Guide: CC-by 3.0
* OpenStack Operations Guide: CC-by 3.0
* OpenStack End User Guide: CC-by 3.0
* Command-Line Interface Reference: CC-by 3.0

* Contributor dev docs (docs.openstack.org/developer/<projectname>): none
  indicated in output; Apache 2.0 in repo
* OpenStack API Quick Start: none indicated in output; Apache 2.0 in repo
* API Complete Reference: none indicated in output; Apache 2.0 in repo

* Infrastructure User Manual: none indicated in output; CC-by 3.0 in repo

What to do to make more consistent output:

* OpenStack Architecture Design Guide: Apache 2.0 and CC-by 3.0
* OpenStack Administrator Guide: Apache 2.0 and CC-by 3.0
* OpenStack Install Guides (all): Apache 2.0 and CC-by 3.0
* OpenStack High Availability Guide: Apache 2.0 and CC-by 3.0
* OpenStack Security Guide: CC-by 3.0
* Virtual Machine Image Guide: CC-by 3.0
* OpenStack Operations Guide: CC-by 3.0
* OpenStack End User Guide: CC-by 3.0

These guides are created by "scraping" code:

* OpenStack Configuration Reference: Apache 2.0 and CC-by 3.0
* Command-Line Interface Reference: Apache 2.0 and CC-by 3.0

These guides have no indicator in output:

* Contributor dev docs (docs.openstack.org/developer/<projectname>): none
  indicated in output; Apache 2.0 in repo
* OpenStack API Quick Start: none indicated in output; Apache 2.0 in repo
* API Complete Reference: none indicated in output; Apache 2.0 in repo

This guide has a review in place to get a license indicator in output:

* Infrastructure User Manual: none indicated in output; CC-by 3.0 in repo
