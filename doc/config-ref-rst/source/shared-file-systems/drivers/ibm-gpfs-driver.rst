===============
IBM GPFS driver
===============

GPFS driver uses IBM General Parallel File System (GPFS), a
high-performance, clustered file system, developed by IBM, as the
storage back end for serving file shares to the Shared File Systems
service clients.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported.

  - Only read-write access level is supported.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

Requirements
~~~~~~~~~~~~

-  Install GPFS with server license, version >= 2.0, on the storage back
   end.

-  Install Kernel NFS or Ganesha NFS server on the storage back-end
   servers.

-  If using Ganesha NFS, currently NFS Ganesha v1.5 and v2.0 are
   supported.

-  Create a GPFS cluster and create a filesystem on the cluster, that
   will be used to create the Shared File Systems service shares.

-  Enable quotas for the GPFS file system (mmchfs -Q yes).

-  Establish network connection between the Shared File Systems Service
   host and the storage back end.

Shared File Systems service driver configuration setting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following parameters in the Shared File Systems service
configuration file need to be set:

-  share_driver = manila.share.drivers.ibm.gpfs.GPFSShareDriver

-  gpfs_share_export_ip = <IP to be added to GPFS export string>

-  If the back-end GPFS server is not running on the Shared File Systems
   service host machine, the following options are required to SSH to
   the remote GPFS back-end server:

   -  gpfs_ssh_login = <GPFS server SSH login name>

      and one of the following settings is required to execute commands
      over SSH:

   -  gpfs_ssh_private_key = <path to GPFS server SSH private key for
      login>

   -  gpfs_ssh_password = <GPFS server SSH login password>

The following configuration parameters are optional:

-  gpfs_mount_point_base = <base folder where exported shares are
   located>

-  gpfs_nfs_server_type = <KNFS\|GNFS>

-  gpfs_nfs_server_list = <list of the fully qualified NFS server
   names>

-  gpfs_ssh_port = <ssh port number>

-  knfs_export_options = <options to use when creating a share using
   kernel> <NFS server>

Restart of manila-share service is needed for the configuration changes
to take effect.

Known restrictions
~~~~~~~~~~~~~~~~~~

-  The driver does not support a segmented-network multi-tenancy model
   but instead works over a flat network where the tenants share a
   network.

-  While using remote GPFS node, with Ganesha NFS,
   'gpfs_ssh_private_key' for remote login to the GPFS node must be
   specified and there must be a passwordless authentication already
   setup between the manila-share service and the remote GPFS node.

Driver configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration options specific to this driver are documented here:

.. include:: ../../tables/manila-gpfs.rst
