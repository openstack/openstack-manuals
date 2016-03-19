==================================
Configure the RPC messaging system
==================================

OpenStack projects use an open standard for messaging middleware known
as AMQP. This messaging middleware enables the OpenStack services that
run on multiple servers to talk to each other. OpenStack Oslo RPC
supports two implementations of AMQP: RabbitMQ and ZeroMQ.


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
file.

.. include:: ../tables/heat-rabbitmq.rst

Configure ZeroMQ
~~~~~~~~~~~~~~~~

Use these options to configure the ZeroMQ messaging system for
OpenStack Oslo RPC. ZeroMQ is not the default messaging system, so you
must enable it by setting the ``rpc_backend`` option in the
``heat.conf`` file.

.. include:: ../tables/heat-zeromq.rst

Configure messaging
~~~~~~~~~~~~~~~~~~~

Use these common options to configure the RabbitMQ and ZeroMq
messaging drivers in the ``heat.conf`` file.

.. include:: ../tables/heat-amqp.rst
.. include:: ../tables/heat-rpc.rst
.. include:: ../tables/heat-notification.rst
