Enable Compute service meters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Telemetry uses a combination of notifications and an agent to collect
Compute meters. Perform these steps on each compute node.

Install and configure components
--------------------------------

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-ceilometer-agent-compute

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-ceilometer-compute python-ceilometerclient python-pecan

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install ceilometer-agent-compute

2. Edit the ``/etc/ceilometer/ceilometer.conf`` file and
   complete the following actions:

   * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
     configure ``RabbitMQ`` message queue access:

     .. code-block:: ini

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

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        auth_plugin = password
        project_domain_id = default
        user_domain_id = default
        project_name = service
        username = ceilometer
        password = CEILOMETER_PASS

     Replace ``CEILOMETER_PASS`` with the password you chose for the
     Telemetry service database.

   * In the ``[service_credentials]`` section, configure service
     credentials:

     .. code-block:: ini

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

   * (Optional) To assist with troubleshooting, enable verbose
     logging in the ``[DEFAULT]`` section:

     .. code-block:: ini

        [DEFAULT]
        ...
        verbose = True

Configure Compute to use Telemetry
----------------------------------

* Edit the ``/etc/nova/nova.conf`` file and configure
  notifications in the ``[DEFAULT]`` section:

  .. code-block:: ini

     [DEFAULT]
     ...
     instance_usage_audit = True
     instance_usage_audit_period = hour
     notify_on_state_change = vm_and_task_state
     notification_driver = messagingv2

Finalize installation
---------------------

.. only:: obs

   #. Start the agent and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-agent-compute.service
         # systemctl start openstack-ceilometer-agent-compute.service

.. only:: rdo

   #. Start the agent and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-compute.service
         # systemctl start openstack-ceilometer-compute.service

.. only:: obs or rdo

   2. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

.. only:: ubuntu

   #. Restart the agent:

      .. code-block:: console

         # service ceilometer-agent-compute restart

   #. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart
