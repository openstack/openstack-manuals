====================================
Configure the Object Storage service
====================================

To retrieve storage-oriented events and samples, configure the
Object Storage service to send notifications to the message bus.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Telemetry service requires access to the Object Storage
service using the ``ResellerAdmin`` role. Perform
these steps on the controller node.

1. Source the ``admin`` credentials to gain access to admin-only
   CLI commands.

   .. code-block:: console

      $ source admin-openrc.sh

2. Create the ``ResellerAdmin`` role:

   .. code-block:: console

      $ openstack role create ResellerAdmin
      +-------+----------------------------------+
      | Field | Value                            |
      +-------+----------------------------------+
      | id    | 462fa46c13fd4798a95a3bfbe27b5e54 |
      | name  | ResellerAdmin                    |
      +-------+----------------------------------+

3. Add the ``ResellerAdmin`` role to the ``service`` tenant and
   ``ceilometer`` user:

   .. code-block:: console

      $ openstack role add --project service --user ceilometer ResellerAdmin
      +-------+----------------------------------+
      | Field | Value                            |
      +-------+----------------------------------+
      | id    | 462fa46c13fd4798a95a3bfbe27b5e54 |
      | name  | ResellerAdmin                    |
      +-------+----------------------------------+

To configure notifications
~~~~~~~~~~~~~~~~~~~~~~~~~~

Perform these steps on the controller and any other nodes that
run the Object Storage proxy service.

1. Edit the ``/etc/swift/proxy-server.conf`` file
   and complete the following actions:

   a. In the ``[filter:keystoneauth]`` section, add the
      ``ResellerAdmin`` role:

      .. code-block:: ini

         [filter:keystoneauth]
         ...
         operator_roles = admin,user,ResellerAdmin

   b. In the ``[pipeline:main]`` section, add ``ceilometer``:

      .. code-block:: ini

         [pipeline:main]
         ...
         pipeline = authtoken cache healthcheck keystoneauth proxy-logging ceilometer proxy-server

   c. In the ``[filter:ceilometer]`` section, configure notifications:

      .. code-block:: ini

         [filter:ceilometer]
         ...
         paste.filter_factory = ceilometermiddleware.swift:filter_factory
         control_exchange = swift
         url = rabbit://openstack:RABBIT_PASS@controller:5672/
         driver = messagingv2
         topic = notifications
         log_level = WARN

      Replace ``RABBIT_PASS`` with the password you chose for the
      ``openstack`` account in ``RabbitMQ``.

2. Add the ``swift`` system user to the ``ceilometer`` system group
   to permit access to the Telemetry configuration files by the
   Object Storage service:

   .. code-block:: console

      # usermod -a -G ceilometer swift

.. only:: obs


   3. Restart the Object Storage proxy service:

      .. code-block:: console

         # systemctl restart openstack-swift-proxy.service

.. only:: rdo

   3. Install the ``ceilometermiddleware`` package:

      .. Workaround for https://bugzilla.redhat.com/show_bug.cgi?id=1214928

      .. code-block:: console

         # pip install ceilometermiddleware

   4. Restart the Object Storage proxy service:

      .. code-block:: console

         # systemctl restart openstack-swift-proxy.service

.. only:: ubuntu

   3. Restart the Object Storage proxy service:

      .. code-block:: console

         # service swift-proxy restart
