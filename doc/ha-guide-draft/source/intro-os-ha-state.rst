==================================
Stateless versus stateful services
==================================

OpenStack components can be divided into three categories:

- OpenStack APIs: APIs that are HTTP(s) stateless services written in python,
  easy to duplicate and mostly easy to load balance.

- The SQL relational database server provides stateful type consumed by other
  components. Supported databases are MySQL, MariaDB, and PostgreSQL.
  Making the SQL database redundant is complex.

- :term:`Advanced Message Queuing Protocol (AMQP)` provides OpenStack
  internal stateful communication service.

.. to do: Ensure the difference between stateless and stateful services
.. is clear

Stateless services
~~~~~~~~~~~~~~~~~~

A service that provides a response after your request and then
requires no further attention. To make a stateless service highly
available, you need to provide redundant instances and load balance them.

Stateless OpenStack services
----------------------------

OpenStack services that are stateless include ``nova-api``,
``nova-conductor``, ``glance-api``, ``keystone-api``, ``neutron-api``,
and ``nova-scheduler``.

Stateful services
~~~~~~~~~~~~~~~~~

A service where subsequent requests to the service
depend on the results of the first request.
Stateful services are more difficult to manage because a single
action typically involves more than one request. Providing
additional instances and load balancing does not solve the problem.
For example, if the horizon user interface reset itself every time
you went to a new page, it would not be very useful.
OpenStack services that are stateful include the OpenStack database
and message queue.
Making stateful services highly available can depend on whether you choose
an active/passive or active/active configuration.

Stateful OpenStack services
----------------------------

.. to do: create list of stateful services
