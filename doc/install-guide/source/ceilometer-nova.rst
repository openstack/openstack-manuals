=============================
Configure the Compute service
=============================

Telemetry uses a combination of notifications and an agent to
collect Compute meters. Perform these steps on each compute node.

To install and configure the agent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   1. Install the packages:

      .. code-block:: console

         # zypper install openstack-ceilometer-agent-compute

.. only:: rdo

   1. Install the packages:

      .. code-block:: console

         # yum install openstack-ceilometer-compute python-ceilometerclient python-pecan

.. only:: ubuntu

   1. Install the packages:

      .. code-block:: console

         # apt-get install ceilometer-agent-compute

2. Edit the :file:`/etc/ceilometer/ceilometer.conf` file and
   complete the following actions:

   a. In the ``[publisher]`` section, configure the telemetry secret:

      .. code-block:: ini
         :linenos:

         [publisher]
         ...
         telemetry_secret = TELEMETRY_SECRET

      Replace ``TELEMETRY_SECRET`` with the telemetry secret you
      chose for the Telemetry module.

   b. In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
      configure ``RabbitMQ`` message queue access:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         rpc_backend = rabbit

         [oslo_messaging_rabbit]
         ...
         rabbit_host = controller
         rabbit_userid = openstack
         rabbit_password = RABBIT_PASS

      Replace ``RABBIT_PASS`` with the password you chose for the
      ``openstack`` account in ``RabbitMQ``.

   c. In the ``[keystone_authtoken]`` section,
      configure Identity service access:

      .. code-block:: ini
         :linenos:

         [keystone_authtoken]
         ...
         auth_uri = http://controller:5000/v2.0
         identity_uri = http://controller:35357
         admin_tenant_name = service
         admin_user = ceilometer
         admin_password = CEILOMETER_PASS

      Replace ``CEILOMETER_PASS`` with the password you chose for the
      Telemetry module database.

      .. note::

         Comment out any ``auth_host``, ``auth_port``, and
         ``auth_protocol`` options because the ``identity_uri``
         option replaces them.

   d. In the ``[service_credentials]`` section, configure service
      credentials:

      .. code-block:: ini
         :linenos:

         [service_credentials]
         ...
         os_auth_url = http://controller:5000/v2.0
         os_username = ceilometer
         os_tenant_name = service
         os_password = CEILOMETER_PASS
         os_endpoint_type = internalURL
         os_region_name = RegionOne

      Replace ``CEILOMETER_PASS`` with the password you chose for
      the ``ceilometer`` user in the Identity service.

   e. (Optional) To assist with troubleshooting, enable verbose
      logging in the ``[DEFAULT]`` section:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         verbose = True

To configure notifications
~~~~~~~~~~~~~~~~~~~~~~~~~~

Configure the Compute service to send notifications to the message bus.

Edit the :file:`/etc/nova/nova.conf` file and configure
notifications in the ``[DEFAULT]`` section:

.. code-block:: ini
   :linenos:

   [DEFAULT]
   ...
   instance_usage_audit = True
   instance_usage_audit_period = hour
   notify_on_state_change = vm_and_task_state
   notification_driver = messagingv2

The Nova notification_driver creates alerts and sends system state
updates to administrators and users. The notification_driver
sends this information to users in a manner as close to real-time
as possible.

Notifications in real-time allow administrars to observe and resolve
emergencies when the cloud environment experiences errors or faults.

Administrators can also restrict notification delivery to certain
tenant groups. Users can view notifications through a web browser,
without using a specific interface.

Messages arrive in a specific format which includes: Message ID,
Publisher ID, Event type, Timestamp, Priority, and Payload. See the
`Notification System information <https://wiki.openstack.org/wiki/
NotificationSystem#General_Notification_Message_Format>`__ for an
example message format.

Notification messages are placed on the OpenStack messaging system,
which recruits AMQP to send information when an event triggers alerts.

The :file:`nova.conf` file uses the nova_notification driver by defualt.

.. warning::

   While you can use a customised notification_driver, we
   recommend using the default settings. Using stable web hooks
   for events, such as creating new instances, and using custom
   notification drivers are not guaranteed to
   deliver notifications in real-time.

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   1. Start the Telemetry agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-agent-compute.service
         # systemctl start openstack-ceilometer-agent-compute.service

.. only:: rdo

   1. Start the Telemetry agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-compute.service
         # systemctl start openstack-ceilometer-compute.service

.. only:: obs or rdo

   2. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

.. only:: ubuntu

   1. Restart the agent:

      .. code-block:: console

         # service ceilometer-agent-compute restart

   2. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart
