============
Architecture
============

Hardware selection involves three key areas:

* Compute

* Network

* Storage

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

* Storage capacity (gigabytes or terabytes as well as :term:`Input/Output
  Operations Per Second (IOPS)`

Evaluate server hardware around four conflicting dimensions:

Server density
 A measure of how many servers can fit into a given measure of
 physical space, such as a rack unit [U].

Resource capacity
 The number of CPU cores, amount of RAM, or amount of deliverable
 storage.

Expandability
 Limit of additional resources you can add to a server.

Cost
 The relative purchase price of the hardware weighted against the
 level of design effort needed to build the system.

Increasing server density means sacrificing resource capacity or
expandability, however, increasing resource capacity and expandability
increases cost and decreases server density. As a result, determining
the best server hardware for a general purpose OpenStack architecture
means understanding how choice of form factor will impact the rest of
the design. The following list outlines the form factors to choose from:

* Blade servers typically support dual-socket multi-core CPUs. Blades
  also offer outstanding density.

* 1U rack-mounted servers occupy only a single rack unit. Their
  benefits include high density, support for dual-socket multi-core
  CPUs, and support for reasonable RAM amounts. This form factor offers
  limited storage capacity, limited network capacity, and limited
  expandability.

* 2U rack-mounted servers offer the expanded storage and networking
  capacity that 1U servers tend to lack, but with a corresponding
  decrease in server density (half the density offered by 1U
  rack-mounted servers).

* Larger rack-mounted servers, such as 4U servers, will tend to offer
  even greater CPU capacity, often supporting four or even eight CPU
  sockets. These servers often have much greater expandability so will
  provide the best option for upgradability. This means, however, that
  the servers have a much lower server density and a much greater
  hardware cost.

* *Sled servers* are rack-mounted servers that support multiple
  independent servers in a single 2U or 3U enclosure. This form factor
  offers increased density over typical 1U-2U rack-mounted servers but
  tends to suffer from limitations in the amount of storage or network
  capacity each individual server supports.

The best form factor for server hardware supporting a general purpose
OpenStack cloud is driven by outside business and cost factors. No
single reference architecture applies to all implementations; the
decision must flow from user requirements, technical considerations, and
operational considerations. Here are some of the key factors that
influence the selection of server hardware:

Instance density
 Sizing is an important consideration for a general purpose OpenStack
 cloud. The expected or anticipated number of instances that each
 hypervisor can host is a common meter used in sizing the deployment.
 The selected server hardware needs to support the expected or
 anticipated instance density.

Host density
 Physical data centers have limited physical space, power, and
 cooling. The number of hosts (or hypervisors) that can be fitted
 into a given metric (rack, rack unit, or floor tile) is another
 important method of sizing. Floor weight is an often overlooked
 consideration. The data center floor must be able to support the
 weight of the proposed number of hosts within a rack or set of
 racks. These factors need to be applied as part of the host density
 calculation and server hardware selection.

Power density
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

Selecting storage hardware
~~~~~~~~~~~~~~~~~~~~~~~~~~

Determine storage hardware architecture by selecting specific storage
architecture. Determine the selection of storage architecture by
evaluating possible solutions against the critical factors, the user
requirements, technical considerations, and operational considerations.
Incorporate the following facts into your storage architecture:

Cost
 Storage can be a significant portion of the overall system cost. For
 an organization that is concerned with vendor support, a commercial
 storage solution is advisable, although it comes with a higher price
 tag. If initial capital expenditure requires minimization, designing
 a system based on commodity hardware would apply. The trade-off is
 potentially higher support costs and a greater risk of
 incompatibility and interoperability issues.

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
 Ensure that, if storage protocols other than Ethernet are part of
 the storage solution, the appropriate hardware has been selected. If
 a centralized storage array is selected, ensure that the hypervisor
 will be able to connect to that storage array for image storage.

Usage
 How the particular storage architecture will be used is critical for
 determining the architecture. Some of the configurations that will
 influence the architecture include whether it will be used by the
 hypervisors for ephemeral instance storage or if OpenStack Object
 Storage will use it for object storage.

Instance and image locations
 Where instances and images will be stored will influence the
 architecture.

Server hardware
 If the solution is a scale-out storage architecture that includes
 DAS, it will affect the server hardware selection. This could ripple
 into the decisions that affect host density, instance density, power
 density, OS-hypervisor, management tools and others.

General purpose OpenStack cloud has multiple options. The key factors
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

Selecting networking hardware
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Selecting network architecture determines which network hardware will be
used. Networking software is determined by the selected networking
hardware.

There are more subtle design impacts that need to be considered. The
selection of certain networking hardware (and the networking software)
affects the management tools that can be used. There are exceptions to
this; the rise of *open* networking software that supports a range of
networking hardware means that there are instances where the
relationship between networking hardware and networking software are not
as tightly defined.

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
 into concerns about fault domains and power density that should be
 considered. Higher density switches are more expensive and should
 also be considered, as it is important not to over design the
 network if it is not required.

Port speed
 The networking hardware must support the proposed network speed, for
 example: 1 GbE, 10 GbE, or 40 GbE (or even 100 GbE).

Redundancy
 The level of network hardware redundancy required is influenced by
 the user requirements for high availability and cost considerations.
 Network redundancy can be achieved by adding redundant power
 supplies or paired switches. If this is a requirement, the hardware
 will need to support this configuration.

Power requirements
 Ensure that the physical data center provides the necessary power
 for the selected network hardware.

.. note::

   This may be an issue for spine switches in a leaf and spine
   fabric, or end of row (EoR) switches.

There is no single best practice architecture for the networking
hardware supporting a general purpose OpenStack cloud that will apply to
all implementations. Some of the key factors that will have a strong
influence on selection of networking hardware include:

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
 To ensure that access to nodes within the cloud is not interrupted,
 we recommend that the network architecture identify any single
 points of failure and provide some level of redundancy or fault
 tolerance. With regard to the network infrastructure itself, this
 often involves use of networking protocols such as LACP, VRRP or
 others to achieve a highly available network connection. In
 addition, it is important to consider the networking implications on
 API availability. In order to ensure that the APIs, and potentially
 other services in the cloud are highly available, we recommend you
 design a load balancing solution within the network architecture to
 accommodate for these requirements.

Software selection
~~~~~~~~~~~~~~~~~~

Software selection for a general purpose OpenStack architecture design
needs to include these three areas:

* Operating system (OS) and hypervisor

* OpenStack components

* Supplemental software

Operating system and hypervisor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The operating system (OS) and hypervisor have a significant impact on
the overall design. Selecting a particular operating system and
hypervisor can directly affect server hardware selection. Make sure the
storage hardware and topology support the selected operating system and
hypervisor combination. Also ensure the networking hardware selection
and topology will work with the chosen operating system and hypervisor
combination.

Some areas that could be impacted by the selection of OS and hypervisor
include:

Cost
 Selecting a commercially supported hypervisor, such as Microsoft
 Hyper-V, will result in a different cost model rather than
 community-supported open source hypervisors including
 :term:`KVM<kernel-based VM (KVM)>`, Kinstance or :term:`Xen`. When
 comparing open source OS solutions, choosing Ubuntu over Red Hat
 (or vice versa) will have an impact on cost due to support
 contracts.

Supportability
 Depending on the selected hypervisor, staff should have the
 appropriate training and knowledge to support the selected OS and
 hypervisor combination. If they do not, training will need to be
 provided which could have a cost impact on the design.

Management tools
 The management tools used for Ubuntu and Kinstance differ from the
 management tools for VMware vSphere. Although both OS and hypervisor
 combinations are supported by OpenStack, there will be very
 different impacts to the rest of the design as a result of the
 selection of one combination versus the other.

Scale and performance
 Ensure that selected OS and hypervisor combinations meet the
 appropriate scale and performance requirements. The chosen
 architecture will need to meet the targeted instance-host ratios
 with the selected OS-hypervisor combinations.

Security
 Ensure that the design can accommodate regular periodic
 installations of application security patches while maintaining
 required workloads. The frequency of security patches for the
 proposed OS-hypervisor combination will have an impact on
 performance and the patch installation process could affect
 maintenance windows.

Supported features
 Determine which features of OpenStack are required. This will often
 determine the selection of the OS-hypervisor combination. Some
 features are only available with specific operating systems or
 hypervisors.

Interoperability
 You will need to consider how the OS and hypervisor combination
 interactions with other operating systems and hypervisors, including
 other software solutions. Operational troubleshooting tools for one
 OS-hypervisor combination may differ from the tools used for another
 OS-hypervisor combination and, as a result, the design will need to
 address if the two sets of tools need to interoperate.

OpenStack components
~~~~~~~~~~~~~~~~~~~~

Selecting which OpenStack components are included in the overall design
is important. Some OpenStack components, like compute and Image service,
are required in every architecture. Other components, like
Orchestration, are not always required.

Excluding certain OpenStack components can limit or constrain the
functionality of other components. For example, if the architecture
includes Orchestration but excludes Telemetry, then the design will not
be able to take advantage of Orchestrations' auto scaling functionality.
It is important to research the component interdependencies in
conjunction with the technical requirements before deciding on the final
architecture.

Networking software
-------------------

OpenStack Networking (neutron) provides a wide variety of networking
services for instances. There are many additional networking software
packages that can be useful when managing OpenStack components. Some
examples include:

* Software to provide load balancing

* Network redundancy protocols

* Routing daemons

Some of these software packages are described in more detail in the
OpenStack High Availability Guide (refer to the `OpenStack network
nodes
chapter <https://docs.openstack.org/ha-guide/networking-ha.html>`__ of
the OpenStack High Availability Guide).

For a general purpose OpenStack cloud, the OpenStack infrastructure
components need to be highly available. If the design does not include
hardware load balancing, networking software packages like HAProxy will
need to be included.

Management software
-------------------

Selected supplemental software solution impacts and affects the overall
OpenStack cloud design. This includes software for providing clustering,
logging, monitoring and alerting.

Inclusion of clustering software, such as Corosync or Pacemaker, is
determined primarily by the availability requirements. The impact of
including (or not including) these software packages is primarily
determined by the availability of the cloud infrastructure and the
complexity of supporting the configuration after it is deployed. The
`OpenStack High Availability
Guide <https://docs.openstack.org/ha-guide/>`__ provides more details on
the installation and configuration of Corosync and Pacemaker, should
these packages need to be included in the design.

Requirements for logging, monitoring, and alerting are determined by
operational considerations. Each of these sub-categories includes a
number of various options.

If these software packages are required, the design must account for the
additional resource consumption (CPU, RAM, storage, and network
bandwidth). Some other potential design impacts include:

* OS-hypervisor combination: Ensure that the selected logging,
  monitoring, or alerting tools support the proposed OS-hypervisor
  combination.

* Network hardware: The network hardware selection needs to be
  supported by the logging, monitoring, and alerting software.

Database software
-----------------

OpenStack components often require access to back-end database services
to store state and configuration information. Selecting an appropriate
back-end database that satisfies the availability and fault tolerance
requirements of the OpenStack services is required. OpenStack services
supports connecting to a database that is supported by the SQLAlchemy
python drivers, however, most common database deployments make use of
MySQL or variations of it. We recommend that the database, which
provides back-end service within a general purpose cloud, be made highly
available when using an available technology which can accomplish that
goal.
