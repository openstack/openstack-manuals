======================
IBM GPFS volume driver
======================

IBM General Parallel File System (GPFS) is a cluster file system that
provides concurrent access to file systems from multiple nodes. The
storage provided by these nodes can be direct attached, network
attached, SAN attached, or a combination of these methods. GPFS provides
many features beyond common data access, including data replication,
policy based storage management, and space efficient file snapshot and
clone operations.

How the GPFS driver works
~~~~~~~~~~~~~~~~~~~~~~~~~

The GPFS driver enables the use of GPFS in a fashion similar to that of
the NFS driver. With the GPFS driver, instances do not actually access a
storage device at the block level. Instead, volume backing files are
created in a GPFS file system and mapped to instances, which emulate a
block device.

.. note::

   GPFS software must be installed and running on nodes where Block
   Storage and Compute services run in the OpenStack environment. A
   GPFS file system must also be created and mounted on these nodes
   before starting the ``cinder-volume`` service. The details of these
   GPFS specific steps are covered in GPFS: Concepts, Planning, and
   Installation Guide and GPFS: Administration and Programming
   Reference.

Optionally, the Image service can be configured to store images on a
GPFS file system. When a Block Storage volume is created from an image,
if both image data and volume data reside in the same GPFS file system,
the data from image file is moved efficiently to the volume file using
copy-on-write optimization strategy.

Enable the GPFS driver
~~~~~~~~~~~~~~~~~~~~~~

To use the Block Storage service with the GPFS driver, first set the
``volume_driver`` in the ``cinder.conf`` file:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.ibm.gpfs.GPFSDriver

The following table contains the configuration options supported by the
GPFS driver.

.. note::

   The ``gpfs_images_share_mode`` flag is only valid if the Image
   Service is configured to use GPFS with the ``gpfs_images_dir`` flag.
   When the value of this flag is ``copy_on_write``, the paths
   specified by the ``gpfs_mount_point_base`` and ``gpfs_images_dir``
   flags must both reside in the same GPFS file system and in the same
   GPFS file set.

Volume creation options
~~~~~~~~~~~~~~~~~~~~~~~

It is possible to specify additional volume configuration options on a
per-volume basis by specifying volume metadata. The volume is created
using the specified options. Changing the metadata after the volume is
created has no effect. The following table lists the volume creation
options supported by the GPFS volume driver.

.. include:: ../../tables/cinder-storage_gpfs.rst

This example shows the creation of a 50GB volume with an ``ext4`` file
system labeled ``newfs`` and direct IO enabled:

.. code-block:: console

   $ cinder create --metadata fstype=ext4 fslabel=newfs dio=yes --display-name volume_1 50

Operational notes for GPFS driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Volume snapshots are implemented using the GPFS file clone feature.
Whenever a new snapshot is created, the snapshot file is efficiently
created as a read-only clone parent of the volume, and the volume file
uses copy-on-write optimization strategy to minimize data movement.

Similarly when a new volume is created from a snapshot or from an
existing volume, the same approach is taken. The same approach is also
used when a new volume is created from an Image service image, if the
source image is in raw format, and ``gpfs_images_share_mode`` is set to
``copy_on_write``.

The GPFS driver supports encrypted volume back end feature.
To encrypt a volume at rest, specify the extra specification
``gpfs_encryption_rest = True``.
