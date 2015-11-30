================
GlusterFS driver
================

GlusterFS driver uses GlusterFS, an open source distributed file system,
as the storage back end for serving file shares to the Shared File
Systems clients.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports NFS shares.

The following operations are supported:

-  Create a share.

-  Delete a share.

-  Allow share access.

   Note the following limitations:

   - Only IP access type is supported

   - Only read-write access is supported.

-  Deny share access.

Requirements
~~~~~~~~~~~~

-  Install glusterfs-server package, version >= 3.5.x, on the storage
   back end.

-  Install NFS-Ganesha, version >=2.1, if using NFS-Ganesha as the NFS
   server for the GlusterFS back end.

-  Install glusterfs and glusterfs-fuse package, version >=3.5.x, on the
   Shared File Systems service host.

-  Establish network connection between the Shared File Systems service
   host and the storage back end.

Shared File Systems service driver configuration setting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following parameters in the Shared File Systems service's
configuration file need to be set:

-  ``share_driver = manila.share.drivers.glusterfs.GlusterfsShareDriver``

-  If the back-end GlusterFS server runs on the Shared File Systems
   service host machine,

   -  ``glusterfs_target = <glustervolserver>:/<glustervolid>``

   And if the back-end GlusterFS server runs remotely,

   -  ``glusterfs_target = <username>@<glustervolserver>:/<glustervolid>``

The following configuration parameters are optional:

-  glusterfs_nfs_server_type =
       <NFS server type used by the GlusterFS back end, Gluster or
       Ganesha. Gluster is the default type>

-  glusterfs_mount_point_base =
       <base path of GlusterFS volume mounted on the Shared File Systems
       service host>

-  ``glusterfs_path_to_private_key = <path to Shared File Systems
   service host's private key file>``

-  ``glusterfs_server_password = <password of remote GlusterFS server
   machine>``

Known restrictions
~~~~~~~~~~~~~~~~~~

-  The driver does not support network segmented multi-tenancy model,
   but instead works over a flat network, where the tenants share a
   network.

-  If NFS Ganesha is the NFS server used by the GlusterFS back end, then
   the shares can be accessed by NFSv3 and v4 protocols. However, if
   Gluster NFS is used by the GlusterFS back end, then the shares can
   only be accessed by NFSv3 protocol.

-  All Shared File Systems service shares, which map to subdirectories
   within a GlusterFS volume, are currently created within a single
   GlusterFS volume of a GlusterFS storage pool.

-  The driver does not provide read-only access level for shares.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-glusterfs.rst
