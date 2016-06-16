======================================
VPN-as-a-Service configuration options
======================================

Use the following options in the ``vpnaas_agent.ini`` file for the
VPNaaS agent.

.. include:: ../tables/neutron-vpnaas.rst
.. include:: ../tables/neutron-vpnaas_ipsec.rst
.. include:: ../tables/neutron-vpnaas_openswan.rst
.. include:: ../tables/neutron-vpnaas_strongswan.rst

.. note::

   ``strongSwan`` and ``Openswan`` cannot both be installed and enabled at the
   same time. The ``vpn_device_driver`` configuration option in the
   ``vpnaas_agent.ini`` file is an option that lists the VPN device
   drivers that the Networking service will use. You must choose either
   ``strongSwan`` or ``Openswan`` as part of the list.

.. important::

   Ensure that your ``strongSwan`` version is 5 or newer.

To declare either one in the ``vpn_device_driver``:

.. code-block:: ini

   #Openswan
   vpn_device_driver = ['neutron_vpnaas.services.vpn.device_drivers.ipsec.OpenSwanDriver']

   #strongSwan
   vpn_device_driver = ['neutron.services.vpn.device_drivers.strongswan_ipsec.StrongSwanDriver']
