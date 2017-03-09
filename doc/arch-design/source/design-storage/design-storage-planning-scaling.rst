=====================================
Storage capacity planning and scaling
=====================================

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

* Public, private or a hybrid cloud, and associated SLA requirements
* The need for encryption-at-rest, for data on storage nodes
* Whether live migration will be offered

We recommend that data be encrypted both in transit and at-rest.
If you plan to use live migration, a shared storage configuration is highly
recommended.

Capacity planning for a multi-site cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
An OpenStack cloud can be designed in a variety of ways to handle individual
application needs. A multi-site deployment has additional challenges compared
to single site installations.

When determining capacity options, take into account technical, economic and
operational issues that might arise from specific decisions.

Inter-site link capacity describes the connectivity capability between
different OpenStack sites. This includes parameters such as
bandwidth, latency, whether or not a link is dedicated, and any business
policies applied to the connection. The capability and number of the
links between sites determine what kind of options are available for
deployment. For example, if two sites have a pair of high-bandwidth
links available between them, it may be wise to configure a separate
storage replication network between the two sites to support a single
swift endpoint and a shared Object Storage capability between them. An
example of this technique, as well as a configuration walk-through, is
available at `Dedicated replication network
<https://docs.openstack.org/developer/swift/replication_network.html#dedicated-replication-network>`_.
Another option in this scenario is to build a dedicated set of tenant
private networks across the secondary link, using overlay networks with
a third party mapping the site overlays to each other.

The capacity requirements of the links between sites is driven by
application behavior. If the link latency is too high, certain
applications that use a large number of small packets, for example
:term:`RPC <Remote Procedure Call (RPC)>` API calls, may encounter
issues communicating with each other or operating
properly. OpenStack may also encounter similar types of issues.
To mitigate this, the Identity service provides service call timeout
tuning to prevent issues authenticating against a central Identity services.

Another network capacity consideration for a multi-site deployment is
the amount and performance of overlay networks available for tenant
networks. If using shared tenant networks across zones, it is imperative
that an external overlay manager or controller be used to map these
overlays together. It is necessary to ensure the amount of possible IDs
between the zones are identical.

.. note::

   As of the Kilo release, OpenStack Networking was not capable of
   managing tunnel IDs across installations. So if one site runs out of
   IDs, but another does not, that tenant's network is unable to reach
   the other site.

The ability for a region to grow depends on scaling out the number of
available compute nodes. However, it may be necessary to grow cells in an
individual region, depending on the size of your cluster and the ratio of
virtual machines per hypervisor.

A third form of capacity comes in the multi-region-capable components of
OpenStack. Centralized Object Storage is capable of serving objects
through a single namespace across multiple regions. Since this works by
accessing the object store through swift proxy, it is possible to
overload the proxies. There are two options available to mitigate this
issue:

* Deploy a large number of swift proxies. The drawback is that the
  proxies are not load-balanced and a large file request could
  continually hit the same proxy.

* Add a caching HTTP proxy and load balancer in front of the swift
  proxies. Since swift objects are returned to the requester via HTTP,
  this load balancer alleviates the load required on the swift
  proxies.

Capacity planning for a compute-focused cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Adding extra capacity to an compute-focused cloud is a horizontally scaling
process.

We recommend using similar CPUs when adding extra nodes to the environment.
This reduces the chance of breaking live-migration features if they are
present. Scaling out hypervisor hosts also has a direct effect on network
and other data center resources. We recommend you factor in this increase
when reaching rack capacity or when requiring extra network switches.

Changing the internal components of a Compute host to account for increases in
demand is a process known as vertical scaling. Swapping a CPU for one with more
cores, or increasing the memory in a server, can help add extra capacity for
running applications.

Another option is to assess the average workloads and increase the number of
instances that can run within the compute environment by adjusting the
overcommit ratio.

.. note::
   It is important to remember that changing the CPU overcommit ratio can
   have a detrimental effect and cause a potential increase in a noisy
   neighbor.

The added risk of increasing the overcommit ratio is that more instances fail
when a compute host fails. We do not recommend that you increase the CPU
overcommit ratio in compute-focused OpenStack design architecture. It can
increase the potential for noisy neighbor issues.

Capacity planning for a hybrid cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the primary reasons many organizations use a hybrid cloud is to
increase capacity without making large capital investments.

Capacity and the placement of workloads are key design considerations for
hybrid clouds. The long-term capacity plan for these designs must incorporate
growth over time to prevent permanent consumption of more expensive external
clouds. To avoid this scenario, account for future applications’ capacity
requirements and plan growth appropriately.

It is difficult to predict the amount of load a particular application might
incur if the number of users fluctuate, or the application experiences an
unexpected increase in use. It is possible to define application requirements
in terms of vCPU, RAM, bandwidth, or other resources and plan appropriately.
However, other clouds might not use the same meter or even the same
oversubscription rates.

Oversubscription is a method to emulate more capacity than may physically be
present. For example, a physical hypervisor node with 32 GB RAM may host 24
instances, each provisioned with 2 GB RAM. As long as all 24 instances do not
concurrently use 2 full gigabytes, this arrangement works well. However, some
hosts take oversubscription to extremes and, as a result, performance can be
inconsistent. If at all possible, determine what the oversubscription rates
of each host are and plan capacity accordingly.

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

