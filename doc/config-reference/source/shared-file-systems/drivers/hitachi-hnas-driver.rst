=========================
Hitachi NAS (HNAS) driver
=========================

The HNAS driver provides NFS Shared File Systems to OpenStack.

Requirements
~~~~~~~~~~~~

- Hitachi NAS Platform Models 3080, 3090, 4040, 4060, 4080, and 4100.

- HNAS/SMU software version is 12.2 or higher.

- HNAS configuration and management utilities to create a storage pool (span)
  and an EVS.

  -  GUI (SMU).

  -  SSC CLI.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Extend a share.

- Manage a share.

- Unmanage a share.

- Shrink a share.

Driver options
~~~~~~~~~~~~~~

This table contains the configuration options specific to the share driver.

.. include:: ../../tables/manila-hds_hnas.rst

Pre-configuration on OpenStack deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Install the OpenStack environment with manila. See the
   `OpenStack installation guide <https://docs.openstack.org/>`_.

#. Configure the OpenStack networking so it can reach HNAS Management
   interface and HNAS EVS Data interface.

   .. note ::

      In the driver mode used by HNAS Driver (DHSS = ``False``), the driver
      does not handle network configuration, it is up to the administrator to
      configure it.

   * Configure the network of the manila-share node network to reach HNAS
     management interface through the admin network.

     .. note::

        The manila-share node only requires the HNAS EVS data interface if you
        plan to use share migration.

   * Configure the network of the Compute and Networking nodes to reach HNAS
     EVS data interface through the data network.

   * Example of networking architecture:

     .. figure:: ../../figures/hds_network.jpg
        :width: 60%
        :align: center
        :alt: Example networking scenario

   * Edit the ``/etc/neutron/plugins/ml2/ml2_conf.ini`` file and update the
     following settings in their respective tags. In case you use linuxbridge,
     update bridge mappings at linuxbridge section:

   .. important ::

      It is mandatory that HNAS management interface is reachable from the
      Shared File System node through the admin network, while the selected
      EVS data interface is reachable from OpenStack Cloud, such as through
      Neutron flat networking.

   .. code-block:: ini

      [ml2]
      type_drivers = flat,vlan,vxlan,gre
      mechanism_drivers = openvswitch
      [ml2_type_flat]
      flat_networks = physnet1,physnet2
      [ml2_type_vlan]
      network_vlan_ranges = physnet1:1000:1500,physnet2:2000:2500
      [ovs]
      bridge_mappings = physnet1:br-ex,physnet2:br-eth1

   You may have to repeat the last line above in another file on the Compute
   node, if it exists it is located in:
   ``/etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini``.

   * In case openvswitch for neutron agent, run in network node:

     .. code-block:: console

        # ifconfig eth1 0
        # ovs-vsctl add-br br-eth1
        # ovs-vsctl add-port br-eth1 eth1
        # ifconfig eth1 up

   * Restart all neutron processes.

#. Create the data HNAS network in OpenStack:

   * List the available projects:

     .. code-block:: console

        $ openstack project list

   * Create a network to the given project (DEMO), providing the project name,
     a name for the network, the name of the physical network over which the
     virtual network is implemented, and the type of the physical mechanism by
     which the virtual network is implemented:

     .. code-block:: console

        $ openstack network create --project DEMO --provider-network-type flat \
          --provider-physical-network physnet2 hnas_network

   * Optional - List available networks:

     .. code-block:: console

        $ openstack network list

   * Create a subnet to the same project (DEMO), the gateway IP of this subnet,
     a name for the subnet, the network name created before, and the CIDR of
     subnet:

     .. code-block:: console

        $ openstack subnet create --project DEMO --gateway GATEWAY \
          --subnet-range SUBNET_CIDR --network NETWORK HNAS_SUBNET

   * OPTIONAL - List available subnets:

     .. code-block:: console

        $ openstack subnet list

   * Add the subnet interface to a router, providing the router name and
     subnet name created before:

     .. code-block:: console

        $ openstack router add subnet SUBNET ROUTER

Pre-configuration on HNAS
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a file system on HNAS. See the `Hitachi HNAS reference <http://www.hds.com/assets/pdf/hus-file-module-file-services-administration-guide.pdf>`_.

   .. important::

      Make sure that the filesystem is not created as a replication target.
      Refer official HNAS administration guide.

#. Prepare the HNAS EVS network.

   * Create a route in HNAS to the project network:

     .. code-block:: console

        $ console-context --evs <EVS_ID_IN_USE> route-net-add --gateway <FLAT_NETWORK_GATEWAY> \
        <TENANT_PRIVATE_NETWORK>

     .. important::

        Make sure multi-tenancy is enabled and routes are configured
        per EVS.

     .. code-block:: console

        $ console-context --evs 3 route-net-add --gateway 192.168.1.1 \
        10.0.0.0/24

Back end configuration
~~~~~~~~~~~~~~~~~~~~~~

#. Configure HNAS driver.

   * Configure HNAS driver according to your environment. This example shows
     a minimal HNAS driver configuration:

     .. code-block:: ini

        [DEFAULT]
        enabled_share_backends = hnas1
        enabled_share_protocols = NFS
        [hnas1]
        share_backend_name = HNAS1
        share_driver = manila.share.drivers.hitachi.hds_hnas.HDSHNASDriver
        driver_handles_share_servers = False
        hds_hnas_ip = 172.24.44.15
        hds_hnas_user = supervisor
        hds_hnas_password = supervisor
        hds_hnas_evs_id = 1
        hds_hnas_evs_ip = 10.0.1.20
        hds_hnas_file_system_name = FS-Manila

#. Optional - HNAS multi-backend configuration.

   * Update the ``enabled_share_backends`` flag with the names of the back
     ends separated by commas.

   * Add a section for every back end according to the example bellow:

     .. code-block:: ini

        [DEFAULT]
        enabled_share_backends = hnas1,hnas2
        enabled_share_protocols = NFS
        [hnas1]
        share_backend_name = HNAS1
        share_driver = manila.share.drivers.hitachi.hds_hnas.HDSHNASDriver
        driver_handles_share_servers = False
        hds_hnas_ip = 172.24.44.15
        hds_hnas_user = supervisor
        hds_hnas_password = supervisor
        hds_hnas_evs_id = 1
        hds_hnas_evs_ip = 10.0.1.20
        hds_hnas_file_system_name = FS-Manila1
        [hnas2]
        share_backend_name = HNAS2
        share_driver = manila.share.drivers.hitachi.hds_hnas.HDSHNASDriver
        driver_handles_share_servers = False
        hds_hnas_ip = 172.24.44.15
        hds_hnas_user = supervisor
        hds_hnas_password = supervisor
        hds_hnas_evs_id = 1
        hds_hnas_evs_ip = 10.0.1.20
        hds_hnas_file_system_name = FS-Manila2


#. Disable DHSS for HNAS share type configuration:

   .. note::

      Shared File Systems requires that the share type includes the
      ``driver_handles_share_servers`` extra-spec. This ensures that the share
      will be created on a backend that supports the requested
      ``driver_handles_share_servers`` capability.

   .. code-block:: console

      $ manila type-create hitachi False

#. (Optional multiple back end) Create an extra-spec for specifying which
   HNAS back end will be created by the share:

   * Create additional share types.

     .. code-block:: console

        $ manila type-create hitachi2 False

   * Add an extra-spec for each share-type in order to match a specific back
     end. Therefore, it is possible to specify which back end the Shared File
     System service will use when creating a share.

     .. code-block:: console

      $ manila type-key hitachi set share_backend_name=hnas1
      $ manila type-key hitachi2 set share_backend_name=hnas2

#. Restart all Shared File Systems services (``manila-share``,
   ``manila-scheduler`` and ``manila-api``).

Manage and unmanage shares
~~~~~~~~~~~~~~~~~~~~~~~~~~

Shared File Systems has the ability to manage and unmanage shares. If there is
a share in the storage and it is not in OpenStack, you can manage that share
and use it as a Shared File Systems share. HNAS drivers use virtual-volumes
(V-VOL) to create shares. Only V-VOL shares can be used by the driver. If the
NFS export is an ordinary FS export, it is not possible to use it in Shared
File Systems. The unmanage operation only unlinks the share from Shared File
Systems. All data is preserved.

Additional notes
~~~~~~~~~~~~~~~~

* HNAS has some restrictions about the number of EVSs, filesystems,
  virtual-volumes, and simultaneous SSC connections. Check the manual
  specification for your system.
* Shares and snapshots are thin provisioned. It is reported to Shared File
  System only the real used space in HNAS. Also, a snapshot does not initially
  take any space in HNAS, it only stores the difference between the share and
  the snapshot, so it grows when share data is changed.
* Administrators should manage the project's quota
  (:command:`manila quota-update`) to control the back-end usage.
