============================
RPC messaging configurations
============================

OpenStack services use advanced message queuing protocol (AMQP),
an open standard for messaging middleware.
This messaging middleware enables the OpenStack services that run on
multiple servers to talk to each other. OpenStack Oslo RPC supports
two implementations of AMQP: RabbitMQ and ZeroMQ.

Configure messaging
~~~~~~~~~~~~~~~~~~~

Use these options to configure the RPC messaging driver.

.. include:: ../tables/common-amqp.rst
.. include:: ../tables/common-rpc.rst

Configure RabbitMQ
~~~~~~~~~~~~~~~~~~

OpenStack Oslo RPC uses ``RabbitMQ`` by default.
The ``rpc_backend`` option is not required as long as ``RabbitMQ``
is the default messaging system. However, if it is included
in the configuration, you must set it to ``rabbit``:

.. code-block:: ini

   rpc_backend = rabbit

You can configure messaging communication for different installation
scenarios, tune retries for RabbitMQ, and define the size of the RPC
thread pool. To monitor notifications through ``RabbitMQ``,
you must set the ``notification_driver`` option to
``nova.openstack.common.notifier.rpc_notifier``.
The default value for sending usage data is sixty seconds plus
a random number of seconds from zero to sixty.

Use the options described in the table below to configure the
``RabbitMQ`` message system.

.. include:: ../tables/oslo-messaging-rabbit.rst

Configure ZeroMQ
~~~~~~~~~~~~~~~~

Use these options to configure the ``ZeroMQ`` messaging system for OpenStack
Oslo RPC. ``ZeroMQ`` is not the default messaging system, so you must enable
it by setting the ``rpc_backend`` option.

.. include:: ../tables/common-zeromq.rst
