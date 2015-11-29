===============
HPE 3PAR driver
===============

The HPE 3PAR driver provides NFS and CIFS shared file systems to
OpenStack using HPE 3PAR's File Persona capabilities.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations for NFS shares:

  - Only IP access type is supported.

  - Access level (read-write or read-only) is ignored.

  - Shares created from snapshots are always read-only.

  - Shares not created from snapshots are read-write and subject to
    ACLs.

  Note the following limitations for CIFS shares:

  - Both IP and user access rules are required for CIFS share access.

  - User access requires a 3PAR local user, since LDAP and AD is not yet
    supported.

  - Access level (read-write or read-only) is ignored.

  - Shares created from snapshots are always read-only.

  - Shares not created from snapshots are read-write (and subject to
    ACLs).

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

  Note the following limitations for shares:

  - Shares created from snapshots are always read-only.

- Extend a share.

- Shrink a share.

Share networks are not supported. Shares are created directly on the
3PAR without the use of a share server or service VM. Network
connectivity is setup outside of the Shared File Systems service.

Requirements
~~~~~~~~~~~~

On the system running the manila-share service:

-  python-3parclient version 4.0.0 or newer from PyPI.

On the HPE 3PAR array:

-  HPE 3PAR Operating System software version 3.2.1 MU3 or higher.

-  A license that enables the File Persona feature.

-  The array class and hardware configuration must support File.

Pre-configuration on the HPE 3PAR
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  HPE 3PAR File Persona must be initialized and started (startfs).

-  A File Provisioning Group (FPG) must be created for use with the
   Shared File Systems service.

-  A Virtual File Server (VFS) must be created for the FPG.

-  The VFS must be configured with an appropriate share export IP
   address.

-  A local user in the Administrators group is needed for CIFS shares.

Backend configuration
~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the Shared File
Systems service configuration file for the HPE 3PAR driver:

-  share_backend_name = <back end name to enable>

-  share_driver =
   manila.share.drivers.hpe.hpe_3par_driver.HPE3ParShareDriver

-  driver_handles_share_servers = False

-  hpe3par_fpg = <FPG to use for share creation>

-  hpe3par_share_ip_address = <IP address to use for share export
   location>

-  hpe3par_san_ip = <IP address for SSH access to the SAN controller>

-  hpe3par_api_url = <3PAR WS API Server URL>

-  hpe3par_username = <3PAR username with the 'edit' role>

-  hpe3par_password = <3PAR password for the user specified in
   hpe3par_username>

-  hpe3par_san_login = <Username for SSH access to the SAN controller>

-  hpe3par_san_password = <Password for SSH access to the SAN
   controller>

-  hpe3par_debug = <False or True for extra debug logging>

The hpe3par_share_ip_address must be a valid IP address for the
configured FPG's VFS. This IP address is used in export locations for
shares that are created. Networking must be configured to allow
connectivity from clients to shares.

Restart of manila-share service is needed for the configuration changes
to take effect.

Network approach
~~~~~~~~~~~~~~~~

Connectivity between the storage array (SSH/CLI and WSAPI) and the
Shared File Systems service host is required for share management.

Connectivity between the clients and the VFS is required for mounting
and using the shares. This includes:

-  Routing from the client to the external network

-  Assigning the client an external IP address (e.g., a floating IP)

-  Configuring the Shared File Systems service host networking properly
   for IP forwarding

-  Configuring the VFS networking properly for client subnets

Share types
~~~~~~~~~~~

When creating a share, a share type can be specified to determine where
and how the share will be created. If a share type is not specified, the
default_share_type set in the Shared File Systems service
configuration file is used.

The Shared File Systems service requires that the share type includes
the driver_handles_share_servers extra-spec. This ensures that the
share will be created on a back end that supports the requested
driver_handles_share_servers (share networks) capability. For the HPE
3PAR driver, this must be set to False.

Another common Shared File Systems service extra-spec used to determine
where a share is created is share_backend_name. When this extra-spec
is defined in the share type, the share will be created on a back end
with a matching share_backend_name.

The HPE 3PAR driver automatically reports capabilities based on the FPG
used for each back end. Share types with extra specs can be created by
an administrator to control which share types are allowed to use FPGs
with or without specific capabilities. The following extra-specs are
used with the capabilities filter and the HPE 3PAR driver:

-  hpe3par_flash_cache = '<is> True' or '<is> False'

-  thin_provisioning = '<is> True' or '<is> False'

-  dedupe = '<is> True' or '<is> False'

hpe3par_flash_cache will be reported as True for back ends that have
3PAR's Adaptive Flash Cache enabled.

thin_provisioning will be reported as True for back ends that use thin
provisioned volumes. FPGs that use fully provisioned volumes will report
False. Backends that use thin provisioning also support the Shared File
Systems service's over-subscription feature.

dedupe will be reported as True for back ends that use deduplication
technology.

Scoped extra-specs are used to influence vendor-specific implementation
details. Scoped extra-specs use a prefix followed by a colon. For HPE
3PAR these extra-specs have a prefix of hpe3par.

The following HPE 3PAR extra-specs are used when creating CIFS (SMB)
shares:

-  hpe3par:smb_access_based_enum = true or false

-  hpe3par:smb_continuous_avail = true or false

-  hpe3par:smb_cache = off, manual, optimized or auto

smb_access_based_enum (Access Based Enumeration) specifies if users
can see only the files and directories to which they have been allowed
access on the shares. The default is false.

smb_continuous_avail (Continuous Availability) specifies if SMB3
continuous availability features should be enabled for this share. If
not specified, the default is true.

smb_cache specifies client-side caching for offline files. Valid values
are:

-  \`off\`: The client must not cache any files from this share. The
   share is configured to disallow caching.

-  \`manual\`: The client must allow only manual caching for the files
   open from this share.

-  \`optimized\`: The client may cache every file that it opens from
   this share. Also, the client may satisfy the file requests from its
   local cache. The share is configured to allow automatic caching of
   programs and documents.

-  \`auto\`: The client may cache every file that it opens from this
   share. The share is configured to allow automatic caching of
   documents.

-  If this is not specified, the default is manual.

The following HPE 3PAR extra-specs are used when creating NFS shares:

-  hpe3par:nfs_options = Comma separated list of NFS export options.

The NFS export options have the following limitations:

-  ro and rw are not allowed (will be determined by the driver).

-  no_subtree_check and fsid are not allowed per HPE 3PAR CLI support.

-  (in)secure and (no\_)root_squash are not allowed because the HPE
   3PAR driver controls those settings.

All other NFS options are forwarded to the HPE 3PAR as part of share
creation. The HPE 3PAR will do additional validation at share creation
time. Refer to HPE 3PAR CLI help for more details.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-hpe3par.rst
