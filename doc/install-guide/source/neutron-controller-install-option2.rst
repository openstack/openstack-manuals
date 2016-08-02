Networking Option 2: Self-service networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install and configure the Networking components on the *controller* node.

Install the components
----------------------

.. only:: ubuntu

   .. code-block:: console

      # apt-get install neutron-server neutron-plugin-ml2 \
        neutron-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent \
        neutron-metadata-agent

.. only:: rdo

   .. code-block:: console

      # yum install openstack-neutron openstack-neutron-ml2 \
        openstack-neutron-linuxbridge ebtables

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron \
        openstack-neutron-server openstack-neutron-linuxbridge-agent \
        openstack-neutron-l3-agent openstack-neutron-dhcp-agent \
        openstack-neutron-metadata-agent

.. only:: debian

   #. .. code-block:: console

         # apt-get install neutron-server neutron-linuxbridge-agent \
           neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent

Configure the server component
------------------------------

* Edit the ``/etc/neutron/neutron.conf`` file and complete the following
  actions:

  * In the ``[database]`` section, configure database access:

    .. code-block:: ini

       [database]
       ...
       connection = mysql+pymysql://neutron:NEUTRON_DBPASS@controller/neutron

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
       memcached_servers = controller:11211
       auth_type = password
       project_domain_name = default
       user_domain_name = default
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

       [nova]
       ...
       auth_url = http://controller:35357
       auth_type = password
       project_domain_name = default
       user_domain_name = default
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

  * In the ``[ml2]`` section, enable VXLAN self-service networks:

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

  * In the ``[ml2_type_flat]`` section, configure the provider virtual
    network as a flat network:

    .. code-block:: ini

       [ml2_type_flat]
       ...
       flat_networks = provider

  * In the ``[ml2_type_vxlan]`` section, configure the VXLAN network identifier
    range for self-service networks:

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
networking infrastructure for instances and handles security groups.

* Edit the ``/etc/neutron/plugins/ml2/linuxbridge_agent.ini`` file and
  complete the following actions:

  * In the ``[linux_bridge]`` section, map the provider virtual network to the
    provider physical network interface:

    .. code-block:: ini

       [linux_bridge]
       physical_interface_mappings = provider:PROVIDER_INTERFACE_NAME

    Replace ``PROVIDER_INTERFACE_NAME`` with the name of the underlying
    provider physical network interface. See :ref:`environment-networking`
    for more information.

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
    example architecture uses the management interface to tunnel traffic to
    the other nodes. Therefore, replace ``OVERLAY_INTERFACE_IP_ADDRESS`` with
    the management IP address of the controller node. See
    :ref:`environment-networking` for more information.

  * In the ``[securitygroup]`` section, enable security groups and
    configure the Linux bridge :term:`iptables` firewall driver:

    .. code-block:: ini

       [securitygroup]
       ...
       enable_security_group = True
       firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

Configure the layer-3 agent
---------------------------

The :term:`Layer-3 (L3) agent` provides routing and NAT services for
self-service virtual networks.

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

Configure the DHCP agent
------------------------

The :term:`DHCP agent` provides DHCP services for virtual networks.

* Edit the ``/etc/neutron/dhcp_agent.ini`` file and complete the following
  actions:

  * In the ``[DEFAULT]`` section, configure the Linux bridge interface driver,
    Dnsmasq DHCP driver, and enable isolated metadata so instances on provider
    networks can access metadata over the network:

    .. code-block:: ini

       [DEFAULT]
       ...
       interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
       dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
       enable_isolated_metadata = True

Return to
:ref:`Networking controller node configuration
<neutron-controller-metadata-agent>`.
