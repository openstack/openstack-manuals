.. _block_storage:

=============
Block Storage
=============

The OpenStack Block Storage service works through the interaction of
a series of daemon processes named ``cinder-*`` that reside
persistently on the host machine or machines. The binaries can all be
run from a single node, or spread across multiple nodes. They can
also be run on the same node as other OpenStack services.

Introduction to Block Storage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To administer the OpenStack Block Storage service, it is helpful to
understand a number of concepts. You must make certain choices when
you configure the Block Storage service in OpenStack. The bulk of the
options come down to two choices, single node or multi-node install.
You can read a longer discussion about storage decisions in
`Storage Decisions`_ in the *OpenStack Operations Guide*.

OpenStack Block Storage enables you to add extra block-level storage
to your OpenStack Compute instances. This service is similar to the
Amazon EC2 Elastic Block Storage (EBS) offering.

.. TODO (MZ) Convert and include the following section:
  include: blockstorage/section_increase-api-throughput.xml

Manage volumes
~~~~~~~~~~~~~~

The default OpenStack Block Storage service implementation is an
iSCSI solution that uses Logical Volume Manager (LVM) for Linux.

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
   services through the :file:`cinder.conf` file.
#. Use the :command:`cinder create` command to create a volume. This
   command creates an LV into the volume group (VG) ``cinder-volumes``.
#. Use the nova :command:`volume-attach` command to attach the volume
   to an instance. This command creates a unique iSCSI IQN that is
   exposed to the compute node.

   * The compute node, which runs the instance, now has an active
     iSCSI session and new local storage (usually a :file:`/dev/sdX`
     disk).
   * Libvirt uses that local storage as storage for the instance. The
     instance gets a new disk (usually a :file:`/dev/vdX` disk).

For this particular walk through, one cloud controller runs
``nova-api``, ``nova-scheduler``, ``nova-objectstore``,
``nova-network`` and ``cinder-*`` services. Two additional compute
nodes run ``nova-compute``. The walk through uses a custom
partitioning scheme that carves out 60 GB of space and labels it as
LVM. The network uses the ``FlatManager`` and ``NetworkManager``
settings for OpenStack Compute.

The network mode does not interfere with OpenStack Block Storage
operations, but you must set up networking for Block Storage to work.
For details, see Chapter 7, Networking.

.. TODO (MZ) Add ch_networking as a reference to the sentence above.

To set up Compute to use volumes, ensure that Block Storage is
installed along with ``lvm2``. This guide describes how to
troubleshoot your installation and back up your Compute volumes.

Boot from volume
~~~~~~~~~~~~~~~~

In some cases, you can store and run instances from inside volumes.
For information, see the `Launch an instance from a volume`_ section
in the `OpenStack End User Guide`_.

.. Links
.. _`Storage Decisions`: http://docs.openstack.org/openstack-ops/content/storage_decision.html
.. _`Launch an instance from a volume`: http://docs.openstack.org/user-guide/cli_nova_launch_instance_from_volume.html
.. _`OpenStack End User Guide`: http://docs.openstack.org/user-guide/

.. TODO (MZ) Convert and include the following sections
  include: blockstorage/section_nfs_backend.xml
  include: blockstorage/section_glusterfs_backend.xml
  include: blockstorage/section_multi_backend.xml
  include: blockstorage/section_backup-block-storage-disks.xml
  include: blockstorage/section_volume-migration.xml
  include: blockstorage/section_glusterfs_removal.xml
  include: blockstorage/section_volume-backups.xml
  include: blockstorage/section_volume-backups-export-import.xml

Use LIO iSCSI support
~~~~~~~~~~~~~~~~~~~~~

The default :option:`iscsi_helper` tool is ``tgtadm``. To use LIO
iSCSI, install the ``python-rtslib`` package, and set
``iscsi_helper=lioadm`` in the :file:`cinder.conf` file.

Once configured, you can use the :command:`cinder-rtstool` command to
manage the volumes. This command enables you to create, delete, and
verify volumes and determine targets and add iSCSI initiators to the
system.

.. TODO (MZ) Convert and include the following sections
  include: blockstorage/section_volume_number_weighter.xml
  include: blockstorage/section_consistency_groups.xml
  include: blockstorage/section_driver_filter_weighing.xml
  include: blockstorage/section_ratelimit-volume-copy-bandwidth.xml
  include: blockstorage/section_over_subscription.xml

Troubleshoot your installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section provides useful tips to help you troubleshoot your Block
Storage installation.

.. TODO (MZ) Convert and include the following sections
  include: blockstorage/section_ts_cinder_config.xml
  include: blockstorage/section_ts_multipath_warn.xml
  include: blockstorage/section_ts_eql_volume_size.xml
  include: blockstorage/section_ts_vol_attach_miss_sg_scan.xml
  include: blockstorage/section_ts_HTTP_bad_req_in_cinder_vol_log.xml
  include: blockstorage/section_ts_duplicate_3par_host.xml
  include: blockstorage/section_ts_failed_attach_vol_after_detach.xml
  include: blockstorage/section_ts_failed_attach_vol_no_sysfsutils.xml
  include: blockstorage/section_ts_failed_connect_vol_FC_SAN.xml
  include: blockstorage/section_ts_no_emulator_x86_64.xml
  include: blockstorage/section_ts_non_existent_host.xml
  include: blockstorage/section_ts_non_existent_vlun.xml
