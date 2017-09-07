================
Storage concepts
================

Storage is found in many parts of the OpenStack cloud environment. It is
important to understand the distinction between
:term:`ephemeral <ephemeral volume>` storage and
:term:`persistent <persistent volume>` storage:

- Ephemeral storage - If you only deploy OpenStack
  :term:`Compute service (nova)`, by default your users do not have access to
  any form of persistent storage. The disks associated with VMs are ephemeral,
  meaning that from the user's point of view they disappear when a virtual
  machine is terminated.

- Persistent storage - Persistent storage means that the storage resource
  outlives any other resource and is always available, regardless of the state
  of a running instance.

OpenStack clouds explicitly support three types of persistent
storage: *Object Storage*, *Block Storage*, and *File-based storage*.

Object storage
~~~~~~~~~~~~~~

Object storage is implemented in OpenStack by the
Object Storage service (swift). Users access binary objects through a REST API.
If your intended users need to archive or manage large datasets, you should
provide them with Object Storage service. Additional benefits include:

- OpenStack can store your virtual machine (VM) images inside of an Object
  Storage system, as an alternative to storing the images on a file system.
- Integration with OpenStack Identity, and works with the OpenStack Dashboard.
- Better support for distributed deployments across multiple datacenters
  through support for asynchronous eventual consistency replication.

You should consider using the OpenStack Object Storage service if you eventually
plan on distributing your storage cluster across multiple data centers, if you
need unified accounts for your users for both compute and object storage, or if
you want to control your object storage with the OpenStack Dashboard. For more
information, see the `Swift project page <https://www.openstack.org/software/releases/ocata/components/swift>`_.

Block storage
~~~~~~~~~~~~~

Block storage is implemented in OpenStack by the
Block Storage service (cinder). Because these volumes are
persistent, they can be detached from one instance and re-attached to another
instance and the data remains intact.

The Block Storage service supports multiple back ends in the form of drivers.
Your choice of a storage back end must be supported by a block storage
driver.

Most block storage drivers allow the instance to have direct access to
the underlying storage hardware's block device. This helps increase the
overall read/write IO. However, support for utilizing files as volumes
is also well established, with full support for NFS, GlusterFS and
others.

These drivers work a little differently than a traditional block
storage driver. On an NFS or GlusterFS file system, a single file is
created and then mapped as a virtual volume into the instance. This
mapping and translation is similar to how OpenStack utilizes QEMU's
file-based virtual machines stored in ``/var/lib/nova/instances``.

File-based storage
~~~~~~~~~~~~~~~~~~

In multi-tenant OpenStack cloud environment, the Shared File Systems service
(manila) provides a set of services for management of shared file systems. The
Shared File Systems service supports multiple back-ends in the form of drivers,
and can be configured to provision shares from one or more back-ends. Share
servers are virtual machines that export file shares using different file
system protocols such as NFS, CIFS, GlusterFS, or HDFS.

The Shared File Systems service is persistent storage and can be mounted to any
number of client machines. It can also be detached from one instance and
attached to another instance without data loss. During this process the data
are safe unless the Shared File Systems service itself is changed or removed.

Users interact with the Shared File Systems service by mounting remote file
systems on their instances with the following usage of those systems for
file storing and exchange. The Shared File Systems service provides shares
which is a remote, mountable file system. You can mount a share and access a
share from several hosts by several users at a time. With shares, you can also:

* Create a share specifying its size, shared file system protocol,
  visibility level.
* Create a share on either a share server or standalone, depending on
  the selected back-end mode, with or without using a share network.
* Specify access rules and security services for existing shares.
* Combine several shares in groups to keep data consistency inside the
  groups for the following safe group operations.
* Create a snapshot of a selected share or a share group for storing
  the existing shares consistently or creating new shares from that
  snapshot in a consistent way.
* Create a share from a snapshot.
* Set rate limits and quotas for specific shares and snapshots.
* View usage of share resources.
* Remove shares.

Differences between storage types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:ref:`table_openstack_storage` explains the differences between Openstack
storage types.

.. _table_openstack_storage:

.. list-table:: Table. OpenStack storage
   :widths: 20 20 20 20 20
   :header-rows: 1

   * -
     - Ephemeral storage
     - Block storage
     - Object storage
     - Shared File System storage
   * - Application
     - Run operating system and scratch space
     - Add additional persistent storage to a virtual machine (VM)
     - Store data, including VM images
     - Add additional persistent storage to a virtual machine
   * - Accessed through…
     - A file system
     - A block device that can be partitioned, formatted, and mounted
       (such as, /dev/vdc)
     - The REST API
     - A Shared File Systems service share (either manila managed or an
       external one registered in manila) that can be partitioned, formatted
       and mounted (such as /dev/vdc)
   * - Accessible from…
     - Within a VM
     - Within a VM
     - Anywhere
     - Within a VM
   * - Managed by…
     - OpenStack Compute (nova)
     - OpenStack Block Storage (cinder)
     - OpenStack Object Storage (swift)
     - OpenStack Shared File System Storage (manila)
   * - Persists until…
     - VM is terminated
     - Deleted by user
     - Deleted by user
     - Deleted by user
   * - Sizing determined by…
     - Administrator configuration of size settings, known as *flavors*
     - User specification in initial request
     - Amount of available physical storage
     - * User specification in initial request
       * Requests for extension
       * Available user-level quotes
       * Limitations applied by Administrator
   * - Encryption configuration
     - Parameter in ``nova.conf``
     - Admin establishing `encrypted volume type
       <https://docs.openstack.org/admin-guide/dashboard-manage-volumes.html>`_,
       then user selecting encrypted volume
     - Not yet available
     - Shared File Systems service does not apply any additional encryption
       above what the share’s back-end storage provides
   * - Example of typical usage…
     - 10 GB first disk, 30 GB second disk
     - 1 TB disk
     - 10s of TBs of dataset storage
     - Depends completely on the size of back-end storage specified when
       a share was being created. In case of thin provisioning it can be
       partial space reservation (for more details see
       `Capabilities and Extra-Specs
       <https://docs.openstack.org/manila/latest/contributor/capabilities_and_extra_specs.html#common-capabilities>`_
       specification)

.. note::

   **File-level storage for live migration**

   With file-level storage, users access stored data using the operating
   system's file system interface. Most users who have used a network
   storage solution before have encountered this form of networked
   storage. The most common file system protocol for Unix is NFS, and for
   Windows, CIFS (previously, SMB).

   OpenStack clouds do not present file-level storage to end users.
   However, it is important to consider file-level storage for storing
   instances under ``/var/lib/nova/instances`` when designing your cloud,
   since you must have a shared file system if you want to support live
   migration.

Commodity storage technologies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are various commodity storage back end technologies available. Depending
on your cloud user's needs, you can implement one or many of these technologies
in different combinations.

Ceph
----

Ceph is a scalable storage solution that replicates data across commodity
storage nodes.

Ceph utilises and object storage mechanism for data storage and exposes
the data via different types of storage interfaces to the end user it
supports interfaces for:
- Object storage
- Block storage
- File-system interfaces

Ceph provides support for the same Object Storage API as swift and can
be used as a back end for the Block Storage service (cinder) as well as
back-end storage for glance images.

Ceph supports thin provisioning implemented using copy-on-write. This can
be useful when booting from volume because a new volume can be provisioned
very quickly. Ceph also supports keystone-based authentication (as of
version 0.56), so it can be a seamless swap in for the default OpenStack
swift implementation.

Ceph's advantages include:

- The administrator has more fine-grained control over data distribution and
  replication strategies.
- Consolidation of object storage and block storage.
- Fast provisioning of boot-from-volume instances using thin provisioning.
- Support for the distributed file-system interface
  `CephFS <http://ceph.com/docs/master/cephfs/>`_.

You should consider Ceph if you want to manage your object and block storage
within a single system, or if you want to support fast boot-from-volume.

Gluster
-------

A distributed shared file system. As of Gluster version 3.3, you
can use Gluster to consolidate your object storage and file storage
into one unified file and object storage solution, which is called
Gluster For OpenStack (GFO). GFO uses a customized version of swift
that enables Gluster to be used as the back-end storage.

The main reason to use GFO rather than swift is if you also
want to support a distributed file system, either to support shared
storage live migration or to provide it as a separate service to
your end users. If you want to manage your object and file storage
within a single system, you should consider GFO.

LVM
---

The Logical Volume Manager (LVM) is a Linux-based system that provides an
abstraction layer on top of physical disks to expose logical volumes
to the operating system. The LVM back-end implements block storage
as LVM logical partitions.

On each host that will house block storage, an administrator must
initially create a volume group dedicated to Block Storage volumes.
Blocks are created from LVM logical volumes.

.. note::

   LVM does *not* provide any replication. Typically,
   administrators configure RAID on nodes that use LVM as block
   storage to protect against failures of individual hard drives.
   However, RAID does not protect against a failure of the entire
   host.

iSCSI
-----

Internet Small Computer Systems Interface (iSCSI) is a network protocol that
operates on top of the Transport Control Protocol (TCP) for linking data
storage devices. It transports data between an iSCSI initiator on a server
and iSCSI target on a storage device.

iSCSI is suitable for cloud environments with Block Storage service to support
applications or for file sharing systems. Network connectivity can be
achieved at a lower cost compared to other storage back end technologies since
iSCSI does not require host bus adaptors (HBA) or storage-specific network
devices.

.. Add tips? iSCSI traffic on a separate network or virtual vLAN?

NFS
---

Network File System (NFS) is a file system protocol that allows a user or
administrator to mount a file system on a server. File clients can access
mounted file systems through Remote Procedure Calls (RPC).

The benefits of NFS is low implementation cost due to shared NICs and
traditional network components, and a simpler configuration and setup process.

For more information on configuring Block Storage to use NFS storage, see
`Configure an NFS storage back end
<https://docs.openstack.org/admin-guide/blockstorage-nfs-backend.html>`_ in the
OpenStack Administrator Guide.

Sheepdog
--------

Sheepdog is a userspace distributed storage system. Sheepdog scales
to several hundred nodes, and has powerful virtual disk management
features like snapshot, cloning, rollback and thin provisioning.

It is essentially an object storage system that manages disks and
aggregates the space and performance of disks linearly in hyper
scale on commodity hardware in a smart way. On top of its object store,
Sheepdog provides elastic volume service and http service.
Sheepdog does require a specific kernel version and can work
nicely with xattr-supported file systems.

ZFS
---

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
on its own, you need to add a replication solution on top of ZFS if
your cloud needs to be able to handle storage-node failures.
