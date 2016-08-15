==========================
Choosing storage back ends
==========================

Users indicate different needs for their cloud use cases. Some may
need fast access to many objects that do not change often, or want to
set a time-to-live (TTL) value on a file. Others may access only storage
that is mounted with the file system itself, but want it to be
replicated instantly when starting a new instance. For other systems,
ephemeral storage is the preferred choice. When you select
:term:`storage back ends <storage back end>`,
consider the following questions from user's perspective:

* Do my users need Block Storage?
* Do my users need Object Storage?
* Do I need to support live migration?
* Should my persistent storage drives be contained in my Compute nodes,
  or should I use external storage?
* What is the platter count I can achieve? Do more spindles result in
  better I/O despite network access?
* Which one results in the best cost-performance scenario I am aiming for?
* How do I manage the storage operationally?
* How redundant and distributed is the storage? What happens if a
  storage node fails? To what extent can it mitigate my data-loss
  disaster scenarios?

To deploy your storage by using only commodity hardware, you can use a number
of open-source packages, as shown in :ref:`table_persistent_file_storage`.

.. _table_persistent_file_storage:

.. list-table:: Table. Persistent file-based storage support
   :widths: 25 25 25 25
   :header-rows: 1

   * -
     - Object
     - Block
     - File-level
   * - Swift
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     -
     -
   * - LVM
     -
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Ceph
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - Experimental
   * - Gluster
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
   * - NFS
     -
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
   * - ZFS
     -
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Sheepdog
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: ../figures/Check_mark_23x20_02.png
          :width: 30%
     -

Open source file-level shared storage solutions are available, such as
MooseFS. Your organization may already have deployed a file-level
shared storage solution that you can use.

.. note::

   **Storage Driver Support**

   In addition to the open source technologies, there are a number of
   proprietary solutions that are officially supported by OpenStack Block
   Storage. You can find a matrix of the functionality provided by all of the
   supported Block Storage drivers on the `OpenStack
   wiki <https://wiki.openstack.org/wiki/CinderSupportMatrix>`_.

You should also decide whether you want to support Object Storage in
your cloud. The two common use cases for providing Object Storage in a
Compute cloud are:

* To provide users with a persistent storage mechanism
* As a scalable, reliable data store for virtual machine images

Commodity storage back-end technologies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section provides a high-level overview of the differences among the
different commodity storage back end technologies. Depending on your
cloud user's needs, you can implement one or many of these technologies
in different combinations:

OpenStack Object Storage (swift)
 The official OpenStack Object Store implementation. It is a mature
 technology that has been used for several years in production by
 Rackspace as the technology behind Rackspace Cloud Files. As it is
 highly scalable, it is well-suited to managing petabytes of storage.
 OpenStack Object Storage's advantages are better integration with
 OpenStack (integrates with OpenStack Identity, works with the
 OpenStack Dashboard interface) and better support for multiple data
 center deployment through support of asynchronous eventual
 consistency replication.

 If you  plan on distributing your storage
 cluster across multiple data centers, if you need unified accounts
 for your users for both compute and object storage, or if you want
 to control your object storage with the OpenStack dashboard, you
 should consider OpenStack Object Storage. More detail can be found
 about OpenStack Object Storage in the section below.

Ceph
 A scalable storage solution that replicates data across commodity
 storage nodes.

 Ceph was designed to expose different types of storage interfaces to
 the end user: it supports Object Storage, Block Storage, and
 file-system interfaces, although the file-system interface is not
 production-ready. Ceph supports the same API as swift
 for Object Storage and can be used as a back end for Block
 Storage, as well as back-end storage for glance images. Ceph supports
 "thin provisioning," implemented using copy-on-write.

 This can be useful when booting from volume because a new volume can
 be provisioned very quickly. Ceph also supports keystone-based
 authentication (as of version 0.56), so it can be a seamless swap in
 for the default OpenStack swift implementation.

 Ceph's advantages are that it gives the administrator more
 fine-grained control over data distribution and replication
 strategies, enables you to consolidate your Object and Block
 Storage, enables very fast provisioning of boot-from-volume
 instances using thin provisioning, and supports a distributed
 file-system interface, though this interface is `not yet
 recommended <http://ceph.com/docs/master/cephfs/>`_ for use in
 production deployment by the Ceph project.

 If you want to manage your Object and Block Storage within a single
 system, or if you want to support fast boot-from-volume, you should
 consider Ceph.

Gluster
 A distributed, shared file system. As of Gluster version 3.3, you
 can use Gluster to consolidate your object storage and file storage
 into one unified file and Object Storage solution, which is called
 Gluster For OpenStack (GFO). GFO uses a customized version of swift
 that enables Gluster to be used as the back-end storage.

 The main reason to use GFO rather than swift is if you also
 want to support a distributed file system, either to support shared
 storage live migration or to provide it as a separate service to
 your end users. If you want to manage your object and file storage
 within a single system, you should consider GFO.

LVM
 The Logical Volume Manager is a Linux-based system that provides an
 abstraction layer on top of physical disks to expose logical volumes
 to the operating system. The LVM back-end implements block storage
 as LVM logical partitions.

 On each host that that houses Block Storage, an administrator must
 initially create a volume group dedicated to Block Storage volumes.
 Blocks are created from LVM logical volumes.

 .. note::

    LVM does *not* provide any replication. Typically,
    administrators configure RAID on nodes that use LVM as block
    storage to protect against failures of individual hard drives.
    However, RAID does not protect against a failure of the entire
    host.

ZFS
 The Solaris iSCSI driver for OpenStack Block Storage implements
 blocks as ZFS entities. ZFS is a file system that also has the
 functionality of a volume manager. This is unlike on a Linux system,
 where there is a separation of volume manager (LVM) and file system
 (such as, ext3, ext4, xfs, and btrfs). ZFS has a number of
 advantages over ext4, including improved data-integrity checking.

 The ZFS back end for OpenStack Block Storage supports only
 Solaris-based systems, such as Illumos. While there is a Linux port
 of ZFS, it is not included in any of the standard Linux
 distributions, and it has not been tested with OpenStack Block
 Storage. As with LVM, ZFS does not provide replication across hosts
 on its own; you need to add a replication solution on top of ZFS if
 your cloud needs to be able to handle storage-node failures.

 We don't recommend ZFS unless you have previous experience with
 deploying it, since the ZFS back end for Block Storage requires a
 Solaris-based operating system, and we assume that your experience
 is primarily with Linux-based systems.

Sheepdog
 Sheepdog is a userspace distributed storage system. Sheepdog scales
 to several hundred nodes, and has powerful virtual disk management
 features like snapshot, cloning, rollback, thin provisioning.

 It is essentially an object storage system that manages disks and
 aggregates the space and performance of disks linearly in hyper
 scale on commodity hardware in a smart way. On top of its object
 store, Sheepdog provides elastic volume service and http service.
 Sheepdog does not assume anything about kernel version and can work
 nicely with xattr-supported file systems.

 .. TODO Add summary of when Sheepdog is recommended
