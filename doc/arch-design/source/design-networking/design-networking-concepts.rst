===================
Networking concepts
===================

A cloud environment fundamentally changes the ways that networking is provided
and consumed. Understanding the following concepts and decisions is imperative
when making architectural decisions. For detailed information on networking
concepts, see the `OpenStack Networking Guide
<https://docs.openstack.org/ocata/networking-guide/>`_.

Network zones
~~~~~~~~~~~~~

The cloud networks are divided into a number of logical zones that support the
network traffic flow requirements. We recommend defining at the least four
distinct network zones.

Underlay
--------

The underlay zone is defined as the physical network switching infrastructure
that connects the storage, compute and control platforms. There are a large
number of potential underlay options available.

Overlay
-------

The overlay zone is defined as any L3 connectivity between the cloud components
and could take the form of SDN solutions such as the neutron overlay solution
or 3rd Party SDN solutions.

Edge
----

The edge zone is where network traffic transitions from the cloud overlay or
SDN networks into the traditional network environments.

External
--------

The external network is defined as the configuration and components that are
required to provide access to cloud resources and workloads, the external
network is defined as all the components outside of the cloud edge gateways.

Traffic flow
~~~~~~~~~~~~

There are two primary types of traffic flow within a cloud infrastructure, the
choice of networking technologies is influenced by the expected loads.

East/West - The internal traffic flow between workload within the cloud as well
as the traffic flow between the compute nodes and storage nodes falls into the
East/West category. Generally this is the heaviest traffic flow and due to the
need to cater for storage access needs to cater for a minimum of hops and low
latency.

North/South - The flow of traffic between the workload and all external
networks, including clients and remote services. This traffic flow is highly
dependant on the workload within the cloud and the type of network services
being offered.

Layer networking choices
~~~~~~~~~~~~~~~~~~~~~~~~

There are several factors to take into consideration when deciding on whether
to use Layer 2 networking architecture or a layer 3 networking architecture.
For more information about OpenStack networking concepts, see the
`OpenStack Networking <https://docs.openstack.org/ocata/networking-guide/intro-os-networking.html#>`_
section in the OpenStack Networking Guide.

Benefits using a Layer-2 network
--------------------------------

There are several reasons a network designed on layer-2 protocols is selected
over a network designed on layer-3 protocols. In spite of the difficulties of
using a bridge to perform the network role of a router, many vendors,
customers, and service providers choose to use Ethernet in as many parts of
their networks as possible. The benefits of selecting a layer-2 design are:

* Ethernet frames contain all the essentials for networking. These include, but
  are not limited to, globally unique source addresses, globally unique
  destination addresses, and error control.

* Ethernet frames can carry any kind of packet. Networking at layer-2 is
  independent of the layer-3 protocol.

* Adding more layers to the Ethernet frame only slows the networking process
  down. This is known as nodal processing delay.

* You can add adjunct networking features, for example class of service (CoS)
  or multicasting, to Ethernet as readily as IP networks.

* VLANs are an easy mechanism for isolating networks.

Most information starts and ends inside Ethernet frames. Today this applies
to data, voice, and video. The concept is that the network will benefit more
from the advantages of Ethernet if the transfer of information from a source
to a destination is in the form of Ethernet frames.

Although it is not a substitute for IP networking, networking at layer-2 can
be a powerful adjunct to IP networking.

Layer-2 Ethernet usage has additional benefits over layer-3 IP network usage:

* Speed
* Reduced overhead of the IP hierarchy.
* No need to keep track of address configuration as systems move around.

Whereas the simplicity of layer-2 protocols might work well in a data center
with hundreds of physical machines, cloud data centers have the additional
burden of needing to keep track of all virtual machine addresses and
networks. In these data centers, it is not uncommon for one physical node
to support 30-40 instances.

.. Important::

   Networking at the frame level says nothing about the presence or
   absence of IP addresses at the packet level. Almost all ports, links, and
   devices on a network of LAN switches still have IP addresses, as do all the
   source and destination hosts. There are many reasons for the continued need
   for IP addressing. The largest one is the need to manage the network. A
   device or link without an IP address is usually invisible to most
   management applications. Utilities including remote access for diagnostics,
   file transfer of configurations and software, and similar applications
   cannot run without IP addresses as well as MAC addresses.

Layer-2 architecture limitations
--------------------------------

Layer-2 network architectures have some limitations that become noticeable when
used outside of traditional data centers.

* Number of VLANs is limited to 4096.
* The number of MACs stored in switch tables is limited.
* You must accommodate the need to maintain a set of layer-4 devices to handle
  traffic control.
* MLAG, often used for switch redundancy, is a proprietary solution that does
  not scale beyond two devices and forces vendor lock-in.
* It can be difficult to troubleshoot a network without IP addresses and ICMP.
* Configuring ARP can be complicated on a large layer-2 networks.
* All network devices need to be aware of all MACs, even instance MACs, so
  there is constant churn in MAC tables and network state changes as instances
  start and stop.
* Migrating MACs (instance migration) to different physical locations are a
  potential problem if you do not set ARP table timeouts properly.

It is important to know that layer-2 has a very limited set of network
management tools. It is difficult to control traffic as it does not have
mechanisms to manage the network or shape the traffic. Network
troubleshooting is also troublesome, in part because network devices have
no IP addresses. As a result, there is no reasonable way to check network
delay.

In a layer-2 network all devices are aware of all MACs, even those that belong
to instances. The network state information in the backbone changes whenever an
instance starts or stops. Because of this, there is far too much churn in the
MAC tables on the backbone switches.

Furthermore, on large layer-2 networks, configuring ARP learning can be
complicated. The setting for the MAC address timer on switches is critical
and, if set incorrectly, can cause significant performance problems. So when
migrating MACs to different physical locations to support instance migration,
problems may arise. As an example, the Cisco default MAC address timer is
extremely long. As such, the network information maintained in the switches
could be out of sync with the new location of the instance.

Benefits using a Layer-3 network
--------------------------------

In layer-3 networking, routing takes instance MAC and IP addresses out of the
network core, reducing state churn. The only time there would be a routing
state change is in the case of a Top of Rack (ToR) switch failure or a link
failure in the backbone itself. Other advantages of using a layer-3
architecture include:

* Layer-3 networks provide the same level of resiliency and scalability
  as the Internet.

* Controlling traffic with routing metrics is straightforward.

* You can configure layer-3 to use Border Gateway Protocol (BGP) confederation
  for scalability. This way core routers have state proportional to the number
  of racks, not to the number of servers or instances.

* There are a variety of well tested tools, such as Internet Control Message
  Protocol (ICMP) to monitor and manage traffic.

* Layer-3 architectures enable the use of :term:`quality of service (QoS)` to
  manage network performance.

Layer-3 architecture limitations
--------------------------------

The main limitation of layer-3 networking is that there is no built-in
isolation mechanism comparable to the VLANs in layer-2 networks. Furthermore,
the hierarchical nature of IP addresses means that an instance is on the same
subnet as its physical host, making migration out of the subnet difficult. For
these reasons, network virtualization needs to use IP encapsulation and
software at the end hosts. This is for isolation and the separation of the
addressing in the virtual layer from the addressing in the physical layer.
Other potential disadvantages of layer-3 networking include the need to design
an IP addressing scheme rather than relying on the switches to keep track of
the MAC addresses automatically, and to configure the interior gateway routing
protocol in the switches.

Networking service (neutron)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Networking (neutron) is the component of OpenStack that provides
the Networking service API and a reference architecture that implements a
Software Defined Network (SDN) solution.

The Networking service provides full control over creation of virtual network
resources to tenants. This is often accomplished in the form of tunneling
protocols that establish encapsulated communication paths over existing
network infrastructure in order to segment tenant traffic. This method varies
depending on the specific implementation, but some of the more common methods
include tunneling over GRE, encapsulating with VXLAN, and VLAN tags.
