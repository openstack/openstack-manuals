Enable Image service meters
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Telemetry uses notifications to collect Image service meters. Perform
these steps on the controller node.

Configure the Image service to use Telemetry
--------------------------------------------

* Edit the ``/etc/glance/glance-api.conf`` and
  ``/etc/glance/glance-registry.conf`` files and
  complete the following actions:

  * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
    configure notifications and RabbitMQ message broker access:

    .. code-block:: ini

       [DEFAULT]
       ...
       notification_driver = messagingv2
       rpc_backend = rabbit

       [oslo_messaging_rabbit]
       ...
       rabbit_host = controller
       rabbit_userid = openstack
       rabbit_password = RABBIT_PASS

    Replace ``RABBIT_PASS`` with the password you chose for
    the ``openstack`` account in ``RabbitMQ``.

Finalize installation
---------------------

.. only:: obs or rdo

   * Restart the Image service:

     .. code-block:: console

        # systemctl restart openstack-glance-api.service openstack-glance-registry.service

.. only:: ubuntu or debian

   * Restart the Image service:

     .. code-block:: console

        # service glance-registry restart
        # service glance-api restart
