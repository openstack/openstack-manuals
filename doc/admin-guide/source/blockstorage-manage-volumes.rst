==============
Manage volumes
==============

The default OpenStack Block Storage service implementation is an
iSCSI solution that uses :term:`Logical Volume Manager (LVM)` for Linux.

.. note::

   The OpenStack Block Storage service is not a shared storage
   solution like a Network Attached Storage (NAS) of NFS volumes,
   where you can attach a volume to multiple servers. With the
   OpenStack Block Storage service, you can attach a volume to only
   one instance at a time.

   The OpenStack Block Storage service also provides drivers that
   enable you to use several vendors' back-end storage devices, in
   addition to or instead of the base LVM implementation.

This high-level procedure shows you how to create and attach a volume
to a server instance.

**To create and attach a volume to an instance**

#. Configure the OpenStack Compute and the OpenStack Block Storage
   services through the ``cinder.conf`` file.
#. Use the :command:`cinder create` command to create a volume. This
   command creates an LV into the volume group (VG) ``cinder-volumes``.
#. Use the nova :command:`volume-attach` command to attach the volume
   to an instance. This command creates a unique  :term:`IQN` that is
   exposed to the compute node.

   * The compute node, which runs the instance, now has an active
     iSCSI session and new local storage (usually a ``/dev/sdX``
     disk).
   * Libvirt uses that local storage as storage for the instance. The
     instance gets a new disk (usually a ``/dev/vdX`` disk).

For this particular walk through, one cloud controller runs
``nova-api``, ``nova-scheduler``, ``nova-objectstore``,
``nova-network`` and ``cinder-*`` services. Two additional compute
nodes run ``nova-compute``. The walk through uses a custom
partitioning scheme that carves out 60 GB of space and labels it as
LVM. The network uses the ``FlatManager`` and ``NetworkManager``
settings for OpenStack Compute.

The network mode does not interfere with OpenStack Block Storage
operations, but you must set up networking for Block Storage to work.
For details, see :ref:`networking`.

To set up Compute to use volumes, ensure that Block Storage is
installed along with ``lvm2``. This guide describes how to
troubleshoot your installation and back up your Compute volumes.

.. toctree::

   blockstorage-boot-from-volume.rst
   blockstorage_nfs_backend.rst
   blockstorage_glusterfs_backend.rst
   blockstorage_multi_backend.rst
   blockstorage_backup_disks.rst
   blockstorage_volume_migration.rst
   blockstorage_glusterfs_removal.rst
   blockstorage_volume_backups.rst
   blockstorage_volume_backups_export_import.rst
   blockstorage-lio-iscsi-support.rst
   blockstorage_volume_number_weigher.rst
   blockstorage-consistency-groups.rst
   blockstorage-driver-filter-weighing.rst
   blockstorage_ratelimit_volume_copy_bandwidth.rst
   blockstorage_over_subscription.rst
   blockstorage_image_volume_cache.rst
   blockstorage_volume_backed_image.rst
   blockstorage_get_capabilities.rst
