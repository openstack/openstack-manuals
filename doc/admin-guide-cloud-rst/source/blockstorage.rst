.. _block_storage:

=============
Block Storage
=============

The OpenStack Block Storage service works through the interaction of
a series of daemon processes named ``cinder-*`` that reside
persistently on the host machine or machines. The binaries can all be
run from a single node, or spread across multiple nodes. They can
also be run on the same node as other OpenStack services.

To administer the OpenStack Block Storage service, it is helpful to
understand a number of concepts. You must make certain choices when
you configure the Block Storage service in OpenStack. The bulk of the
options come down to two choices, single node or multi-node install.
You can read a longer discussion about `Storage Decisions`_ in the
`OpenStack Operations Guide`_.

OpenStack Block Storage enables you to add extra block-level storage
to your OpenStack Compute instances. This service is similar to the
Amazon EC2 Elastic Block Storage (EBS) offering.

.. toctree::
   :maxdepth: 1

   blockstorage-api-throughput.rst
   blockstorage-manage-volumes.rst
   blockstorage-troubleshoot.rst

.. _`Storage Decisions`: http://docs.openstack.org/openstack-ops/content/storage_decision.html
.. _`OpenStack Operations Guide`: http://docs.openstack.org/ops/

.. include:: blockstorage_nfs_backend.rst
.. include:: blockstorage_glusterfs_backend.rst
.. include:: blockstorage_multi_backend.rst
.. include:: blockstorage_backup_disks.rst

.. toctree::
   :hidden:

   blockstorage_nfs_backend.rst
   blockstorage_glusterfs_backend.rst
   blockstorage_multi_backend.rst
   blockstorage_backup_disks.rst

.. TODO (MZ) Convert and include the following sections
   include: blockstorage/section_volume-migration.xml
   include: blockstorage/section_glusterfs_removal.xml
   include: blockstorage/section_volume-backups.xml
   include: blockstorage/section_volume-backups-export-import.xml

Use LIO iSCSI support
---------------------

The default mode for the ``iscsi_helper`` tool is ``tgtadm``.
To use LIO iSCSI, install the ``python-rtslib`` package, and set
``iscsi_helper=lioadm`` in the :file:`cinder.conf` file.

Once configured, you can use the :command:`cinder-rtstool` command to
manage the volumes. This command enables you to create, delete, and
verify volumes and determine targets and add iSCSI initiators to the
system.

.. TODO (MZ) Convert and include the following sections
   include: blockstorage/section_consistency_groups.xml
   include: blockstorage/section_driver_filter_weighing.xml
   include: blockstorage/section_ratelimit-volume-copy-bandwidth.xml
   include: blockstorage/section_over_subscription.xml
