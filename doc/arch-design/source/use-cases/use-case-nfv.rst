.. _nfv-cloud:

==============================
Network virtual function cloud
==============================


Design model
~~~~~~~~~~~~

Requirements
~~~~~~~~~~~~

Component block diagram
~~~~~~~~~~~~~~~~~~~~~~~


Network-focused cloud examples
------------------------------

An organization designs a large scale cloud-based web application. The
application scales horizontally in a bursting behavior and generates a
high instance count. The application requires an SSL connection to secure
data and must not lose connection state to individual servers.

The figure below depicts an example design for this workload. In this
example, a hardware load balancer provides SSL offload functionality and
connects to tenant networks in order to reduce address consumption. This
load balancer links to the routing architecture as it services the VIP
for the application. The router and load balancer use the GRE tunnel ID
of the application's tenant network and an IP address within the tenant
subnet but outside of the address pool. This is to ensure that the load
balancer can communicate with the application's HTTP servers without
requiring the consumption of a public IP address.

Because sessions persist until closed, the routing and switching
architecture provides high availability. Switches mesh to each
hypervisor and each other, and also provide an MLAG implementation to
ensure that layer-2 connectivity does not fail. Routers use VRRP and
fully mesh with switches to ensure layer-3 connectivity. Since GRE
provides an overlay network, Networking is present and uses the Open
vSwitch agent in GRE tunnel mode. This ensures all devices can reach all
other devices and that you can create tenant networks for private
addressing links to the load balancer.

.. figure:: ../figures/Network_Web_Services1.png

A web service architecture has many options and optional components. Due
to this, it can fit into a large number of other OpenStack designs. A
few key components, however, need to be in place to handle the nature of
most web-scale workloads. You require the following components:

*  OpenStack Controller services (Image service, Identity service, Networking
   service, and supporting services such as MariaDB and RabbitMQ)

*  OpenStack Compute running KVM hypervisor

*  OpenStack Object Storage

*  Orchestration service

*  Telemetry service

Beyond the normal Identity service, Compute service, Image service, and
Object Storage components, we recommend the Orchestration service component
to handle the proper scaling of workloads to adjust to demand. Due to the
requirement for auto-scaling, the design includes the Telemetry service.
Web services tend to be bursty in load, have very defined peak and
valley usage patterns and, as a result, benefit from automatic scaling
of instances based upon traffic. At a network level, a split network
configuration works well with databases residing on private tenant
networks since these do not emit a large quantity of broadcast traffic
and may need to interconnect to some databases for content.

Load balancing
~~~~~~~~~~~~~~

Load balancing spreads requests across multiple instances. This workload
scales well horizontally across large numbers of instances. This enables
instances to run without publicly routed IP addresses and instead to
rely on the load balancer to provide a globally reachable service. Many
of these services do not require direct server return. This aids in
address planning and utilization at scale since only the virtual IP
(VIP) must be public.

Overlay networks
~~~~~~~~~~~~~~~~

The overlay functionality design includes OpenStack Networking in Open
vSwitch GRE tunnel mode. In this case, the layer-3 external routers pair
with VRRP, and switches pair with an implementation of MLAG to ensure
that you do not lose connectivity with the upstream routing
infrastructure.

Performance tuning
~~~~~~~~~~~~~~~~~~

Network level tuning for this workload is minimal. :term:`Quality of
Service (QoS)` applies to these workloads for a middle ground Class
Selector depending on existing policies. It is higher than a best effort
queue but lower than an Expedited Forwarding or Assured Forwarding
queue. Since this type of application generates larger packets with
longer-lived connections, you can optimize bandwidth utilization for
long duration TCP. Normal bandwidth planning applies here with regards
to benchmarking a session's usage multiplied by the expected number of
concurrent sessions with overhead.

Network functions
~~~~~~~~~~~~~~~~~

Network functions is a broad category but encompasses workloads that
support the rest of a system's network. These workloads tend to consist
of large amounts of small packets that are very short lived, such as DNS
queries or SNMP traps. These messages need to arrive quickly and do not
deal with packet loss as there can be a very large volume of them. There
are a few extra considerations to take into account for this type of
workload and this can change a configuration all the way to the
hypervisor level. For an application that generates 10 TCP sessions per
user with an average bandwidth of 512 kilobytes per second per flow and
expected user count of ten thousand concurrent users, the expected
bandwidth plan is approximately 4.88 gigabits per second.

The supporting network for this type of configuration needs to have a
low latency and evenly distributed availability. This workload benefits
from having services local to the consumers of the service. Use a
multi-site approach as well as deploying many copies of the application
to handle load as close as possible to consumers. Since these
applications function independently, they do not warrant running
overlays to interconnect tenant networks. Overlays also have the
drawback of performing poorly with rapid flow setup and may incur too
much overhead with large quantities of small packets and therefore we do
not recommend them.

QoS is desirable for some workloads to ensure delivery. DNS has a major
impact on the load times of other services and needs to be reliable and
provide rapid responses. Configure rules in upstream devices to apply a
higher Class Selector to DNS to ensure faster delivery or a better spot
in queuing algorithms.

Cloud storage
~~~~~~~~~~~~~

Another common use case for OpenStack environments is providing a
cloud-based file storage and sharing service. You might consider this a
storage-focused use case, but its network-side requirements make it a
network-focused use case.

For example, consider a cloud backup application. This workload has two
specific behaviors that impact the network. Because this workload is an
externally-facing service and an internally-replicating application, it
has both :term:`north-south<north-south traffic>` and
:term:`east-west<east-west traffic>` traffic considerations:

north-south traffic
 When a user uploads and stores content, that content moves into the
 OpenStack installation. When users download this content, the
 content moves out from the OpenStack installation. Because this
 service operates primarily as a backup, most of the traffic moves
 southbound into the environment. In this situation, it benefits you
 to configure a network to be asymmetrically downstream because the
 traffic that enters the OpenStack installation is greater than the
 traffic that leaves the installation.

east-west traffic
 Likely to be fully symmetric. Because replication originates from
 any node and might target multiple other nodes algorithmically, it
 is less likely for this traffic to have a larger volume in any
 specific direction. However, this traffic might interfere with
 north-south traffic.

.. figure:: ../figures/Network_Cloud_Storage2.png

This application prioritizes the north-south traffic over east-west
traffic: the north-south traffic involves customer-facing data.

The network design, in this case, is less dependent on availability and
more dependent on being able to handle high bandwidth. As a direct
result, it is beneficial to forgo redundant links in favor of bonding
those connections. This increases available bandwidth. It is also
beneficial to configure all devices in the path, including OpenStack, to
generate and pass jumbo frames.
