==============================
Specialized networking example
==============================

Some applications that interact with a network require
specialized connectivity. Applications such as a looking glass
require the ability to connect to a BGP peer, or route participant
applications may need to join a network at a layer2 level.

Challenges
~~~~~~~~~~

Connecting specialized network applications to their required
resources alters the design of an OpenStack installation.
Installations that rely on overlay networks are unable to
support a routing participant, and may also block layer-2 listeners.

Possible solutions
~~~~~~~~~~~~~~~~~~

Deploying an OpenStack installation using OpenStack Networking with a
provider network allows direct layer-2 connectivity to an
upstream networking device.
This design provides the layer-2 connectivity required to communicate
via Intermediate System-to-Intermediate System (ISIS) protocol or
to pass packets controlled by an OpenFlow controller.
Using the multiple layer-2 plug-in with an agent such as
:term:`Open vSwitch` allows a private connection through a VLAN
directly to a specific port in a layer-3 device.
This allows a BGP point-to-point link to join the autonomous system.
Avoid using layer-3 plug-ins as they divide the broadcast
domain and prevent router adjacencies from forming.
