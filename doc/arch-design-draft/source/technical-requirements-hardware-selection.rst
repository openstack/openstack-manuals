==================
Hardware selection
==================

Hardware selection involves three key areas:

* Network

* Compute

* Storage

Network hardware selection
~~~~~~~~~~~~~~~~~~~~~~~~~~

The network architecture determines which network hardware will be
used. Networking software is determined by the selected networking
hardware.

There are more subtle design impacts that need to be considered. The
selection of certain networking hardware (and the networking software)
affects the management tools that can be used. There are exceptions to
this; the rise of *open* networking software that supports a range of
networking hardware means there are instances where the relationship
between networking hardware and networking software are not as tightly
defined.

For a compute-focus architecture, we recommend designing the network
architecture using a scalable network model that makes it easy to add
capacity and bandwidth. A good example of such a model is the leaf-spline
model. In this type of network design, it is possible to easily add additional
bandwidth as well as scale out to additional racks of gear. It is important to
select network hardware that supports the required port count, port speed, and
port density while also allowing for future growth as workload demands
increase. It is also important to evaluate where in the network architecture
it is valuable to provide redundancy.

Some of the key considerations that should be included in the selection
of networking hardware include:

Port count
 The design will require networking hardware that has the requisite
 port count.

Port density
 The network design will be affected by the physical space that is
 required to provide the requisite port count. A higher port density
 is preferred, as it leaves more rack space for compute or storage
 components that may be required by the design. This can also lead
 into considerations about fault domains and power density. Higher
 density switches are more expensive, therefore it is important not
 to over design the network.

Port speed
 The networking hardware must support the proposed network speed, for
 example: 1 GbE, 10 GbE, or 40 GbE (or even 100 GbE).

Redundancy
 User requirements for high availability and cost considerations
 influence the required level of network hardware redundancy.
 Network redundancy can be achieved by adding redundant power
 supplies or paired switches.

 .. note::

    If this is a requirement, the hardware must support this
    configuration. User requirements determine if a completely
    redundant network infrastructure is required.

Power requirements
 Ensure that the physical data center provides the necessary power
 for the selected network hardware.

 .. note::

    This is not an issue for top of rack (ToR) switches. This may be an issue
    for spine switches in a leaf and spine fabric, or end of row (EoR)
    switches.

Protocol support
 It is possible to gain more performance out of a single storage
 system by using specialized network technologies such as RDMA, SRP,
 iSER and SCST. The specifics for using these technologies is beyond
 the scope of this book.

There is no single best practice architecture for the networking
hardware supporting an OpenStack cloud that will apply to all implementations.
Some of the key factors that will have a major influence on selection of
networking hardware include:

Connectivity
 All nodes within an OpenStack cloud require network connectivity. In
 some cases, nodes require access to more than one network segment.
 The design must encompass sufficient network capacity and bandwidth
 to ensure that all communications within the cloud, both north-south
 and east-west traffic have sufficient resources available.

Scalability
 The network design should encompass a physical and logical network
 design that can be easily expanded upon. Network hardware should
 offer the appropriate types of interfaces and speeds that are
 required by the hardware nodes.

Availability
 To ensure access to nodes within the cloud is not interrupted,
 we recommend that the network architecture identify any single
 points of failure and provide some level of redundancy or fault
 tolerance. The network infrastructure often involves use of
 networking protocols such as LACP, VRRP or others to achieve a highly
 available network connection. It is also important to consider the
 networking implications on API availability. We recommend a load balancing
 solution is designed within the network architecture to ensure that the APIs,
 and potentially other services in the cloud are highly available.

Compute (server) hardware selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Consider the following factors when selecting compute (server) hardware:

* Server density
   A measure of how many servers can fit into a given measure of
   physical space, such as a rack unit [U].

* Resource capacity
   The number of CPU cores, how much RAM, or how much storage a given
   server delivers.

* Expandability
   The number of additional resources you can add to a server before it
   reaches capacity.

* Cost
   The relative cost of the hardware weighed against the level of
   design effort needed to build the system.

Weigh these considerations against each other to determine the best
design for the desired purpose. For example, increasing server density
means sacrificing resource capacity or expandability.  Increasing resource
capacity and expandability can increase cost but decrease server density.
Decreasing cost often means decreasing supportability, server density,
resource capacity, and expandability.

Compute capacity (CPU cores and RAM capacity) is a secondary
consideration for selecting server hardware. The required
server hardware must supply adequate CPU sockets, additional CPU cores,
and more RAM; network connectivity and storage capacity are not as
critical. The hardware needs to provide enough network connectivity and
storage capacity to meet the user requirements.

For a compute-focused cloud, emphasis should be on server
hardware that can offer more CPU sockets, more CPU cores, and more RAM.
Network connectivity and storage capacity are less critical.

When designing a OpenStack cloud architecture, you must
consider whether you intend to scale up or scale out. Selecting a
smaller number of larger hosts, or a larger number of smaller hosts,
depends on a combination of factors: cost, power, cooling, physical rack
and floor space, support-warranty, and manageability.

Consider the following in selecting server hardware form factor suited for
your OpenStack design architecture:

* Most blade servers can support dual-socket multi-core CPUs. To avoid
  this CPU limit, select ``full width`` or ``full height`` blades. Be
  aware, however, that this also decreases server density. For example,
  high density blade servers such as HP BladeSystem or Dell PowerEdge
  M1000e support up to 16 servers in only ten rack units. Using
  half-height blades is twice as dense as using full-height blades,
  which results in only eight servers per ten rack units.

* 1U rack-mounted servers have the ability to offer greater server density
  than a blade server solution, but are often limited to dual-socket,
  multi-core CPU configurations. It is possible to place forty 1U servers
  in a rack, providing space for the top of rack (ToR) switches, compared
  to 32 full width blade servers.

  To obtain greater than dual-socket support in a 1U rack-mount form
  factor, customers need to buy their systems from Original Design
  Manufacturers (ODMs) or second-tier manufacturers.

  .. warning::

     This may cause issues for organizations that have preferred
     vendor policies or concerns with support and hardware warranties
     of non-tier 1 vendors.

* 2U rack-mounted servers provide quad-socket, multi-core CPU support,
  but with a corresponding decrease in server density (half the density
  that 1U rack-mounted servers offer).

* Larger rack-mounted servers, such as 4U servers, often provide even
  greater CPU capacity, commonly supporting four or even eight CPU
  sockets. These servers have greater expandability, but such servers
  have much lower server density and are often more expensive.

* ``Sled servers`` are rack-mounted servers that support multiple
  independent servers in a single 2U or 3U enclosure. These deliver
  higher density as compared to typical 1U or 2U rack-mounted servers.
  For example, many sled servers offer four independent dual-socket
  nodes in 2U for a total of eight CPU sockets in 2U.

Other factors that influence server hardware selection for an OpenStack
design architecture include:

Instance density
 More hosts are required to support the anticipated scale
 if the design architecture uses dual-socket hardware designs.

 For a general purpose OpenStack cloud, sizing is an important consideration.
 The expected or anticipated number of instances that each hypervisor can
 host is a common meter used in sizing the deployment. The selected server
 hardware needs to support the expected or anticipated instance density.

Host density
 Another option to address the higher host count is to use a
 quad-socket platform. Taking this approach decreases host density
 which also increases rack count. This configuration affects the
 number of power connections and also impacts network and cooling
 requirements.

 Physical data centers have limited physical space, power, and
 cooling. The number of hosts (or hypervisors) that can be fitted
 into a given metric (rack, rack unit, or floor tile) is another
 important method of sizing. Floor weight is an often overlooked
 consideration. The data center floor must be able to support the
 weight of the proposed number of hosts within a rack or set of
 racks. These factors need to be applied as part of the host density
 calculation and server hardware selection.

Power and cooling density
 The power and cooling density requirements might be lower than with
 blade, sled, or 1U server designs due to lower host density (by
 using 2U, 3U or even 4U server designs). For data centers with older
 infrastructure, this might be a desirable feature.

 Data centers have a specified amount of power fed to a given rack or
 set of racks. Older data centers may have a power density as power
 as low as 20 AMPs per rack, while more recent data centers can be
 architected to support power densities as high as 120 AMP per rack.
 The selected server hardware must take power density into account.

Network connectivity
 The selected server hardware must have the appropriate number of
 network connections, as well as the right type of network
 connections, in order to support the proposed architecture. Ensure
 that, at a minimum, there are at least two diverse network
 connections coming into each rack.

The selection of form factors or architectures affects the selection of
server hardware. Ensure that the selected server hardware is configured
to support enough storage capacity (or storage expandability) to match
the requirements of selected scale-out storage solution. Similarly, the
network architecture impacts the server hardware selection and vice
versa.

Hardware for general purpose OpenStack cloud
--------------------------------------------

Hardware for a general purpose OpenStack cloud should reflect a cloud
with no pre-defined usage model, designed to run a wide variety of
applications with varying resource usage requirements. These
applications include any of the following:

* RAM-intensive

* CPU-intensive

* Storage-intensive

Certain hardware form factors may better suit a general purpose
OpenStack cloud due to the requirement for equal (or nearly equal)
balance of resources. Server hardware must provide the following:

* Equal (or nearly equal) balance of compute capacity (RAM and CPU)

* Network capacity (number and speed of links)

* Storage capacity (gigabytes or terabytes as well as Input/Output
  Operations Per Second (:term:`IOPS`)

The best form factor for server hardware supporting a general purpose
OpenStack cloud is driven by outside business and cost factors. No
single reference architecture applies to all implementations; the
decision must flow from user requirements, technical considerations, and
operational considerations.

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
