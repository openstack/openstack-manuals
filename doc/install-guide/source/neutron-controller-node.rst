=====================================
Install and configure controller node
=====================================

**To configure prerequisites**

Before you configure the OpenStack Networking (neutron) service, you
must create a database, service credentials, and API endpoint.

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

#. Create the Networking service API endpoint:

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

**To install the Networking components**

.. only:: ubuntu

   .. code:: console

      # apt-get install neutron-server neutron-plugin-ml2 python-neutronclient

.. only:: rdo

   .. code:: console

      # yum install openstack-neutron openstack-neutron-ml2 python-neutronclient which

.. only:: obs

   .. code:: console

      # zypper install openstack-neutron openstack-neutron-server

   .. note::

      SUSE does not use a separate ML2 plug-in package.

.. only:: debian

   **To install and configure the Networking components**

   #. .. code:: console

         # apt-get install neutron-server

      .. note::

         Debian does not use a separate ML2 plug-in package.

   #. Respond to prompts for `database
      management <#debconf-dbconfig-common>`__, `Identity service
      credentials <#debconf-keystone_authtoken>`__, `service endpoint
      registration <#debconf-api-endpoints>`__, and `message queue
      credentials <#debconf-rabbitmq>`__.

   #. Select the ML2 plug-in:

      .. image:: figures/debconf-screenshots/neutron_1_plugin_selection.png

      .. note::

         Selecting the ML2 plug-in also populates the ``service_plugins`` and
         ``allow_overlapping_ips`` options in the
         :file:`/etc/neutron/neutron.conf` file with the appropriate values.

.. only:: ubuntu or rdo or obs

   **To configure the Networking server component**

   The Networking server component configuration includes the database,
   authentication mechanism, message queue, topology change notifications,
   and plug-in.

   .. note::

      Default configuration files vary by distribution. You might need to
      add these sections and options rather than modifying existing
      sections and options. Also, an ellipsis (...) in the configuration
      snippets indicates potential default configuration options that you
      should retain.

   #. Open the :file:`/etc/neutron/neutron.conf` file and edit the
      ``[database]`` section to configure database access:

      .. code:: ini

         [database]
         ...
         connection = mysql://neutron:NEUTRON_DBPASS@controller/neutron

         Replace ``NEUTRON_DBPASS`` with the password you chose for the
         database.

   #. In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
      configure RabbitMQ message queue access:

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

   #. Replace ``RABBIT_PASS`` with the password you chose for the
      ``openstack`` account in RabbitMQ.

   #. In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections, configure
      Identity service access:

      .. code-block:: ini
         :linenos:

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
         username = neutron
         password = NEUTRON_PASS

   #. Replace NEUTRON\_PASS with the password you chose for the ``neutron``
      user in the Identity service.

      .. note::

         Comment out or remove any other options in the
         ``[keystone_authtoken]`` section.

   #. In the ``[DEFAULT]`` section, enable the Modular Layer 2 (ML2)
      plug-in, router service, and overlapping IP addresses:

      .. code:: ini

         [DEFAULT]
         ...
         core_plugin = ml2
         service_plugins = router
         allow_overlapping_ips = True

   #. In the ``[DEFAULT]`` and ``[nova]`` sections, configure Networking to
      notify Compute of network topology changes:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         notify_nova_on_port_status_changes = True
         notify_nova_on_port_data_changes = True
         nova_url = http://controller:8774/v2

         [nova]
         ...
         auth_url = http://controller:35357
         auth_plugin = password
         project_domain_id = default
         user_domain_id = default
         region_name = RegionOne
         project_name = service
         username = nova
         password = NOVA_PASS

   #. Replace ``NOVA_PASS`` with the password you chose for the ``nova``
      user in the Identity service.

   #. (Optional) To assist with troubleshooting, enable verbose logging in
      the ``[DEFAULT]`` section:

      .. code:: ini

         [DEFAULT]
         ...
         verbose = True

**To configure the Modular Layer 2 (ML2) plug-in**

The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent) to build
the virtual networking framework for instances. However, the controller
node does not need the OVS components because it does not handle
instance network traffic.

#. Open the :file:`/etc/neutron/plugins/ml2/ml2_conf.ini` file and edit the
   ``[ml2]`` section, to enable the flat, VLAN, generic routing
   encapsulation (GRE), and virtual extensible LAN (VXLAN) network type
   drivers, GRE tenant networks, and the OVS mechanism driver:

   .. code:: ini

      [ml2]
      ...
      type_drivers = flat,vlan,gre,vxlan
      tenant_network_types = gre
      mechanism_drivers = openvswitch

   .. warning::

      After you configure the ML2 plug-in, changing values in the
      ``type_drivers`` option can lead to database inconsistency.

#. In the ``[ml2_type_gre]`` section, configure the tunnel identifier (id)
   range:

   .. code:: ini

      [ml2_type_gre]
      ...
      tunnel_id_ranges = 1:1000

#. In the ``[securitygroup]`` section, enable security groups, enable
   ipset, and configure the OVS iptables firewall driver:

   .. code:: ini

      [securitygroup]
      ...
      enable_security_group = True
      enable_ipset = True
      firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver

**To configure Compute to use Networking**

By default, distribution packages configure Compute to use legacy
networking. You must reconfigure Compute to manage networks through
Networking.

#. Open the :file:`/etc/nova/nova.conf` file on the controller node and edit
   the ``[DEFAULT]`` section to configure the APIs and drivers:

   .. code:: ini

      [DEFAULT]
      ...
      network_api_class = nova.network.neutronv2.api.API
      security_group_api = neutron
      linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver
      firewall_driver = nova.virt.firewall.NoopFirewallDriver

   .. note::

      By default, Compute uses an internal firewall service. Since
      Networking includes a firewall service, you must disable the Compute
      firewall service by using the
      ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

#. In the ``[neutron]`` section, configure access parameters:

   .. code-block:: ini
      :linenos:

      [neutron]
      ...
      url = http://controller:9696
      auth_strategy = keystone
      admin_auth_url = http://controller:35357/v2.0
      admin_tenant_name = service
      admin_username = neutron
      admin_password = NEUTRON_PASS

   Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
   user in the Identity service.

**To finalize installation**

.. only:: rdo

   #. The Networking service initialization scripts expect a symbolic link
      :file:`/etc/neutron/plugin.ini` pointing to the ML2 plug-in configuration
      file, :file:`/etc/neutron/plugins/ml2/ml2_conf.ini`. If this symbolic
      link does not exist, create it using the following command:

      .. code:: console

         # ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

   #. Populate the database:

      .. code:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade kilo" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the Compute services:

      .. code:: console

         # systemctl restart openstack-nova-api.service openstack-nova-scheduler.service \
           openstack-nova-conductor.service


   #. Start the Networking service and configure it to start when the system
      boots:

      .. code:: console

         # systemctl enable neutron-server.service
         # systemctl start neutron-server.service

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

   #. Start the Networking service and configure it to start when the system
      boots:

      .. code:: console

         # systemctl enable openstack-neutron.service
         # systemctl start openstack-neutron.service

.. only:: ubuntu

   #. Populate the database:

      .. code:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade kilo" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the nova-api service:

      .. code:: console

         # service nova-api restart

   #. Restart the Networking service:

      .. code:: console

         # service neutron-server restart

**Verify operation**

Perform the following commands on the controller node.

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code:: console

      $ source admin-openrc.sh

#. List loaded extensions to verify successful launch of the
   ``neutron-server`` process:

   .. code:: console

      $ neutron ext-list
      +-----------------------+-----------------------------------------------+
      | alias                 | name                                          |
      +-----------------------+-----------------------------------------------+
      | security-group        | security-group                                |
      | l3_agent_scheduler    | L3 Agent Scheduler                            |
      | ext-gw-mode           | Neutron L3 Configurable external gateway mode |
      | binding               | Port Binding                                  |
      | provider              | Provider Network                              |
      | agent                 | agent                                         |
      | quotas                | Quota management support                      |
      | dhcp_agent_scheduler  | DHCP Agent Scheduler                          |
      | l3-ha                 | HA Router extension                           |
      | multi-provider        | Multi Provider Network                        |
      | external-net          | Neutron external network                      |
      | router                | Neutron L3 Router                             |
      | allowed-address-pairs | Allowed Address Pairs                         |
      | extraroute            | Neutron Extra Route                           |
      | extra_dhcp_opt        | Neutron Extra DHCP opts                       |
      | dvr                   | Distributed Virtual Router                    |
      +-----------------------+-----------------------------------------------+
