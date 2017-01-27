Architecture
~~~~~~~~~~~~

Consider the following factors when selecting storage hardware:

* Cost

* Performance

* Reliability

Storage-focused OpenStack clouds must address I/O intensive workloads.
These workloads are not CPU intensive, nor are they consistently network
intensive. The network may be heavily utilized to transfer storage, but
they are not otherwise network intensive.

The selection of storage hardware determines the overall performance and
scalability of a storage-focused OpenStack design architecture. Several
factors impact the design process, including:

Cost
 The cost of components affects which storage architecture and
 hardware you choose.

Performance
 The latency of storage I/O requests indicates performance.
 Performance requirements affect which solution you choose.

Scalability
 Scalability refers to how the storage solution performs as it
 expands to its maximum size. Storage solutions that perform well in
 small configurations but have degraded performance in large
 configurations are not scalable. A solution that performs well at
 maximum expansion is scalable. Large deployments require a storage
 solution that performs well as it expands.

Latency is a key consideration in a storage-focused OpenStack cloud.
Using solid-state disks (SSDs) to minimize latency and, to reduce CPU
delays caused by waiting for the storage, increases performance. Use
RAID controller cards in compute hosts to improve the performance of the
underlying disk subsystem.

Depending on the storage architecture, you can adopt a scale-out
solution, or use a highly expandable and scalable centralized storage
array. If a centralized storage array is the right fit for your
requirements, then the array vendor determines the hardware selection.
It is possible to build a storage array using commodity hardware with
Open Source software, but requires people with expertise to build such a
system.

On the other hand, a scale-out storage solution that uses
direct-attached storage (DAS) in the servers may be an appropriate
choice. This requires configuration of the server hardware to support
the storage solution.

Considerations affecting storage architecture (and corresponding storage
hardware) of a Storage-focused OpenStack cloud include:

Connectivity
 Based on the selected storage solution, ensure the connectivity
 matches the storage solution requirements. We recommended confirming
 that the network characteristics minimize latency to boost the
 overall performance of the design.

Latency
 Determine if the use case has consistent or highly variable latency.

Throughput
 Ensure that the storage solution throughput is optimized for your
 application requirements.

Server hardware
 Use of DAS impacts the server hardware choice and affects host
 density, instance density, power density, OS-hypervisor, and
 management tools.

Compute (server) hardware selection
-----------------------------------

Four opposing factors determine the compute (server) hardware selection:

Server density
 A measure of how many servers can fit into a given measure of
 physical space, such as a rack unit [U].

Resource capacity
 The number of CPU cores, how much RAM, or how much storage a given
 server delivers.

Expandability
 The number of additional resources you can add to a server before it
 reaches capacity.

Cost
 The relative cost of the hardware weighed against the level of
 design effort needed to build the system.

You must weigh the dimensions against each other to determine the best
design for the desired purpose. For example, increasing server density
can mean sacrificing resource capacity or expandability. Increasing
resource capacity and expandability can increase cost but decrease
server density. Decreasing cost often means decreasing supportability,
server density, resource capacity, and expandability.

Compute capacity (CPU cores and RAM capacity) is a secondary
consideration for selecting server hardware. As a result, the required
server hardware must supply adequate CPU sockets, additional CPU cores,
and more RAM; network connectivity and storage capacity are not as
critical. The hardware needs to provide enough network connectivity and
storage capacity to meet the user requirements, however they are not the
primary consideration.

Some server hardware form factors are better suited to storage-focused
designs than others. The following is a list of these form factors:

* Most blade servers support dual-socket multi-core CPUs. Choose either
  full width or full height blades to avoid the limit. High density
  blade servers support up to 16 servers in only 10 rack units using
  half height or half width blades.

  .. warning::

     This decreases density by 50% (only 8 servers in 10 U) if a full
     width or full height option is used.

* 1U rack-mounted servers have the ability to offer greater server
  density than a blade server solution, but are often limited to
  dual-socket, multi-core CPU configurations.

  .. note::

     Due to cooling requirements, it is rare to see 1U rack-mounted
     servers with more than 2 CPU sockets.

  To obtain greater than dual-socket support in a 1U rack-mount form
  factor, customers need to buy their systems from Original Design
  Manufacturers (ODMs) or second-tier manufacturers.

.. warning::

   This may cause issues for organizations that have preferred
   vendor policies or concerns with support and hardware warranties
   of non-tier 1 vendors.

* 2U rack-mounted servers provide quad-socket, multi-core CPU support
  but with a corresponding decrease in server density (half the density
  offered by 1U rack-mounted servers).

* Larger rack-mounted servers, such as 4U servers, often provide even
  greater CPU capacity. Commonly supporting four or even eight CPU
  sockets. These servers have greater expandability but such servers
  have much lower server density and usually greater hardware cost.

* Rack-mounted servers that support multiple independent servers in a
  single 2U or 3U enclosure, "sled servers", deliver increased density
  as compared to a typical 1U-2U rack-mounted servers.

Other factors that influence server hardware selection for a
storage-focused OpenStack design architecture include:

Instance density
 In this architecture, instance density and CPU-RAM oversubscription
 are lower. You require more hosts to support the anticipated scale,
 especially if the design uses dual-socket hardware designs.

Host density
 Another option to address the higher host count is to use a
 quad-socket platform. Taking this approach decreases host density
 which also increases rack count. This configuration affects the
 number of power connections and also impacts network and cooling
 requirements.

Power and cooling density
 The power and cooling density requirements might be lower than with
 blade, sled, or 1U server designs due to lower host density (by
 using 2U, 3U or even 4U server designs). For data centers with older
 infrastructure, this might be a desirable feature.

Storage-focused OpenStack design architecture server hardware selection
should focus on a "scale-up" versus "scale-out" solution. The
determination of which is the best solution (a smaller number of larger
hosts or a larger number of smaller hosts), depends on a combination of
factors including cost, power, cooling, physical rack and floor space,
support-warranty, and manageability.

Networking hardware selection
-----------------------------

Key considerations for the selection of networking hardware include:

Port count
 The user requires networking hardware that has the requisite port
 count.

Port density
 The physical space required to provide the requisite port count
 affects the network design. A switch that provides 48 10 GbE ports
 in 1U has a much higher port density than a switch that provides 24
 10 GbE ports in 2U. On a general scale, a higher port density leaves
 more rack space for compute or storage components which is
 preferred. It is also important to consider fault domains and power
 density. Finally, higher density switches are more expensive,
 therefore it is important not to over design the network.

Port speed
 The networking hardware must support the proposed network speed, for
 example: 1 GbE, 10 GbE, or 40 GbE (or even 100 GbE).

Redundancy
 User requirements for high availability and cost considerations
 influence the required level of network hardware redundancy. Achieve
 network redundancy by adding redundant power supplies or paired
 switches.

 .. note::

    If this is a requirement, the hardware must support this
    configuration. User requirements determine if a completely
    redundant network infrastructure is required.

Power requirements
 Ensure that the physical data center provides the necessary power
 for the selected network hardware. This is not an issue for top of
 rack (ToR) switches, but may be an issue for spine switches in a
 leaf and spine fabric, or end of row (EoR) switches.

Protocol support
 It is possible to gain more performance out of a single storage
 system by using specialized network technologies such as RDMA, SRP,
 iSER and SCST. The specifics for using these technologies is beyond
 the scope of this book.

Software selection
------------------

Factors that influence the software selection for a storage-focused
OpenStack architecture design include:

* Operating system (OS) and hypervisor

* OpenStack components

* Supplemental software

Design decisions made in each of these areas impacts the rest of the
OpenStack architecture design.

Operating system and hypervisor
-------------------------------

Operating system (OS) and hypervisor have a significant impact on the
overall design and also affect server hardware selection. Ensure the
selected operating system and hypervisor combination support the storage
hardware and work with the networking hardware selection and topology.

Operating system and hypervisor selection affect the following areas:

Cost
 Selecting a commercially supported hypervisor, such as Microsoft
 Hyper-V, results in a different cost model than a
 community-supported open source hypervisor like Kinstance or Xen.
 Similarly, choosing Ubuntu over Red Hat (or vice versa) impacts cost
 due to support contracts. However, business or application
 requirements might dictate a specific or commercially supported
 hypervisor.

Supportability
 Staff must have training with the chosen hypervisor. Consider the
 cost of training when choosing a solution. The support of a
 commercial product such as Red Hat, SUSE, or Windows, is the
 responsibility of the OS vendor. If an open source platform is
 chosen, the support comes from in-house resources.

Management tools
 Ubuntu and Kinstance use different management tools than VMware
 vSphere. Although both OS and hypervisor combinations are supported
 by OpenStack, there are varying impacts to the rest of the design as
 a result of the selection of one combination versus the other.

Scale and performance
 Ensure the selected OS and hypervisor combination meet the
 appropriate scale and performance requirements needed for this
 storage focused OpenStack cloud. The chosen architecture must meet
 the targeted instance-host ratios with the selected OS-hypervisor
 combination.

Security
 Ensure the design can accommodate the regular periodic installation
 of application security patches while maintaining the required
 workloads. The frequency of security patches for the proposed
 OS-hypervisor combination impacts performance and the patch
 installation process could affect maintenance windows.

Supported features
 Selecting the OS-hypervisor combination often determines the
 required features of OpenStack. Certain features are only available
 with specific OSes or hypervisors. For example, if certain features
 are not available, you might need to modify the design to meet user
 requirements.

Interoperability
 The OS-hypervisor combination should be chosen based on the
 interoperability with one another, and other OS-hyervisor
 combinations. Operational and troubleshooting tools for one
 OS-hypervisor combination may differ from the tools used for another
 OS-hypervisor combination. As a result, the design must address if
 the two sets of tools need to interoperate.

OpenStack components
--------------------

The OpenStack components you choose can have a significant impact on the
overall design. While there are certain components that are always
present (Compute and Image service, for example), there are other
services that may not be required. As an example, a certain design may
not require the Orchestration service. Omitting Orchestration would not
typically have a significant impact on the overall design, however, if
the architecture uses a replacement for OpenStack Object Storage for its
storage component, this could potentially have significant impacts on
the rest of the design.

A storage-focused design might require the ability to use Orchestration
to launch instances with Block Storage volumes to perform
storage-intensive processing.

A storage-focused OpenStack design architecture uses the following
components:

* OpenStack Identity (keystone)

* OpenStack dashboard (horizon)

* OpenStack Compute (nova) (including the use of multiple hypervisor
   drivers)

* OpenStack Object Storage (swift) (or another object storage solution)

* OpenStack Block Storage (cinder)

* OpenStack Image service (glance)

* OpenStack Networking (neutron) or legacy networking (nova-network)

Excluding certain OpenStack components may limit or constrain the
functionality of other components. If a design opts to include
Orchestration but exclude Telemetry, then the design cannot take
advantage of Orchestration's auto scaling functionality (which relies on
information from Telemetry). Due to the fact that you can use
Orchestration to spin up a large number of instances to perform the
compute-intensive processing, we strongly recommend including
Orchestration in a compute-focused architecture design.

Networking software
-------------------

OpenStack Networking (neutron) provides a wide variety of networking
services for instances. There are many additional networking software
packages that may be useful to manage the OpenStack components
themselves. Some examples include HAProxy, Keepalived, and various
routing daemons (like Quagga). The OpenStack High Availability Guide
describes some of these software packages, HAProxy in particular. See
the `Network controller cluster stack
chapter <https://docs.openstack.org/ha-guide/networking-ha.html>`_ of
the OpenStack High Availability Guide.

Management software
-------------------

Management software includes software for providing:

* Clustering

* Logging

* Monitoring

* Alerting

.. important::

   The factors for determining which software packages in this category
   to select is outside the scope of this design guide.

The availability design requirements determine the selection of
Clustering Software, such as Corosync or Pacemaker. The availability of
the cloud infrastructure and the complexity of supporting the
configuration after deployment determines the impact of including these
software packages. The OpenStack High Availability Guide provides more
details on the installation and configuration of Corosync and Pacemaker.

Operational considerations determine the requirements for logging,
monitoring, and alerting. Each of these sub-categories includes options.
For example, in the logging sub-category you could select Logstash,
Splunk, Log Insight, or another log aggregation-consolidation tool.
Store logs in a centralized location to facilitate performing analytics
against the data. Log data analytics engines can also provide automation
and issue notification, by providing a mechanism to both alert and
automatically attempt to remediate some of the more commonly known
issues.

If you require any of these software packages, the design must account
for the additional resource consumption. Some other potential design
impacts include:

* OS-Hypervisor combination: Ensure that the selected logging,
  monitoring, or alerting tools support the proposed OS-hypervisor
  combination.

* Network hardware: The network hardware selection needs to be
  supported by the logging, monitoring, and alerting software.

Database software
-----------------

Most OpenStack components require access to back-end database services
to store state and configuration information. Choose an appropriate
back-end database which satisfies the availability and fault tolerance
requirements of the OpenStack services.

MySQL is the default database for OpenStack, but other compatible
databases are available.

.. note::

   Telemetry uses MongoDB.

The chosen high availability database solution changes according to the
selected database. MySQL, for example, provides several options. Use a
replication technology such as Galera for active-active clustering. For
active-passive use some form of shared storage. Each of these potential
solutions has an impact on the design:

* Solutions that employ Galera/MariaDB require at least three MySQL
  nodes.

* MongoDB has its own design considerations for high availability.

* OpenStack design, generally, does not include shared storage.
  However, for some high availability designs, certain components might
  require it depending on the specific implementation.
