Message queue for Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack uses a :term:`message queue` to coordinate operations and
status information among services. The message queue service typically
runs on the controller node. OpenStack supports several message queue
services including `RabbitMQ <https://www.rabbitmq.com>`__ and
`Qpid <https://qpid.apache.org>`__.
However, most distributions that package OpenStack support a particular
message queue service. This guide implements the RabbitMQ message queue
service because most distributions support it. If you prefer to
implement a different message queue service, consult the documentation
associated with it.

The message queue runs on the controller node.

Install and configure components
--------------------------------

1. Install the package:

   .. code-block:: console

      # apt install rabbitmq-server

2. Add the ``openstack`` user:

   .. code-block:: console

      # rabbitmqctl add_user openstack RABBIT_PASS

      Creating user "openstack" ...

   Replace ``RABBIT_PASS`` with a suitable password.

3. Permit configuration, write, and read access for the
   ``openstack`` user:

   .. code-block:: console

      # rabbitmqctl set_permissions openstack ".*" ".*" ".*"

      Setting permissions for user "openstack" in vhost "/" ...

.. note::

   Sometimes it's necessary to increase the file descriptor limit for RabbitMQ to
   handle a large number of connections properly.
