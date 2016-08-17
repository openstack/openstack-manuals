==============================
Commodity storage technologies
==============================

This section provides a high-level overview of the differences among the
different commodity storage back end technologies. Depending on your
cloud user's needs, you can implement one or many of these technologies
in different combinations:

OpenStack Object Storage (swift)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Swift id the official OpenStack Object Store implementation. It is
a mature technology that has been used for several years in production
by a number of large cloud service providers. It is highly scalable
and well-suited to managing petabytes of storage.

Swifts's advantages include better integration with OpenStack (integrates
with OpenStack Identity, works with the OpenStack dashboard interface)
and better support for distributed deployments across multiple datacenters
through support for asynchronous eventual consistency replication.

Therefore, if you eventually plan on distributing your storage
cluster across multiple data centers, if you need unified accounts
for your users for both compute and object storage, or if you want
to control your object storage with the OpenStack dashboard, you
should consider OpenStack Object Storage. More detail can be found
about OpenStack Object Storage in the section below.

Further information can be found on the `Swift Project page <https://www.openstack.org/software/releases/mitaka/components/swift>`_.

Ceph
~~~~

A scalable storage solution that replicates data across commodity
storage nodes.

Ceph utilises and object storage mechanism for data storage and exposes
the data via different types of storage interfaces to the end user it
supports interfaces for:
* Object storage
* Block storage
* File-system interfaces

Ceph provides support for the same Object Storage API as Swift and can
be used as a back end for cinder block storage as well as back-end storage
for glance images.

Ceph supports thin provisioning, implemented using copy-on-write. This can
be useful when booting from volume because a new volume can be provisioned
very quickly. Ceph also supports keystone-based authentication (as of
version 0.56), so it can be a seamless swap in for the default OpenStack
Swift implementation.

Ceph's advantages include:
* provides the administrator more fine-grained
control over data distribution and replication strategies
* enables consolidation of object and block storage
* enables very fast provisioning of boot-from-volume
instances using thin provisioning
* supports a distributed file-system interface,`CephFS <http://ceph.com/docs/master/cephfs/>`_

If you want to manage your object and block storage within a single
system, or if you want to support fast boot-from-volume, you should
consider Ceph.

Gluster
~~~~~~~

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
~~~

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

ZFS
~~~

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


Sheepdog
~~~~~~~~

Sheepdog is a userspace distributed storage system. Sheepdog scales
to several hundred nodes, and has powerful virtual disk management
features like snapshot, cloning, rollback and thin provisioning.

It is essentially an object storage system that manages disks and
aggregates the space and performance of disks linearly in hyper
scale on commodity hardware in a smart way. On top of its object store,
Sheepdog provides elastic volume service and http service.
Sheepdog does require a specific kernel version and can work
nicely with xattr-supported file systems.
