==================
Layer 3 networking
==================

This section describes the concepts and choices to take into
account when deciding on the configuration of Layer 3 networking.

Layer-3 architecture advantages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
