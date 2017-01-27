==============
Storage design
==============

Storage is found in many parts of the OpenStack cloud environment. This
section describes persistent storage options you can configure with
your cloud. It is important to understand the distinction between
:term:`ephemeral <ephemeral volume>` storage and
:term:`persistent <persistent volume>` storage.

Ephemeral storage
~~~~~~~~~~~~~~~~~

If you deploy only the OpenStack :term:`Compute service (nova)`, by
default your users do not have access to any form of persistent storage. The
disks associated with VMs are ephemeral, meaning that from the user's point
of view they disappear when a virtual machine is terminated.

Persistent storage
~~~~~~~~~~~~~~~~~~

Persistent storage means that the storage resource outlives any other
resource and is always available, regardless of the state of a running
instance.

Today, OpenStack clouds explicitly support three types of persistent
storage: *Object Storage*, *Block Storage*, and *File-Based Storage*.

Object storage
~~~~~~~~~~~~~~

Object storage is implemented in OpenStack by the
OpenStack Object Storage (swift) project. Users access binary objects
through a REST API. If your intended users need to
archive or manage large datasets, you want to provide them with Object
Storage. In addition, OpenStack can store your virtual machine (VM)
images inside of an object storage system, as an alternative to storing
the images on a file system.

OpenStack storage concepts
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
       <https://docs.openstack.org/admin-guide/dashboard_manage_volumes.html>`_,
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

Choosing storage back ends
~~~~~~~~~~~~~~~~~~~~~~~~~~

Users will indicate different needs for their cloud use cases. Some may
need fast access to many objects that do not change often, or want to
set a time-to-live (TTL) value on a file. Others may access only storage
that is mounted with the file system itself, but want it to be
replicated instantly when starting a new instance. For other systems,
ephemeral storage is the preferred choice. When you select
:term:`storage back ends <storage back end>`,
consider the following questions from user's perspective:

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
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
     -
   * - LVM
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Ceph
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - Experimental
   * - Gluster
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
   * - NFS
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
   * - ZFS
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Sheepdog
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -

This list of open source file-level shared storage solutions is not
exhaustive other open source solutions exist (MooseFS). Your
organization may already have deployed a file-level shared storage
solution that you can use.

.. note::

   **Storage Driver Support**

   In addition to the open source technologies, there are a number of
   proprietary solutions that are officially supported by OpenStack Block
   Storage. You can find a matrix of the functionality provided by all of the
   supported Block Storage drivers on the `OpenStack
   wiki <https://wiki.openstack.org/wiki/CinderSupportMatrix>`_.

Also, you need to decide whether you want to support object storage in
your cloud. The two common use cases for providing object storage in a
compute cloud are:

* To provide users with a persistent storage mechanism
* As a scalable, reliable data store for virtual machine images

Selecting storage hardware
~~~~~~~~~~~~~~~~~~~~~~~~~~

Storage hardware architecture is determined by selecting specific storage
architecture. Determine the selection of storage architecture by
evaluating possible solutions against the critical factors, the user
requirements, technical considerations, and operational considerations.
Consider the following factors when selecting storage hardware:

Cost
 Storage can be a significant portion of the overall system cost. For
 an organization that is concerned with vendor support, a commercial
 storage solution is advisable, although it comes with a higher price
 tag. If initial capital expenditure requires minimization, designing
 a system based on commodity hardware would apply. The trade-off is
 potentially higher support costs and a greater risk of
 incompatibility and interoperability issues.

Performance
 The latency of storage I/O requests indicates performance. Performance
 requirements affect which solution you choose.

Scalability
 Scalability, along with expandability, is a major consideration in a
 general purpose OpenStack cloud. It might be difficult to predict
 the final intended size of the implementation as there are no
 established usage patterns for a general purpose cloud. It might
 become necessary to expand the initial deployment in order to
 accommodate growth and user demand.

Expandability
 Expandability is a major architecture factor for storage solutions
 with general purpose OpenStack cloud. A storage solution that
 expands to 50 PB is considered more expandable than a solution that
 only scales to 10 PB. This meter is related to scalability, which is
 the measure of a solution's performance as it expands.

General purpose cloud storage requirements
------------------------------------------
Using a scale-out storage solution with direct-attached storage (DAS) in
the servers is well suited for a general purpose OpenStack cloud. Cloud
services requirements determine your choice of scale-out solution. You
need to determine if a single, highly expandable and highly vertical,
scalable, centralized storage array is suitable for your design. After
determining an approach, select the storage hardware based on this
criteria.

This list expands upon the potential impacts for including a particular
storage architecture (and corresponding storage hardware) into the
design for a general purpose OpenStack cloud:

Connectivity
 If storage protocols other than Ethernet are part of the storage solution,
 ensure the appropriate hardware has been selected. If a centralized storage
 array is selected, ensure that the hypervisor will be able to connect to
 that storage array for image storage.

Usage
 How the particular storage architecture will be used is critical for
 determining the architecture. Some of the configurations that will
 influence the architecture include whether it will be used by the
 hypervisors for ephemeral instance storage, or if OpenStack Object
 Storage will use it for object storage.

Instance and image locations
 Where instances and images will be stored will influence the
 architecture.

Server hardware
 If the solution is a scale-out storage architecture that includes
 DAS, it will affect the server hardware selection. This could ripple
 into the decisions that affect host density, instance density, power
 density, OS-hypervisor, management tools and others.

A general purpose OpenStack cloud has multiple options. The key factors
that will have an influence on selection of storage hardware for a
general purpose OpenStack cloud are as follows:

Capacity
 Hardware resources selected for the resource nodes should be capable
 of supporting enough storage for the cloud services. Defining the
 initial requirements and ensuring the design can support adding
 capacity is important. Hardware nodes selected for object storage
 should be capable of support a large number of inexpensive disks
 with no reliance on RAID controller cards. Hardware nodes selected
 for block storage should be capable of supporting high speed storage
 solutions and RAID controller cards to provide performance and
 redundancy to storage at a hardware level. Selecting hardware RAID
 controllers that automatically repair damaged arrays will assist
 with the replacement and repair of degraded or deleted storage
 devices.

Performance
 Disks selected for object storage services do not need to be fast
 performing disks. We recommend that object storage nodes take
 advantage of the best cost per terabyte available for storage.
 Contrastingly, disks chosen for block storage services should take
 advantage of performance boosting features that may entail the use
 of SSDs or flash storage to provide high performance block storage
 pools. Storage performance of ephemeral disks used for instances
 should also be taken into consideration.

Fault tolerance
 Object storage resource nodes have no requirements for hardware
 fault tolerance or RAID controllers. It is not necessary to plan for
 fault tolerance within the object storage hardware because the
 object storage service provides replication between zones as a
 feature of the service. Block storage nodes, compute nodes, and
 cloud controllers should all have fault tolerance built in at the
 hardware level by making use of hardware RAID controllers and
 varying levels of RAID configuration. The level of RAID chosen
 should be consistent with the performance and availability
 requirements of the cloud.

Storage-focus cloud storage requirements
----------------------------------------

Storage-focused OpenStack clouds must address I/O intensive workloads.
These workloads are not CPU intensive, nor are they consistently network
intensive. The network may be heavily utilized to transfer storage, but
they are not otherwise network intensive.

The selection of storage hardware determines the overall performance and
scalability of a storage-focused OpenStack design architecture. Several
factors impact the design process, including:

Latency is a key consideration in a storage-focused OpenStack cloud.
Using solid-state disks (SSDs) to minimize latency and, to reduce CPU
delays caused by waiting for the storage, increases performance. Use
RAID controller cards in compute hosts to improve the performance of the
underlying disk subsystem.

Depending on the storage architecture, you can adopt a scale-out
solution, or use a highly expandable and scalable centralized storage
array. If a centralized storage array meets your requirements, then the
array vendor determines the hardware selection. It is possible to build
a storage array using commodity hardware with Open Source software, but
requires people with expertise to build such a system.

On the other hand, a scale-out storage solution that uses
direct-attached storage (DAS) in the servers may be an appropriate
choice. This requires configuration of the server hardware to support
the storage solution.

Considerations affecting storage architecture (and corresponding storage
hardware) of a Storage-focused OpenStack cloud include:

Connectivity
 Ensure the connectivity matches the storage solution requirements. We
 recommended confirming that the network characteristics minimize latency
 to boost the overall performance of the design.

Latency
 Determine if the use case has consistent or highly variable latency.

Throughput
 Ensure that the storage solution throughput is optimized for your
 application requirements.

Server hardware
 Use of DAS impacts the server hardware choice and affects host
 density, instance density, power density, OS-hypervisor, and
 management tools.
