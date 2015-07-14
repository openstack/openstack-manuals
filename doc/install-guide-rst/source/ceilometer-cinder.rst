===================================
Configure the Block Storage service
===================================

To retrieve volume-oriented events and samples, you must configure
the Block Storage service to send notifications to the message bus.
Perform these steps on the controller and storage nodes.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`/etc/cinder/cinder.conf` file and complete the
following actions:

1. In the ``[DEFAULT]`` section, configure notifications:

   .. code-block:: ini

      [DEFAULT]
      ...
      control_exchange = cinder
      notification_driver = messagingv2</programlisting>

.. only:: obs or rdo

   2. Restart the Block Storage services on the controller node:

      .. code-block:: console

         # systemctl restart openstack-cinder-api.service openstack-cinder-scheduler.service

   3. Restart the Block Storage services on the storage nodes:

      .. code-block:: console

         # systemctl restart openstack-cinder-volume.service

.. only:: ubuntu

   2. Restart the Block Storage services on the controller node:

      .. code-block:: console

         # service cinder-api restart
         # service cinder-scheduler restart

   3. Restart the Block Storage services on the storage nodes:

      .. code-block:: console

         # service cinder-volume restart

4. Use the ``cinder-volume-usage-audit`` command to retrieve meters
   on demand. For more information, see `Block Storage audit script
   setup to get notifications <http://docs.openstack.org/
   admin-guide-cloud/content/section_telemetry-cinder-audit-script.html>`__.
