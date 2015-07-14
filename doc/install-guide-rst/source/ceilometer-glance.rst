===========================
Configure the Image service
===========================

To retrieve image-oriented events and samples, configure
the Image service to send notifications to the message bus.
Perform these steps on the controller node.

Edit the :file:`/etc/glance/glance-api.conf` and
:file:`/etc/glance/glance-registry.conf` files and
complete the following actions:

1. In the ``[DEFAULT]`` section, configure notifications
   and RabbitMQ message broker access:

   .. code-block:: ini

      [DEFAULT]
      ...
      notification_driver = messagingv2
      rpc_backend = rabbit
      rabbit_host = controller
      rabbit_userid = openstack
      rabbit_password = RABBIT_PASS

   Replace ``RABBIT_PASS`` with the password you chose for
   the ``openstack`` account in ``RabbitMQ``.

.. only:: obs or rdo

   2. Restart the Image service:

      .. code-block:: console

         # systemctl restart openstack-glance-api.service openstack-glance-registry.service

.. only:: ubuntu

   2. Restart the Image service:

      .. code-block:: console

         # service glance-registry restart
         # service glance-api restart
