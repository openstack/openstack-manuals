====================
Dell EMC VMAX driver
====================

The Dell EMC Shared File Systems service driver framework (EMCShareDriver)
utilizes the Dell EMC storage products to provide the shared file systems
to OpenStack. The Dell EMC driver is a plug-in based driver which is designed
to use different plug-ins to manage different Dell EMC storage products.

The VMAX plug-in manages the VMAX to provide shared file systems. The EMC
driver framework with the VMAX plug-in is referred to as the VMAX driver
in this document.

This driver performs the operations on VMAX eNAS by XMLAPI and the file
command line. Each back end manages one Data Mover of VMAX. Multiple
Shared File Systems service back ends need to be configured to manage
multiple Data Movers.

Requirements
~~~~~~~~~~~~

-  VMAX eNAS OE for File version 8.1 or higher

-  VMAX Unified or File only

-  The following licenses should be activated on VMAX for File:

   -  CIFS

   -  NFS

   -  SnapSure (for snapshot)

   -  ReplicationV2 (for create share from snapshot)

Supported shared file systems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

While the generic driver creates shared file systems based on cinder
volumes attached to nova VMs, the VMAX driver performs similar operations
using the Data Movers on the array.

Pre-configurations on VMAX
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Enable Unicode on Data Mover.

   The VMAX driver requires that the Unicode is enabled on Data Mover.

   .. warning::

      After enabling Unicode, you cannot disable it. If there are some
      file systems created before Unicode is enabled on the VMAX,
      consult the storage administrator before enabling Unicode.

   To check the Unicode status on Data Mover, use the following VMAX eNAS File
   commands on the VMAX control station:

   .. code-block:: console

      server_cifs <MOVER_NAME> | head
      # MOVER_NAME = <name of the Data Mover>

   Check the value of I18N mode field. UNICODE mode is shown as
   ``I18N mode = UNICODE``.

   To enable the Unicode for Data Mover, use the following command:

   .. code-block:: console

      uc_config -on -mover <MOVER_NAME>
      # MOVER_NAME = <name of the Data Mover>

   Refer to the document Using International Character Sets on VMAX for
   File on `EMC support site <http://support.emc.com>`_ for more
   information.

#. Enable CIFS service on Data Mover.

   Ensure the CIFS service is enabled on the Data Mover which is going
   to be managed by VMAX driver.

   To start the CIFS service, use the following command:

   .. code-block:: none

      server_setup <MOVER_NAME> -Protocol cifs -option start [=<n>]
      # MOVER_NAME = <name of the Data Mover>
      # n = <number of threads for CIFS users>

   .. note::

      If there is 1 GB of memory on the Data Mover, the default is 96
      threads. However, if there is over 1 GB of memory, the default
      number of threads is 256.

   To check the CIFS service status, use the following command:

   .. code-block:: none

      server_cifs <MOVER_NAME> | head
      # MOVER_NAME = <name of the Data Mover>

   The command output will show the number of CIFS threads started.

#. NTP settings on Data Mover.

   VMAX driver only supports CIFS share creation with share network
   which has an Active Directory security-service associated.

   Creating CIFS share requires that the time on the Data Mover is in
   sync with the Active Directory domain so that the CIFS server can
   join the domain. Otherwise, the domain join will fail when creating
   a share with this security service. There is a limitation that the
   time of the domains used by security-services, even for different
   tenants and different share networks, should be in sync. Time
   difference should be less than 10 minutes.

   We recommend setting the NTP server to the same public NTP
   server on both the Data Mover and domains used in security services
   to ensure the time is in sync everywhere.

   Check the date and time on Data Mover with the following command:

   .. code-block:: none

      server_date <MOVER_NAME>
      # MOVER_NAME = <name of the Data Mover>

   Set the NTP server for Data Mover with the following command:

   .. code-block:: none

      server_date <MOVER_NAME> timesvc start ntp <host> [<host> ...]
      # MOVER_NAME = <name of the Data Mover>
      # host = <IP address of the time server host>

   .. note::

      The host must be running the NTP protocol. Only 4 host entries
      are allowed.

#. Configure User Mapping on the Data Mover.

   Before creating CIFS share using VMAX driver, you must select a
   method of mapping Windows SIDs to UIDs and GIDs. DELL EMC recommends
   using usermapper in single protocol (CIFS) environment which is
   enabled on VMAX eNAS by default.

   To check usermapper status, use the following command syntax:

   .. code-block:: none

      server_usermapper <movername>
      # movername = <name of the Data Mover>

   If usermapper does not start, use the following command
   to start the usermapper:

   .. code-block:: none

      server_usermapper <movername> -enable
      # movername = <name of the Data Mover>

   For a multiple protocol environment, refer to Configuring VMAX eNAS User
   Mapping on `EMC support site <http://support.emc.com>`_ for
   additional information.

#. Configure network connection.

   Find the network devices (physical port on NIC) of the Data Mover that
   has access to the share network.

   To check the device list, go
   to :menuselection:`Unisphere > Settings > Network > Device`.

Back-end configurations
~~~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the
``/etc/manila/manila.conf`` file for the VMAX driver:

.. code-block:: ini

   emc_share_backend = vmax
   emc_nas_server = <IP address>
   emc_nas_password = <password>
   emc_nas_login = <user>
   emc_nas_server_container = <Data Mover name>
   emc_nas_pool_names = <Comma separated pool names>
   share_driver = manila.share.drivers.emc.driver.EMCShareDriver
   emc_interface_ports = <Comma separated ports list>

- `emc_share_backend`
    The plug-in name. Set it to ``vmax`` for the VMAX driver.

- `emc_nas_server`
    The control station IP address of the VMAX system to be managed.

- `emc_nas_password` and `emc_nas_login`
    The fields that are used to provide credentials to the
    VMAX system. Only local users of VMAX File is supported.

- `emc_nas_server_container`
    Name of the Data Mover to serve the share service.

- `emc_nas_pool_names`
    Comma separated list specifying the name of the pools to be used
    by this back end. Do not set this option if all storage pools
    on the system can be used.
    Wild card character is supported.

    Examples: pool_1, pool_*, *

- `emc_interface_ports`
    Comma-separated list specifying the ports (devices) of Data Mover
    that can be used for share server interface. Do not set this
    option if all ports on the Data Mover can be used.
    Wild card character is supported.

    Examples: spa_eth1, spa_*, *


Restart of the ``manila-share`` service is needed for the configuration
changes to take effect.


Restrictions
~~~~~~~~~~~~

The VMAX driver has the following restrictions:

-  Only IP access type is supported for NFS.

-  Only user access type is supported for CIFS.

-  Only FLAT network and VLAN network are supported.

-  VLAN network is supported with limitations. The neutron subnets in
   different VLANs that are used to create share networks cannot have
   overlapped address spaces. Otherwise, VMAX may have a problem to
   communicate with the hosts in the VLANs. To create shares for
   different VLANs with same subnet address, use different Data Movers.

-  The **Active Directory** security service is the only supported
   security service type and it is required to create CIFS shares.

-  Only one security service can be configured for each share network.

-  The domain name of the ``active_directory`` security
   service should be unique even for different tenants.

-  The time on the Data Mover and the Active Directory domains used in
   security services should be in sync (time difference should be less
   than 10 minutes). We recommended using same NTP server on both
   the Data Mover and Active Directory domains.

-  On eNAS, the snapshot is stored in the SavVols. eNAS system allows the
   space used by SavVol to be created and extended until the sum of the
   space consumed by all SavVols on the system exceeds the default 20%
   of the total space available on the system. If the 20% threshold
   value is reached, an alert will be generated on eNAS. Continuing to
   create snapshot will cause the old snapshot to be inactivated (and
   the snapshot data to be abandoned). The limit percentage value can be
   changed manually by storage administrator based on the storage needs.
   We recommend the administrator configures the notification on the
   SavVol usage. Refer to Using eNAS SnapSure document on `EMC support
   site <http://support.emc.com>`_ for more information.

-  eNAS has limitations on the overall numbers of Virtual Data Movers,
   filesystems, shares, and checkpoints. Virtual Data Mover(VDM) is
   created by the eNAS driver on the eNAS to serve as the Shared File
   Systems service share server. Similarly, the filesystem is created,
   mounted, and exported from the VDM over CIFS or NFS protocol to serve
   as the Shared File Systems service share. The eNAS checkpoint serves
   as the Shared File Systems service share snapshot. Refer to the NAS
   Support Matrix document on `EMC support
   site <http://support.emc.com>`_ for the limitations and configure the
   quotas accordingly.

Driver options
~~~~~~~~~~~~~~

Configuration options specific to this driver are documented in
:ref:`manila-emc`.
