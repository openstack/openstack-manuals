==================================
Configure the RPC messaging system
==================================

OpenStack projects use an open standard for messaging middleware known
as AMQP. This messaging middleware enables the OpenStack services that
run on multiple servers to talk to each other. The OpenStack common
library project, oslo, supports two implementations of AMQP: RabbitMQ and
ZeroMQ.

The following tables contain settings to configure the messaging
middleware for the Shared File System service:

.. include:: ../tables/manila-amqp.rst
.. include:: ../tables/manila-rpc.rst
.. include:: ../tables/manila-rabbitmq.rst
.. include:: ../tables/manila-zeromq.rst
