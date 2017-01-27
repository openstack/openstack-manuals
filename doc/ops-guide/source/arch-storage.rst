=================
Storage Decisions
=================

Storage is found in many parts of the OpenStack stack, and the differing
types can cause confusion to even experienced cloud engineers. This
section focuses on persistent storage options you can configure with
your cloud. It's important to understand the distinction between
:term:`ephemeral <ephemeral volume>` storage and
:term:`persistent <persistent volume>` storage.

Ephemeral Storage
~~~~~~~~~~~~~~~~~

If you deploy only the OpenStack :term:`Compute service (nova)`,
your users do not have access to any form of persistent storage by default.
The disks associated with VMs are "ephemeral," meaning that (from the user's
point of view) they effectively disappear when a virtual machine is
terminated.

Persistent Storage
~~~~~~~~~~~~~~~~~~

Persistent storage means that the storage resource outlives any other
resource and is always available, regardless of the state of a running
instance.

Today, OpenStack clouds explicitly support three types of persistent
storage: *object storage*, *block storage*, and *file system storage*.

Object Storage
--------------

With object storage, users access binary objects through a REST API. You
may be familiar with Amazon S3, which is a well-known example of an
object storage system. Object storage is implemented in OpenStack by the
OpenStack Object Storage (swift) project. If your intended users need to
archive or manage large datasets, you want to provide them with object
storage. In addition, OpenStack can store your virtual machine (VM)
images inside of an object storage system, as an alternative to storing
the images on a file system.

OpenStack Object Storage provides a highly scalable, highly available
storage solution by relaxing some of the constraints of traditional file
systems. In designing and procuring for such a cluster, it is important
to understand some key concepts about its operation. Essentially, this
type of storage is built on the idea that all storage hardware fails, at
every level, at some point. Infrequently encountered failures that would
hamstring other storage systems, such as issues taking down RAID cards
or entire servers, are handled gracefully with OpenStack Object
Storage.

A good document describing the Object Storage architecture is found
within the `developer
documentation <https://docs.openstack.org/developer/swift/overview_architecture.html>`_
— read this first. Once you understand the architecture, you should know what a
proxy server does and how zones work. However, some important points are
often missed at first glance.

When designing your cluster, you must consider durability and
availability. Understand that the predominant source of these is the
spread and placement of your data, rather than the reliability of the
hardware. Consider the default value of the number of replicas, which is
three. This means that before an object is marked as having been
written, at least two copies exist—in case a single server fails to
write, the third copy may or may not yet exist when the write operation
initially returns. Altering this number increases the robustness of your
data, but reduces the amount of storage you have available. Next, look
at the placement of your servers. Consider spreading them widely
throughout your data center's network and power-failure zones. Is a zone
a rack, a server, or a disk?

Object Storage's network patterns might seem unfamiliar at first.
Consider these main traffic flows:

* Among :term:`object`, :term:`container`, and
  :term:`account servers <account server>`
* Between those servers and the proxies
* Between the proxies and your users

Object Storage is very "chatty" among servers hosting data—even a small
cluster does megabytes/second of traffic, which is predominantly, “Do
you have the object?”/“Yes I have the object!” Of course, if the answer
to the aforementioned question is negative or the request times out,
replication of the object begins.

Consider the scenario where an entire server fails and 24 TB of data
needs to be transferred "immediately" to remain at three copies—this can
put significant load on the network.

Another fact that's often forgotten is that when a new file is being
uploaded, the proxy server must write out as many streams as there are
replicas—giving a multiple of network traffic. For a three-replica
cluster, 10 Gbps in means 30 Gbps out. Combining this with the previous
high bandwidth demands of replication is what results in the
recommendation that your private network be of significantly higher
bandwidth than your public need be. Oh, and OpenStack Object Storage
communicates internally with unencrypted, unauthenticated rsync for
performance—you do want the private network to be private.

The remaining point on bandwidth is the public-facing portion. The
``swift-proxy`` service is stateless, which means that you can easily
add more and use HTTP load-balancing methods to share bandwidth and
availability between them.

More proxies means more bandwidth, if your storage can keep up.

Block Storage
-------------

Block storage (sometimes referred to as volume storage) provides users
with access to block-storage devices. Users interact with block storage
by attaching volumes to their running VM instances.

These volumes are persistent: they can be detached from one instance and
re-attached to another, and the data remains intact. Block storage is
implemented in OpenStack by the OpenStack Block Storage (cinder)
project, which supports multiple back ends in the form of drivers. Your
choice of a storage back end must be supported by a Block Storage
driver.

Most block storage drivers allow the instance to have direct access to
the underlying storage hardware's block device. This helps increase the
overall read/write IO. However, support for utilizing files as volumes
is also well established, with full support for NFS and other protocols.

These drivers work a little differently than a traditional "block"
storage driver. On an NFS file system, a single file is
created and then mapped as a "virtual" volume into the instance. This
mapping/translation is similar to how OpenStack utilizes QEMU's
file-based virtual machines stored in ``/var/lib/nova/instances``.

Shared File Systems Service
---------------------------

The Shared File Systems service provides a set of services for
management of Shared File Systems in a multi-tenant cloud environment.
Users interact with Shared File Systems service by mounting remote File
Systems on their instances with the following usage of those systems for
file storing and exchange. Shared File Systems service provides you with
shares. A share is a remote, mountable file system. You can mount a
share to and access a share from several hosts by several users at a
time. With shares, user can also:

* Create a share specifying its size, shared file system protocol,
  visibility level
* Create a share on either a share server or standalone, depending on
  the selected back-end mode, with or without using a share network.
* Specify access rules and security services for existing shares.
* Combine several shares in groups to keep data consistency inside the
  groups for the following safe group operations.
* Create a snapshot of a selected share or a share group for storing
  the existing shares consistently or creating new shares from that
  snapshot in a consistent way
* Create a share from a snapshot.
* Set rate limits and quotas for specific shares and snapshots
* View usage of share resources
* Remove shares.

Like Block Storage, the Shared File Systems service is persistent. It
can be:

* Mounted to any number of client machines.
* Detached from one instance and attached to another without data loss.
  During this process the data are safe unless the Shared File Systems
  service itself is changed or removed.

Shares are provided by the Shared File Systems service. In OpenStack,
Shared File Systems service is implemented by Shared File System
(manila) project, which supports multiple back-ends in the form of
drivers. The Shared File Systems service can be configured to provision
shares from one or more back-ends. Share servers are, mostly, virtual
machines that export file shares via different protocols such as NFS,
CIFS, GlusterFS, or HDFS.

OpenStack Storage Concepts
~~~~~~~~~~~~~~~~~~~~~~~~~~

:ref:`table_openstack_storage` explains the different storage concepts
provided by OpenStack.

.. _table_openstack_storage:

.. list-table:: Table. OpenStack storage
   :widths: 20 20 20 20 20
   :header-rows: 1

   * -
     - Ephemeral storage
     - Block storage
     - Object storage
     - Shared File System storage
   * - Used to…
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
   * - Encryption set by…
     - Parameter in nova.conf
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
       <https://docs.openstack.org/developer/manila/devref/capabilities_and_extra_specs.html?highlight=extra%20specs#common-capabilities>`_
       specification)

.. note::

   **File-level Storage (for Live Migration)**

   With file-level storage, users access stored data using the operating
   system's file system interface. Most users, if they have used a network
   storage solution before, have encountered this form of networked
   storage. In the Unix world, the most common form of this is NFS. In the
   Windows world, the most common form is called CIFS (previously, SMB).

   OpenStack clouds do not present file-level storage to end users.
   However, it is important to consider file-level storage for storing
   instances under ``/var/lib/nova/instances`` when designing your cloud,
   since you must have a shared file system if you want to support live
   migration.

Choosing Storage Back Ends
~~~~~~~~~~~~~~~~~~~~~~~~~~

Users will indicate different needs for their cloud use cases. Some may
need fast access to many objects that do not change often, or want to
set a time-to-live (TTL) value on a file. Others may access only storage
that is mounted with the file system itself, but want it to be
replicated instantly when starting a new instance. For other systems,
ephemeral storage—storage that is released when a VM attached to it is
shut down— is the preferred way. When you select
:term:`storage back ends <storage back end>`,
ask the following questions on behalf of your users:

* Do my users need block storage?
* Do my users need object storage?
* Do I need to support live migration?
* Should my persistent storage drives be contained in my compute nodes,
  or should I use external storage?
* What is the platter count I can achieve? Do more spindles result in
  better I/O despite network access?
* Which one results in the best cost-performance scenario I'm aiming for?
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
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     -
     -
   * - LVM
     -
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Ceph
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     - Experimental
   * - Gluster
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     -
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
   * - NFS
     -
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
   * - ZFS
     -
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Sheepdog
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: figures/Check_mark_23x20_02.png
          :width: 30%
     -

This list of open source file-level shared storage solutions is not
exhaustive; other open source solutions exist (MooseFS). Your
organization may already have deployed a file-level shared storage
solution that you can use.

.. note::

   **Storage Driver Support**

   In addition to the open source technologies, there are a number of
   proprietary solutions that are officially supported by OpenStack Block
   Storage. The full list of options can be found in the
   `Available Drivers <https://docs.openstack.org/developer/cinder/drivers.html>`_
   list.

   You can find a matrix of the functionality provided by all of the
   supported Block Storage drivers on the `OpenStack
   wiki <https://wiki.openstack.org/wiki/CinderSupportMatrix>`_.

Also, you need to decide whether you want to support object storage in
your cloud. The two common use cases for providing object storage in a
compute cloud are:

* To provide users with a persistent storage mechanism
* As a scalable, reliable data store for virtual machine images

Commodity Storage Back-end Technologies
---------------------------------------

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
    OpenStack dashboard interface) and better support for multiple data
    center deployment through support of asynchronous eventual
    consistency replication.

    Therefore, if you eventually plan on distributing your storage
    cluster across multiple data centers, if you need unified accounts
    for your users for both compute and object storage, or if you want
    to control your object storage with the OpenStack dashboard, you
    should consider OpenStack Object Storage. More detail can be found
    about OpenStack Object Storage in the section below.

Ceph
    A scalable storage solution that replicates data across commodity
    storage nodes. Ceph was originally developed by one of the founders
    of DreamHost and is currently used in production there.

    Ceph was designed to expose different types of storage interfaces to
    the end user: it supports object storage, block storage, and
    file-system interfaces, although the file-system interface is not
    yet considered production-ready. Ceph supports the same API as swift
    for object storage and can be used as a back end for cinder block
    storage as well as back-end storage for glance images. Ceph supports
    "thin provisioning," implemented using copy-on-write.

    This can be useful when booting from volume because a new volume can
    be provisioned very quickly. Ceph also supports keystone-based
    authentication (as of version 0.56), so it can be a seamless swap in
    for the default OpenStack swift implementation.

    Ceph's advantages are that it gives the administrator more
    fine-grained control over data distribution and replication
    strategies, enables you to consolidate your object and block
    storage, enables very fast provisioning of boot-from-volume
    instances using thin provisioning, and supports a distributed
    file-system interface, though this interface is `not yet
    recommended <http://ceph.com/docs/master/cephfs/>`_ for use in
    production deployment by the Ceph project.

    If you want to manage your object and block storage within a single
    system, or if you want to support fast boot-from-volume, you should
    consider Ceph.

Gluster
    A distributed, shared file system. As of Gluster version 3.3, you
    can use Gluster to consolidate your object storage and file storage
    into one unified file and object storage solution, which is called
    Gluster For OpenStack (GFO). GFO uses a customized version of swift
    that enables Gluster to be used as the back-end storage.

    The main reason to use GFO rather than regular swift is if you also
    want to support a distributed file system, either to support shared
    storage live migration or to provide it as a separate service to
    your end users. If you want to manage your object and file storage
    within a single system, you should consider GFO.

LVM
    The Logical Volume Manager is a Linux-based system that provides an
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

Conclusion
~~~~~~~~~~

We hope that you now have some considerations in mind and questions to
ask your future cloud users about their storage use cases. As you can
see, your storage decisions will also influence your network design for
performance and security needs. Continue with us to make more informed
decisions about your OpenStack cloud design.

