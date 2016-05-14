Networking Option 1: Provider networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install and configure the Networking components on the *controller* node.

Install the components
----------------------

.. code-block:: console

   # apt-get install neutron-server neutron-linuxbridge-agent \
     neutron-dhcp-agent neutron-metadata-agent python-neutronclient

Respond to prompts for `database
management <#debconf-dbconfig-common>`__, `Identity service
credentials <#debconf-keystone_authtoken>`__, `service endpoint
registration <#debconf-api-endpoints>`__, and `message queue
credentials <#debconf-rabbitmq>`__.

Select the ML2 plug-in:

.. image:: figures/debconf-screenshots/neutron_1_plugin_selection.png

.. note::

   Selecting the ML2 plug-in also populates the ``core_plugin`` option
   in the ``/etc/neutron/neutron.conf`` file with the appropriate values
   (in this case, it is set to the value ``ml2``).

Configure the server component
------------------------------

#. Edit the ``/etc/neutron/neutron.conf`` file and complete the following
   actions:

   * In the ``[DEFAULT]`` section, disable additional plug-ins:

     .. code-block:: ini

        [DEFAULT]
        ...
        service_plugins =

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
