========================================
Overview of highly-available controllers
========================================

OpenStack is a set of multiple services exposed to the end users
as HTTP(s) APIs. Additionally, for own internal usage OpenStack
requires SQL database server and AMQP broker. The physical servers,
where all the components are running are often called controllers.
This modular OpenStack architecture allows to duplicate all the
components and run them on different controllers.
By making all the components redundant it is possible to make
OpenStack highly-available.

In general we can divide all the OpenStack components into three categories:

- OpenStack APIs, these are HTTP(s) stateless services written in python,
  easy to duplicate and mostly easy to load balance.

- SQL relational database server provides stateful type consumed by other
  components. Supported databases are MySQL, MariaDB, and PostgreSQL.
  Making SQL database redundant is complex.

- :term:`Advanced Message Queuing Protocol (AMQP)` provides OpenStack
  internal stateful communication service.

Network components
~~~~~~~~~~~~~~~~~~

[TODO Need discussion of network hardware, bonding interfaces,
intelligent Layer 2 switches, routers and Layer 3 switches.]

The configuration uses static routing without
Virtual Router Redundancy Protocol (VRRP)
or similar techniques implemented.

[TODO Need description of VIP failover inside Linux namespaces
and expected SLA.]

See :doc:`networking-ha` for more information about configuring
Networking for high availability.

Common deployment architectures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are primarily two recommended architectures for making OpenStack
highly available.

Both use a cluster manager such as Pacemaker or Veritas to
orchestrate the actions of the various services across a set of
machines. Since we are focused on FOSS, we will refer to these as
Pacemaker architectures.

The architectures differ in the sets of services managed by the
cluster.

Traditionally, Pacemaker has been positioned as an all-encompassing
solution. However, as OpenStack services have matured, they are
increasingly able to run in an active/active configuration and
gracefully tolerate the disappearance of the APIs on which they
depend.

With this in mind, some vendors are restricting Pacemaker's use to
services that must operate in an active/passive mode (such as
cinder-volume), those with multiple states (for example, Galera) and
those with complex bootstrapping procedures (such as RabbitMQ).

The majority of services, needing no real orchestration, are handled
by Systemd on each node. This approach avoids the need to coordinate
service upgrades or location changes with the cluster and has the
added advantage of more easily scaling beyond Corosync's 16 node
limit. However, it will generally require the addition of an
enterprise monitoring solution such as Nagios or Sensu for those
wanting centralized failure reporting.

.. toctree::
   :maxdepth: 1

   intro-ha-arch-pacemaker.rst
