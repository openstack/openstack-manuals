==================================
Install and configure compute node
==================================

The compute node handles connectivity and :term:`security groups <security
group>` for instances.

**To configure prerequisites**

Before you install and configure OpenStack Networking, you must
configure certain kernel networking parameters.

#. Edit the :file:`/etc/sysctl.conf` file to contain the following parameters:

   .. code-block:: ini

      net.ipv4.conf.all.rp_filter=0
      net.ipv4.conf.default.rp_filter=0
      net.bridge.bridge-nf-call-iptables=1
      net.bridge.bridge-nf-call-ip6tables=1

#. Implement the changes:

   .. code-block:: ini

      # sysctl -p

.. only:: ubuntu or rdo or obs

   **To install the Networking components**

.. only:: ubuntu

   .. code-block:: console

      # apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent

.. only:: rdo

   .. code-block:: console

      # yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron-openvswitch-agent ipset

   .. note:: SUSE does not use a separate ML2 plug-in package.

.. only:: debian

   **To install and configure the Networking components**

   #. .. code-block:: console

         # apt-get install neutron-plugin-openvswitch-agent openvswitch-datapath-dkms

      .. note::

         Debian does not use a separate ML2 plug-in package.

   #. Respond to prompts for ``database management``, ``Identity service
      credentials``, ``service endpoint``, and ``message queue credentials``.

   #. Select the ML2 plug-in:

      .. image:: figures/debconf-screenshots/neutron_1_plugin_selection.png
         :alt: Neutron plug-in selection dialog

      .. note::

         Selecting the ML2 plug-in also populates the ``service_plugins`` and
         ``allow_overlapping_ips`` options in the
         :file:`/etc/neutron/neutron.conf` file with the appropriate values.

.. only:: ubuntu or rdo or obs

   **To configure the Networking common components**

   The Networking common component configuration includes the
   authentication mechanism, message queue, and plug-in.

   .. note::

      Default configuration files vary by distribution. You might need to
      add these sections and options rather than modifying existing
      sections and options. Also, an ellipsis (...) in the configuration
      snippets indicates potential default configuration options that you
      should retain.

   #. Open the :file:`/etc/neutron/neutron.conf` file and edit the
      ``[database]`` section. Comment out any ``connection`` options because
      compute nodes do not directly access the database.

   #. In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections, configure
      RabbitMQ message queue access:

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

      Replace ``RABBIT_PASS`` with the password you chose for the ``openstack``
      account in RabbitMQ.

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

      Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
      user in the Identity service.

      .. note::

         Comment out or remove any other options in the
         ``[keystone_authtoken]`` section.

   #. In the ``[DEFAULT]`` section, enable the Modular Layer 2 (ML2) plug-in,
      router service, and overlapping IP addresses:

      .. code-block:: ini

         [DEFAULT]
         ...
         core_plugin = ml2
         service_plugins = router
         allow_overlapping_ips = True

   #. (Optional) To assist with troubleshooting, enable verbose logging in the
      ``[DEFAULT]`` section:

      .. code-block:: ini

         [DEFAULT]
         ...
         verbose = True

**To configure the Modular Layer 2 (ML2) plug-in**

The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent) to build
the virtual networking framework for instances.

#. Open the :file:`/etc/neutron/plugins/ml2/ml2_conf.ini` file and edit the
   ``[ml2]`` section. Enable the :term:`flat <flat network>`, :term:`VLAN
   <VLAN network>`, :term:`generic routing encapsulation (GRE)`, and
   :term:`virtual extensible LAN (VXLAN)` network type
   drivers, GRE tenant networks, and the OVS mechanism driver:

   .. code-block:: ini

      [ml2]
      ...
      type_drivers = flat,vlan,gre,vxlan
      tenant_network_types = gre
      mechanism_drivers = openvswitch

#. In the ``[ml2_type_gre]`` section, configure the tunnel identifier (id)
   range:

   .. code-block:: ini

      [ml2_type_gre]
      ...
      tunnel_id_ranges = 1:1000

#. In the ``[securitygroup]`` section, enable security groups, enable
   :term:`ipset`, and configure the OVS :term:`iptables` firewall driver:

   .. code-block:: ini

      [securitygroup]
      ...
      enable_security_group = True
      enable_ipset = True
      firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver

#. In the ``[ovs]`` section, enable tunnels and configure the local tunnel
   endpoint:

   .. code-block:: ini

      [ovs]
      ...
      local_ip = INSTANCE_TUNNELS_INTERFACE_IP_ADDRESS

   Replace ``INSTANCE_TUNNELS_INTERFACE_IP_ADDRESS`` with the IP address of
   the instance tunnels network interface on your compute node.

#. In the ``[agent]`` section, enable GRE tunnels:

   .. code-block:: ini

      [agent]
      ...
      tunnel_types = gre

**To configure the Open vSwitch (OVS) service**

The OVS service provides the underlying virtual networking framework for
instances.

.. only:: rdo or obs

   Start the OVS service and configure it to start when the system boots:

   .. code-block:: console

      # systemctl enable openvswitch.service
      # systemctl start openvswitch.service

.. only:: ubuntu or debian

   Restart the OVS service:

   .. code-block:: console

      # service openvswitch-switch restart

**To configure Compute to use Networking**

By default, distribution packages configure Compute to use legacy
networking. You must reconfigure Compute to manage networks through
Networking.

#. Open the :file:`/etc/nova/nova.conf` file and edit the ``[DEFAULT]``
   section. Configure the :term:`APIs <API>` and drivers:

   .. code-block:: ini

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

**To finalize the installation**

.. only:: rdo

   #. The Networking service initialization scripts expect a symbolic link
      :file:`/etc/neutron/plugin.ini` pointing to the ML2 plug-in configuration
      file, :file:`/etc/neutron/plugins/ml2/ml2_conf.ini`. If this symbolic
      link does not exist, create it using the following command:

      .. code-block:: console

         # ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

   #. Due to a packaging bug, the Open vSwitch agent initialization script
      explicitly looks for the Open vSwitch plug-in configuration file rather
      than a symbolic link :file:`/etc/neutron/plugin.ini` pointing to the ML2
      plug-in configuration file. Run the following commands to resolve this
      issue:

      .. code-block:: console

         # cp /usr/lib/systemd/system/neutron-openvswitch-agent.service \
           /usr/lib/systemd/system/neutron-openvswitch-agent.service.orig
         # sed -i 's,plugins/openvswitch/ovs_neutron_plugin.ini,plugin.ini,g' \
           /usr/lib/systemd/system/neutron-openvswitch-agent.service

   #. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

   #. Start the Open vSwitch (OVS) agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable neutron-openvswitch-agent.service
         # systemctl start neutron-openvswitch-agent.service

.. only:: obs

   #. The Networking service initialization scripts expect the variable
      ``NEUTRON_PLUGIN_CONF`` in the :file:`/etc/sysconfig/neutron` file to
      reference the ML2 plug-in configuration file. Edit the
      :file:`/etc/sysconfig/neutron` file and add the following:

      .. code-block:: ini

         NEUTRON_PLUGIN_CONF="/etc/neutron/plugins/ml2/ml2_conf.ini"

   #. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

   #. Start the Open vSwitch (OVS) agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-neutron-openvswitch-agent.service
         # systemctl start openstack-neutron-openvswitch-agent.service

.. only:: ubuntu or debian

   #. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart

   #. Restart the Open vSwitch (OVS) agent:

      .. code-block:: console

         # service neutron-plugin-openvswitch-agent restart

**Verify operation**

Perform the following commands on the controller node:

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. List agents to verify successful launch of the neutron agents:

   .. code-block:: console

      $ neutron agent-list
      +------+--------------------+----------+-------+----------------+---------------------------+
      | id   | agent_type         | host     | alive | admin_state_up | binary                    |
      +------+--------------------+----------+-------+----------------+---------------------------+
      |302...| Metadata agent     | network  | :-)   | True           | neutron-metadata-agent    |
      |4bd...| Open vSwitch agent | network  | :-)   | True           | neutron-openvswitch-agent |
      |756...| L3 agent           | network  | :-)   | True           | neutron-l3-agent          |
      |9c4...| DHCP agent         | network  | :-)   | True           | neutron-dhcp-agent        |
      |a5a...| Open vSwitch agent | compute1 | :-)   | True           | neutron-openvswitch-agent |
      +------+--------------------+----------+-------+----------------+---------------------------+

   This output should indicate four agents alive on the network node
   and one agent alive on the compute node.
