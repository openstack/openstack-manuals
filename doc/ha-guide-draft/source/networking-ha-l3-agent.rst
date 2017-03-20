========
L3 Agent
========
.. TODO: Introduce L3 agent

HA Routers
~~~~~~~~~~
.. TODO: content for HA routers

Networking DHCP agent
~~~~~~~~~~~~~~~~~~~~~
The OpenStack Networking (neutron) service has a scheduler that lets you run
multiple agents across nodes. The DHCP agent can be natively highly available.

To configure the number of DHCP agents per network, modify the
``dhcp_agents_per_network`` parameter in the :file:`/etc/neutron/neutron.conf`
file. By default this is set to 1. To achieve high availability, assign more
than one DHCP agent per network. For more information, see
`High-availability for DHCP
<https://docs.openstack.org/newton/networking-guide/config-dhcp-ha.html>`_.
