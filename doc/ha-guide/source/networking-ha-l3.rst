
.. _neutron-l3:

====================
Run neutron L3 agent
====================

The neutron L3 agent is scalable, due to the scheduler that supports
Virtual Router Redundancy Protocol (VRRP)
to distribute virtual routers across multiple nodes.
To enable high availability for configured routers,
edit the :file:`/etc/neutron/neutron.conf` file
to set the following values:

.. list-table:: /etc/neutron/neutron.conf parameters for high availability
   :widths: 15 10 30
   :header-rows: 1

   * - Parameter
     - Value
     - Description
   * - l3_ha
     - True
     - All routers are highly available by default.
   * - allow_automatic_l3agent_failover
     - True
     - Set automatic L3 agent failover for routers
   * - max_l3_agents_per_router
     - 2 or more
     - Maximum number of network nodes to use for the HA router.
   * - min_l3_agents_per_router
     - 2 or more
     - Minimum number of network nodes to use for the HA router.
       A new router can be created only if this number
       of network nodes are available.


