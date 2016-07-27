=====================
Orchestration service
=====================

.. toctree::

   orchestration/api.rst
   orchestration/clients.rst
   orchestration/rpc.rst
   orchestration/logs.rst
   tables/conf-changes/heat.rst


The Orchestration service is designed to manage the lifecycle of infrastructure
and applications within OpenStack clouds. Its various agents and services are
configured in the ``/etc/heat/heat.conf`` file.

To install Orchestration, see the OpenStack Installation Guide for your
distribution (`docs.openstack.org <http://docs.openstack.org>`__).

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.

The following tables provide a comprehensive list of the Orchestration
configuration options:

.. include:: tables/heat-common.rst
.. include:: tables/heat-crypt.rst
.. include:: tables/heat-loadbalancer.rst
.. include:: tables/heat-quota.rst
.. include:: tables/heat-redis.rst
.. include:: tables/heat-testing.rst
.. include:: tables/heat-trustee.rst
