
=======================
OpenStack network nodes
=======================

Configure networking on each node.
The
`Networking <http://docs.openstack.org/liberty/install-guide-ubuntu/environment-networking.html>`_
section of the *Install Guide* includes basic information
about configuring networking.

Notes from planning outline:

- Rather than configuring neutron here,
  we should simply mention physical network HA methods
  such as bonding and additional node/network requirements
  for L3HA and DVR for planning purposes.
- Neutron agents shuld be described for active/active;
  deprecate single agent's instances case.
- For Kilo and beyond, focus on L3HA and DVR.
- Link to `Networking Guide <http://docs.openstack.org/networking-guide/>`_
  for configuration details.

[TODO: Verify that the active/passive
network configuration information from
`<http://docs.openstack.org/high-availability-guide/content/s-neutron-server.html>`_
should not be included here.

`LP1328922 <https://bugs.launchpad.net/openstack-manuals/+bug/1328922>`_
and
`LP1349398 <https://bugs.launchpad.net/openstack-manuals/+bug/1349398>`_
are related.]

OpenStack network nodes contain:

- :ref:`Neutron DHCP agent<dhcp-agent>`
- Neutron L2 agent.
  Note that the L2 agent cannot be distributed and highly available.
  Instead, it must be installed on each data forwarding node
  to control the virtual network drivers
  such as Open vSwitch or Linux Bridge.
  One L2 agent runs per node and controls its virtual interfaces.
- :ref:`Neutron L3 agent<neutron-l3>`
- :ref:`Neutron metadata agent<neutron-metadata>`
- :ref:`Neutron LBaaS<neutron-lbaas>` (Load Balancing as a Service) agent

.. note::

   For Liberty, we do not have the standalone network nodes in general.
   We usually run the Networking services on the controller nodes.
   In this guide, we use the term "network nodes" for convenience.

.. toctree::
   :maxdepth: 2

   networking-ha-dhcp.rst
   networking-ha-l3.rst
   networking-ha-metadata.rst
   networking-ha-lbaas.rst

