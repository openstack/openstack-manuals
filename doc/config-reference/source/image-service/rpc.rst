==================================
Configure the RPC messaging system
==================================

OpenStack projects use an open standard for messaging middleware known
as AMQP. This messaging middleware enables the OpenStack services that
run on multiple servers to talk to each other. The OpenStack common
library project, oslo, supports two implementations of AMQP: RabbitMQ and
ZeroMQ.

The following tables contain settings to configure the messaging middleware
for the Image service. Use these options to configure the messaging drivers
in the ``glance-api.conf`` and ``glance-registry.conf`` files:

.. include:: ../tables/glance-zeromq.rst
.. include:: ../tables/glance-amqp.rst
.. include:: ../tables/glance-rpc.rst
.. include:: ../tables/glance-rabbitmq.rst
