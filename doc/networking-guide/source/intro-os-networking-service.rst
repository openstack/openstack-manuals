===============================
Service and component hierarchy
===============================

Server
~~~~~~

Overview and concepts
---------------------

* Provides API, manages database, etc.

Plug-ins
~~~~~~~~

Overview and concepts
---------------------

* Manages agents

Agents
~~~~~~

Overview and concepts
---------------------

* Provides layer 2/3 connectivity to instances

* Handles physical-virtual network transition

* Handles metadata, etc.

Layer 2 (Ethernet and Switching)
--------------------------------

* Linux Bridge

  * Overview and concepts

* OVS

  * Overview and concepts

Layer 3 (IP and Routing)
------------------------

* L3

  * Overview and concepts

* DHCP

  * Overview and concepts

Miscellaneous
-------------

* Metadata

  * Overview and concepts

Services
~~~~~~~~

Routing services
----------------

VPNaaS
------

The Virtual Private Network-as-a-Service (VPNaaS) is a neutron
extension that introduces the VPN feature set.

LbaaS
-----

The Load-Balancer-as-a-Service (LBaaS) API provisions and configures
load balancers. The reference implementation is based on the HAProxy
software load balancer.

FwaaS
-----

The Firewall-as-a-Service (FWaaS) API is an experimental API that
enables early adopters and vendors to test their networking
implementations.
