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

neutron_lbaas.conf
------------------

.. literalinclude:: ../samples/neutron-lbaas/neutron_lbaas.conf.sample
   :language: ini

lbaas_agent.ini
---------------

.. literalinclude:: ../samples/neutron-lbaas/lbaas_agent.ini.sample
   :language: ini

services_lbaas.conf
-------------------

.. literalinclude:: ../samples/neutron-lbaas/services_lbaas.conf.sample
   :language: ini

VPN-as-a-Service (VPNaaS)
~~~~~~~~~~~~~~~~~~~~~~~~~

neutron_vpnaas.conf
-------------------

.. literalinclude:: ../samples/neutron-vpnaas/neutron_vpnaas.conf.sample
   :language: ini

vpn_agent.ini
-------------

.. literalinclude:: ../samples/neutron-vpnaas/vpn_agent.ini.sample
   :language: ini
