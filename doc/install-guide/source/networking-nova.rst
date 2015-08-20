================================
Legacy networking (nova-network)
================================

Configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~
Legacy networking primarily involves compute nodes. However, you must
configure the controller node to use legacy networking.

**To configure legacy networking**

#. Open the :file:`/etc/nova/nova.conf` file and edit the ``[DEFAULT]``
   section. Configure the network and security group APIs:

   .. code-block:: ini

      [DEFAULT]
      ...
      network_api_class = nova.network.api.API
      security_group_api = nova

#. Restart the Compute services:

   .. only:: rdo or obs

      .. code-block:: console

         # systemctl restart openstack-nova-api.service \
           openstack-nova-scheduler.service openstack-nova-conductor.service

   .. only:: ubuntu or debian

      .. code-block:: console

         # service nova-api restart
         # service nova-scheduler restart
         # service nova-conductor restart

Configure compute node
~~~~~~~~~~~~~~~~~~~~~~
This section covers deployment of a simple :term:`flat network` that provides
IP addresses to your instances via :term:`DHCP`. If your environment includes
multiple compute nodes, the :term:`multi-host` feature provides redundancy by
spreading network functions across compute nodes.

**To install legacy networking components**

.. only:: ubuntu

   .. code-block:: console

      # apt-get install nova-network nova-api-metadata

.. only:: debian

   .. code-block:: console

      # apt-get install nova-network nova-api

.. only:: rdo

   .. code-block:: console

      # yum install openstack-nova-network openstack-nova-api

.. only:: obs

   .. code-block:: console

      # zypper install openstack-nova-network openstack-nova-api

**To configure legacy networking**

#. Open the :file:`/etc/nova/nova.conf` file and edit the ``[DEFAULT]``
   section. Configure the network parameters:

   .. code-block:: ini
      :linenos:

      [DEFAULT]
      ...
      network_api_class = nova.network.api.API
      security_group_api = nova
      firewall_driver = nova.virt.libvirt.firewall.IptablesFirewallDriver
      network_manager = nova.network.manager.FlatDHCPManager
      network_size = 254
      allow_same_net_traffic = False
      multi_host = True
      send_arp_for_ha = True
      share_dhcp_address = True
      force_dhcp_release = True
      flat_network_bridge = br100
      flat_interface = INTERFACE_NAME
      public_interface = INTERFACE_NAME

   Replace ``INTERFACE_NAME`` with the actual interface name for the external
   network. For example, *eth1* or *ens224*. You can also leave these two
   parameters undefined if you are serving multiple networks with
   individual bridges for each.

.. only:: ubuntu or debian

   2. Restart the services:

      .. code-block:: console

         # service nova-network restart
         # service nova-api-metadata restart

.. only:: rdo or obs

   2. Start the services and configure them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-nova-network.service openstack-nova-metadata-api.service
         # systemctl start openstack-nova-network.service openstack-nova-metadata-api.service

Create initial network
~~~~~~~~~~~~~~~~~~~~~~
Before launching your first instance, you must create the necessary
virtual network infrastructure to which the instance will connect. This
network typically provides Internet access *from* instances. You can
enable Internet access *to* individual instances using a :term:`floating IP
address` and suitable :term:`security group` rules. The ``admin`` tenant owns
this network because it provides external network access for multiple
tenants.

This network shares the same :term:`subnet` associated with the physical
network connected to the external :term:`interface` on the compute node. You
should specify an exclusive slice of this subnet to prevent interference with
other devices on the external network.

**To create the network**

#. On the controller node, source the ``admin`` tenant credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the network:

   Replace ``NETWORK_CIDR`` with the subnet associated with the physical
   network.

   .. code-block:: console

      $ nova network-create demo-net --bridge br100 --multi-host T \
        --fixed-range-v4 NETWORK_CIDR

   For example, using an exclusive slice of ``203.0.113.0/24`` with IP
   address range ``203.0.113.24`` to ``203.0.113.31``:

   .. code-block:: console

      $ nova network-create demo-net --bridge br100 --multi-host T \
        --fixed-range-v4 203.0.113.24/29

   .. note:: This command provides no output.

#. Verify creation of the network:

   .. code-block:: console

      $ nova net-list
      +--------------------------------------+----------+------------------+
      | ID                                   | Label    | CIDR             |
      +--------------------------------------+----------+------------------+
      | 84b34a65-a762-44d6-8b5e-3b461a53f513 | demo-net | 203.0.113.24/29  |
      +--------------------------------------+----------+------------------+
