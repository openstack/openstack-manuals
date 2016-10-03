================================================
Load-Balancer-as-a-Service configuration options
================================================

Use the following options in the ``neutron_lbaas.conf`` file for the
LBaaS agent.

.. note::

   The common configurations for shared services and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`../common-configurations`.

.. include:: ../tables/neutron-lbaas.rst

Use the following options in the ``lbaas_agent.ini`` file for the
LBaaS agent.

.. include:: ../tables/neutron-lbaas_agent.rst

Use the following options in the ``services_lbaas.conf`` file for the
LBaaS agent.

.. include:: ../tables/neutron-lbaas_services.rst

Octavia configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Octavia is an operator-grade open source load balancing solution.
Use the following options in the ``/etc/octavia/octavia.conf`` file
to configure the octavia service.

.. include:: ../tables/octavia-auth_token.rst
.. include:: ../tables/octavia-common.rst
.. include:: ../tables/octavia-redis.rst
