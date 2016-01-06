Networking Option 2: Self-service networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install and configure the Networking components on the *controller* node.

Install the components
----------------------

.. only:: ubuntu

   .. code-block:: console

      # apt-get install neutron-server neutron-plugin-ml2 \
        neutron-plugin-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent \
        neutron-metadata-agent python-neutronclient conntrack

.. only:: rdo

   .. code-block:: console

      # yum install openstack-neutron openstack-neutron-ml2 \
        openstack-neutron-linuxbridge python-neutronclient ebtables ipset

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron \
        openstack-neutron-server openstack-neutron-linuxbridge-agent \
        openstack-neutron-l3-agent openstack-neutron-dhcp-agent \
        openstack-neutron-metadata-agent ipset

.. only:: debian

   Install and configure the Networking components
   -----------------------------------------------

   #. .. code-block:: console

         # apt-get install neutron-server neutron-plugin-linuxbridge-agent \
           neutron-dhcp-agent neutron-metadata-agent

      For networking option 2, also install the ``neutron-l3-agent`` package.

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
         ``/etc/neutron/neutron.conf`` file with the appropriate values.

.. only:: ubuntu or rdo or obs

   Configure the server component
   ------------------------------

   * Edit the ``/etc/neutron/neutron.conf`` file and complete the following
     actions:

     * In the ``[database]`` section, configure database access:

       .. only:: ubuntu or obs

          .. code-block:: ini

             [database]
             ...
             connection = mysql+pymysql://neutron:NEUTRON_DBPASS@controller/neutron

       .. only:: rdo

          .. code-block:: ini

             [database]
             ...
             connection = mysql://neutron:NEUTRON_DBPASS@controller/neutron

       Replace ``NEUTRON_DBPASS`` with the password you chose for the
       database.

     * In the ``[DEFAULT]`` section, enable the Modular Layer 2 (ML2)
       plug-in, router service, and overlapping IP addresses:

       .. code-block:: ini

          [DEFAULT]
          ...
          core_plugin = ml2
          service_plugins = router
          allow_overlapping_ips = True

     * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
       configure RabbitMQ message queue access:

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
       ``openstack`` account in RabbitMQ.

     * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections, configure
       Identity service access:

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
          username = neutron
          password = NEUTRON_PASS

       Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
       user in the Identity service.

       .. note::

          Comment out or remove any other options in the
          ``[keystone_authtoken]`` section.

     * In the ``[DEFAULT]`` and ``[nova]`` sections, configure Networking to
       notify Compute of network topology changes:

       .. code-block:: ini

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

       Replace ``NOVA_PASS`` with the password you chose for the ``nova``
       user in the Identity service.

     .. only:: rdo

        * In the ``[oslo_concurrency]`` section, configure the lock path:

          .. code-block:: ini

             [oslo_concurrency]
             ...
             lock_path = /var/lib/neutron/tmp

     * (Optional) To assist with troubleshooting, enable verbose logging in
       the ``[DEFAULT]`` section:

       .. code-block:: ini

          [DEFAULT]
          ...
          verbose = True

Configure the Modular Layer 2 (ML2) plug-in
-------------------------------------------

The ML2 plug-in uses the Linux bridge mechanism to build layer-2 (bridging
and switching) virtual networking infrastructure for instances.

* Edit the ``/etc/neutron/plugins/ml2/ml2_conf.ini`` file and complete the
  following actions:

  * In the ``[ml2]`` section, enable flat, VLAN, and VXLAN networks:

    .. code-block:: ini

       [ml2]
       ...
       type_drivers = flat,vlan,vxlan

  * In the ``[ml2]`` section, enable VXLAN project (private) networks:

    .. code-block:: ini

       [ml2]
       ...
       tenant_network_types = vxlan

  * In the ``[ml2]`` section, enable the Linux bridge and layer-2 population
    mechanisms:

    .. code-block:: ini

       [ml2]
       ...
       mechanism_drivers = linuxbridge,l2population

    .. warning::

       After you configure the ML2 plug-in, removing values in the
       ``type_drivers`` option can lead to database inconsistency.

    .. note::

       The Linux bridge agent only supports VXLAN overlay networks.

  * In the ``[ml2]`` section, enable the port security extension driver:

    .. code-block:: ini

       [ml2]
       ...
       extension_drivers = port_security

  * In the ``[ml2_type_flat]`` section, configure the public flat provider
    network:

    .. code-block:: ini

       [ml2_type_flat]
       ...
       flat_networks = public

  * In the ``[ml2_type_vxlan]`` section, configure the VXLAN network identifier
    range for private networks:

    .. code-block:: ini

       [ml2_type_vxlan]
       ...
       vni_ranges = 1:1000

  * In the ``[securitygroup]`` section, enable :term:`ipset` to increase
    efficiency of security group rules:

    .. code-block:: ini

       [securitygroup]
       ...
       enable_ipset = True

Configure the Linux bridge agent
--------------------------------

The Linux bridge agent builds layer-2 (bridging and switching) virtual
networking infrastructure for instances including VXLAN tunnels for private
networks and handles security groups.

* Edit the ``/etc/neutron/plugins/ml2/linuxbridge_agent.ini`` file and
  complete the following actions:

  * In the ``[linux_bridge]`` section, map the public virtual network to the
    public physical network interface:

    .. code-block:: ini

       [linux_bridge]
       physical_interface_mappings = public:PUBLIC_INTERFACE_NAME

    Replace ``PUBLIC_INTERFACE_NAME`` with the name of the underlying physical
    public network interface.

  * In the ``[vxlan]`` section, enable VXLAN overlay networks, configure the
    IP address of the physical network interface that handles overlay
    networks, and enable layer-2 population:

    .. code-block:: ini

       [vxlan]
       enable_vxlan = True
       local_ip = OVERLAY_INTERFACE_IP_ADDRESS
       l2_population = True

    Replace ``OVERLAY_INTERFACE_IP_ADDRESS`` with the IP address of the
    underlying physical network interface that handles overlay networks. The
    example architecture uses the management interface.

  * In the ``[agent]`` section, enable ARP spoofing protection:

    .. code-block:: ini

       [agent]
       ...
       prevent_arp_spoofing = True

  * In the ``[securitygroup]`` section, enable security groups and
    configure the Linux bridge :term:`iptables` firewall driver:

    .. code-block:: ini

       [securitygroup]
       ...
       enable_security_group = True
       firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

Configure the layer-3 agent
---------------------------

The :term:`Layer-3 (L3) agent` provides routing and NAT services for virtual
networks.

* Edit the ``/etc/neutron/l3_agent.ini`` file and complete the following
  actions:

  * In the ``[DEFAULT]`` section, configure the Linux bridge interface driver
    and external network bridge:

    .. code-block:: ini

       [DEFAULT]
       ...
       interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
       external_network_bridge =

    .. note::

       The ``external_network_bridge`` option intentionally lacks a value
       to enable multiple external networks on a single agent.

  * (Optional) To assist with troubleshooting, enable verbose logging in the
    ``[DEFAULT]`` section:

    .. code-block:: ini

       [DEFAULT]
       ...
       verbose = True

Configure the DHCP agent
------------------------

The :term:`DHCP agent` provides DHCP services for virtual networks.

* Edit the ``/etc/neutron/dhcp_agent.ini`` file and complete the following
  actions:

  * In the ``[DEFAULT]`` section, configure the Linux bridge interface driver,
    Dnsmasq DHCP driver, and enable isolated metadata so instances on public
    networks can access metadata over the network:

    .. code-block:: ini

       [DEFAULT]
       ...
       interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
       dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
       enable_isolated_metadata = True

  * (Optional) To assist with troubleshooting, enable verbose logging in the
    ``[DEFAULT]`` section:

    .. code-block:: ini

       [DEFAULT]
       ...
       verbose = True

  Overlay networks such as VXLAN include additional packet headers that
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
  negates the impact of VXLAN overhead on virtual networks. However, many
  network devices lack support for jumbo frames and OpenStack administrators
  often lack control over network infrastructure. Given the latter
  complications, you can also prevent MTU problems by reducing the
  instance MTU to account for VXLAN overhead. Determining the proper MTU
  value often takes experimentation, but 1450 bytes works in most
  environments. You can configure the DHCP server that assigns IP
  addresses to your instances to also adjust the MTU.

  .. note::

     Some cloud images ignore the DHCP MTU option in which case you
     should configure it using metadata, a script, or other suitable
     method.

  * In the ``[DEFAULT]`` section, enable the :term:`dnsmasq` configuration
    file:

    .. code-block:: ini

       [DEFAULT]
       ...
       dnsmasq_config_file = /etc/neutron/dnsmasq-neutron.conf

  * Create and edit the ``/etc/neutron/dnsmasq-neutron.conf`` file to
    enable the DHCP MTU option (26) and configure it to 1450 bytes:

    .. code-block:: ini

       dhcp-option-force=26,1450

Return to
:ref:`Networking controller node configuration
<neutron-controller-metadata-agent>`.
