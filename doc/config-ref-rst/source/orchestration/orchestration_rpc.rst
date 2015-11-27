==================================
Configure the RPC messaging system
==================================

OpenStack projects use an open standard for messaging middleware known
as AMQP. This messaging middleware enables the OpenStack services that
run on multiple servers to talk to each other. OpenStack Oslo RPC
supports three implementations of AMQP: RabbitMQ, Qpid, and ZeroMQ.


Configure RabbitMQ
~~~~~~~~~~~~~~~~~~

OpenStack Oslo RPC uses RabbitMQ by default. Use these options to
configure the RabbitMQ message system. The ``rpc_backend`` option is
optional as long as RabbitMQ is the default messaging system. However,
if it is included in the configuration, you must set it to
``heat.openstack.common.rpc.impl_kombu``:

.. code-block:: ini

   rpc_backend = heat.openstack.common.rpc.impl_kombu

Use these options to configure the RabbitMQ messaging system. You can
configure messaging communication for different installation
scenarios, tune retries for RabbitMQ, and define the size of the RPC
thread pool. To monitor notifications through RabbitMQ, you must set
the ``notification_driver`` option to
``heat.openstack.common.notifier.rpc_notifier`` in the ``heat.conf``
file:

.. include:: ../tables/heat-rabbitmq.rst

Configure Qpid
~~~~~~~~~~~~~~

Use these options to configure the
Qpid messaging system for OpenStack
Oslo RPC. Qpid is not the default
messaging system, so you must enable it by setting the
``rpc_backend`` option in the
``heat.conf`` file:

.. code-block:: ini

   rpc_backend = heat.openstack.common.rpc.impl_qpid

This critical option points the compute nodes to the Qpid broker
(server). Set the ``qpid_hostname`` option to the host name where the
broker runs in the ``heat.conf`` file.

.. note::

   The ``qpid_hostname`` option accepts a host name or IP address
   value.

.. code-block:: ini

   qpid_hostname = hostname.example.com

If the Qpid broker listens on a
port other than the AMQP default of 5672, you
must set the ``qpid_port`` option to that
value:

.. code-block:: ini

   qpid_port = 12345

If you configure the Qpid broker to require authentication, you must
add a user name and password to the configuration:

.. code-block:: ini

   qpid_username = username
   qpid_password = password

By default, TCP is used as the transport. To enable SSL, set
the ``qpid_protocol`` option:

.. code-block:: ini

   qpid_protocol = ssl

Use these additional options to configure the Qpid messaging
driver for OpenStack Oslo RPC. These options are used
infrequently.

.. include:: ../tables/heat-qpid.rst

Configure ZeroMQ
~~~~~~~~~~~~~~~~

Use these options to configure the ZeroMQ messaging system for
OpenStack Oslo RPC. ZeroMQ is not the default messaging system, so you
must enable it by setting the ``rpc_backend`` option in the
``heat.conf`` file.

.. include:: ../tables/heat-zeromq.rst

Configure messaging
~~~~~~~~~~~~~~~~~~~

Use these common options to configure the RabbitMQ, Qpid, and ZeroMq
messaging drivers:

.. include:: ../tables/heat-amqp.rst
.. include:: ../tables/heat-rpc.rst
.. include:: ../tables/heat-notification.rst
