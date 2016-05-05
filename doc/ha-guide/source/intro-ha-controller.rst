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

See [TODO link] for more information about configuring networking
for high availability.

Common deployement architectures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are primarily two HA architectures in use today.

One uses a cluster manager such as Pacemaker or Veritas to co-ordinate
the actions of the various services across a set of machines. Since
we are focused on FOSS, we will refer to this as the Pacemaker
architecture.

The other is optimized for Active/Active services that do not require
any inter-machine coordination. In this setup, services are started by
your init system (systemd in most modern distributions) and a tool is
used to move IP addresses between the hosts. The most common package
for doing this is keepalived.

.. toctree::
   :maxdepth: 1

   intro-ha-arch-pacemaker.rst
   intro-ha-arch-keepalived.rst
