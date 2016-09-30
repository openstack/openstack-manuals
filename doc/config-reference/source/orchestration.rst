=====================
Orchestration service
=====================

.. toctree::

   orchestration/api.rst
   orchestration/clients.rst
   orchestration/config-options.rst
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
