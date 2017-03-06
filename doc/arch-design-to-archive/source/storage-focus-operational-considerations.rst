Operational Considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~

Several operational factors affect the design choices for a general
purpose cloud. Operations staff receive tasks regarding the maintenance
of cloud environments for larger installations, including:

Maintenance tasks
    The storage solution should take into account storage maintenance
    and the impact on underlying workloads.

Reliability and availability
    Reliability and availability depend on wide area network
    availability and on the level of precautions taken by the service
    provider.

Flexibility
    Organizations need to have the flexibility to choose between
    off-premise and on-premise cloud storage options. This relies on
    relevant decision criteria with potential cost savings. For example,
    continuity of operations, disaster recovery, security, records
    retention laws, regulations, and policies.

Monitoring and alerting services are vital in cloud environments with
high demands on storage resources. These services provide a real-time
view into the health and performance of the storage systems. An
integrated management console, or other dashboards capable of
visualizing SNMP data, is helpful when discovering and resolving issues
that arise within the storage cluster.

A storage-focused cloud design should include:

*  Monitoring of physical hardware resources.

*  Monitoring of environmental resources such as temperature and
   humidity.

*  Monitoring of storage resources such as available storage, memory,
   and CPU.

*  Monitoring of advanced storage performance data to ensure that
   storage systems are performing as expected.

*  Monitoring of network resources for service disruptions which would
   affect access to storage.

*  Centralized log collection.

*  Log analytics capabilities.

*  Ticketing system (or integration with a ticketing system) to track
   issues.

*  Alerting and notification of responsible teams or automated systems
   which remediate problems with storage as they arise.

*  Network Operations Center (NOC) staffed and always available to
   resolve issues.

Application awareness
---------------------

Well-designed applications should be aware of underlying storage
subsystems in order to use cloud storage solutions effectively.

If natively available replication is not available, operations personnel
must be able to modify the application so that they can provide their
own replication service. In the event that replication is unavailable,
operations personnel can design applications to react such that they can
provide their own replication services. An application designed to
detect underlying storage systems can function in a wide variety of
infrastructures, and still have the same basic behavior regardless of
the differences in the underlying infrastructure.

Fault tolerance and availability
--------------------------------

Designing for fault tolerance and availability of storage systems in an
OpenStack cloud is vastly different when comparing the Block Storage and
Object Storage services.

Block Storage fault tolerance and availability
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configure Block Storage resource nodes with advanced RAID controllers
and high performance disks to provide fault tolerance at the hardware
level.

Deploy high performing storage solutions such as SSD disk drives or
flash storage systems for applications requiring extreme performance out
of Block Storage devices.

In environments that place extreme demands on Block Storage, we
recommend using multiple storage pools. In this case, each pool of
devices should have a similar hardware design and disk configuration
across all hardware nodes in that pool. This allows for a design that
provides applications with access to a wide variety of Block Storage
pools, each with their own redundancy, availability, and performance
characteristics. When deploying multiple pools of storage it is also
important to consider the impact on the Block Storage scheduler which is
responsible for provisioning storage across resource nodes. Ensuring
that applications can schedule volumes in multiple regions, each with
their own network, power, and cooling infrastructure, can give projects
the ability to build fault tolerant applications that are distributed
across multiple availability zones.

In addition to the Block Storage resource nodes, it is important to
design for high availability and redundancy of the APIs, and related
services that are responsible for provisioning and providing access to
storage. We recommend designing a layer of hardware or software load
balancers in order to achieve high availability of the appropriate REST
API services to provide uninterrupted service. In some cases, it may
also be necessary to deploy an additional layer of load balancing to
provide access to back-end database services responsible for servicing
and storing the state of Block Storage volumes. We also recommend
designing a highly available database solution to store the Block
Storage databases. Leverage highly available database solutions such as
Galera and MariaDB to help keep database services online for
uninterrupted access, so that projects can manage Block Storage volumes.

In a cloud with extreme demands on Block Storage, the network
architecture should take into account the amount of East-West bandwidth
required for instances to make use of the available storage resources.
The selected network devices should support jumbo frames for
transferring large blocks of data. In some cases, it may be necessary to
create an additional back-end storage network dedicated to providing
connectivity between instances and Block Storage resources so that there
is no contention of network resources.

Object Storage fault tolerance and availability
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

While consistency and partition tolerance are both inherent features of
the Object Storage service, it is important to design the overall
storage architecture to ensure that the implemented system meets those
goals. The OpenStack Object Storage service places a specific number of
data replicas as objects on resource nodes. These replicas are
distributed throughout the cluster based on a consistent hash ring which
exists on all nodes in the cluster.

Design the Object Storage system with a sufficient number of zones to
provide quorum for the number of replicas defined. For example, with
three replicas configured in the Swift cluster, the recommended number
of zones to configure within the Object Storage cluster in order to
achieve quorum is five. While it is possible to deploy a solution with
fewer zones, the implied risk of doing so is that some data may not be
available and API requests to certain objects stored in the cluster
might fail. For this reason, ensure you properly account for the number
of zones in the Object Storage cluster.

Each Object Storage zone should be self-contained within its own
availability zone. Each availability zone should have independent access
to network, power and cooling infrastructure to ensure uninterrupted
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

*  Multiple DCs

Selecting the proper zone design is crucial for allowing the Object
Storage cluster to scale while providing an available and redundant
storage system. It may be necessary to configure storage policies that
have different requirements with regards to replicas, retention and
other factors that could heavily affect the design of storage in a
specific zone.

Scaling storage services
------------------------

Adding storage capacity and bandwidth is a very different process when
comparing the Block and Object Storage services. While adding Block
Storage capacity is a relatively simple process, adding capacity and
bandwidth to the Object Storage systems is a complex task that requires
careful planning and consideration during the design phase.

Scaling Block Storage
^^^^^^^^^^^^^^^^^^^^^

You can upgrade Block Storage pools to add storage capacity without
interrupting the overall Block Storage service. Add nodes to the pool by
installing and configuring the appropriate hardware and software and
then allowing that node to report in to the proper storage pool via the
message bus. This is because Block Storage nodes report into the
scheduler service advertising their availability. After the node is
online and available, projects can make use of those storage resources
instantly.

In some cases, the demand on Block Storage from instances may exhaust
the available network bandwidth. As a result, design network
infrastructure that services Block Storage resources in such a way that
you can add capacity and bandwidth easily. This often involves the use
of dynamic routing protocols or advanced networking solutions to add
capacity to downstream devices easily. Both the front-end and back-end
storage network designs should encompass the ability to quickly and
easily add capacity and bandwidth.

Scaling Object Storage
^^^^^^^^^^^^^^^^^^^^^^

Adding back-end storage capacity to an Object Storage cluster requires
careful planning and consideration. In the design phase, it is important
to determine the maximum partition power required by the Object Storage
service, which determines the maximum number of partitions which can
exist. Object Storage distributes data among all available storage, but
a partition cannot span more than one disk, although a disk can have
multiple partitions.

For example, a system that starts with a single disk and a partition
power of 3 can have 8 (2^3) partitions. Adding a second disk means that
each has 4 partitions. The one-disk-per-partition limit means that this
system can never have more than 8 partitions, limiting its scalability.
However, a system that starts with a single disk and a partition power
of 10 can have up to 1024 (2^10) partitions.

As you add back-end storage capacity to the system, the partition maps
redistribute data amongst the storage nodes. In some cases, this
replication consists of extremely large data sets. In these cases, we
recommend using back-end replication links that do not contend with
projects' access to data.

As more projects begin to access data within the cluster and their data
sets grow, it is necessary to add front-end bandwidth to service data
access requests. Adding front-end bandwidth to an Object Storage cluster
requires careful planning and design of the Object Storage proxies that
projects use to gain access to the data, along with the high availability
solutions that enable easy scaling of the proxy layer. We recommend
designing a front-end load balancing layer that projects and consumers
use to gain access to data stored within the cluster. This load
balancing layer may be distributed across zones, regions or even across
geographic boundaries, which may also require that the design encompass
geo-location solutions.

In some cases, you must add bandwidth and capacity to the network
resources servicing requests between proxy servers and storage nodes.
For this reason, the network architecture used for access to storage
nodes and proxy servers should make use of a design which is scalable.
