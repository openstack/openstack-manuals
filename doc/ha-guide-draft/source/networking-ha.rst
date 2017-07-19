===================================
Configuring the networking services
===================================

Configure networking on each node. See the basic information about
configuring networking in the Networking service section of the
`Install Tutorials and Guides <https://docs.openstack.org/ocata/install/>`_,
depending on your distribution.

OpenStack network nodes contain:

- Networking DHCP agent
- Neutron L3 agent
- Networking L2 agent

.. note::

   The L2 agent cannot be distributed and highly available. Instead, it
   must be installed on each data forwarding node to control the virtual
   network driver such as Open vSwitch or Linux Bridge. One L2 agent runs
   per node and controls its virtual interfaces.

.. toctree::
   :maxdepth: 2

   networking-ha-neutron-server.rst
   networking-ha-neutron-l3-analysis.rst
   networking-ha-l3-agent.rst

