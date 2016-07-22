Networking Option 1: Provider networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install and configure the Networking components on the *controller* node.

Install the components
----------------------

.. only:: ubuntu

   .. code-block:: console

      # apt-get install neutron-server neutron-plugin-ml2 \
        neutron-linuxbridge-agent neutron-dhcp-agent \
        neutron-metadata-agent

.. only:: debian

   .. code-block:: console

      # apt-get install neutron-server neutron-linuxbridge-agent \
        neutron-dhcp-agent neutron-metadata-agent python-neutronclient

.. only:: rdo

   .. code-block:: console

      # yum install openstack-neutron openstack-neutron-ml2 \
        openstack-neutron-linuxbridge ebtables

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron \
        openstack-neutron-server openstack-neutron-linuxbridge-agent \
        openstack-neutron-dhcp-agent openstack-neutron-metadata-agent

Configure the server component
------------------------------

The Networking server component configuration includes the database,
authentication mechanism, message queue, topology change notifications,
and plug-in.

.. include:: shared/note_configuration_vary_by_distribution.rst

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
    plug-in and disable additional plug-ins:

    .. code-block:: ini

       [DEFAULT]
       ...
       core_plugin = ml2
       service_plugins =

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

  * In the ``[ml2]`` section, enable flat and VLAN networks:

    .. code-block:: ini

       [ml2]
       ...
       type_drivers = flat,vlan

  * In the ``[ml2]`` section, disable self-service networks:

    .. code-block:: ini

       [ml2]
       ...
       tenant_network_types =

  * In the ``[ml2]`` section, enable the Linux bridge mechanism:

    .. code-block:: ini

       [ml2]
       ...
       mechanism_drivers = linuxbridge

    .. warning::

       After you configure the ML2 plug-in, removing values in the
       ``type_drivers`` option can lead to database inconsistency.

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

  * In the ``[vxlan]`` section, disable VXLAN overlay networks:

    .. code-block:: ini

       [vxlan]
       enable_vxlan = False

  * In the ``[securitygroup]`` section, enable security groups and
    configure the Linux bridge :term:`iptables` firewall driver:

    .. code-block:: ini

       [securitygroup]
       ...
       enable_security_group = True
       firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

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
