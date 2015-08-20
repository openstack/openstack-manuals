==================================
Install and configure network node
==================================

The network node primarily handles internal and external routing and
:term:`DHCP` services for virtual networks.

**To configure prerequisites**

Before you install and configure OpenStack Networking, you must
configure certain kernel networking parameters.

#. Edit the :file:`/etc/sysctl.conf` file to contain the following parameters:

   .. code-block:: ini

      net.ipv4.ip_forward=1
      net.ipv4.conf.all.rp_filter=0
      net.ipv4.conf.default.rp_filter=0

#. Implement the changes:

   .. code-block:: console

      # sysctl -p

.. only:: rdo or ubuntu or obs

   **To install the Networking components**

.. only:: ubuntu

   .. code-block:: console

      # apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent \
        neutron-l3-agent neutron-dhcp-agent neutron-metadata-agent

.. only:: rdo

   .. code-block:: console

      # yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron-openvswitch-agent \
        openstack-neutron-l3-agent \
        openstack-neutron-dhcp-agent openstack-neutron-metadata-agent ipset

   .. note:: SUSE does not use a separate ML2 plug-in package.

.. only:: debian

   **To install and configure the Networking components**

   #. .. code-block:: console

         # apt-get install neutron-plugin-openvswitch-agent openvswitch-datapath-dkms \
           neutron-l3-agent neutron-dhcp-agent neutron-metadata-agent

      .. note:: Debian does not use a separate ML2 plug-in package.

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

.. only:: rdo or ubuntu or obs

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
      ``[database]`` section. Comment out any ``connection`` options
      because network nodes do not directly access the database.

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

      Replace ``NEUTRON_PASS`` with the password you chose or the ``neutron``
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

The ML2 plug-in uses the :term:`Open vSwitch (OVS) <Open vSwitch>` mechanism
(agent) to build the virtual networking framework for instances.

#. Open the :file:`/etc/neutron/plugins/ml2/ml2_conf.ini` file and edit the
   ``[ml2]`` section. Enable the :term:`flat <flat network>`, :term:`VLAN <VLAN
   network>`, :term:`generic routing encapsulation (GRE)`, and
   :term:`virtual extensible LAN (VXLAN)` network type drivers, GRE tenant
   networks, and the OVS mechanism driver:

   .. code-block:: ini

      [ml2]
      ...
      type_drivers = flat,vlan,gre,vxlan
      tenant_network_types = gre
      mechanism_drivers = openvswitch

#. In the ``[ml2_type_flat]`` section, configure the external flat provider
   network:

   .. code-block:: ini

      [ml2_type_flat]
      ...
      flat_networks = external

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

#. In the ``[ovs]`` section, enable tunnels, configure the local tunnel
   endpoint, and map the external flat provider network to the ``br-ex``
   external network bridge:

   .. code-block:: ini

      [ovs]
      ...
      local_ip = INSTANCE_TUNNELS_INTERFACE_IP_ADDRESS
      bridge_mappings = external:br-ex

   Replace ``INSTANCE_TUNNELS_INTERFACE_IP_ADDRESS`` with the IP address of
   the instance tunnels network interface on your network node.

#. In the ``[agent]`` section, enable GRE tunnels:

   .. code-block:: ini

      [agent]
      ...
      tunnel_types = gre

**To configure the Layer-3 (L3) agent**

The :term:`Layer-3 (L3) agent` provides routing services for virtual networks.

#. Open the :file:`/etc/neutron/l3_agent.ini` file edit the ``[DEFAULT]``
   section. Configure the interface driver, external
   network bridge, and enable deletion of defunct router namespaces:

   .. code-block:: ini

      [DEFAULT]
      ...
      interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
      external_network_bridge =
      router_delete_namespaces = True

   .. note:

      The ``external_network_bridge`` option intentionally lacks a value
      to enable multiple external networks on a single agent.

#. (Optional) To assist with troubleshooting, enable verbose logging in the
   ``[DEFAULT]`` section:

   .. code-block:: ini

      [DEFAULT]
      ...
      verbose = True

**To configure the DHCP agent**

The :term:`DHCP agent` provides DHCP services for virtual networks.

#. Open the :file:`/etc/neutron/dhcp_agent.ini` file and edit the ``[DEFAULT]``
   section, configure the interface and DHCP drivers and enable deletion of
   defunct DHCP namespaces:

   .. code-block:: ini

      [DEFAULT]
      ...
      interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
      dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
      dhcp_delete_namespaces = True

#. (Optional) To assist with troubleshooting, enable verbose logging in the
   ``[DEFAULT]`` section:

   .. code-block:: ini

      [DEFAULT]
      ...
      verbose = True

#. (Optional)
   Tunneling protocols such as GRE include additional packet headers that
   increase overhead and decrease space available for the payload or user
   data. Without knowledge of the virtual network infrastructure, instances
   attempt to send packets using the default Ethernet :term:`maximum
   transmission unit (MTU)` of 1500 bytes. :term:`Internet protocol (IP)`
   networks contain the :term:`path MTU discovery (PMTUD)` mechanism to detect
   end-to-end MTU and adjust packet size accordingly. However, some operating
   systems and networks block or otherwise lack support for PMTUD causing
   performance degradation or connectivity failure.

   Ideally, you can prevent these problems by enabling :term:`jumbo frames
   <jumbo frame>` on the physical network that contains your tenant virtual
   networks. Jumbo frames support MTUs up to approximately 9000 bytes which
   negates the impact of GRE overhead on virtual networks. However, many
   network devices lack support for jumbo frames and OpenStack administrators
   often lack control over network infrastructure. Given the latter
   complications, you can also prevent MTU problems by reducing the
   instance MTU to account for GRE overhead. Determining the proper MTU
   value often takes experimentation, but 1454 bytes works in most
   environments. You can configure the DHCP server that assigns IP
   addresses to your instances to also adjust the MTU.

   .. note::

      Some cloud images ignore the DHCP MTU option in which case you
      should configure it using metadata, a script, or another suitable
      method.

   #. Open the :file:`/etc/neutron/dhcp_agent.ini` file and edit the
      ``[DEFAULT]`` section. Enable the :term:`dnsmasq` configuration file:

      .. code-block:: ini

         [DEFAULT]
         ...
         dnsmasq_config_file = /etc/neutron/dnsmasq-neutron.conf

   #. Create and edit the :file:`/etc/neutron/dnsmasq-neutron.conf` file to
      enable the DHCP MTU option (26) and configure it to 1454 bytes:

      .. code-block:: ini

         dhcp-option-force=26,1454

   #. Kill any existing dnsmasq processes:

      .. code-block:: console

         # pkill dnsmasq

**To configure the metadata agent**

The :term:`metadata agent <Metadata agent>` provides configuration information
such as credentials to instances.

#. Open the :file:`/etc/neutron/metadata_agent.ini` file and edit the
   ``[DEFAULT]`` section, configure access parameters:

   .. code-block:: ini
      :linenos:

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

#. Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
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

#. On the *controller* node, open the :file:`/etc/nova/nova.conf` file and
   edit the ``[neutron]`` section to enable the metadata proxy and configure
   the secret:

   .. code-block:: ini

      [neutron]
      ...
      service_metadata_proxy = True
      metadata_proxy_shared_secret = METADATA_SECRET

   Replace ``METADATA_SECRET`` with the secret you chose for the metadata
   proxy.

#. On the *controller* node, restart the Compute :term:`API` service:

   .. only:: rdo or obs

      .. code-block:: console

         # systemctl restart openstack-nova-api.service

   .. only:: ubuntu or debian

      .. code-block:: console

         # service nova-api restart

**To configure the Open vSwitch (OVS) service**

The OVS service provides the underlying virtual networking framework for
instances. The integration bridge ``br-int`` handles internal instance
network traffic within OVS. The external bridge ``br-ex`` handles
external instance network traffic within OVS. The external bridge
requires a port on the physical external network interface to provide
instances with external network access. In essence, this port connects
the virtual and physical external networks in your environment.

.. only:: rdo or obs

   #. Start the OVS service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable openvswitch.service
         # systemctl start openvswitch.service

.. only:: ubuntu or debian

   #. Restart the OVS service:

      .. code-block:: console

         # service openvswitch-switch restart

2. Add the external bridge:

   .. code-block:: console

    # ovs-vsctl add-br br-ex

#. Add a port to the external bridge that connects to the physical external
   network interface. Replace ``INTERFACE_NAME`` with the actual interface
   name. For example, *eth2* or *ens256*:

   .. code-block:: console

      # ovs-vsctl add-port br-ex INTERFACE_NAME

   .. note::

      Depending on your network interface driver, you may need to disable
      :term:`generic receive offload (GRO)` to achieve suitable throughput
      between your instances and the external network.

      To temporarily disable GRO on the external network interface while
      testing your environment:

      .. code-block:: console

         # ethtool -K INTERFACE_NAME gro off

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

   #. Start the Networking services and configure them to start when the
      system boots:

      .. code-block:: console

         # systemctl enable neutron-openvswitch-agent.service neutron-l3-agent.service \
           neutron-dhcp-agent.service neutron-metadata-agent.service \
           neutron-ovs-cleanup.service
         # systemctl start neutron-openvswitch-agent.service neutron-l3-agent.service \
           neutron-dhcp-agent.service neutron-metadata-agent.service

      .. note:: Do not explicitly start the neutron-ovs-cleanup service.

.. only:: obs

   #. The Networking service initialization scripts expect the variable
      ``NEUTRON_PLUGIN_CONF`` in the :file:`/etc/sysconfig/neutron` file to
      reference the ML2 plug-in configuration file. Edit the
      :file:`/etc/sysconfig/neutron` file and add the following:

      .. code-block:: ini

         NEUTRON_PLUGIN_CONF="/etc/neutron/plugins/ml2/ml2_conf.ini"

   #. Start the Networking services and configure them to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-neutron-openvswitch-agent.service
           openstack-neutron-l3-agent.service \
           openstack-neutron-dhcp-agent.service openstack-neutron-metadata-agent.service \
           openstack-neutron-ovs-cleanup.service
         # systemctl start openstack-neutron-openvswitch-agent.service
           openstack-neutron-l3-agent.service \
           openstack-neutron-dhcp-agent.service openstack-neutron-metadata-agent.service

      .. note:: Do not explicitly start the neutron-ovs-cleanup service.

.. only:: ubuntu or debian

   #. Restart the Networking services:

      .. code-block:: console

         # service neutron-plugin-openvswitch-agent restart
         # service neutron-l3-agent restart
         # service neutron-dhcp-agent restart
         # service neutron-metadata-agent restart

      .. note:: Perform these commands on the controller node.

**Verify operation**

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. List agents to verify successful launch of the neutron agents:

   .. code-block:: console

      $ neutron agent-list
      +-------+--------------------+---------+-------+----------------+---------------------------+
      | id    | agent_type         | host    | alive | admin_state_up | binary                    |
      +-------+--------------------+---------+-------+----------------+---------------------------+
      | 302...| Metadata agent     | network | :-)   | True           | neutron-metadata-agent    |
      | 4bd...| Open vSwitch agent | network | :-)   | True           | neutron-openvswitch-agent |
      | 756...| L3 agent           | network | :-)   | True           | neutron-l3-agent          |
      | 9c4...| DHCP agent         | network | :-)   | True           | neutron-dhcp-agent        |
      +-------+--------------------+---------+-------+----------------+---------------------------+
