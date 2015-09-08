Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prerequisites
-------------

Before you configure the OpenStack Networking (neutron) service, you
must create a database, service credentials, and API endpoints.

#. To create the database, complete these steps:

   a. Use the database access client to connect to the database server as the
      ``root`` user:

      .. code:: console

         $ mysql -u root -p

   #. Create the ``neutron`` database:

      .. code:: console

         CREATE DATABASE neutron;

   #. Grant proper access to the ``neutron`` database, replacing
      ``NEUTRON_DBPASS`` with a suitable password:

      .. code:: console

         GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
           IDENTIFIED BY 'NEUTRON_DBPASS';
         GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
           IDENTIFIED BY 'NEUTRON_DBPASS';

   #. Exit the database access client.

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code:: console

      $ source admin-openrc.sh

#. To create the service credentials, complete these steps:

   a. Create the ``neutron`` user:

      .. code:: console

         $ openstack user create --password-prompt neutron
         User Password:
         Repeat User Password:
         +----------+----------------------------------+
         | Field    | Value                            |
         +----------+----------------------------------+
         | email    | None                             |
         | enabled  | True                             |
         | id       | ab67f043d9304017aaa73d692eeb4945 |
         | name     | neutron                          |
         | username | neutron                          |
         +----------+----------------------------------+

   #. Add the ``admin`` role to the ``neutron`` user:

      .. code:: console

         $ openstack role add --project service --user neutron admin
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
         | name  | admin                            |
         +-------+----------------------------------+

   #. Create the ``neutron`` service entity:

      .. code:: console

         $ openstack service create --name neutron \
           --description "OpenStack Networking" network
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | OpenStack Networking             |
         | enabled     | True                             |
         | id          | f71529314dab4a4d8eca427e701d209e |
         | name        | neutron                          |
         | type        | network                          |
         +-------------+----------------------------------+

#. Create the Networking service API endpoints:

   .. code:: console

      $ openstack endpoint create \
        --publicurl http://controller:9696 \
        --adminurl http://controller:9696 \
        --internalurl http://controller:9696 \
        --region RegionOne \
        network
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | adminurl     | http://controller:9696           |
      | id           | 04a7d3c1de784099aaba83a8a74100b3 |
      | internalurl  | http://controller:9696           |
      | publicurl    | http://controller:9696           |
      | region       | RegionOne                        |
      | service_id   | f71529314dab4a4d8eca427e701d209e |
      | service_name | neutron                          |
      | service_type | network                          |
      +--------------+----------------------------------+

Configure networking options
----------------------------

Choose one of the following networking options to configure services
specific to it.

.. note::

   Option 2 augments option 1 with the layer-3 (routing) service and
   enables self-service (private) networks. If you want to use public
   (provider) and private (self-service) networks, choose option 2.

.. toctree::
   :maxdepth: 1

   neutron-controller-install-option1.rst
   neutron-controller-install-option2.rst

.. _neutron-controller-metadata-agent:

Configure the metadata agent
----------------------------

The :term:`metadata agent <Metadata agent>` provides configuration information
such as credentials to instances.

Edit the ``/etc/neutron/metadata_agent.ini`` file.

#. In the ``[DEFAULT]`` section, configure access parameters:

   .. code-block:: ini

      [DEFAULT]
      ...
      auth_uri = http://controller:5000
      auth_url = http://controller:35357
      auth_region = RegionOne
      auth_plugin = password
      project_domain_id = default
      user_domain_id = default
      project_name = service
      username = neutron
      password = NEUTRON_PASS

   Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
   user in the Identity service.

#. In the ``[DEFAULT]`` section, configure the metadata host:

   .. code-block:: ini

      [DEFAULT]
      ...
      nova_metadata_ip = controller

#. In the ``[DEFAULT]`` section, configure the metadata proxy shared
   secret:

   .. code-block:: ini

      [DEFAULT]
      ...
      metadata_proxy_shared_secret = METADATA_SECRET

   Replace ``METADATA_SECRET`` with a suitable secret for the metadata proxy.

#. (Optional) To assist with troubleshooting, enable verbose logging in the
   ``[DEFAULT]`` section:

   .. code-block:: ini

      [DEFAULT]
      ...
      verbose = True

Configure Compute to use Networking
-----------------------------------

Edit the ``/etc/nova/nova.conf`` file:

#. In the ``[DEFAULT]`` section, configure Compute to use the Networking
   service:

   .. code-block:: ini

      [DEFAULT]
      network_api_class = nova.network.neutronv2.api.API
      security_group_api = neutron
      linuxnet_interface_driver = nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
      firewall_driver = nova.virt.firewall.NoopFirewallDriver

   .. note::

      The ``firewall_driver`` option uses the ``NoopFirewallDriver`` value
      because Compute delegates security group (firewall) operation to the
      Networking service.

#. In the ``[neutron]`` section, configure access parameters, enable the
   metadata proxy, and configure the secret:

   .. code-block:: ini

      [neutron]
      ...
      url = http://controller:9696
      auth_strategy = keystone
      admin_auth_url = http://controller:35357/v2.0
      admin_tenant_name = service
      admin_username = neutron
      admin_password = NEUTRON_PASS

      service_metadata_proxy = True
      metadata_proxy_shared_secret = METADATA_SECRET

   Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
   user in the Identity service.

   Replace ``METADATA_SECRET`` with the secret you chose for the metadata
   proxy.

Finalize installation
---------------------

.. only:: rdo

   #. The Networking service initialization scripts expect a symbolic link
      :file:`/etc/neutron/plugin.ini` pointing to the ML2 plug-in configuration
      file, :file:`/etc/neutron/plugins/ml2/ml2_conf.ini`. If this symbolic
      link does not exist, create it using the following command:

      .. code:: console

         # ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

   #. Due to a packaging issue, the Linux bridge agent initialization script
      explicitly looks for the Linux bridge plug-in configuration file rather
      than the agent configuration file. Run the following commands to resolve
      this issue:

      .. code-block:: console

         # cp /usr/lib/systemd/system/neutron-linuxbridge-agent.service \
           /usr/lib/systemd/system/neutron-linuxbridge-agent.service.orig
         # sed -i 's,openvswitch/linuxbridge_neutron_plugin.ini,ml2/linuxbridge_agent.ini,g' \
           /usr/lib/systemd/system/neutron-linuxbridge-agent.service

      .. note::

         Future upgrades of the ``neutron-linuxbridge-agent`` package may
         overwrite this modification.

   #. Populate the database:

      .. code:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the Compute services:

      .. code:: console

         # systemctl restart openstack-nova-api.service openstack-nova-scheduler.service \
           openstack-nova-conductor.service

   #. Start the Networking services and configure them to start when the system
      boots.

      For both networking options:

      .. code:: console

         # systemctl enable neutron-server.service \
           neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
           neutron-metadata-agent.service
         # systemctl start neutron-server.service \
           neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
           neutron-metadata-agent.service

      For networking option 2, also enable and start the layer-3 service:

      .. code:: console

         # systemctl enable neutron-l3-agent.service
         # systemctl start neutron-l3-agent.service

.. only:: obs

   #. The Networking service initialization scripts expect the variable
      ``NEUTRON_PLUGIN_CONF`` in the :file:`/etc/sysconfig/neutron` file to
      reference the ML2 plug-in configuration file. Edit the
      :file:`/etc/sysconfig/neutron` file and add the following:

      .. code:: console

         NEUTRON_PLUGIN_CONF="/etc/neutron/plugins/ml2/ml2_conf.ini"

   #. Restart the Compute services:

      .. code:: console

         # systemctl restart openstack-nova-api.service openstack-nova-scheduler.service \
           openstack-nova-conductor.service

   #. Start the Networking services and configure them to start when the system
      boots.

      For both networking options:

      .. code:: console

         # systemctl enable openstack-neutron.service \
           openstack-neutron-linuxbridge.service \
           openstack-neutron-dhcp-agent.service \
           openstack-neutron-metadata-agent.service
         # systemctl start openstack-neutron.service \
           openstack-neutron-linuxbridge.service \
           openstack-neutron-dhcp-agent.service \
           openstack-neutron-metadata-agent.service

      For networking option 2, also enable and start the layer-3 service:

      .. code:: console

         # systemctl enable openstack-neutron-l3-agent.service
         # systemctl start openstack-neutron-l3-agent.service

.. only:: ubuntu

   #. Due to a packaging issue, the Linux bridge agent initialization script
      explicitly looks for the ML2 plug-in configuration file rather than the
      agent configuration file. Run the following commands to resolve this
      issue:

      .. code:: console

         # cp /etc/init/neutron-plugin-linuxbridge-agent.conf \
           /etc/init/neutron-plugin-linuxbridge-agent.conf.orig
         # sed -i 's,ml2_conf.ini,linuxbridge_agent.ini,g' \
           /etc/init/neutron-plugin-linuxbridge-agent.conf

   #. Populate the database:

      .. code:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the nova-api service:

      .. code:: console

         # service nova-api restart

   #. Restart the Networking services.

      For both networking options:

      .. code:: console

         # service neutron-server restart
         # service neutron-plugin-linuxbridge-agent restart
         # service neutron-dhcp-agent restart
         # service neutron-metadata-agent restart

      For networking option 2, also restart the layer-3 service:

      .. code:: console

         # service neutron-l3-agent restart
