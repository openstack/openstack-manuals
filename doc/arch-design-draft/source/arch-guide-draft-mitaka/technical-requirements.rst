======================
Technical requirements
======================

.. toctree::
   :maxdepth: 2

   technical-requirements-software-selection.rst
   technical-requirements-hardware-selection.rst
   technical-requirements-network-design.rst
   technical-requirements-logging-monitoring.rst

Any given cloud deployment is expected to include these base services:

* Compute

* Networking

* Storage

Each of these services have different software and hardware resource
requirements.
As a result, you must make design decisions relating directly
to the service, as well as provide a balanced infrastructure for all services.

There are many ways to split out an OpenStack deployment, but a two box
deployment typically consists of:

* A controller node
* A compute node

The controller node will typically host:

* Identity service (for authentication)
* Image service (for image storage)
* Block Storage
* Networking service (the ``nova-network`` service may be used instead)
* Compute service API, conductor, and scheduling services
* Supporting services like the message broker (RabbitMQ)
  and database (MySQL or PostgreSQL)

The compute node will typically host:

* Nova compute
* A networking agent, if using OpenStack Networking

To provide additional block storage in a small environment, you may also
choose to deploy ``cinder-volume`` on the compute node.
You may also choose to run ``nova-compute`` on the controller itself to
allow you to run virtual machines on both hosts in a small environments.

To expand such an environment you would add additional compute nodes,
a separate networking node, and eventually a second controller for high
availability. You might also split out storage to dedicated nodes.

The OpenStack Installation guides provide some guidance on getting a basic
2-3 node deployment installed and running:

* `OpenStack Installation Guide for Ubuntu <http://docs.openstack.org/mitaka/install-guide-ubuntu/>`_
* `OpenStack Installation Guide for Red Hat Enterprise Linux and CentOS <http://docs.openstack.org/mikata/install-guide-rdo/>`_
* `OpenStack Installation Guide for openSUSE and SUSE Linux Enterprise <http://docs.openstack.org/mitaka/install-guide-obs/>`_
