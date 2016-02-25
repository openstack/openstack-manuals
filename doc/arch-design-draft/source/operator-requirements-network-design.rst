==============
Network design
==============

The network design for an OpenStack cluster includes decisions regarding
the interconnect needs within the cluster, the need to allow clients to
access their resources, and the access requirements for operators to
administrate the cluster. You should consider the bandwidth, latency,
and reliability of these networks.

Whether you are using an external provider or an internal team, you need
to consider additional design decisions about monitoring and alarming.
If you are using an external provider, service level agreements (SLAs)
are typically defined in your contract. Operational considerations such
as bandwidth, latency, and jitter can be part of the SLA.

As demand for network resources increase, make sure your network design
accommodates expansion and upgrades. Operators add additional IP address
blocks and add additional bandwidth capacity. In addition, consider
managing hardware and software lifecycle events, for example upgrades,
decommissioning, and outages, while avoiding service interruptions for
tenants.

Factor maintainability into the overall network design. This includes
the ability to manage and maintain IP addresses as well as the use of
overlay identifiers including VLAN tag IDs, GRE tunnel IDs, and MPLS
tags. As an example, if you may need to change all of the IP addresses
on a network, a process known as renumbering, then the design must
support this function.

Address network-focused applications when considering certain
operational realities. For example, consider the impending exhaustion of
IPv4 addresses, the migration to IPv6, and the use of private networks
to segregate different types of traffic that an application receives or
generates. In the case of IPv4 to IPv6 migrations, applications should
follow best practices for storing IP addresses. We recommend you avoid
relying on IPv4 features that did not carry over to the IPv6 protocol or
have differences in implementation.

To segregate traffic, allow applications to create a private tenant
network for database and storage network traffic. Use a public network
for services that require direct client access from the Internet. Upon
segregating the traffic, consider quality of service (QoS) and security
to ensure each network has the required level of service.

Finally, consider the routing of network traffic. For some applications,
develop a complex policy framework for routing. To create a routing
policy that satisfies business requirements, consider the economic cost
of transmitting traffic over expensive links versus cheaper links, in
addition to bandwidth, latency, and jitter requirements.

Additionally, consider how to respond to network events. How load
transfers from one link to another during a failure scenario could be
a factor in the design. If you do not plan network capacity
correctly, failover traffic could overwhelm other ports or network
links and create a cascading failure scenario. In this case,
traffic that fails over to one link overwhelms that link and then
moves to the subsequent links until all network traffic stops.
