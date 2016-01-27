=============================
Capacity planning and scaling
=============================

An important consideration in running a cloud over time is projecting growth
and utilization trends in order to plan capital expenditures for the short and
long term. Gather utilization meters for compute, network, and storage, along
with historical records of these meters. While securing major anchor tenants
can lead to rapid jumps in the utilization of resources, the average rate of
adoption of cloud services through normal usage also needs to be carefully
monitored.


General storage considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A wide variety of operator-specific requirements dictates the nature of the
storage back end. Examples of such requirements are as follows:

* Public or private cloud, and associated SLA requirements
* The need for encryption-at-rest, for data on storage nodes
* Whether live migration will be offered

We recommend that data be encrypted both in transit and at-rest.
If you plan to use live migration, a shared storage configuration is highly
recommended.

Block Storage
~~~~~~~~~~~~~

Configure Block Storage resource nodes with advanced RAID controllers
and high-performance disks to provide fault tolerance at the hardware
level.

Deploy high performing storage solutions such as SSD drives or
flash storage systems for applications requiring additional performance out
of Block Storage devices.

In environments that place substantial demands on Block Storage, we
recommend using multiple storage pools. In this case, each pool of
devices should have a similar hardware design and disk configuration
across all hardware nodes in that pool. This allows for a design that
provides applications with access to a wide variety of Block Storage
pools, each with their own redundancy, availability, and performance
characteristics. When deploying multiple pools of storage, it is also
important to consider the impact on the Block Storage scheduler which is
responsible for provisioning storage across resource nodes. Ideally,
ensure that applications can schedule volumes in multiple regions, each with
their own network, power, and cooling infrastructure.  This will give tenants
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
highly available database cluster is used to store the Block
Storage metadata.

In a cloud with significant demands on Block Storage, the network
architecture should take into account the amount of East-West bandwidth
required for instances to make use of the available storage resources.
The selected network devices should support jumbo frames for
transferring large blocks of data, and utilize a dedicated network for
providing connectivity between instances and Block Storage.

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

Object Storage
~~~~~~~~~~~~~~

While consistency and partition tolerance are both inherent features of
the Object Storage service, it is important to design the overall
storage architecture to ensure that the implemented system meets those
goals. The OpenStack Object Storage service places a specific number of
data replicas as objects on resource nodes. Replicas are distributed
throughout the cluster, based on a consistent hash ring also stored on
each node in the cluster.

Design the Object Storage system with a sufficient number of zones to
provide quorum for the number of replicas defined. For example, with
three replicas configured in the swift cluster, the recommended number
of zones to configure within the Object Storage cluster in order to
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


Network
~~~~~~~
.. TODO(unassigned): consolidate and update existing network sub-chapters.


Compute
~~~~~~~
A relationship exists between the size of the compute environment and
the supporting OpenStack infrastructure controller nodes requiring
support.

Increasing the size of the supporting compute environment increases the
network traffic and messages, adding load to the controller or
networking nodes. Effective monitoring of the environment will help with
capacity decisions on scaling.

Compute nodes automatically attach to OpenStack clouds, resulting in a
horizontally scaling process when adding extra compute capacity to an
OpenStack cloud. Additional processes are required to place nodes into
appropriate availability zones and host aggregates. When adding
additional compute nodes to environments, ensure identical or functional
compatible CPUs are used, otherwise live migration features will break.
It is necessary to add rack capacity or network switches as scaling out
compute hosts directly affects network and data center resources.

Compute host components can also be upgraded to account for increases in
demand. This is also known as vertical scaling. Upgrading CPUs with more
cores, or increasing the overall server memory, can add extra needed
capacity depending on whether the running applications are more CPU
intensive or memory intensive.

Another option is to assess the average workloads and increase the
number of instances that can run within the compute environment by
adjusting the overcommit ratio.

.. note::

   Changing the CPU overcommit ratio can have a detrimental effect
   and cause a potential increase in a noisy neighbor.

Insufficient disk capacity could also have a negative effect on overall
performance including CPU and memory usage. Depending on the back-end
architecture of the OpenStack Block Storage layer, capacity includes
adding disk shelves to enterprise storage systems or installing
additional block storage nodes. Upgrading directly attached storage
installed in compute hosts, and adding capacity to the shared storage
for additional ephemeral storage to instances, may be necessary.

For a deeper discussion on many of these topics, refer to the `OpenStack
Operations Guide <http://docs.openstack.org/ops>`_.


Control plane API services and Horizon
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. TODO(unassigned): consolidate existing control plane sub-chapters.
