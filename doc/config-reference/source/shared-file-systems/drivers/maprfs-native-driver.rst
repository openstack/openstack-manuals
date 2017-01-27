====================
MapRFS native driver
====================

MapR-FS native driver is a plug-in based on the Shared File Systems service
and provides high-throughput access to the data on MapR-FS distributed file
system, which is designed to hold very large amounts of data.

A Shared File Systems service share in this driver is a volume in MapR-FS.
Instances talk directly to the MapR-FS storage backend via the (mapr-posix)
client. To mount a MapR-FS volume, the MapR POSIX client is required.
Access to each share is allowed by user and group based access type, which is
aligned with MapR-FS ACEs to support access control for multiple users and
groups. If user name and group name are the same, the group access type will
be used by default.

For more details, see `MapR documentation <http://maprdocs.mapr.com/>`_.

Network configuration
~~~~~~~~~~~~~~~~~~~~~

The storage backend and Shared File Systems service hosts should be in a flat
network. Otherwise, the L3 connectivity between them should exist.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports MapR-FS shares.

The following operations are supported:

- Create MapR-FS share.
- Delete MapR-FS share.
- Allow MapR-FS Share access.

  - Only support user and group access type.
  - Support level of access (ro/rw).

- Deny MapR-FS Share access.
- Update MapR-FS Share access.
- Create snapshot.
- Delete snapshot.
- Create share from snapshot.
- Extend share.
- Shrink share.
- Manage share.
- Unmanage share.
- Manage snapshot.
- Unmanage snapshot.
- Ensure share.

Requirements
~~~~~~~~~~~~

-  Install MapR core packages, version >= 5.2.x, on the storage backend.

-  To enable snapshots, the MapR cluster should have at least M5 license.

-  Establish network connection between the Shared File Systems service hosts
   and storage backend.

-  Obtain a `ticket <http://maprdocs.mapr.com/home/SecurityGuide/Tickets.html>`_
   for user who will be used to access MapR-FS.

Back end configuration (manila.conf)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add MapR-FS protocol to ``enabled_share_protocols``:

.. code-block:: ini

    enabled_share_protocols = MAPRFS

Create a section for MapR-FS backend. Example:

.. code-block:: ini

    [maprfs]
    driver_handles_share_servers = False
    share_driver =
    manila.share.drivers.maprfs.maprfs_native.MapRFSNativeShareDriver
    maprfs_clinode_ip = example
    maprfs_ssh_name = mapr
    maprfs_ssh_pw = mapr
    share_backend_name = maprfs

Set ``driver-handles-share-servers`` to ``False`` as the driver does not
manage the lifecycle of ``share-servers``.

Add driver backend to ``enabled_share_backends``:

.. code-block:: ini

    enabled_share_backends = maprfs

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to this
driver.

.. include:: ../../tables/manila-maprfs.rst

Known restrictions
~~~~~~~~~~~~~~~~~~

This driver does not handle user authentication, no tickets or users are
created by this driver. This means that when 'access_allow' or
'update_access' is calling, this will have no effect without providing
tickets to users.


Share metadata
~~~~~~~~~~~~~~

MapR-FS shares can be created by specifying additional options. Metadata is
used for this purpose. Every metadata option with ``-`` prefix is passed to
MapR-FS volume. For example, to specify advisory volume quota add
``_advisoryquota=10G`` option to metadata:

.. code-block:: console

    $ manila create MAPRFS 1 --metadata _advisoryquota=10G

If you need to create a share with your custom backend name or export location
instead if uuid, you can specify ``_name`` and ``_path`` options:

.. code-block:: console

    $ manila create MAPRFS 1 --metadata _name=example _path=/example

.. WARNING::
   Specifying invalid options will cause an error.

The list of allowed options depends on mapr-core version.
See `volume create <http://maprdocs.mapr.com/home/ReferenceGuide/volume-create.html>`_
for more information.
