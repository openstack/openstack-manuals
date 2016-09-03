Architecture
~~~~~~~~~~~~

Network-focused OpenStack architectures have many similarities to other
OpenStack architecture use cases. There are several factors to consider
when designing for a network-centric or network-heavy application
environment.

Networks exist to serve as a medium of transporting data between
systems. It is inevitable that an OpenStack design has
inter-dependencies with non-network portions of OpenStack as well as on
external systems. Depending on the specific workload, there may be major
interactions with storage systems both within and external to the
OpenStack environment. For example, in the case of content delivery
network, there is twofold interaction with storage. Traffic flows to and
from the storage array for ingesting and serving content in a
north-south direction. In addition, there is replication traffic flowing
in an east-west direction.

Compute-heavy workloads may also induce interactions with the network.
Some high performance compute applications require network-based memory
mapping and data sharing and, as a result, induce a higher network load
when they transfer results and data sets. Others may be highly
transactional and issue transaction locks, perform their functions, and
revoke transaction locks at high rates. This also has an impact on the
network performance.

Some network dependencies are external to OpenStack. While OpenStack
Networking is capable of providing network ports, IP addresses, some
level of routing, and overlay networks, there are some other functions
that it cannot provide. For many of these, you may require external
systems or equipment to fill in the functional gaps. Hardware load
balancers are an example of equipment that may be necessary to
distribute workloads or offload certain functions. OpenStack Networking
provides a tunneling feature, however it is constrained to a
Networking-managed region. If the need arises to extend a tunnel beyond
the OpenStack region to either another region or an external system,
implement the tunnel itself outside OpenStack or use a tunnel management
system to map the tunnel or overlay to an external tunnel.

Depending on the selected design, Networking itself might not support
the required :term:`layer-3 network<Layer-3 network>` functionality. If
you choose to use the provider networking mode without running the layer-3
agent, you must install an external router to provide layer-3 connectivity
to outside systems.

Interaction with orchestration services is inevitable in larger-scale
deployments. The Orchestration service is capable of allocating network
resource defined in templates to map to project networks and for port
creation, as well as allocating floating IPs. If there is a requirement
to define and manage network resources when using orchestration, we
recommend that the design include the Orchestration service to meet the
demands of users.

Design impacts
--------------

A wide variety of factors can affect a network-focused OpenStack
architecture. While there are some considerations shared with a general
use case, specific workloads related to network requirements influence
network design decisions.

One decision includes whether or not to use Network Address Translation
(NAT) and where to implement it. If there is a requirement for floating
IPs instead of public fixed addresses then you must use NAT. An example
of this is a DHCP relay that must know the IP of the DHCP server. In
these cases it is easier to automate the infrastructure to apply the
target IP to a new instance rather than to reconfigure legacy or
external systems for each new instance.

NAT for floating IPs managed by Networking resides within the hypervisor
but there are also versions of NAT that may be running elsewhere. If
there is a shortage of IPv4 addresses there are two common methods to
mitigate this externally to OpenStack. The first is to run a load
balancer either within OpenStack as an instance, or use an external load
balancing solution. In the internal scenario, Networking's
Load-Balancer-as-a-Service (LBaaS) can manage load balancing software,
for example HAproxy. This is specifically to manage the Virtual IP (VIP)
while a dual-homed connection from the HAproxy instance connects the
public network with the project private network that hosts all of the
content servers. In the external scenario, a load balancer needs to
serve the VIP and also connect to the project overlay network through
external means or through private addresses.

Another kind of NAT that may be useful is protocol NAT. In some cases it
may be desirable to use only IPv6 addresses on instances and operate
either an instance or an external service to provide a NAT-based
transition technology such as NAT64 and DNS64. This provides the ability
to have a globally routable IPv6 address while only consuming IPv4
addresses as necessary or in a shared manner.

Application workloads affect the design of the underlying network
architecture. If a workload requires network-level redundancy, the
routing and switching architecture have to accommodate this. There are
differing methods for providing this that are dependent on the selected
network hardware, the performance of the hardware, and which networking
model you deploy. Examples include Link aggregation (LAG) and Hot
Standby Router Protocol (HSRP). Also consider whether to deploy
OpenStack Networking or legacy networking (nova-network), and which
plug-in to select for OpenStack Networking. If using an external system,
configure Networking to run :term:`layer-2<Layer-2 network>` with a provider
network configuration. For example, implement HSRP to terminate layer-3
connectivity.

Depending on the workload, overlay networks may not be the best
solution. Where application network connections are small, short lived,
or bursty, running a dynamic overlay can generate as much bandwidth as
the packets it carries. It also can induce enough latency to cause
issues with certain applications. There is an impact to the device
generating the overlay which, in most installations, is the hypervisor.
This causes performance degradation on packet per second and connection
per second rates.

Overlays also come with a secondary option that may not be appropriate
to a specific workload. While all of them operate in full mesh by
default, there might be good reasons to disable this function because it
may cause excessive overhead for some workloads. Conversely, other
workloads operate without issue. For example, most web services
applications do not have major issues with a full mesh overlay network,
while some network monitoring tools or storage replication workloads
have performance issues with throughput or excessive broadcast traffic.

Many people overlook an important design decision: The choice of layer-3
protocols. While OpenStack was initially built with only IPv4 support,
Networking now supports IPv6 and dual-stacked networks. Some workloads
are possible through the use of IPv6 and IPv6 to IPv4 reverse transition
mechanisms such as NAT64 and DNS64 or :term:`6to4`. This alters the
requirements for any address plan as single-stacked and transitional IPv6
deployments can alleviate the need for IPv4 addresses.

OpenStack has limited support for dynamic routing, however there are a
number of options available by incorporating third party solutions to
implement routing within the cloud including network equipment, hardware
nodes, and instances. Some workloads perform well with nothing more than
static routes and default gateways configured at the layer-3 termination
point. In most cases this is sufficient, however some cases require the
addition of at least one type of dynamic routing protocol if not
multiple protocols. Having a form of interior gateway protocol (IGP)
available to the instances inside an OpenStack installation opens up the
possibility of use cases for anycast route injection for services that
need to use it as a geographic location or failover mechanism. Other
applications may wish to directly participate in a routing protocol,
either as a passive observer, as in the case of a looking glass, or as
an active participant in the form of a route reflector. Since an
instance might have a large amount of compute and memory resources, it
is trivial to hold an entire unpartitioned routing table and use it to
provide services such as network path visibility to other applications
or as a monitoring tool.

Path maximum transmission unit (MTU) failures are lesser known but
harder to diagnose. The MTU must be large enough to handle normal
traffic, overhead from an overlay network, and the desired layer-3
protocol. Adding externally built tunnels reduces the MTU packet size.
In this case, you must pay attention to the fully calculated MTU size
because some systems ignore or drop path MTU discovery packets.

Tunable networking components
-----------------------------

Consider configurable networking components related to an OpenStack
architecture design when designing for network intensive workloads that
include MTU and QoS. Some workloads require a larger MTU than normal due
to the transfer of large blocks of data. When providing network service
for applications such as video streaming or storage replication, we
recommend that you configure both OpenStack hardware nodes and the
supporting network equipment for jumbo frames where possible. This
allows for better use of available bandwidth. Configure jumbo frames
across the complete path the packets traverse. If one network component
is not capable of handling jumbo frames then the entire path reverts to
the default MTU.

:term:`Quality of Service (QoS)` also has a great impact on network intensive
workloads as it provides instant service to packets which have a higher
priority due to the impact of poor network performance. In applications
such as Voice over IP (VoIP), differentiated services code points are a
near requirement for proper operation. You can also use QoS in the
opposite direction for mixed workloads to prevent low priority but high
bandwidth applications, for example backup services, video conferencing,
or file sharing, from blocking bandwidth that is needed for the proper
operation of other workloads. It is possible to tag file storage traffic
as a lower class, such as best effort or scavenger, to allow the higher
priority traffic through. In cases where regions within a cloud might be
geographically distributed it may also be necessary to plan accordingly
to implement WAN optimization to combat latency or packet loss.
