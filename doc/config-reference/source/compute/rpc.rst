=======================================
Configure the Oslo RPC messaging system
=======================================

OpenStack projects use AMQP, an open standard for messaging middleware.
This messaging middleware enables the OpenStack services that run on
multiple servers to talk to each other. OpenStack Oslo RPC supports
two implementations of AMQP: RabbitMQ and ZeroMQ.

Configure RabbitMQ
~~~~~~~~~~~~~~~~~~

OpenStack Oslo RPC uses ``RabbitMQ`` by default.
Use these options to configure the ``RabbitMQ`` message system.
The ``rpc_backend`` option is not required as long as ``RabbitMQ``
is the default messaging system. However, if it is included in
the configuration, you must set it to ``rabbit``.

.. code-block:: ini

   rpc_backend=rabbit

You can use these additional options to configure the ``RabbitMQ``
messaging system. You can configure messaging communication for
different installation scenarios, tune retries for RabbitMQ, and
define the size of the RPC thread pool. To monitor notifications
through ``RabbitMQ``, you must set the ``notification_driver`` option to
``nova.openstack.common.notifier.rpc_notifier`` in the ``nova.conf`` file.
The default for sending usage data is sixty seconds plus a random
number of seconds from zero to sixty.

.. include:: ../tables/nova-rabbitmq.rst

Configure ZeroMQ
~~~~~~~~~~~~~~~~

Use these options to configure the ``ZeroMQ`` messaging system for OpenStack
Oslo RPC. ``ZeroMQ`` is not the default messaging system, so you must enable
it by setting the ``rpc_backend`` option in the ``nova.conf`` file.

.. include:: ../tables/nova-zeromq.rst

Configure messaging
~~~~~~~~~~~~~~~~~~~

Use these options to configure the ``RabbitMQ`` messaging driver in the
``nova.conf`` file.

.. include:: ../tables/nova-amqp.rst
.. include:: ../tables/nova-rpc.rst
