User requirements
~~~~~~~~~~~~~~~~~

Network-focused architectures vary from the general-purpose architecture
designs. Certain network-intensive applications influence these
architectures. Some of the business requirements that influence the
design include network latency through slow page loads, degraded video
streams, and low quality VoIP sessions impacts the user experience.

Users are often not aware of how network design and architecture affects their
experiences. Both enterprise customers and end-users rely on the network for
delivery of an application. Network performance problems can result in a
negative experience for the end-user, as well as productivity and economic
loss.

High availability issues
------------------------

Depending on the application and use case, network-intensive OpenStack
installations can have high availability requirements. Financial
transaction systems have a much higher requirement for high availability
than a development application. Use network availability technologies,
for example :term:`quality of service (QoS)`, to improve the network
performance of sensitive applications such as VoIP and video streaming.

High performance systems have SLA requirements for a minimum QoS with
regard to guaranteed uptime, latency, and bandwidth. The level of the
SLA can have a significant impact on the network architecture and
requirements for redundancy in the systems.

Risks
-----

Network misconfigurations
 Configuring incorrect IP addresses, VLANs, and routers can cause
 outages to areas of the network or, in the worst-case scenario, the
 entire cloud infrastructure. Automate network configurations to
 minimize the opportunity for operator error as it can cause
 disruptive problems.

Capacity planning
 Cloud networks require management for capacity and growth over time.
 Capacity planning includes the purchase of network circuits and
 hardware that can potentially have lead times measured in months or
 years.

Network tuning
 Configure cloud networks to minimize link loss, packet loss, packet
 storms, broadcast storms, and loops.

Single Point Of Failure (SPOF)
 Consider high availability at the physical and environmental layers.
 If there is a single point of failure due to only one upstream link,
 or only one power supply, an outage can become unavoidable.

Complexity
 An overly complex network design can be difficult to maintain and
 troubleshoot. While device-level configuration can ease maintenance
 concerns and automated tools can handle overlay networks, avoid or
 document non-traditional interconnects between functions and
 specialized hardware to prevent outages.

Non-standard features
 There are additional risks that arise from configuring the cloud
 network to take advantage of vendor specific features. One example
 is multi-link aggregation (MLAG) used to provide redundancy at the
 aggregator switch level of the network. MLAG is not a standard and,
 as a result, each vendor has their own proprietary implementation of
 the feature. MLAG architectures are not interoperable across switch
 vendors, which leads to vendor lock-in, and can cause delays or
 inability when upgrading components.
