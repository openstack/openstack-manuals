==================================
Configure the RPC messaging system
==================================

OpenStack projects use an open standard for messaging middleware known
as AMQP. This messaging middleware enables the OpenStack services that
run on multiple servers to talk to each other. OpenStack Trove RPC
supports two implementations of AMQP: RabbitMQ and ZeroMQ.

Configure RabbitMQ
~~~~~~~~~~~~~~~~~~

Use these options to configure the RabbitMQ messaging system
in the ``trove.conf`` file:

.. include:: ../tables/trove-rabbitmq.rst

Configure ZeroMQ
~~~~~~~~~~~~~~~~

Use these options to configure the ZeroMQ messaging system
in the ``trove.conf`` file:

.. include:: ../tables/trove-zeromq.rst

Configure messaging
~~~~~~~~~~~~~~~~~~~

Use these common options to configure the RabbitMQ and ZeroMq
messaging drivers in the ``trove.conf`` file:

.. include:: ../tables/trove-amqp.rst
.. include:: ../tables/trove-rpc.rst
