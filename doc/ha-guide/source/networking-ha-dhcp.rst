
.. _dhcp-agent:

======================
Run neutron DHCP agent
======================

The OpenStack Networking service has a scheduler
that lets you run multiple agents across nodes;
the DHCP agent can be natively highly available.
To configure the number of DHCP agents per network,
modify the ``dhcp_agents_per_network`` parameter
in the :file:`/etc/neutron/neutron.conf` file.
By default this is set to 1.
To achieve high availability,
assign more than one DHCP agent per network.

