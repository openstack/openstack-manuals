===================
Dell EMC VNX driver
===================

The EMC Shared File Systems service driver framework (EMCShareDriver)
utilizes the EMC storage products to provide the shared file systems to
OpenStack. The EMC driver is a plug-in based driver which is designed to
use different plug-ins to manage different EMC storage products.

The VNX plug-in is the plug-in which manages the VNX to provide shared
filesystems. The EMC driver framework with the VNX plug-in is referred
to as the VNX driver in this document.

This driver performs the operations on VNX by XMLAPI and the file
command line. Each back end manages one Data Mover of VNX. Multiple
Shared File Systems service back ends need to be configured to manage
multiple Data Movers.

Requirements
~~~~~~~~~~~~

-  VNX OE for File version 7.1 or higher

-  VNX Unified, File only, or Gateway system with a single storage back
   end

-  The following licenses should be activated on VNX for File:

   -  CIFS

   -  NFS

   -  SnapSure (for snapshot)

   -  ReplicationV2 (for create share from snapshot)

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

-  Create a share.

-  Delete a share.

-  Allow share access.

   Note the following limitations:

   -  Only IP access type is supported for NFS.
   -  Only user access type is supported for CIFS.

-  Deny share access.

-  Create a snapshot.

-  Delete a snapshot.

-  Create a share from a snapshot.

While the generic driver creates shared filesystems based on cinder
volumes attached to nova VMs, the VNX driver performs similar operations
using the Data Movers on the array.

Pre-configurations on VNX
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Enable unicode on Data Mover.

   The VNX driver requires that the unicode is enabled on Data Mover.

   .. warning::

      After enabling Unicode, you cannot disable it. If there are some
      filesystems created before Unicode is enabled on the VNX,
      consult the storage administrator before enabling Unicode.

   To check the Unicode status on Data Mover, use the following VNX File
   command on the VNX control station:

   .. code-block:: none

      server_cifs <mover_name> | head
      # mover_name = <name of the Data Mover>

   Check the value of I18N mode field. UNICODE mode is shown as
   ``I18N mode = UNICODE``.

   To enable the Unicode for Data Mover:

   .. code-block:: none

      uc_config -on -mover <mover_name>
      # mover_name = <name of the Data Mover>

   Refer to the document Using International Character Sets on VNX for
   File on `EMC support site <http://support.emc.com>`_ for more
   information.

#. Enable CIFS service on Data Mover.

   Ensure the CIFS service is enabled on the Data Mover which is going
   to be managed by VNX driver.

   To start the CIFS service, use the following command:

   .. code-block:: none

      server_setup <mover_name> -Protocol cifs -option start [=<n>]
      # mover_name = <name of the Data Mover>
      # n = <number of threads for CIFS users>

   .. note::

      If there is 1 GB of memory on the Data Mover, the default is 96
      threads; however, if there is over 1 GB of memory, the default
      number of threads is 256.

   To check the CIFS service status, use this command:

   .. code-block:: none

      server_cifs <mover_name> | head
      # mover_name = <name of the Data Mover>

   The command output will show the number of CIFS threads started.

#. NTP settings on Data Mover.

   VNX driver only supports CIFS share creation with share network
   which has an Active Directory security-service associated.

   Creating CIFS share requires that the time on the Data Mover is in
   sync with the Active Directory domain so that the CIFS server can
   join the domain. Otherwise, the domain join will fail when creating
   share with this security service. There is a limitation that the
   time of the domains used by security-services even for different
   tenants and different share networks should be in sync. Time
   difference should be less than 10 minutes.

   It is recommended to set the NTP server to the same public NTP
   server on both the Data Mover and domains used in security services
   to ensure the time is in sync everywhere.

   Check the date and time on Data Mover:

   .. code-block:: none

      server_date <mover_name>
      # mover_name = <name of the Data Mover>

   Set the NTP server for Data Mover:

   .. code-block:: none

      server_date <mover_name> timesvc start ntp <host> [<host> ...]
      # mover_name = <name of the Data Mover>
      # host = <IP address of the time server host>

   .. note::

      The host must be running the NTP protocol. Only 4 host entries
      are allowed.

#. Configure User Mapping on the Data Mover.

   Before creating CIFS share using VNX driver, you must select a
   method of mapping Windows SIDs to UIDs and GIDs. EMC recommends
   using usermapper in single protocol (CIFS) environment which is
   enabled on VNX by default.

   To check usermapper status, use this command syntax:

   .. code-block:: none

      server_usermapper <movername>
      # movername = <name of the Data Mover>

   If usermapper is not started, the following command can be used
   to start the usermapper:

   .. code-block:: none

      server_usermapper <movername> -enable
      # movername = <name of the Data Mover>

   For a multiple protocol environment, refer to Configuring VNX User
   Mapping on `EMC support site <http://support.emc.com>`_ for
   additional information.

#. Network Connection.

   Find the network devices (physical port on NIC) of Data Mover that
   has access to the share network.

   Go to :guilabel:`Unisphere` to check the device list:
   :menuselection:`Settings > Network > Settings for File (Unified system
   only) > Device`.


Back-end configurations
~~~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the
``/etc/manila/manila.conf`` file for the VNX driver:

.. code-block:: ini

   emc_share_backend = vnx
   emc_nas_server = <IP address>
   emc_nas_password = <password>
   emc_nas_login = <user>
   vnx_server_container = <Data Mover name>
   vnx_share_data_pools = <Comma separated pool names>
   share_driver = manila.share.drivers.emc.driver.EMCShareDriver
   vnx_ethernet_ports = <Comma separated ports list>

- `emc_share_backend`
    The plug-in name. Set it to ``vnx`` for the VNX driver.

- `emc_nas_server`
    The control station IP address of the VNX system to be managed.

- `emc_nas_password` and `emc_nas_login`
    The fields that are used to provide credentials to the
    VNX system. Only local users of VNX File is supported.

- `vnx_server_container`
    Name of the Data Mover to serve the share service.

- `vnx_share_data_pools`
    Comma separated list specifying the name of the pools to be used
    by this back end. Do not set this option if all storage pools
    on the system can be used.
    Wild card character is supported.

    Examples: pool_1, pool_*, *

- `vnx_ethernet_ports`
    Comma separated list specifying the ports (devices) of Data Mover
    that can be used for share server interface. Do not set this
    option if all ports on the Data Mover can be used.
    Wild card character is supported.

    Examples: spa_eth1, spa_*, *


Restart of the ``manila-share`` service is needed for the configuration
changes to take effect.


Restrictions
~~~~~~~~~~~~

The VNX driver has the following restrictions:

-  Only IP access type is supported for NFS.

-  Only user access type is supported for CIFS.

-  Only FLAT network and VLAN network are supported.

-  VLAN network is supported with limitations. The neutron subnets in
   different VLANs that are used to create share networks cannot have
   overlapped address spaces. Otherwise, VNX may have a problem to
   communicate with the hosts in the VLANs. To create shares for
   different VLANs with same subnet address, use different Data Movers.

-  The ``Active Directory`` security service is the only supported
   security service type and it is required to create CIFS shares.

-  Only one security service can be configured for each share network.

-  Active Directory domain name of the 'active\_directory' security
   service should be unique even for different tenants.

-  The time on Data Mover and the Active Directory domains used in
   security services should be in sync (time difference should be less
   than 10 minutes). It is recommended to use same NTP server on both
   the Data Mover and Active Directory domains.

-  On VNX the snapshot is stored in the SavVols. VNX system allows the
   space used by SavVol to be created and extended until the sum of the
   space consumed by all SavVols on the system exceeds the default 20%
   of the total space available on the system. If the 20% threshold
   value is reached, an alert will be generated on VNX. Continuing to
   create snapshot will cause the old snapshot to be inactivated (and
   the snapshot data to be abandoned). The limit percentage value can be
   changed manually by storage administrator based on the storage needs.
   Administrator is recommended to configure the notification on the
   SavVol usage. Refer to Using VNX SnapSure document on `EMC support
   site <http://support.emc.com>`_ for more information.

-  VNX has limitations on the overall numbers of Virtual Data Movers,
   filesystems, shares, checkpoints, etc. Virtual Data Mover(VDM) is
   created by the VNX driver on the VNX to serve as the Shared File
   Systems service share server. Similarly, filesystem is created,
   mounted, and exported from the VDM over CIFS or NFS protocol to serve
   as the Shared File Systems service share. The VNX checkpoint serves
   as the Shared File Systems service share snapshot. Refer to the NAS
   Support Matrix document on `EMC support
   site <http://support.emc.com>`_ for the limitations and configure the
   quotas accordingly.

Driver options
~~~~~~~~~~~~~~

Configuration options specific to this driver are documented in
:ref:`manila-emc`.
