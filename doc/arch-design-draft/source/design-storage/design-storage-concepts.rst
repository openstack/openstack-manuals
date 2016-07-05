================
Storage concepts
================

This section describes persistent storage options you can configure with
your cloud. It is important to understand the distinction between
:term:`ephemeral <ephemeral volume>` storage and
:term:`persistent <persistent volume>` storage.

Ephemeral storage
~~~~~~~~~~~~~~~~~

If you deploy only the OpenStack :term:`Compute service` (nova), by default
your users do not have access to any form of persistent storage. The disks
associated with VMs are ephemeral, meaning that from the user's point
of view they disappear when a virtual machine is terminated.

Persistent storage
~~~~~~~~~~~~~~~~~~

Persistent storage is a storage resource that outlives any other
resource and is always available, regardless of the state of a running
instance.

OpenStack clouds explicitly support three types of persistent
storage: *Object Storage*, *Block Storage*, and *file system storage*.

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
       <http://docs.openstack.org/admin-guide/dashboard_manage_volumes.html>`_,
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
       <http://docs.openstack.org/developer/manila/devref/capabilities_and_extra_specs.html?highlight=extra%20specs#common-capabilities>`_
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

Object Storage
--------------

.. TODO (shaun) Revise this section. I would start with an abstract of object
   storage and then describe how swift fits into it. I think this will match
   the rest of the sections better.

Object storage is implemented in OpenStack by the
OpenStack Object Storage (swift) project. Users access binary objects
through a REST API. If your intended users need to
archive or manage large datasets, you want to provide them with Object
Storage. In addition, OpenStack can store your virtual machine (VM)
images inside of an Object Storage system, as an alternative to storing
the images on a file system.

OpenStack Object Storage provides a highly scalable, highly available
storage solution by relaxing some of the constraints of traditional file
systems. In designing and procuring for such a cluster, it is important
to understand some key concepts about its operation. Essentially, this
type of storage is built on the idea that all storage hardware fails, at
every level, at some point. Infrequently encountered failures that would
hamstring other storage systems, such as issues taking down RAID cards
or entire servers, are handled gracefully with OpenStack Object
Storage. For more information, see the  `Swift developer
documentation <http://docs.openstack.org/developer/swift/overview_architecture.html>`_

When designing your cluster, consider:

* Durability and availability, that is dependent on the spread and
  placement of your data, rather than the reliability of the hardware.

* Default value of the number of replicas, which is
  three. This means that before an object is marked as having been
  written, at least two copies exist in case a single server fails to
  write, the third copy may or may not yet exist when the write operation
  initially returns. Altering this number increases the robustness of your
  data, but reduces the amount of storage you have available.

* Placement of your servers, whether to spread them widely
  throughout your data center's network and power-failure zones. Define
  a zone as a rack, a server, or a disk.

Consider these main traffic flows for an Object Storage network:

* Among :term:`object`, :term:`container`, and
  :term:`account servers <account server>`
* Between servers and the proxies
* Between the proxies and your users

Object Storage frequently communicates among servers hosting data. Even a small
cluster generates megabytes/second of traffic. If an object is not received
or the request times out, replication of the object begins.

.. TODO Above paragraph: descibe what Object Storage is communicationg. What
   is actually communicating? What part of the software is doing the
   communicating? Is it all of the servers communicating with one another?

Consider the scenario where an entire server fails and 24 TB of data
needs to be transferred immediately to remain at three copies — this can
put significant load on the network.

Another consideration is when a new file is being uploaded, the proxy server
must write out as many streams as there are replicas, multiplying network
traffic. For a three-replica cluster, 10 Gbps in means 30 Gbps out. Combining
this with the previous high bandwidth private versus public network
recommendations demands of replication is what results in the recommendation
that your private network be of significantly higher bandwidth than your public
network requires. OpenStack Object Storage communicates internally with
unencrypted, unauthenticated rsync for performance, so the private
network is required.

.. TODO Revise the above paragraph for clarity.

The remaining point on bandwidth is the public-facing portion. The
``swift-proxy`` service is stateless, which means that you can easily
add more and use HTTP load-balancing methods to share bandwidth and
availability between them.

Block Storage
-------------

Block storage provides users with access to Block Storage devices. Users
interact with Block Storage by attaching volumes to their running VM instances.

These volumes are persistent: they can be detached from one instance and
re-attached to another, and the data remains intact. Block storage is
implemented in OpenStack by the OpenStack Block Storage (cinder), which
supports multiple back ends in the form of drivers. Your
choice of a storage back end must be supported by a Block Storage
driver.

Most Block Storage drivers allow the instance to have direct access to
the underlying storage hardware's block device. This helps increase the
overall read and write IO. However, support for utilizing files as volumes
is also well established, with full support for NFS, GlusterFS, and
others.

These drivers work a little differently than a traditional Block
Storage driver. On an NFS or GlusterFS file system, a single file is
created and then mapped as a virtual volume into the instance. This
mapping or translation is similar to how OpenStack utilizes QEMU's
file-based virtual machines stored in ``/var/lib/nova/instances``.

Shared File Systems Service
---------------------------

The Shared File Systems service (manila) provides a set of services for
management of shared file systems in a multi-tenant cloud environment.
Users interact with the Shared File Systems service by mounting remote File
Systems on their instances with the following usage of those systems for
file storing and exchange. The Shared File Systems service provides you with
a share which is a remote, mountable file system. You can mount a
share to and access a share from several hosts by several users at a
time. With shares, a user can also:

* Create a share specifying its size, shared file system protocol, and
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
shares from one or more back-ends. Share servers are virtual
machines that export file shares using different protocols such as NFS,
CIFS, GlusterFS, or HDFS.
