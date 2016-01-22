===================
Tunnel technologies
===================

Tunneling allows one network protocol to encapsulate another payload
protocol such that packets from the payload protocol are passed as
data on the delivery protocol. For example, this can be used to pass
data securely over an untrusted network.

Generic routing encapsulation (GRE)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GRE carries IP packets with private IP addresses over the Internet
using delivery packets with public IP addresses.

.. _VXLAN:

Virtual extensible local area network (VXLAN)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A VXLAN, virtual extensible local area network, allows the creation of
a logical network for virtual machines across various networks. VXLAN
encapsulates layer-2 Ethernet frames over layer-4 UDP packets.
