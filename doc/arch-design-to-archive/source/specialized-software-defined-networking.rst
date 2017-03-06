===========================
Software-defined networking
===========================

Software-defined networking (SDN) is the separation of the data
plane and control plane. SDN is a popular method of
managing and controlling packet flows within networks.
SDN uses overlays or directly controlled layer-2 devices to
determine flow paths, and as such presents challenges to a
cloud environment. Some designers may wish to run their
controllers within an OpenStack installation. Others may wish
to have their installations participate in an SDN-controlled network.

Challenges
~~~~~~~~~~

SDN is a relatively new concept that is not yet standardized,
so SDN systems come in a variety of different implementations.
Because of this, a truly prescriptive architecture is not feasible.
Instead, examine the differences between an existing and a planned
OpenStack design and determine where potential conflicts and gaps exist.

Possible solutions
~~~~~~~~~~~~~~~~~~

If an SDN implementation requires layer-2 access because it
directly manipulates switches, we do not recommend running an
overlay network or a layer-3 agent.
If the controller resides within an OpenStack installation,
it may be necessary to build an ML2 plug-in and schedule the
controller instances to connect to project VLANs that they can
talk directly to the switch hardware.
Alternatively, depending on the external device support,
use a tunnel that terminates at the switch hardware itself.

Diagram
-------

OpenStack hosted SDN controller:

.. figure:: figures/Specialized_SDN_hosted.png

OpenStack participating in an SDN controller network:

.. figure:: figures/Specialized_SDN_external.png

