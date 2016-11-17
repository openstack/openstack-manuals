Technical considerations
~~~~~~~~~~~~~~~~~~~~~~~~

When you design an OpenStack network architecture, you must consider
layer-2 and layer-3 issues. Layer-2 decisions involve those made at the
data-link layer, such as the decision to use Ethernet versus Token Ring.
Layer-3 decisions involve those made about the protocol layer and the
point when IP comes into the picture. As an example, a completely
internal OpenStack network can exist at layer 2 and ignore layer 3. In
order for any traffic to go outside of that cloud, to another network,
or to the Internet, however, you must use a layer-3 router or switch.

The past few years have seen two competing trends in networking. One
trend leans towards building data center network architectures based on
layer-2 networking. Another trend treats the cloud environment
essentially as a miniature version of the Internet. This approach is
radically different from the network architecture approach in the
staging environment: the Internet only uses layer-3 routing rather than
layer-2 switching.

A network designed on layer-2 protocols has advantages over one designed
on layer-3 protocols. In spite of the difficulties of using a bridge to
perform the network role of a router, many vendors, customers, and
service providers choose to use Ethernet in as many parts of their
networks as possible. The benefits of selecting a layer-2 design are:

* Ethernet frames contain all the essentials for networking. These
  include, but are not limited to, globally unique source addresses,
  globally unique destination addresses, and error control.

* Ethernet frames can carry any kind of packet. Networking at layer-2
  is independent of the layer-3 protocol.

* Adding more layers to the Ethernet frame only slows the networking
  process down. This is known as 'nodal processing delay'.

* You can add adjunct networking features, for example class of service
  (CoS) or multicasting, to Ethernet as readily as IP networks.

* VLANs are an easy mechanism for isolating networks.

Most information starts and ends inside Ethernet frames. Today this
applies to data, voice (for example, VoIP), and video (for example, web
cameras). The concept is that if you can perform more of the end-to-end
transfer of information from a source to a destination in the form of
Ethernet frames, the network benefits more from the advantages of
Ethernet. Although it is not a substitute for IP networking, networking
at layer-2 can be a powerful adjunct to IP networking.

Layer-2 Ethernet usage has these advantages over layer-3 IP network
usage:

* Speed

* Reduced overhead of the IP hierarchy.

* No need to keep track of address configuration as systems move
  around. Whereas the simplicity of layer-2 protocols might work well
  in a data center with hundreds of physical machines, cloud data
  centers have the additional burden of needing to keep track of all
  virtual machine addresses and networks. In these data centers, it is
  not uncommon for one physical node to support 30-40 instances.

  .. important::

     Networking at the frame level says nothing about the presence or
     absence of IP addresses at the packet level. Almost all ports,
     links, and devices on a network of LAN switches still have IP
     addresses, as do all the source and destination hosts. There are
     many reasons for the continued need for IP addressing. The largest
     one is the need to manage the network. A device or link without an
     IP address is usually invisible to most management applications.
     Utilities including remote access for diagnostics, file transfer of
     configurations and software, and similar applications cannot run
     without IP addresses as well as MAC addresses.

Layer-2 architecture limitations
--------------------------------

Outside of the traditional data center the limitations of layer-2
network architectures become more obvious.

* Number of VLANs is limited to 4096.

* The number of MACs stored in switch tables is limited.

* You must accommodate the need to maintain a set of layer-4 devices to
  handle traffic control.

* MLAG, often used for switch redundancy, is a proprietary solution
  that does not scale beyond two devices and forces vendor lock-in.

* It can be difficult to troubleshoot a network without IP addresses
  and ICMP.

* Configuring :term:`ARP<Address Resolution Protocol (ARP)>` can be
  complicated on large layer-2 networks.

* All network devices need to be aware of all MACs, even instance MACs,
  so there is constant churn in MAC tables and network state changes as
  instances start and stop.

* Migrating MACs (instance migration) to different physical locations
  are a potential problem if you do not set ARP table timeouts
  properly.

It is important to know that layer-2 has a very limited set of network
management tools. It is very difficult to control traffic, as it does
not have mechanisms to manage the network or shape the traffic, and
network troubleshooting is very difficult. One reason for this
difficulty is network devices have no IP addresses. As a result, there
is no reasonable way to check network delay in a layer-2 network.

On large layer-2 networks, configuring ARP learning can also be
complicated. The setting for the MAC address timer on switches is
critical and, if set incorrectly, can cause significant performance
problems. As an example, the Cisco default MAC address timer is
extremely long. Migrating MACs to different physical locations to
support instance migration can be a significant problem. In this case,
the network information maintained in the switches could be out of sync
with the new location of the instance.

In a layer-2 network, all devices are aware of all MACs, even those that
belong to instances. The network state information in the backbone
changes whenever an instance starts or stops. As a result there is far
too much churn in the MAC tables on the backbone switches.

Layer-3 architecture advantages
-------------------------------

In the layer-3 case, there is no churn in the routing tables due to
instances starting and stopping. The only time there would be a routing
state change is in the case of a Top of Rack (ToR) switch failure or a
link failure in the backbone itself. Other advantages of using a layer-3
architecture include:

* Layer-3 networks provide the same level of resiliency and scalability
  as the Internet.

* Controlling traffic with routing metrics is straightforward.

* You can configure layer 3 to use :term:`BGP<Border Gateway Protocol (BGP)>`
  confederation for scalability so core routers have state proportional to the
  number of racks, not to the number of servers or instances.

* Routing takes instance MAC and IP addresses out of the network core,
  reducing state churn. Routing state changes only occur in the case of
  a ToR switch failure or backbone link failure.

* There are a variety of well tested tools, for example ICMP, to
  monitor and manage traffic.

* Layer-3 architectures enable the use of :term:`quality of service (QoS)` to
  manage network performance.

Layer-3 architecture limitations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The main limitation of layer 3 is that there is no built-in isolation
mechanism comparable to the VLANs in layer-2 networks. Furthermore, the
hierarchical nature of IP addresses means that an instance is on the
same subnet as its physical host. This means that you cannot migrate it
outside of the subnet easily. For these reasons, network virtualization
needs to use IP :term:`encapsulation` and software at the end hosts for
isolation and the separation of the addressing in the virtual layer from
the addressing in the physical layer. Other potential disadvantages of
layer 3 include the need to design an IP addressing scheme rather than
relying on the switches to keep track of the MAC addresses automatically
and to configure the interior gateway routing protocol in the switches.

Network recommendations overview
--------------------------------

OpenStack has complex networking requirements for several reasons. Many
components interact at different levels of the system stack that adds
complexity. Data flows are complex. Data in an OpenStack cloud moves
both between instances across the network (also known as East-West), as
well as in and out of the system (also known as North-South). Physical
server nodes have network requirements that are independent of instance
network requirements, which you must isolate from the core network to
account for scalability. We recommend functionally separating the
networks for security purposes and tuning performance through traffic
shaping.

You must consider a number of important general technical and business
factors when planning and designing an OpenStack network. They include:

* A requirement for vendor independence. To avoid hardware or software
  vendor lock-in, the design should not rely on specific features of a
  vendor's router or switch.

* A requirement to massively scale the ecosystem to support millions of
  end users.

* A requirement to support indeterminate platforms and applications.

* A requirement to design for cost efficient operations to take
  advantage of massive scale.

* A requirement to ensure that there is no single point of failure in
  the cloud ecosystem.

* A requirement for high availability architecture to meet customer SLA
  requirements.

* A requirement to be tolerant of rack level failure.

* A requirement to maximize flexibility to architect future production
  environments.

Bearing in mind these considerations, we recommend the following:

* Layer-3 designs are preferable to layer-2 architectures.

* Design a dense multi-path network core to support multi-directional
  scaling and flexibility.

* Use hierarchical addressing because it is the only viable option to
  scale network ecosystem.

* Use virtual networking to isolate instance service network traffic
  from the management and internal network traffic.

* Isolate virtual networks using encapsulation technologies.

* Use traffic shaping for performance tuning.

* Use eBGP to connect to the Internet up-link.

* Use iBGP to flatten the internal traffic on the layer-3 mesh.

* Determine the most effective configuration for block storage network.

Additional considerations
-------------------------

There are several further considerations when designing a
network-focused OpenStack cloud.

OpenStack Networking versus legacy networking (nova-network) considerations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Selecting the type of networking technology to implement depends on many
factors. OpenStack Networking (neutron) and legacy networking
(nova-network) both have their advantages and disadvantages. They are
both valid and supported options that fit different use cases:

.. list-table:: **Redundant networking: ToR switch high availability risk
                analysis**
   :widths: 50 40
   :header-rows: 1

   * - Legacy networking (nova-network)
     - OpenStack Networking
   * - Simple, single agent
     - Complex, multiple agents
   * - More mature, established
     - Newer, maturing
   * - Flat or VLAN
     - Flat, VLAN, Overlays, L2-L3, SDN
   * - No plug-in support
     - Plug-in support for 3rd parties
   * - Scales well
     - Scaling requires 3rd party plug-ins
   * - No multi-tier topologies
     - Multi-tier topologies

Redundant networking: ToR switch high availability risk analysis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A technical consideration of networking is the idea that you should
install switching gear in a data center with backup switches in case of
hardware failure.

Research indicates the mean time between failures (MTBF) on switches is
between 100,000 and 200,000 hours. This number is dependent on the
ambient temperature of the switch in the data center. When properly
cooled and maintained, this translates to between 11 and 22 years before
failure. Even in the worst case of poor ventilation and high ambient
temperatures in the data center, the MTBF is still 2-3 years.  See
`Ethernet switch reliablity: Temperature vs. moving parts
<http://media.beldensolutions.com/garrettcom/techsupport/papers/ethernet_switch_reliability.pdf>`_
for further information.

In most cases, it is much more economical to use a single switch with a
small pool of spare switches to replace failed units than it is to
outfit an entire data center with redundant switches. Applications
should tolerate rack level outages without affecting normal operations,
since network and compute resources are easily provisioned and
plentiful.

Preparing for the future: IPv6 support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

One of the most important networking topics today is the impending
exhaustion of IPv4 addresses. In early 2014, ICANN announced that they
started allocating the final IPv4 address blocks to the `Regional
Internet Registries
<http://www.internetsociety.org/deploy360/blog/2014/05/goodbye-ipv4-iana-starts-allocating-final-address-blocks/>`_.
This means the IPv4 address space is close to being fully allocated. As
a result, it will soon become difficult to allocate more IPv4 addresses
to an application that has experienced growth, or that you expect to
scale out, due to the lack of unallocated IPv4 address blocks.

For network focused applications the future is the IPv6 protocol. IPv6
increases the address space significantly, fixes long standing issues in
the IPv4 protocol, and will become essential for network focused
applications in the future.

OpenStack Networking supports IPv6 when configured to take advantage of
it. To enable IPv6, create an IPv6 subnet in Networking and use IPv6
prefixes when creating security groups.

Asymmetric links
^^^^^^^^^^^^^^^^

When designing a network architecture, the traffic patterns of an
application heavily influence the allocation of total bandwidth and the
number of links that you use to send and receive traffic. Applications
that provide file storage for customers allocate bandwidth and links to
favor incoming traffic, whereas video streaming applications allocate
bandwidth and links to favor outgoing traffic.

Performance
^^^^^^^^^^^

It is important to analyze the applications' tolerance for latency and
jitter when designing an environment to support network focused
applications. Certain applications, for example VoIP, are less tolerant
of latency and jitter. Where latency and jitter are concerned, certain
applications may require tuning of QoS parameters and network device
queues to ensure that they queue for transmit immediately or guarantee
minimum bandwidth. Since OpenStack currently does not support these
functions, consider carefully your selected network plug-in.

The location of a service may also impact the application or consumer
experience. If an application serves differing content to different
users it must properly direct connections to those specific locations.
Where appropriate, use a multi-site installation for these situations.

You can implement networking in two separate ways. Legacy networking
(nova-network) provides a flat DHCP network with a single broadcast
domain. This implementation does not support project isolation networks
or advanced plug-ins, but it is currently the only way to implement a
distributed :term:`layer-3 (L3) agent` using the multi_host configuration.
OpenStack Networking (neutron) is the official networking implementation and
provides a pluggable architecture that supports a large variety of
network methods. Some of these include a layer-2 only provider network
model, external device plug-ins, or even OpenFlow controllers.

Networking at large scales becomes a set of boundary questions. The
determination of how large a layer-2 domain must be is based on the
amount of nodes within the domain and the amount of broadcast traffic
that passes between instances. Breaking layer-2 boundaries may require
the implementation of overlay networks and tunnels. This decision is a
balancing act between the need for a smaller overhead or a need for a
smaller domain.

When selecting network devices, be aware that making this decision based
on the greatest port density often comes with a drawback. Aggregation
switches and routers have not all kept pace with Top of Rack switches
and may induce bottlenecks on north-south traffic. As a result, it may
be possible for massive amounts of downstream network utilization to
impact upstream network devices, impacting service to the cloud. Since
OpenStack does not currently provide a mechanism for traffic shaping or
rate limiting, it is necessary to implement these features at the
network hardware level.
