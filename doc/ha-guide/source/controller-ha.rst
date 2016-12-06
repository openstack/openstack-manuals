==========================
Configuring the controller
==========================

The cloud controller runs on the management network and must talk to
all other services.

.. toctree::
   :maxdepth: 2

   intro-ha-arch-pacemaker.rst
   controller-ha-pacemaker.rst
   controller-ha-vip.rst
   controller-ha-haproxy.rst
   controller-ha-memcached.rst
   controller-ha-identity.rst
   controller-ha-telemetry.rst

Overview of highly available controllers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack is a set of services exposed to the end users
as HTTP(s) APIs. Additionally, for your own internal usage, OpenStack
requires an SQL database server and AMQP broker. The physical servers,
where all the components are running, are called controllers.
This modular OpenStack architecture allows you to duplicate all the
components and run them on different controllers.
By making all the components redundant, it is possible to make
OpenStack highly available.

In general, we can divide all the OpenStack components into three categories:

- OpenStack APIs: APIs that are HTTP(s) stateless services written in python,
  easy to duplicate and mostly easy to load balance.

- The SQL relational database server provides stateful type consumed by other
  components. Supported databases are MySQL, MariaDB, and PostgreSQL.
  Making the SQL database redundant is complex.

- :term:`Advanced Message Queuing Protocol (AMQP)` provides OpenStack
  internal stateful communication service.

Common deployment architectures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend two primary architectures for making OpenStack highly available.

The architectures differ in the sets of services managed by the
cluster.

Both use a cluster manager, such as Pacemaker or Veritas, to
orchestrate the actions of the various services across a set of
machines. Because we are focused on FOSS, we refer to these as
Pacemaker architectures.

Traditionally, Pacemaker has been positioned as an all-encompassing
solution. However, as OpenStack services have matured, they are
increasingly able to run in an active/active configuration and
gracefully tolerate the disappearance of the APIs on which they
depend.

With this in mind, some vendors are restricting Pacemaker's use to
services that must operate in an active/passive mode (such as
``cinder-volume``), those with multiple states (for example, Galera), and
those with complex bootstrapping procedures (such as RabbitMQ).

The majority of services, needing no real orchestration, are handled
by systemd on each node. This approach avoids the need to coordinate
service upgrades or location changes with the cluster and has the
added advantage of more easily scaling beyond Corosync's 16 node
limit. However, it will generally require the addition of an
enterprise monitoring solution such as Nagios or Sensu for those
wanting centralized failure reporting.
