============================
Log files used by Networking
============================

The corresponding log file of each Networking service is stored in the
``/var/log/neutron/`` directory of the host on which each service
runs.

.. list-table:: Log files used by Networking services
   :header-rows: 1

   * - Log file
     - Service/interface
   * - ``dhcp-agent.log``
     - ``neutron-dhcp-agent``
   * - ``l3-agent.log``
     - ``neutron-l3-agent``
   * - ``lbaas-agent.log``
     - ``neutron-lbaas-agent`` [#f1]_
   * - ``linuxbridge-agent.log``
     - ``neutron-linuxbridge-agent``
   * - ``metadata-agent.log``
     - ``neutron-metadata-agent``
   * - ``metering-agent.log``
     - ``neutron-metering-agent``
   * - ``openvswitch-agent.log``
     - ``neutron-openvswitch-agent``
   * - ``server.log``
     - ``neutron-server``

.. [#f1] The ``neutron-lbaas-agent`` service only runs when
         Load-Balancer-as-a-Service is enabled.
