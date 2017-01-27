===================================
Configuring the networking services
===================================

.. toctree::
   :maxdepth: 2

   networking-ha-dhcp.rst
   networking-ha-l3.rst

Configure networking on each node. See the basic information
about configuring networking in the *Networking service*
section of the
`Install Tutorials and Guides <https://docs.openstack.org/project-install-guide/newton>`_,
depending on your distribution.

OpenStack network nodes contain:

- :doc:`Networking DHCP agent<networking-ha-dhcp>`
- :doc:`Neutron L3 agent<networking-ha-l3>`
- Networking L2 agent

  .. note::

     The L2 agent cannot be distributed and highly available.
     Instead, it must be installed on each data forwarding node
     to control the virtual network driver such as Open vSwitch
     or Linux Bridge. One L2 agent runs per node and controls its
     virtual interfaces.

.. note::

   For Liberty, you can not have the standalone network nodes.
   The Networking services are run on the controller nodes.
   In this guide, the term `network nodes` is used for convenience.
