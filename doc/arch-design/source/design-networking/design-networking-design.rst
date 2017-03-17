==============================
Designing an OpenStack network
==============================

There are many reasons an OpenStack network has complex requirements. One main
factor is that many components interact at different levels of the system
stack. Data flows are also complex.

Data in an OpenStack cloud moves between instances across the network
(known as east-west traffic), as well as in and out of the system (known
as north-south traffic). Physical server nodes have network requirements that
are independent of instance network requirements and must be isolated to
account for scalability. We recommend separating the networks for security
purposes and tuning performance through traffic shaping.

You must consider a number of important technical and business requirements
when planning and designing an OpenStack network:

* Avoid hardware or software vendor lock-in. The design should not rely on
  specific features of a vendor's network router or switch.
* Massively scale the ecosystem to support millions of end users.
* Support an indeterminate variety of platforms and applications.
* Design for cost efficient operations to take advantage of massive scale.
* Ensure that there is no single point of failure in the cloud ecosystem.
* High availability architecture to meet customer SLA requirements.
* Tolerant to rack level failure.
* Maximize flexibility to architect future production environments.

Considering these requirements, we recommend the following:

* Design a Layer-3 network architecture rather than a layer-2 network
  architecture.
* Design a dense multi-path network core to support multi-directional
  scaling and flexibility.
* Use hierarchical addressing because it is the only viable option to scale
  a network ecosystem.
* Use virtual networking to isolate instance service network traffic from the
  management and internal network traffic.
* Isolate virtual networks using encapsulation technologies.
* Use traffic shaping for performance tuning.
* Use External Border Gateway Protocol (eBGP) to connect to the Internet
  up-link.
* Use Internal Border Gateway Protocol (iBGP) to flatten the internal traffic
  on the layer-3 mesh.
* Determine the most effective configuration for block storage network.

Additional network design considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are several other considerations when designing a network-focused
OpenStack cloud.

Redundant networking
--------------------

You should conduct a high availability risk analysis to determine whether to
use redundant switches such as Top of Rack (ToR) switches. In most cases, it
is much more economical to use single switches with a small pool of spare
switches to replace failed units than it is to outfit an entire data center
with redundant switches. Applications should tolerate rack level outages
without affecting normal operations since network and compute resources are
easily provisioned and plentiful.

Research indicates the mean time between failures (MTBF) on switches is
between 100,000 and 200,000 hours. This number is dependent on the ambient
temperature of the switch in the data center. When properly cooled and
maintained, this translates to between 11 and 22 years before failure. Even
in the worst case of poor ventilation and high ambient temperatures in the data
center, the MTBF is still 2-3 years.

.. Link to research findings?

.. TODO Legacy networking (nova-network)
.. TODO OpenStack Networking
.. TODO Simple, single agent
.. TODO Complex, multiple agents
.. TODO Flat or VLAN
.. TODO Flat, VLAN, Overlays, L2-L3, SDN
.. TODO No plug-in support
.. TODO Plug-in support for 3rd parties
.. TODO No multi-tier topologies
.. TODO Multi-tier topologies
.. What about network security? (DC)

Providing IPv6 support
----------------------

One of the most important networking topics today is the exhaustion of
IPv4 addresses. As of late 2015, ICANN announced that the final
IPv4 address blocks have been fully assigned. Because of this, IPv6
protocol has become the future of network focused applications. IPv6
increases the address space significantly, fixes long standing issues
in the IPv4 protocol, and will become essential for network focused
applications in the future.

OpenStack Networking, when configured for it, supports IPv6. To enable
IPv6, create an IPv6 subnet in Networking and use IPv6 prefixes when
creating security groups.

Supporting asymmetric links
---------------------------

When designing a network architecture, the traffic patterns of an
application heavily influence the allocation of total bandwidth and
the number of links that you use to send and receive traffic. Applications
that provide file storage for customers allocate bandwidth and links to
favor incoming traffic; whereas video streaming applications allocate
bandwidth and links to favor outgoing traffic.

Optimizing network performance
------------------------------

It is important to analyze the applications tolerance for latency and
jitter when designing an environment to support network focused
applications. Certain applications, for example VoIP, are less tolerant
of latency and jitter. When latency and jitter are issues, certain
applications may require tuning of QoS parameters and network device
queues to ensure that they immediately queue for transmitting or guarantee
minimum bandwidth. Since OpenStack currently does not support these functions,
consider carefully your selected network plug-in.

The location of a service may also impact the application or consumer
experience. If an application serves differing content to different users,
it must properly direct connections to those specific locations. Where
appropriate, use a multi-site installation for these situations.

You can implement networking in two separate ways. Legacy networking
(nova-network) provides a flat DHCP network with a single broadcast domain.
This implementation does not support tenant isolation networks or advanced
plug-ins, but it is currently the only way to implement a distributed
layer-3 (L3) agent using the multi-host configuration. The Networking service
(neutron) is the official networking implementation and provides a pluggable
architecture that supports a large variety of network methods. Some of these
include a layer-2 only provider network model, external device plug-ins, or
even OpenFlow controllers.

Networking at large scales becomes a set of boundary questions. The
determination of how large a layer-2 domain must be is based on the
number of nodes within the domain and the amount of broadcast traffic
that passes between instances. Breaking layer-2 boundaries may require
the implementation of overlay networks and tunnels. This decision is a
balancing act between the need for a smaller overhead or a need for a smaller
domain.

When selecting network devices, be aware that making a decision based on the
greatest port density often comes with a drawback. Aggregation switches and
routers have not all kept pace with ToR switches and may induce
bottlenecks on north-south traffic. As a result, it may be possible for
massive amounts of downstream network utilization to impact upstream network
devices, impacting service to the cloud. Since OpenStack does not currently
provide a mechanism for traffic shaping or rate limiting, it is necessary to
implement these features at the network hardware level.

Using tunable networking components
-----------------------------------

Consider configurable networking components related to an OpenStack
architecture design when designing for network intensive workloads
that include MTU and QoS. Some workloads require a larger MTU than normal
due to the transfer of large blocks of data. When providing network
service for applications such as video streaming or storage replication,
we recommend that you configure both OpenStack hardware nodes and the
supporting network equipment for jumbo frames where possible. This
allows for better use of available bandwidth. Configure jumbo frames across the
complete path the packets traverse. If one network component is not capable of
handling jumbo frames then the entire path reverts to the default MTU.

:term:`Quality of Service (QoS)` also has a great impact on network intensive
workloads as it provides instant service to packets which have a higher
priority due to the impact of poor network performance. In applications such as
Voice over IP (VoIP), differentiated services code points are a near
requirement for proper operation. You can also use QoS in the opposite
direction for mixed workloads to prevent low priority but high bandwidth
applications, for example backup services, video conferencing, or file sharing,
from blocking bandwidth that is needed for the proper operation of other
workloads. It is possible to tag file storage traffic as a lower class, such as
best effort or scavenger, to allow the higher priority traffic through. In
cases where regions within a cloud might be geographically distributed it may
also be necessary to plan accordingly to implement WAN optimization to combat
latency or packet loss.

Choosing network hardware
~~~~~~~~~~~~~~~~~~~~~~~~~

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

Some of the key considerations in the selection of networking hardware
include:

Port count
 The design will require networking hardware that has the requisite
 port count.

Port density
 The network design will be affected by the physical space that is
 required to provide the requisite port count. A higher port density
 is preferred, as it leaves more rack space for compute or storage
 components. This can also lead into considerations about fault domains
 and power density. Higher density switches are more expensive, therefore
 it is important not to over design the network.

Port speed
 The networking hardware must support the proposed network speed, for
 example: 1 GbE, 10 GbE, or 40 GbE (or even 100 GbE).

Redundancy
 User requirements for high availability and cost considerations
 influence the level of network hardware redundancy. Network redundancy
 can be achieved by adding redundant power supplies or paired switches.

 .. note::

    Hardware must support network redundancy.

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
 iSER and SCST. The specifics of using these technologies is beyond
 the scope of this book.

There is no single best practice architecture for the networking
hardware supporting an OpenStack cloud. Some of the key factors that will
have a major influence on selection of networking hardware include:

Connectivity
 All nodes within an OpenStack cloud require network connectivity. In
 some cases, nodes require access to more than one network segment.
 The design must encompass sufficient network capacity and bandwidth
 to ensure that all communications within the cloud, both north-south
 and east-west traffic, have sufficient resources available.

Scalability
 The network design should encompass a physical and logical network
 design that can be easily expanded upon. Network hardware should
 offer the appropriate types of interfaces and speeds that are
 required by the hardware nodes.

Availability
 To ensure access to nodes within the cloud is not interrupted,
 we recommend that the network architecture identifies any single
 points of failure and provides some level of redundancy or fault
 tolerance. The network infrastructure often involves use of
 networking protocols such as LACP, VRRP or others to achieve a highly
 available network connection. It is also important to consider the
 networking implications on API availability. We recommend a load balancing
 solution is designed within the network architecture to ensure that the APIs
 and potentially other services in the cloud are highly available.

Choosing networking software
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Networking (neutron) provides a wide variety of networking
services for instances. There are many additional networking software
packages that can be useful when managing OpenStack components. Some
examples include:

- Software to provide load balancing
- Network redundancy protocols
- Routing daemons.

.. TODO Provide software examples
