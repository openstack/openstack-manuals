==========
Networking
==========

OpenStack provides a rich networking environment. This chapter
details the requirements and options to consider when designing your
cloud. This includes examples of network implementations to
consider, information about some OpenStack network layouts and networking
services that are essential for stable operation.

.. warning::

   If this is the first time you are deploying a cloud infrastructure
   in your organization, your first conversations should be with your
   networking team. Network usage in a running cloud is vastly different
   from traditional network deployments and has the potential to be
   disruptive at both a connectivity and a policy level.

   For example, you must plan the number of IP addresses that you need for
   both your guest instances as well as management infrastructure.
   Additionally, you must research and discuss cloud network connectivity
   through proxy servers and firewalls.

See the `OpenStack Security Guide <https://docs.openstack.org/sec/>`_ for tips
on securing your network.

Networking (neutron)
~~~~~~~~~~~~~~~~~~~~

OpenStack Networking (neutron) is the component of OpenStack that provides
the Networking service API and a reference architecture that implements a
Software Defined Network (SDN) solution.

The Networking service provides full control over creation of virtual network
resources to tenants. This is often accomplished in the form of tunneling
protocols that establish encapsulated communication paths over existing
network infrastructure in order to segment tenant traffic. This method varies
depending on the specific implementation, but some of the more common methods
include tunneling over GRE, encapsulating with VXLAN, and VLAN tags.

.. toctree::
   :maxdepth: 2

   design-networking/design-networking-concepts
   design-networking/design-networking-design
   design-networking/design-networking-layer2
   design-networking/design-networking-layer3
   design-networking/design-networking-services
