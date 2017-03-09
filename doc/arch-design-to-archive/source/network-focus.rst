===============
Network focused
===============

.. toctree::
   :maxdepth: 2

   network-focus-user-requirements.rst
   network-focus-technical-considerations.rst
   network-focus-operational-considerations.rst
   network-focus-architecture.rst
   network-focus-prescriptive-examples.rst

All OpenStack deployments depend on network communication in order to function
properly due to its service-based nature. In some cases, however, the network
elevates beyond simple infrastructure. This chapter discusses architectures
that are more reliant or focused on network services. These architectures
depend on the network infrastructure and require network services that
perform reliably in order to satisfy user and application requirements.

Some possible use cases include:

Content delivery network
 This includes streaming video, viewing photographs, or accessing any other
 cloud-based data repository distributed to a large number of end users.
 Network configuration affects latency, bandwidth, and the distribution of
 instances. Therefore, it impacts video streaming. Not all video streaming
 is consumer-focused. For example, multicast videos (used for media, press
 conferences, corporate presentations, and web conferencing services) can
 also use a content delivery network. The location of the video repository
 and its relationship to end users affects content delivery. Network
 throughput of the back-end systems, as well as the WAN architecture and
 the cache methodology, also affect performance.

Network management functions
 Use this cloud to provide network service functions built to support the
 delivery of back-end network services such as DNS, NTP, or SNMP.

Network service offerings
 Use this cloud to run customer-facing network tools to support services.
 Examples include VPNs, MPLS private networks, and GRE tunnels.

Web portals or web services
 Web servers are a common application for cloud services, and we recommend
 an understanding of their network requirements. The network requires scaling
 out to meet user demand and deliver web pages with a minimum latency.
 Depending on the details of the portal architecture, consider the internal
 east-west and north-south network bandwidth.

High speed and high volume transactional systems
 These types of applications are sensitive to network configurations. Examples
 include financial systems, credit card transaction applications, and trading
 and other extremely high volume systems. These systems are sensitive to
 network jitter and latency. They must balance a high volume of East-West and
 North-South network traffic to maximize efficiency of the data delivery. Many
 of these systems must access large, high performance database back ends.

High availability
 These types of use cases are dependent on the proper sizing of the network to
 maintain replication of data between sites for high availability. If one site
 becomes unavailable, the extra sites can serve the displaced load until the
 original site returns to service. It is important to size network capacity to
 handle the desired loads.

Big data
 Clouds used for the management and collection of big data (data ingest) have
 a significant demand on network resources. Big data often uses partial
 replicas of the data to maintain integrity over large distributed clouds.
 Other big data applications that require a large amount of network resources
 are Hadoop, Cassandra, NuoDB, Riak, and other NoSQL and distributed
 databases.

Virtual desktop infrastructure (VDI)
 This use case is sensitive to network congestion, latency, jitter, and other
 network characteristics. Like video streaming, the user experience is
 important. However, unlike video streaming, caching is not an option to
 offset the network issues. VDI requires both upstream and downstream traffic
 and cannot rely on caching for the delivery of the application to the end
 user.

Voice over IP (VoIP)
 This is sensitive to network congestion, latency, jitter, and other network
 characteristics. VoIP has a symmetrical traffic pattern and it requires
 network :term:`quality of service (QoS)` for best performance. In addition,
 you can implement active queue management to deliver voice and multimedia
 content. Users are sensitive to latency and jitter fluctuations and can detect
 them at very low levels.

Video Conference or web conference
 This is sensitive to network congestion, latency, jitter, and other network
 characteristics. Video Conferencing has a symmetrical traffic pattern, but
 unless the network is on an MPLS private network, it cannot use network
 :term:`quality of service (QoS)` to improve performance. Similar to VoIP,
 users are sensitive to network performance issues even at low levels.

High performance computing (HPC)
 This is a complex use case that requires careful consideration of the traffic
 flows and usage patterns to address the needs of cloud clusters. It has high
 east-west traffic patterns for distributed computing, but there can be
 substantial north-south traffic depending on the specific application.

