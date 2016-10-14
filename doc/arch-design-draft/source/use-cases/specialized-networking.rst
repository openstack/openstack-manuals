==============================
Specialized networking example
==============================

Some applications that interact with a network require
specialized connectivity. For example, applications used in Looking Glass
servers require the ability to connect to a Border Gateway Protocol (BGP) peer,
or route participant applications may need to join a layer-2 network.

Challenges
~~~~~~~~~~

Connecting specialized network applications to their required
resources impacts the OpenStack architecture design. Installations that
rely on overlay networks cannot support a routing participant, and may
also block listeners on a layer-2 network.

Possible solutions
~~~~~~~~~~~~~~~~~~

Deploying an OpenStack installation using OpenStack Networking with a
provider network allows direct layer-2 connectivity to an
upstream networking device. This design provides the layer-2 connectivity
required to communicate through Intermediate System-to-Intermediate System
(ISIS) protocol, or pass packets using an OpenFlow controller.

Using the multiple layer-2 plug-in with an agent such as
:term:`Open vSwitch` allows a private connection through a VLAN
directly to a specific port in a layer-3 device. This allows a BGP
point-to-point link to join the autonomous system.

Avoid using layer-3 plug-ins as they divide the broadcast
domain and prevent router adjacencies from forming.
