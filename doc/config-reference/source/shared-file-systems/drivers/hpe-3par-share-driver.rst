===============
HPE 3PAR driver
===============

The HPE 3PAR driver provides NFS and CIFS shared file systems to
OpenStack using HPE 3PAR's File Persona capabilities.

HPE 3PAR File Persona Software Suite concepts and terminology
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The software suite comprises the following managed objects:

-  File Provisioning Groups (FPGs)

-  Virtual File Servers (VFSs)

-  File Stores

-  File Shares

The File Persona Software Suite is built upon the resilient mesh-active
architecture of HPE 3PAR StoreServ and benefits from HPE 3PAR storage
foundation of wide-striped logical disks and autonomic
``Common Provisioning Groups (CPGs)``. A CPG can be shared between file and
block to create the File Shares or the logical unit numbers (LUNs) to
provide true convergence.

``A File Provisioning Group (FPG)`` is an instance of the HPE intellectual
property Adaptive File System. It controls how files are stored and retrieved.
Each FPG is transparently constructed from one or multiple
Virtual Volumes (VVs) and is the unit for replication and disaster recovery
for File Persona Software Suite. There are up to 16 FPGs supported on a
node pair.

``A Virtual File Server (VFS)`` is conceptually like a server. As such, it
presents virtual IP addresses to clients, participates in user authentication
services, and can have properties for such things as user/group quota
management and antivirus policies. Up to 16 VFSs are supported on a node pair,
one per FPG.

``File Stores`` are the slice of a VFS and FPG at which snapshots are taken,
capacity quota management can be performed, and antivirus scan service
policies customized. There are up to 256 File Stores supported on a node pair,
16 File Stores per VFS.

``File Shares`` are what provide data access to clients via SMB, NFS, and the
Object Access API, subject to the share permissions applied to them. Multiple
File Shares can be created for a File Store and at different directory levels
within a File Store.

Supported shared filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The driver supports CIFS and NFS shares.

Operations supported
~~~~~~~~~~~~~~~~~~~~
- Create a share.

  – Share is not accessible until access rules allow access.

- Delete a share.

- Allow share access.

  Note the following limitations:

  – IP access rules are required for NFS share access.

  – User access rules are not allowed for NFS shares.

  – User access rules are required for SMB share access.

  – User access requires a File Persona local user for SMB shares.

  – Shares are read/write (and subject to ACLs).

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Extend a share.

- Shrink a share.

- Share networks.

HPE 3PAR File Persona driver can be configured to work with or without
share networks. When using share networks, the HPE 3PAR
driver allocates an FSIP on the back end FPG (VFS) to match the share
network's subnet and segmentation ID. Security groups associated
with share networks are ignored.

Operations not supported
~~~~~~~~~~~~~~~~~~~~~~~~

-  Manage and unmanage

-  Manila Experimental APIs (consistency groups, replication, and migration)
   were added in Mitaka but have not yet been implemented by the HPE 3PAR
   File Persona driver.

Requirements
~~~~~~~~~~~~

On the OpenStack host running the Manila share service:

-  python-3parclient version 4.2.0 or newer from PyPI.

On the HPE 3PAR array:

-  HPE 3PAR Operating System software version 3.2.1 MU3 or higher.

-  A license that enables the File Persona feature.

-  The array class and hardware configuration must support File Persona.

Pre-configuration on the HPE 3PAR StoreServ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The following HPE 3PAR CLI commands show how to set up the HPE 3PAR StoreServ
to use File Persona with OpenStack Manila. HPE 3PAR File Persona must be
licensed, initialized, and started on the HPE 3PAR storage.

.. code-block:: console

   cli% startfs 0:2:1 1:2:1
   cli% setfs nodeip -ipaddress 10.10.10.11 -subnet 255.255.240.0 0
   cli% setfs nodeip -ipaddress 10.10.10.12 -subnet 255.255.240.0 1
   cli% setfs dns 192.168.8.80,127.127.5.50 foo.com,bar.com
   cli% setfs gw 10.10.10.10

-  A File Provisioning Group (FPG) must be created for use with the
   Shared File Systems service.

   .. code-block:: console

      cli% createfpg examplecpg examplefpg 18T

-  A Virtual File Server (VFS) must be created on the FPG.

-  The VFS must be configured with an appropriate share export IP
   address.

   .. code-block:: console

      cli% createvfs -fpg examplefpg 10.10.10.101 255.255.0.0 examplevfs

-  A local user in the Administrators group is needed for CIFS (SMB) shares.

   .. code-block:: console

      cli% createfsgroup fsusers
      cli% createfsuser –passwd <password> -enable true -grplist
      Users,Administrators –primarygroup fsusers fsadmin

-  The WSAPI with HTTP and/or HTTPS must be enabled and started.

   .. code-block:: console

      cli% setwsapi -https enable
      cli% startwsapi

HPE 3PAR shared file system driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Install the python-3parclient python package on the OpenStack Block Storage
   system:

   .. code-block:: console

      $ pip install 'python-3parclient>=4.0,<5.0'

-  Manila configuration file

   The Manila configuration file (typically ``/etc/manila/manila.conf``)
   defines and configures the Manila drivers and backends. After updating the
   configuration file, the Manila share service must be restarted for changes
   to take effect.

-  Enable share protocols

   To enable share protocols, an optional list of supported protocols can be
   specified using the ``enabled_share_protocols`` setting in the ``DEFAULT``
   section of the ``manila.conf`` file. The default is ``NFS, CIFS`` which
   allows both protocols supported by HPE 3PAR (NFS and SMB). Where Manila
   uses the term ``CIFS``, HPE 3PAR uses the term ``SMB``. Use the
   ``enabled_share_protocols`` option if you want to only provide one type of
   share (for example, only NFS) or if you want to explicitly avoid the
   introduction of other protocols that can be added for other drivers in the
   future.

-  Enable share back ends

   In the ``[DEFAULT]`` section of the Manila configuration file, use the
   ``enabled_share_backends`` option to specify the name of one or more
   back-end configuration sections to be enabled. To enable multiple
   back ends, use a comma-separated list.

   .. note::

      The name of the backend's configuration section is used (which may
      be different from the ``share_backend_name`` value)

-  Configure each back end

   For each back end, a configuration section defines the driver and back end
   options. These include common Manila options, as well as driver-specific
   options. The following ``Driver options`` section describes
   the parameters that need to be configured in the Manila
   configuration file for the HPE 3PAR driver.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-hpe3par.rst


HPE 3PAR Manila driver configuration example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following parameters shows a sample subset of the ``manila.conf`` file,
which configures two backends and the relevant ``[DEFAULT]`` options. A real
configuration would include additional ``[DEFAULT]`` options and additional
sections that are not discussed in this document. In this example, the
backends are using different FPGs on the same array:

.. code-block:: ini

   [DEFAULT]
   enabled_share_backends = HPE1,HPE2
   enabled_share_protocols = NFS,CIFS
   default_share_type = default
   [HPE1]
   share_backend_name = HPE3PAR1
   share_driver = manila.share.drivers.hpe.hpe_3par_driver.HPE3ParShareDriver
   driver_handles_share_servers = False
   max_over_subscription_ratio = 1
   hpe3par_fpg = examplefpg,10.10.10.101
   hpe3par_san_ip = 10.20.30.40
   hpe3par_api_url = https://10.20.30.40:8080/api/v1
   hpe3par_username = <username>
   hpe3par_password = <password>
   hpe3par_san_login = <san_username>
   hpe3par_san_password = <san_password>
   hpe3par_debug = False
   hpe3par_cifs_admin_access_username = <fs_admin>
   hpe3par_cifs_admin_access_password = <fs_password>
   [HPE2]
   share_backend_name = HPE3PAR2
   share_driver = manila.share.drivers.hpe.hpe_3par_driver.HPE3ParShareDriver
   driver_handles_share_servers = False
   max_over_subscription_ratio = 1
   hpe3par_fpg = examplefpg2,10.10.10.102
   hpe3par_san_ip = 10.20.30.40
   hpe3par_api_url = https://10.20.30.40:8080/api/v1
   hpe3par_username = <username>
   hpe3par_password = <password>
   hpe3par_san_login = <san_username>
   hpe3par_san_password = <san_password>
   hpe3par_debug = False
   hpe3par_cifs_admin_access_username = <fs_admin>
   hpe3par_cifs_admin_access_password = <password>


Network approach
~~~~~~~~~~~~~~~~

Network connectivity between the storage array (SSH/CLI and WSAPI) and the
Manila host is required for share management. Network connectivity between
the clients and the VFS is required for mounting and using the shares.
This includes:

-  Routing from the client to the external network.

-  Assigning the client an external IP address, for example a floating IP.

-  Configuring the Shared File Systems service host networking properly
   for IP forwarding.

-  Configuring the VFS networking properly for client subnets.

-  Configuring network segmentation, if applicable.

In the OpenStack Kilo release, the HPE 3PAR driver did not support share
networks. Share access from clients to HPE 3PAR shares required external
network access (external to OpenStack) and was set up and configured outside
of Manila.

In the OpenStack Liberty release, the HPE 3PAR driver could run with or
without share networks. The configuration option
``driver_handles_share_servers``( ``True`` or ``False`` ) indicated whether
share networks could be used. When set to ``False``, the HPE 3PAR driver
behaved as described earlier for Kilo. When set to ``True``, the share
network’s subnet, segmentation ID and IP address range were used to allocate
an FSIP on the HPE 3PAR. There is a limit of four FSIPs per VFS. For clients
to communicate with shares via this FSIP, the client must have access to the
external network using the subnet and segmentation ID of the share network.

For example, the client must be routed to the neutron provider network with
external access. The Manila host networking configuration and network
switches must support the subnet routing. If the VLAN segmentation ID is used,
communication with the share will use the FSIP IP address. Neutron networking
is required for HPE 3PAR share network support. Flat and VLAN provider
networks are supported, but the HPE 3PAR driver does not support share network
security groups.

Share access
~~~~~~~~~~~~
A share that is mounted before access is allowed can appear to be an empty
read-only share. After granting access, the share must be remounted.

-  IP access rules are required for NFS.

-  SMB shares require user access rules.

With the proper access rules, share access is not limited to the OpenStack
environment. Access rules added via Manila or directly in HPE 3PAR CLI can be
used to allow access to clients outside of the stack. The HPE 3PAR VFS/FSIP
settings determine the subnets visible for HPE 3PAR share access.

-  IP access rules

   To allow IP access to a share in the horizon UI, find the share in the
   Project|Manage Compute|Shares view. Use the ``Manage Rules`` action to add
   a rule. Select IP as the access type, and enter the external IP address
   (for example, the floating IP) of the client in the ``Access to`` box.

   You can also use the command line to allow IP access to a share in the
   horizon UI with the command:

   .. code-block:: console

      $ manila access-allow <share-id> ip <ip-address>

-  User access rules

   To allow user access to a share in the horizon UI, find the share in the
   Project|Manage Compute|Shares view. Use the ``Manage Rules`` action to add
   a rule. Select user as the access type and enter user name in the
   ``Access to`` box.

   You can also use the command line to allow user access to a share in the
   horizon UI with the command:

   .. code-block:: console

      $ manila access-allow <share-id> user <user name>

   The user name must be an HPE 3PAR user.

   Share access is different from file system permissions,
   for example, ACLs on files and folders. If a user wants to read a file,
   the user must have at least read permissions on the share and an ACL that
   grants him read permissions on the file or folder. Even with
   full control share access, it does not mean every user can do
   everything due to the additional restrictions of the folder ACLs.

   To modify the file or folder ACLs, allow access to an HPE 3PAR File Persona
   local user that is in the administrator's group and connect to the share
   using that user's credentials. Then, use the appropriate mechanism to
   modify the ACL or permissions to allow different access than what is
   provided by default.

.. _Share types:

Share types
~~~~~~~~~~~

When creating a share, a share type can be specified to determine where and
how the share will be created. If a share type is not specified, the
``default_share_type`` set in the Shared File Systems service configuration
file is used.

Manila share types are a type or label that can be selected at share creation
time in OpenStack. These types can be created either in the ``Admin`` horizon
UI or using the command line, as follows:

.. code-block:: console

      $ manila --os-username admin --os-tenant-name demo type-create
      –is_public false <name> false

The ``<name>`` is the name of the new share type. False at the end specifies
``driver_handles_share_servers=False``. The ``driver_handles_share_servers``
setting in the share type needs to match the setting configured for the
back end in the ``manila.conf`` file.

``is_public`` is used to indicate whether this share type is applicable to all
tenants or will be assigned to specific tenants.

``--os-username admin --os-tenant-name demo`` are only needed if your
environment variables do not specify the desired user and tenant.

For share types that are not public, use Manila ``type-access-add`` to assign
the share type to a tenant.

-  Using share types to require share networks

   The Shared File Systems service requires that the share type include the
   ``driver_handles_share_servers`` extra-spec. This ensures that the share is
   created on a back end that supports the requested
   ``driver_handles_share_servers`` (share networks) capability. From the
   Liberty release forward, both ``True`` and ``False`` are supported.

   The ``driver_handles_share_servers`` setting in the share type must match
   the setting in the back end configuration.

-  Using share types to select backends by name

   Administrators can optionally specify that a particular share type be
   explicitly associated with a single back end (or group of backends) by
   including the extra spec share_backend_name to match the name specified
   within the ``share_backend_name`` option in the back end configuration.

   When a share type is not selected during share creation, the default share
   type is used. To prevent creating these shares on any back end, the default
   share type needs to be specific enough to find appropriate default backends
   (or to find none if the default should not be used). The following example
   shows how to set share_backend_name for a share type.

   .. code-block:: console

      $ manila --os-username admin --os-tenant-name demo type-key <share-type>
      set share_backend_name=HPE3PAR2

-  Using share types to select backends with capabilities

   The HPE 3PAR driver automatically reports capabilities based on the FPG
   used for each back end. An administrator can create share types with extra
   specs, which controls share types that can use FPGs with or without
   specific capabilities.

   With the OpenStack Liberty release or later, below section shows the extra
   specs used with the capabilities filter and the HPE 3PAR driver:

   ``hpe3par_flash_cache``
     When the value is set to ``<is> True`` (or ``<is> False``), shares of
     this type are only created on a back end that uses HPE 3PAR Adaptive
     Flash Cache. For Adaptive Flash Cache, the HPE 3PAR StoreServ Storage
     array must meet the following requirements:

     -  Adaptive Flash Cache license installed
     -  Available SSDs
     -  Adaptive Flash Cache must be enabled on the HPE 3PAR StoreServ
        Storage array. This is done with the following CLI command:

        .. code-block:: console

           cli% createflashcache <size>

        ``<size>`` must be in 16 GB increments. For example, the below command
        creates 128 GB of Flash Cache for each node pair in the array.

        .. code-block:: console

           cli% createflashcache 128g

     -  Adaptive Flash Cache must be enabled for the VV set used by an FPG.
        For example, ``setflashcache vvset:<fpgname>``. The VV set name is the
        same as the FPG name.

        .. note::

           This setting affects all shares in that FPG (on that back end).

   ``Dedupe``
     When the value is set to ``<is> True`` (or ``<is> False``), shares of
     this type are only created on a back end that uses deduplication. For HPE
     3PAR File Persona, the provisioning type is determined when the FPG is
     created. Using the ``createfpg –tdvv`` option creates an FPG that
     supports both dedupe and thin provisioning. A thin deduplication license
     must be installed to use the tdvv option.

   ``thin_provisioning``
     When the value is set to ``<is> True`` (or ``<is> False``), shares of
     this type are only created on a back end that uses thin (or full)
     provisioning. For HPE 3PAR File Persona, the provisioning type is
     determined when the FPG is created. By default, FPGs are created with
     thin provisioning. The capacity filter uses the total provisioned space
     and configured ``max_oversubscription_ratio`` when filtering and weighing
     backends that use thin provisioning.


-  Using share types to influence share creation options

   Scoped extra-specs are used to influence vendor-specific implementation
   details. Scoped extra-specs use a prefix followed by a colon. For HPE 3PAR,
   these extra specs have a prefix of hpe3par.

   The following HPE 3PAR extra-specs are used when creating CIFS (SMB)
   shares:

   ``hpe3par:smb_access_based_enum``
     ``smb_access_based_enum`` (Access Based Enumeration) specifies if users
     can see only the files and directories to which they have been allowed
     access on the shares. Valid values are ``True`` or ``False``.
     The default is ``False``.

   ``hpe3par:smb_continuous_avail``
     ``smb_continuous_avail`` (Continuous Availability) specifies if
     continuous availability features of SMB3 should be enabled for this
     share. Valid values are ``True`` or ``False``. The default is ``True``.

   ``hpe3par:smb_cache``
     ``smb_cache`` specifies client-side caching for offline files. The
     default value is ``manual``. Valid values are:

     -  ``off`` — the client must not cache any files from this share. The
        share is configured to disallow caching.

     -  ``manual`` — the client must allow only manual caching for the files
        open from this share.

     -  ``optimized`` — the client may cache every file that it opens from
        this share. Also, the client may satisfy the file requests from its
        local cache. The share is configured to allow automatic caching of
        programs and documents.

     -  ``auto`` — the client may cache every file that it opens from this
        share. The share is configured to allow automatic caching of
        documents.

   When creating NFS shares, the following HPE 3PAR extra-specs are used:

   ``hpe3par:nfs_options``
     Comma separated list of NFS export options.

     The NFS export options have the following limitations:

     ``ro`` and ``rw`` are not allowed (will be determined by the driver)

     ``no_subtree_check`` and ``fsid`` are not allowed per HPE 3PAR CLI
     support

     ``(in)secure`` and ``(no_)root_squash`` are not allowed because the HPE
     3PAR driver controls those settings

     All other NFS options are forwarded to the HPE 3PAR as part of share
     creation. The HPE 3PAR performs additional validation at share creation
     time. For details, see the HPE 3PAR CLI help.


Implementation characteristics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Shares from snapshots


   -  When a share is created from a snapshot, the share must be deleted
      before the snapshot can be deleted. This is enforced by the driver.

   -  A snapshot of an empty share will appear to work correctly, but
      attempting to create a share from an empty share snapshot may fail with
      an ``NFS Create export`` error.

   -  HPE 3PAR File Persona snapshots are for an entire File Store. In Manila,
      they appear as snapshots of shares. A share sub-directory is used to
      give the appearance of a share snapshot when using ``create share from
      snapshot`` .

-  Snapshots

   -  For HPE 3PAR File Persona, snapshots are per File Store and not per
      share. So, the HPE 3PAR limit of 1024 snapshots per File Store results
      in a Manila limit of 1024 snapshots per tenant on each back end FPG.

   -  Before deleting a share, you must delete its snapshots. This is enforced
      by Manila. For HPE 3PAR File Persona, this also kicks off a snapshot
      reclamation.

-  Size enforcement

   Manila users create shares with size limits. HPE 3PAR enforces size limits
   by using File Store quotas. When using ``hpe3par_fstore_per_share``=
   ``True``(the non-default setting) there is only one share per File Store,
   so the size enforcement acts as expected. When using
   ``hpe3par_fstore_per_share`` = ``False`` (the default), the HPE 3PAR Manila
   driver uses one File Store for multiple shares. In this case, the size of
   the File Store limit is set to the cumulative limit of its Manila share
   sizes. This can allow one tenant share to exceed the limit and affect the
   space available for the same tenant’s other shares. One tenant cannot use
   another tenant’s File Store.


-  File removal

   When shares are removed and the ``hpe3par_fstore_per_share``=``False``
   setting is used (the default), files may be left behind in the File Store.
   Prior to Mitaka, removal of obsolete share directories and files that have
   been stranded would require tools outside of OpenStack/Manila. In Mitaka
   and later, the driver mounts the File Store to remove the deleted share’s
   subdirectory and files. For SMB/CIFS share, it requires the
   ``hpe3par_cifs_admin_access_username`` and
   ``hpe3par_cifs_admin_access_password`` configuration. If the mount and
   delete cannot be performed, an error is logged and the share is deleted
   in Manila. Due to the potential space held by leftover files, File Store
   quotas are not reduced when shares are removed.


-  Multi-tenancy

   -  Network

      The ``driver_handles_share_servers`` configuration setting determines
      whether share networks are supported. When
      ``driver_handles_share_servers`` is set to ``True``, a share network is
      required to create a share. The administrator creates share networks
      with the desired network, subnet, IP range, and segmentation ID. The HPE
      3PAR is configured with an FSIP using the same subnet and
      segmentation ID and an IP address allocated from the neutron network.
      Using share network-specific IP addresses, subnets, and segmentation IDs
      give the appearance of better tenant isolation. Shares on an FPG,
      however, are accessible via any of the FSIPs (subject to access rules).
      Back end filtering should be used for further separation.

   -  Back end filtering

      A Manila HPE 3PAR back end configuration refers to a specific array and
      a specific FPG. With multiple backends and multiple tenants, the
      scheduler determines where shares will be created. In a scenario where
      an array or back end needs to be restricted to one or more specific
      tenants, share types can be used to influence the selection of a
      back end. For more information on using share types,
      see `Share types`_ .

   -  Tenant limit

      The HPE 3PAR driver uses one File Store per tenant per protocol in each
      configured FPG. When only one back end is configured, this results in a
      limit of eight tenants (16 if only using one protocol). Use multiple
      back end configurations to introduce additional FPGs on the same array
      to increase the tenant limit.

      When using share networks, an FSIP is created for each share network
      (when its first share is created on the back end). The HPE 3PAR supports
      4 FSIPs per FPG (VFS). One of those 4 FSIPs is reserved for the initial
      VFS IP, so the share network limit is 48 share networks per node pair.
