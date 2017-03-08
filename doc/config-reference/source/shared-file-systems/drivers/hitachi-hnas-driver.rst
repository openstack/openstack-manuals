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

The driver supports NFS and CIFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Revert a share to a snapshot.

- Extend a share.

- Manage a share.

- Unmanage a share.

- Shrink a share.

- Mount snapshots.

- Allow snapshot access.

- Deny snapshot access.

- Manage a snapshot.

- Unmanage a snapshot.

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

        $ openstack network create --project DEMO \
          --provider-network-type flat \
          --provider-physical-network physnet2 hnas_network

   * Optional: List available networks:

     .. code-block:: console

        $ openstack network list

   * Create a subnet to the same project (DEMO), the gateway IP of this subnet,
     a name for the subnet, the network name created before, and the CIDR of
     subnet:

     .. code-block:: console

        $ openstack subnet create --project DEMO --gateway GATEWAY \
          --subnet-range SUBNET_CIDR --network NETWORK HNAS_SUBNET

   * Optional: List available subnets:

     .. code-block:: console

        $ openstack subnet list

   * Add the subnet interface to a router, providing the router name and
     subnet name created before:

     .. code-block:: console

        $ openstack router add subnet SUBNET ROUTER

Pre-configuration on HNAS
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a file system on HNAS. See the
   `Hitachi HNAS reference <http://www.hds.com/assets/pdf/hus-file-module-file-services-administration-guide.pdf>`_.

   .. important::

      Make sure that the filesystem is not created as a replication target.
      For more information, refer to the official HNAS administration guide.

#. Prepare the HNAS EVS network.

   * Create a route in HNAS to the project network:

     .. code-block:: console

        $ console-context --evs <EVS_ID_IN_USE> route-net-add \
          --gateway <FLAT_NETWORK_GATEWAY> <TENANT_PRIVATE_NETWORK>

     .. important::

        Make sure multi-tenancy is enabled and routes are configured
        per EVS.

     .. code-block:: console

        $ console-context --evs 3 route-net-add --gateway 192.168.1.1 \
        10.0.0.0/24

#. Configure the CIFS security.

   * Before using CIFS shares with the HNAS driver, make sure to configure a
     security service in the back end. For details, refer to the `Hitachi HNAS
     reference
     <http://www.hds.com/assets/pdf/hus-file-module-file-services-administration-guide.pdf>`_.

Back end configuration
~~~~~~~~~~~~~~~~~~~~~~

#. Configure HNAS driver.

   * Configure HNAS driver according to your environment. This example shows
     a minimal HNAS driver configuration:

     .. code-block:: ini

        [DEFAULT]
        enabled_share_backends = hnas1
        enabled_share_protocols = NFS,CIFS

        [hnas1]
        share_backend_name = HNAS1
        share_driver = manila.share.drivers.hitachi.hnas.driver.HitachiHNASDriver
        driver_handles_share_servers = False
        hitachi_hnas_ip = 172.24.44.15
        hitachi_hnas_user = supervisor
        hitachi_hnas_password = supervisor
        hitachi_hnas_evs_id = 1
        hitachi_hnas_evs_ip = 10.0.1.20
        hitachi_hnas_file_system_name = FS-Manila
        hitachi_hnas_cifs_snapshot_while_mounted = True

     .. note::

        The ``hds_hnas_cifs_snapshot_while_mounted`` parameter allows snapshots
        to be taken while CIFS shares are mounted. This parameter is set to
        ``False`` by default, which prevents a snapshot from being taken if the
        share is mounted or in use.

#. Optional. HNAS multi-backend configuration.

   * Update the ``enabled_share_backends`` flag with the names of the back
     ends separated by commas.

   * Add a section for every back end according to the example bellow:

     .. code-block:: ini

        [DEFAULT]
        enabled_share_backends = hnas1,hnas2
        enabled_share_protocols = NFS,CIFS

        [hnas1]
        share_backend_name = HNAS1
        share_driver = manila.share.drivers.hitachi.hnas.driver.HitachiHNASDriver
        driver_handles_share_servers = False
        hitachi_hnas_ip = 172.24.44.15
        hitachi_hnas_user = supervisor
        hitachi_hnas_password = supervisor
        hitachi_hnas_evs_id = 1
        hitachi_hnas_evs_ip = 10.0.1.20
        hitachi_hnas_file_system_name = FS-Manila1
        hitachi_hnas_cifs_snapshot_while_mounted = True

        [hnas2]
        share_backend_name = HNAS2
        share_driver = manila.share.drivers.hitachi.hnas.driver.HitachiHNASDriver
        driver_handles_share_servers = False
        hitachi_hnas_ip = 172.24.44.15
        hitachi_hnas_user = supervisor
        hitachi_hnas_password = supervisor
        hitachi_hnas_evs_id = 1
        hitachi_hnas_evs_ip = 10.0.1.20
        hitachi_hnas_file_system_name = FS-Manila2
        hitachi_hnas_cifs_snapshot_while_mounted = True

#. Disable DHSS for HNAS share type configuration:

   .. note::

      Shared File Systems requires that the share type includes the
      ``driver_handles_share_servers`` extra-spec. This ensures that the share
      will be created on a back end that supports the requested
      ``driver_handles_share_servers`` capability.

   .. code-block:: console

      $ manila type-create hitachi False

#. Optional: Add extra-specs for enabling HNAS-supported features:

   * These commands will enable various snapshot-related features that are
     supported in HNAS.

     .. code-block:: console

        $ manila type-key hitachi set snapshot_support=True
        $ manila type-key hitachi set mount_snapshot_support=True
        $ manila type-key hitachi set revert_to_snapshot_support=True
        $ manila type-key hitachi set create_share_from_snapshot_support=True

   * To specify which HNAS back end will be created by the share, in case of
     multiple back end setups, add an extra-spec for each share-type to match
     a specific back end. Therefore, it is possible to specify which back end
     the Shared File System service will use when creating a share.

     .. code-block:: console

        $ manila type-key hitachi set share_backend_name=hnas1
        $ manila type-key hitachi2 set share_backend_name=hnas2

#. Restart all Shared File Systems services (``manila-share``,
   ``manila-scheduler`` and ``manila-api``).

Share migration
~~~~~~~~~~~~~~~

Extra configuration is needed for allowing shares to be migrated from or to
HNAS. In the OpenStack deployment, the manila-share node needs an additional
connection to the EVS data interface. Furthermore, make sure to add
``hitachi_hnas_admin_network_ip`` to the configuration. This should match the
value of ``data_node_access_ip``. For more in-depth documentation,
refer to the `share migration documents
<https://docs.openstack.org/admin-guide/shared-file-systems-share-migration.html>`_

Manage and unmanage shares
~~~~~~~~~~~~~~~~~~~~~~~~~~

Shared File Systems has the ability to manage and unmanage shares. If there is
a share in the storage and it is not in OpenStack, you can manage that share
and use it as a Shared File Systems share. Administrators have to make sure the
exports are under the ``/shares`` folder beforehand. HNAS drivers use
virtual-volumes (V-VOL) to create shares. Only V-VOL shares can be used by the
driver, and V-VOLs must have a quota limit. If the NFS export is an ordinary FS
export, it is not possible to use it in Shared File Systems. The unmanage
operation only unlinks the share from Shared File Systems, all data is
preserved. Both manage and unmanage operations are non-disruptive by default,
until access rules are modified.

To **manage** a share, use:

.. code-block:: console

   $ manila manage [--name <name>] [--description <description>]
                   [--share_type <share-type>]
                   [--driver_options [<key=value> [<key=value> ...]]]
                   [--public]
                   <service_host> <protocol> <export_path>

Where:

+--------------------+------------------------------------------------------+
|  **Parameter**     | **Description**                                      |
+====================+======================================================+
|                    | Manila host, back end and share name. For example,   |
|  ``service_host``  | ``ubuntu@hitachi1#hsp1``. The available hosts can    |
|                    | be listed with the command: ``manila pool-list``     |
|                    | (admin only).                                        |
+--------------------+------------------------------------------------------+
|  ``protocol``      | Protocol of share to manage, such as NFS or CIFS.    |
+--------------------+------------------------------------------------------+
|  ``export_path``   | Share export path.                                   |
|                    |   For NFS: ``10.0.0.1:/shares/share_name``           |
|                    |                                                      |
|                    |   For CIFS: ``\\10.0.0.1\share_name``                |
+--------------------+------------------------------------------------------+

.. note::
   For NFS exports, ``export_path`` **must** include ``/shares/`` after the
   target address. Trying to reference the share name directly or under another
   path will fail.

.. note::
   For CIFS exports, although the shares will be created under the ``/shares/``
   folder in the back end, only the share name is needed in the export path. It
   should also be noted that the backslash ``\`` character has to be escaped
   when entered in Linux terminals.

For additional details, refer to ``manila help manage`` or the
`OpenStack Shared File Systems documentation
<https://docs.openstack.org/admin-guide/shared-file-systems.html>`_.

To **unmanage** a share, use:

.. code-block:: console

   $ manila unmanage <share>

Where:

+------------------+---------------------------------------------------------+
|  **Parameter**   | **Description**                                         |
+==================+=========================================================+
|  ``share``       | ID or name of the share to be unmanaged. A list of      |
|                  | shares can be fetched with ``manila list``.             |
+------------------+---------------------------------------------------------+

Manage and unmanage snapshots
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Shared File Systems service also has the ability to manage share
snapshots. All new share snapshots are created inside a directory
``/snapshots/share_ID``. Existing HNAS snapshots can also be managed, as long
as they respect the pre-existing folder structure.

To **manage** a snapshot, use:

.. code-block:: console

   $ manila snapshot-manage [--name <name>] [--description <description>]
                            [--driver_options [<key=value> [<key=value> ...]]]
                            <share> <provider_location>

Where:

+------------------------+-------------------------------------------------+
|  **Parameter**         | **Description**                                 |
+========================+=================================================+
|  ``share``             | ID or name of the share to be managed. A list   |
|                        | of shares can be fetched with ``manila list``.  |
+------------------------+-------------------------------------------------+
| ``provider_location``  | Location of the snapshot on the back end, such  |
|                        | as ``/snapshots/share_ID/snapshot_ID``.         |
+------------------------+-------------------------------------------------+
| ``--driver_options``   | Driver-related configuration, passed such as    |
|                        | ``size=10``.                                    |
+------------------------+-------------------------------------------------+

.. note::
   The mandatory ``provider_location`` parameter uses the same syntax for both
   NFS and CIFS shares. This is only the case for snapshot management.

.. note::
   The ``--driver_options`` parameter ``size`` is **required** for the HNAS
   driver. Administrators need to know the size of the to-be-managed
   snapshot beforehand.

.. note::
   If the ``mount_snapshot_support=True`` extra-spec is set in the share type,
   the HNAS driver will automatically create an export when managing a snapshot
   if one does not already exist.

To **unmanage** a snapshot, use:

.. code-block:: console

   $ manila snapshot-unmanage <snapshot>

Where:

+---------------+--------------------------------+
| **Parameter** | **Description**                |
+===============+================================+
| ``snapshot``  | Name or ID of the snapshot(s). |
+---------------+--------------------------------+

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
  (:command:`manila quota-update`) to control the back end usage.
* Shares will need to be remounted after a revert-to-snapshot operation.
