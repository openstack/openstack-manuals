====================
Storage architecture
====================

There are many different storage architectures available when designing an
OpenStack cloud. The convergence of orchestration and automation within the
OpenStack platform enables rapid storage provisioning without the hassle of
the traditional manual processes like volume creation and
attachment.

However, before choosing a storage architecture, a few generic questions should
be answered:

* Will the storage architecture scale linearly as the cloud grows and what are
  its limits?
* What is the desired attachment method: NFS, iSCSI, FC, or other?
* Is the storage proven with the OpenStack platform?
* What is the level of support provided by the vendor within the community?
* What OpenStack features and enhancements does the cinder driver enable?
* Does it include tools to help troubleshoot and resolve performance issues?
* Is it interoperable with all of the projects you are planning on using
  in your cloud?

Choosing storage back ends
~~~~~~~~~~~~~~~~~~~~~~~~~~

Users will indicate different needs for their cloud architecture. Some may
need fast access to many objects that do not change often, or want to
set a time-to-live (TTL) value on a file. Others may access only storage
that is mounted with the file system itself, but want it to be
replicated instantly when starting a new instance. For other systems,
ephemeral storage is the preferred choice. When you select
:term:`storage back ends <storage back end>`,
consider the following questions from user's perspective:

First and foremost:

* Do I need block storage?
* Do I need object storage?
* Do I need file-based storage?

Next answer the following:

* Do I need to support live migration?
* Should my persistent storage drives be contained in my compute nodes,
  or should I use external storage?
* What type of performance do I need in regards to IOPS? Total IOPS and IOPS
  per instance? Do I have applications with IOPS SLAs?
* Are my storage needs mostly read, or write, or mixed?
* Which storage choices result in the best cost-performance scenario I am
  aiming for?
* How do I manage the storage operationally?
* How redundant and distributed is the storage? What happens if a
  storage node fails? To what extent can it mitigate my data-loss disaster
  scenarios?
* What is my company currently using and can I use it with OpenStack?
* Do I need more than one storage choice? Do I need tiered performance storage?

While this is not a definitive list of all the questions possible, the list
above will hopefully help narrow the list of possible storage choices down.

A wide variety of use case requirements dictate the nature of the storage
back end. Examples of such requirements are as follows:

* Public, private, or a hybrid cloud (performance profiles, shared storage,
  replication options)
* Storage-intensive use cases like HPC and Big Data clouds
* Web-scale or development clouds where storage is typically ephemeral in
  nature

Data security recommendations:

* We recommend that data be encrypted both in transit and at-rest.
  To this end, carefully select disks, appliances, and software.
  Do not assume these features are included with all storage solutions.
* Determine the security policy of your organization and understand
  the data sovereignty of your cloud geography and plan accordingly.

If you plan to use live migration, we highly recommend a shared storage
configuration. This allows the operating system and application volumes
for instances to reside outside of the compute nodes and adds significant
performance increases when live migrating.

To deploy your storage by using only commodity hardware, you can use a number
of open-source packages, as described in :ref:`table_persistent_file_storage`.

.. _table_persistent_file_storage:

.. list-table:: Persistent file-based storage support
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
exhaustive. Your organization may already have deployed a file-level shared
storage solution that you can use.

.. note::

   **Storage driver support**

   In addition to the open source technologies, there are a number of
   proprietary solutions that are officially supported by OpenStack Block
   Storage. You can find a matrix of the functionality provided by all of the
   supported Block Storage drivers on the `CinderSupportMatrix
   wiki <https://wiki.openstack.org/wiki/CinderSupportMatrix>`_.

Also, you need to decide whether you want to support object storage in
your cloud. The two common use cases for providing object storage in a
compute cloud are to provide:

* Users with a persistent storage mechanism for objects like images and video.
* A scalable, reliable data store for OpenStack virtual machine images.
* An API driven S3 compatible object store for application use.

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
  Performance of block based storage is typically measured in the maximum read
  and write operations to non-contiguous storage locations per second. This
  measurement typically applies to SAN, hard drives, and solid state drives.
  While IOPS can be broadly measured and is not an official benchmark, many
  vectors like to be used by vendors to communicate performance levels. Since
  there are no real standards for measuring IOPS, vendor test results may vary,
  sometimes wildly. However, along with transfer rate which measures the speed
  that data can be transferred to contiguous storage locations, IOPS can be
  used in a performance evaluation. Typically, transfer rate is represented by
  a bytes per second calculation but IOPS is measured by an integer.

To calculate IOPS for a single drive you could use:
  IOPS = 1 / (AverageLatency + AverageSeekTime)
  For example:
  Average Latency for Single Disk = 2.99ms or .00299 seconds
  Average Seek Time for Single Disk = 4.7ms or .0047 seconds
  IOPS = 1/(.00299 + .0047)
  IOPS = 130

To calculate maximum IOPS for a disk array:
  Maximum Read IOPS:
  In order to accurately calculate maximum read IOPS for a disk array,
  multiply the IOPS for each disk by the maximum read or write IOPS per disk.
  maxReadIOPS = nDisks * diskMaxIOPS
  For example, 15 10K Spinning Disks would be measured the following way:
  maxReadIOPS = 15 * 130 maxReadIOPS = 1950

Maximum write IOPS per array:
  Determining the maximum *write* IOPS is a little different because most
  administrators configure disk replication using RAID and since the RAID
  controller requires IOPS itself, there is a write penalty. The severity of
  the write penalty is determined by the type of RAID used.

  =========== ==========
  Raid Type   Penalty
  ----------- ----------
  1           2
  5           4
  10          2
  =========== ==========

.. note::

   Raid 5 has the worst penalty (has the most cross disk writes.)
   Therefore, when using the above examples, a 15 disk array using RAID 5 is
   capable of 1950 read IOPS however, we need to add the penalty when
   determining the *write* IOPS:

   .. code-block:: none

      maxWriteIOPS = 1950 / 4
      maxWriteIOPS = 487.5

   A RAID 5 array only has 25% of the write IOPS of the read IOPS while a RAID
   1 array in this case would produce a maximum of 975 IOPS.

What about SSD? DRAM SSD?
  In an HDD, data transfer is sequential. The actual read/write head "seeks" a
  point in the hard drive to execute the operation. Seek time is significant.
  Transfer rate can also be influenced by file system fragmentation and the
  layout. Finally, the mechanical nature of hard disks also has certain
  performance limitations.

  In an SSD, data transfer is *not* sequential; it is random so it is faster.
  There is consistent read performance because the physical location of data is
  irrelevant because SSDs have no read/write heads and thus no delays due to
  head motion (seeking).

.. note::

   Some basic benchmarks for small read/writes:

   - **HDDs**: Small reads – 175 IOPs, Small writes – 280 IOPs
   - **Flash SSDs**: Small reads – 1075 IOPs (6x), Small writes – 21 IOPs (0.1x)
   - **DRAM SSDs**: Small reads – 4091 IOPs (23x), Small writes – 4184 IOPs
     (14x)

Scalability
 Scalability, along with expandability, is a major consideration in
 a general purpose OpenStack cloud. It might be difficult to predict the final
 intended size of the implementation as there are no established usage patterns
 for a general purpose cloud. It might become necessary to expand the initial
 deployment in order to accommodate growth and user demand. Many vendors have
 implemented their own solutions to this problem. Some use clustered file
 systems that span multiple appliances, while others have similar technologies
 to allow block storage to scale past a fixed capacity. Ceph, a distributed
 storage solution that offers block storage, was designed to solve this scale
 issue and does not have the same limitations on domains, clusters, or scale
 issues of other appliance driven models.

Expandability
 Expandability is a major architecture factor for storage solutions
 with general purpose OpenStack cloud. A storage solution that
 expands to 50 PB is considered more expandable than a solution that
 only scales to 10 PB. This meter is related to scalability, which is
 the measure of a solution's performance as it expands.

Implementing Block Storage
--------------------------

Configure Block Storage resource nodes with advanced RAID controllers
and high-performance disks to provide fault tolerance at the hardware
level.

We recommend deploying high performing storage solutions such as SSD
drives or flash storage systems for applications requiring additional
performance out of Block Storage devices.

In environments that place substantial demands on Block Storage, we
recommend using multiple storage pools. In this case, each pool of
devices should have a similar hardware design and disk configuration
across all hardware nodes in that pool. This allows for a design that
provides applications with access to a wide variety of Block Storage pools,
each with their own redundancy, availability, and performance
characteristics. When deploying multiple pools of storage, it is also
important to consider the impact on the Block Storage scheduler which is
responsible for provisioning storage across resource nodes. Ideally,
ensure that applications can schedule volumes in multiple regions, each with
their own network, power, and cooling infrastructure. This will give tenants
the option of building fault-tolerant applications that are distributed
across multiple availability zones.

In addition to the Block Storage resource nodes, it is important to
design for high availability and redundancy of the APIs, and related
services that are responsible for provisioning and providing access to
storage. We recommend designing a layer of hardware or software load
balancers in order to achieve high availability of the appropriate REST
API services to provide uninterrupted service. In some cases, it may
also be necessary to deploy an additional layer of load balancing to
provide access to back-end database services responsible for servicing
and storing the state of Block Storage volumes. It is imperative that a
highly available database cluster is used to store the Block Storage metadata.

In a cloud with significant demands on Block Storage, the network
architecture should take into account the amount of East-West bandwidth
required for instances to make use of the available storage resources.
The selected network devices should support jumbo frames for
transferring large blocks of data, and utilize a dedicated network for
providing connectivity between instances and Block Storage.

Implementing Object Storage
~~~~~~~~~~~~~~~~~~~~~~~~~~~

While consistency and partition tolerance are both inherent features of
the Object Storage service, it is important to design the overall
storage architecture to ensure that the implemented system meets those goals.
The OpenStack Object Storage service places a specific number of
data replicas as objects on resource nodes. Replicas are distributed
throughout the cluster, based on a consistent hash ring also stored on
each node in the cluster.

When designing your cluster, you must consider durability and
availability which is dependent on the spread and placement of your data,
rather than the reliability of the hardware.

Consider the default value of the number of replicas, which is three. This
means that before an object is marked as having been written, at least two
copies exist in case a single server fails to write, the third copy may or
may not yet exist when the write operation initially returns. Altering this
number increases the robustness of your data, but reduces the amount of
storage you have available. Look at the placement of your servers. Consider
spreading them widely throughout your data center's network and power-failure
zones. Is a zone a rack, a server, or a disk?

Consider these main traffic flows for an Object Storage network:

* Among :term:`object`, :term:`container`, and
  :term:`account servers <account server>`
* Between servers and the proxies
* Between the proxies and your users

Object Storage frequent communicates among servers hosting data. Even a small
cluster generates megabytes per second of traffic.

Consider the scenario where an entire server fails and 24 TB of data
needs to be transferred "immediately" to remain at three copies — this can
put significant load on the network.

Another consideration is when a new file is being uploaded, the proxy server
must write out as many streams as there are replicas, multiplying network
traffic. For a three-replica cluster, 10 Gbps in means 30 Gbps out. Combining
this with the previous high bandwidth bandwidth private versus public network
recommendations demands of replication is what results in the recommendation
that your private network be of significantly higher bandwidth than your public
network requires. OpenStack Object Storage communicates internally with
unencrypted, unauthenticated rsync for performance, so the private
network is required.

The remaining point on bandwidth is the public-facing portion. The
``swift-proxy`` service is stateless, which means that you can easily
add more and use HTTP load-balancing methods to share bandwidth and
availability between them. More proxies means more bandwidth.

You should consider designing the Object Storage system with a sufficient
number of zones to provide quorum for the number of replicas defined. For
example, with three replicas configured in the swift cluster, the recommended
number of zones to configure within the Object Storage cluster in order to
achieve quorum is five. While it is possible to deploy a solution with
fewer zones, the implied risk of doing so is that some data may not be
available and API requests to certain objects stored in the cluster
might fail. For this reason, ensure you properly account for the number
of zones in the Object Storage cluster.

Each Object Storage zone should be self-contained within its own
availability zone. Each availability zone should have independent access
to network, power, and cooling infrastructure to ensure uninterrupted
access to data. In addition, a pool of Object Storage proxy servers
providing access to data stored on the object nodes should service each
availability zone. Object proxies in each region should leverage local
read and write affinity so that local storage resources facilitate
access to objects wherever possible. We recommend deploying upstream
load balancing to ensure that proxy services are distributed across the
multiple zones and, in some cases, it may be necessary to make use of
third-party solutions to aid with geographical distribution of services.

A zone within an Object Storage cluster is a logical division. Any of
the following may represent a zone:

*  A disk within a single node
*  One zone per node
*  Zone per collection of nodes
*  Multiple racks
*  Multiple data centers

Selecting the proper zone design is crucial for allowing the Object
Storage cluster to scale while providing an available and redundant
storage system. It may be necessary to configure storage policies that
have different requirements with regards to replicas, retention, and
other factors that could heavily affect the design of storage in a
specific zone.

Planning and scaling storage capacity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An important consideration in running a cloud over time is projecting growth
and utilization trends in order to plan capital expenditures for the short and
long term. Gather utilization meters for compute, network, and storage, along
with historical records of these meters. While securing major anchor tenants
can lead to rapid jumps in the utilization of resources, the average rate of
adoption of cloud services through normal usage also needs to be carefully
monitored.

Scaling Block Storage
---------------------

You can upgrade Block Storage pools to add storage capacity without
interrupting the overall Block Storage service. Add nodes to the pool by
installing and configuring the appropriate hardware and software and
then allowing that node to report in to the proper storage pool through the
message bus. Block Storage nodes generally report into the scheduler
service advertising their availability. As a result, after the node is
online and available, tenants can make use of those storage resources
instantly.

In some cases, the demand on Block Storage may exhaust the available
network bandwidth. As a result, design network infrastructure that
services Block Storage resources in such a way that you can add capacity
and bandwidth easily. This often involves the use of dynamic routing
protocols or advanced networking solutions to add capacity to downstream
devices easily. Both the front-end and back-end storage network designs
should encompass the ability to quickly and easily add capacity and
bandwidth.

.. note::

   Sufficient monitoring and data collection should be in-place
   from the start, such that timely decisions regarding capacity,
   input/output metrics (IOPS) or storage-associated bandwidth can
   be made.

Scaling Object Storage
----------------------

Adding back-end storage capacity to an Object Storage cluster requires
careful planning and forethought. In the design phase, it is important
to determine the maximum partition power required by the Object Storage
service, which determines the maximum number of partitions which can
exist. Object Storage distributes data among all available storage, but
a partition cannot span more than one disk, so the maximum number of
partitions can only be as high as the number of disks.

For example, a system that starts with a single disk and a partition
power of 3 can have 8 (2^3) partitions. Adding a second disk means that
each has 4 partitions. The one-disk-per-partition limit means that this
system can never have more than 8 disks, limiting its scalability.
However, a system that starts with a single disk and a partition power
of 10 can have up to 1024 (2^10) disks.

As you add back-end storage capacity to the system, the partition maps
redistribute data amongst the storage nodes. In some cases, this
involves replication of extremely large data sets. In these cases, we
recommend using back-end replication links that do not contend with
tenants' access to data.

As more tenants begin to access data within the cluster and their data
sets grow, it is necessary to add front-end bandwidth to service data
access requests. Adding front-end bandwidth to an Object Storage cluster
requires careful planning and design of the Object Storage proxies that
tenants use to gain access to the data, along with the high availability
solutions that enable easy scaling of the proxy layer. We recommend
designing a front-end load balancing layer that tenants and consumers
use to gain access to data stored within the cluster. This load
balancing layer may be distributed across zones, regions or even across
geographic boundaries, which may also require that the design encompass
geo-location solutions.

In some cases, you must add bandwidth and capacity to the network
resources servicing requests between proxy servers and storage nodes.
For this reason, the network architecture used for access to storage
nodes and proxy servers should make use of a design which is scalable.


Redundancy
----------

When making swift more redundant, one approach is to add additional proxy
servers and load balancing. HAProxy is one method of providing load
balancing and high availability and is often combined with keepalived
or pacemaker to ensure the HAProxy service maintains a stable VIP.
Sample HAProxy configurations can be found in the `OpenStack HA Guide.
<https://docs.openstack.org/ha-guide/controller-ha-haproxy.html#configuring-haproxy>`_.

Replication
-----------

Replicas in Object Storage function independently, and clients only
require a majority of nodes to respond to a request in order for an
operation to be considered successful. Thus, transient failures like
network partitions can quickly cause replicas to diverge.
Fix These differences are eventually reconciled by
asynchronous, peer-to-peer replicator processes. The replicator processes
traverse their local filesystems, concurrently performing operations in a
manner that balances load across physical disks.

Replication uses a push model, with records and files generally only being
copied from local to remote replicas. This is important because data on the
node may not belong there (as in the case of handoffs and ring changes), and a
replicator can not know what data exists elsewhere in the cluster that it
should pull in. It is the duty of any node that contains data to ensure that
data gets to where it belongs. Replica placement is handled by the ring.

Every deleted record or file in the system is marked by a tombstone, so that
deletions can be replicated alongside creations. The replication process cleans
up tombstones after a time period known as the consistency window. The
consistency window encompasses replication duration and the length of time a
transient failure can remove a node from the cluster. Tombstone cleanup must be
tied to replication to reach replica convergence.

If a replicator detects that a remote drive has failed, the replicator uses the
``get_more_nodes`` interface for the ring to choose an alternative node with
which to synchronize. The replicator can maintain desired levels of replication
in the face of disk failures, though some replicas may not be in an immediately
usable location.

.. note::

   The replicator does not maintain desired levels of replication when other
   failures occur, such as entire node failures, because most failures are
   transient.

   Replication is an area of active development, andimplementation details
   are likely to change over time.

There are two major classes of replicator: the db replicator, which replicates
accounts and containers, and the object replicator, which replicates object
data.

For more information, please see the `Swift replication page <https://docs.openstack.org/developer/swift/overview_replication.html>`_.
