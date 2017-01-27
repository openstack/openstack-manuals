====================
Logical architecture
====================

To design, deploy, and configure OpenStack, administrators must
understand the logical architecture.

As shown in :ref:`get_started_conceptual_architecture`, OpenStack consists of
several independent parts, named the OpenStack services. All services
authenticate through a common Identity service. Individual services interact
with each other through public APIs, except where privileged administrator
commands are necessary.

Internally, OpenStack services are composed of several processes. All
services have at least one API process, which listens for API requests,
preprocesses them and passes them on to other parts of the service. With
the exception of the Identity service, the actual work is done by
distinct processes.

For communication between the processes of one service, an AMQP message
broker is used. The service's state is stored in a database. When
deploying and configuring your OpenStack cloud, you can choose among
several message broker and database solutions, such as RabbitMQ,
MySQL, MariaDB, and SQLite.

Users can access OpenStack via the web-based user interface implemented
by :doc:`Dashboard <get-started-dashboard>`, via `command-line
clients <https://docs.openstack.org/cli-reference/>`__ and by
issuing API requests through tools like browser plug-ins or :command:`curl`.
For applications, `several SDKs <http://developer.openstack.org/#sdk>`__
are available. Ultimately, all these access methods issue REST API calls
to the various OpenStack services.

The following diagram shows the most common, but not the only possible,
architecture for an OpenStack cloud:

.. image:: figures/openstack-arch-kilo-logical-v1.png
   :alt: Logical architecture
   :width: 100%
