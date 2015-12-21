=========================
Hitachi NAS (HNAS) driver
=========================

This Shared File Systems driver provides support for Hitachi NAS
Platform Models 3080, 3090, 4040, 4060, 4080, and 4100.

HNAS storage requirements
~~~~~~~~~~~~~~~~~~~~~~~~~

Before using Hitachi HNAS Shared File Systems driver, use the HNAS
configuration and management utilities, such as GUI (SMU) or SSC CLI to create
a storage pool (span) and an EVS. Also, check that HNAS/SMU software version
is 12.2 or higher.

Supported operations
~~~~~~~~~~~~~~~~~~~~

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

Driver configuration
~~~~~~~~~~~~~~~~~~~~

To configure the driver, make sure that the controller and compute nodes have
access to the HNAS management port, and compute and networking nodes have
access to the data ports (EVS IPs or aggregations). If Shared File Systems
service is not running on controller node, it must have access to the
management port. The driver configuration can be summarized in the following
steps:

#. Create a file system to be used by Shared File Systems on HNAS. Make sure
   that the filesystem is not created as a replication target. For more
   information on creating a filesystem, see the
   `Hitachi HNAS reference <http://www.hds.com/assets/pdf/hus-file-module-file-services-administration-guide.pdf>`_.
#. Install and configure an OpenStack environment with default Shared File
   System parameters and services. Refer to OpenStack Manila configuration
   reference.
#. Configure HNAS parameters in the ``manila.conf`` file.
#. Prepare the network.
#. Configure and create share type.
#. Restart the services.
#. Configure the network.

The first two steps are not in the scope of this document. We cover all the
remaining steps in the following sections.

Step 3 - HNAS parameter configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Below is an example of a minimal configuration of HNAS driver:

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

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-hds_hnas.rst

Step 4 - prepare the network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the driver mode used by HNAS Driver (DHSS = ``False``), the driver does not
handle network configuration, it is up to the administrator to configure it.
It is mandatory that HNAS management interface is reachable from Shared File
System node through Admin network, while the selected EVS data interface is
reachable from OpenStack Cloud, such as through Neutron Flat networking. Here
is a step-by-step of an example configuration:

| **Shared File Systems node:**
| **eth0**: Admin network, can ping HNAS management interface.
| **eth1**: Data network, can ping HNAS EVS IP (data interface). This
 interface is only required if you plan to use share migration.

| **Networking node and Compute nodes:**
| **eth0**: Admin network, can ping HNAS management interface.
| **eth1**: Data network, can ping HNAS EVS IP (data interface).

Run in **Networking node**:

.. code-block:: console

   # ifconfig eth1 0
   # ovs-vsctl add-br br-eth1
   # ovs-vsctl add-port br-eth1 eth1
   # ifconfig eth1 up

Edit the ``/etc/neutron/plugins/ml2/ml2_conf.ini`` (default directory),
change the following settings as follows in their respective tags:

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

You may have to repeat the last line above in another file on the Compute node,
if it exists it is located in:
``/etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini``.

Create a route in HNAS to the tenant network. Please make sure
multi-tenancy is enabled and routes are configured per EVS. Use the command
:command:`route-net-add` in HNAS console, where the network parameter should
be the tenant's private network, while the gateway parameter should be the
FLAT network gateway and the :command:`console-context --evs` parameter should
be the ID of EVS in use, such as in the following example:

.. code-block:: console

   $ console-context --evs 3 route-net-add --gateway 192.168.1.1 \
     10.0.0.0/24

Step 5 - share type configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shared File Systems requires that the share type includes the
``driver_handles_share_servers`` extra-spec. This ensures that the share will
be created on a backend that supports the requested
``driver_handles_share_servers`` capability. For the Hitachi HNAS Shared File
System driver, this must be set to ``False``.

.. code-block:: console

   $ manila type-create hitachi False

Step 6 - restart the services
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Restart all Shared File Systems services
(``manila-share``, ``manila-scheduler`` and ``manila-api``) and
Networking services (``neutron-\*``).

Step 7 - configure the network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Networking node it is necessary to create a network, a subnet and to add
this subnet interface to a router:

Create a network to the given tenant (demo), providing the DEMO_ID (this can
be fetched using :command:`openstack project list` command), a name for the
network, the name of the physical network over which the virtual network is
implemented and the type of the physical mechanism by which the virtual
network is implemented:

.. code-block:: console

   $ neutron net-create --tenant-id <DEMO_ID> hnas_network \
     --provider:physical_network=physnet2 --provider:network_type=flat

Create a subnet to same tenant (demo), providing the DEMO_ID (this can be
fetched using :command:`openstack project list` command), the gateway IP of
this subnet, a name for the subnet, the network ID created in the previous
step (this can be fetched using :command:`neutron net-list` command) and
CIDR of subnet:

.. code-block:: console

   $ neutron subnet-create --tenant-id <DEMO_ID> --gateway <GATEWAY> \
     --name hnas_subnet <NETWORK_ID> <SUBNET_CIDR>

Finally, add the subnet interface to a router, providing the router ID and
subnet ID created in the previous step (can be fetched using :command:`neutron
subnet-list` command):

.. code-block:: console

   $ neutron router-interface-add <ROUTER_ID> <SUBNET_ID>

Manage and unmanage shares
~~~~~~~~~~~~~~~~~~~~~~~~~~

Shared File Systems has the ability to manage and unmanage shares. If there is
a share in the storage and it is not in OpenStack, you can manage that share
and use it as a Shared File Systems share. HNAS drivers use virtual-volumes
(V-VOL) to create shares. Only V-VOL shares can be used by the driver. If the
NFS export is an ordinary FS export, it is not possible to use it in Shared
File Systems. The unmanage operation only unlinks the share from Shared File
Systems. All data is preserved.

Additional notes:
~~~~~~~~~~~~~~~~~

* HNAS has some restrictions about the number of EVSs, filesystems,
  virtual-volumes, and simultaneous SSC connections. Check the manual
  specification for your system.
* Shares and snapshots are thin provisioned. It is reported to Shared File
  System only the real used space in HNAS. Also, a snapshot does not initially
  take any space in HNAS, it only stores the difference between the share and
  the snapshot, so it grows when share data is changed.
* Administrators should manage the tenant’s quota
  (:command:`manila quota-update`) to control the back-end usage.
