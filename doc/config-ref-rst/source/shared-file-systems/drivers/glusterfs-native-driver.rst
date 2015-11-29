=======================
GlusterFS Native driver
=======================

GlusterFS Native driver uses GlusterFS, an open source distributed file
system, as the storage back end for serving file shares to Shared File
Systems service clients.

A Shared File Systems service share is a GlusterFS volume. This driver
uses flat-network (share-server-less) model. Instances directly talk
with the GlusterFS back end storage pool. The instances use 'glusterfs'
protocol to mount the GlusterFS shares. Access to each share is allowed
via TLS Certificates. Only the instance which has the TLS trust
established with the GlusterFS back end can mount and hence use the
share. Currently only 'rw' access is supported.

Network approach
~~~~~~~~~~~~~~~~

L3 connectivity between the storage back end and the host running the
Shared File Systems share service should exist.

Multi-tenancy model
~~~~~~~~~~~~~~~~~~~

The driver does not support network segmented multi-tenancy model.
Instead multi-tenancy is supported using tenant specific TLS
certificates.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports GlusterFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only access by TLS Certificates (``cert`` access type) is supported.

  - Only read-write access is supported.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

Requirements
~~~~~~~~~~~~

-  Install glusterfs-server package, version >= 3.6.x, on the storage
   back end.

-  Install glusterfs and glusterfs-fuse package, version >=3.6.x, on the
   Shared File Systems service host.

-  Establish network connection between the Shared File Systems service
   host and the storage back end.

Shared File Systems service driver configuration setting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following parameters in the Shared File Systems service's
configuration file need to be set:

-  ``share_driver =
   manila.share.drivers.glusterfs_native.GlusterfsNativeShareDriver``

-  ``glusterfs_servers`` = List of GlusterFS servers which provide volumes
   that can be used to create shares. The servers are expected to be
   of distinct Gluster clusters (ie. should not be gluster peers).
   Each server should be of the form
   ``[<remoteuser>@]<glustervolserver>``.

   The optional ``<remoteuser>@`` part of the server URI indicates
   SSH access for cluster management (see related optional
   parameters below). If it is not given, direct command line
   management is performed (the Shared File Systems service host is
   assumed to be part of the GlusterFS cluster the server belongs
   to).

-  ``glusterfs_volume_pattern`` = Regular expression template
   used to filter GlusterFS volumes for share creation. The regex
   template can contain the #{size} parameter which matches a number
   (sequence of digits) and the value shall be interpreted as size
   of the volume in GB. Examples: ``manila-share-volume-\d+$``,
   ``manila-share-volume-#{size}G-\d+$``; with matching volume
   names, respectively: *manila-share-volume-12*,
   *manila-share-volume-3G-13*". In latter example, the number that
   matches ``#{size}``, that is, 3, is an indication that the size
   of volume is 3G.

The following configuration parameters are optional:

-  ``glusterfs_mount_point_base`` = <base path of GlusterFS volume
   mounted on the Shared File Systems service host>

-  ``glusterfs_path_to_private_key`` = <path to Shared File Systems
   service host's private key file>

-  ``glusterfs_server_password`` = <password of remote GlusterFS server
   machine>

-  GlusterFS volumes are not created on demand. A pre-existing set of
   GlusterFS volumes should be supplied by the GlusterFS cluster(s),
   conforming to the naming convention encoded by
   ``glusterfs_volume_pattern``. However, the GlusterFS endpoint is
   allowed to extend this set any time (so the Shared File Systems
   service and GlusterFS endpoints are expected to communicate volume
   supply/demand out-of-band). ``glusterfs_volume_pattern`` can include
   a size hint (with ``#{size}`` syntax), which, if present, requires
   the GlusterFS end to indicate the size of the shares in GB in the
   name. (On share creation, the Shared File Systems service picks
   volumes *at least* as big as the requested one.)

-  Certificate setup (also known as trust setup) between instance and
   storage back end is out of band of the Shared File Systems service.

-  Support for ``create_share_from_snapshot`` is planned for Liberty
   release.

-  For the Shared File Systems service to use GlusterFS volumes, the
   name of the trashcan directory in GlusterFS volumes must not be
   changed from the default.

Driver options
~~~~~~~~~~~~~~

Configuration options specific to this driver are documented here in
:ref:`manila-glusterfs`.
