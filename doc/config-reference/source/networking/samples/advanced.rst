================================================
Networking advanced services configuration files
================================================

The Networking advanced services such as Load-Balancer-as-a-Service (LBaaS),
Firewall-as-a-Service (FWaaS), and VPN-as-a-Service (VPNaaS) implement
the automatic generation of configuration files. Here are the sample
configuration files and you can generate the latest configuration files
by running the ``generate_config_file_samples.sh`` script provided by
each `LBaaS
<https://git.openstack.org/cgit/openstack/neutron-lbaas/tree/tools/generate_config_file_samples.sh>`__,
`FWaaS
<https://git.openstack.org/cgit/openstack/neutron-fwaas/tree/tools/generate_config_file_samples.sh>`__,
and `VPNaaS
<https://git.openstack.org/cgit/openstack/neutron-vpnaas/tree/tools/generate_config_file_samples.sh>`__
services on their root directory.

Load-Balancer-as-a-Service (LBaaS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. toctree::

   neutron_lbaas.conf.rst
   lbaas_agent.ini.rst
   services_lbaas.conf.rst

VPN-as-a-Service (VPNaaS)
~~~~~~~~~~~~~~~~~~~~~~~~~

.. toctree::

   neutron_vpnaas.conf.rst
   vpn_agent.ini.rst
