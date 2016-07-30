=================
Telemetry service
=================

.. toctree::

   telemetry/telemetry-config-options.rst
   telemetry/alarming-config-options.rst
   telemetry/logs.rst
   telemetry/samples/index.rst
   tables/conf-changes/aodh.rst
   tables/conf-changes/ceilometer.rst

The Telemetry service collects measurements within OpenStack. Its
various agents and services are configured in the
``/etc/ceilometer/ceilometer.conf`` file.

To install Telemetry, see the OpenStack Installation Guide for your
distribution (`docs.openstack.org <http://docs.openstack.org>`__).

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.
