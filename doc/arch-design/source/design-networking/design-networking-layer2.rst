==================
Layer 2 networking
==================

This section describes the concepts and choices to take into
account when deciding on the configuration of Layer 2 networking.

Layer-2 architecture advantages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A network designed on layer-2 protocols has advantages over a network designed
on layer-3 protocols. In spite of the difficulties of using a bridge to perform
the network role of a router, many vendors, customers, and service providers
choose to use Ethernet in as many parts of their networks as possible. The
benefits of selecting a layer-2 design are:

* Ethernet frames contain all the essentials for networking. These include, but
  are not limited to, globally unique source addresses, globally unique
  destination addresses, and error control.

* Ethernet frames contain all the essentials for networking. These include,
  but are not limited to, globally unique source addresses, globally unique
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

Layer-2 Ethernet usage has these additional advantages over layer-3 IP network
usage:

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
