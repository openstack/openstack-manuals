===============
Compute service
===============

.. toctree::
   :maxdepth: 1

   compute/nova-conf.rst
   compute/api.rst
   compute/logging.rst
   compute/authentication-authorization.rst
   compute/resize.rst
   compute/database-connections.rst
   compute/rpc.rst
   compute/fibre-channel.rst
   compute/iscsi-offload.rst
   compute/hypervisors.rst
   compute/scheduler.rst
   compute/cells.rst
   compute/conductor.rst
   compute/config-options.rst
   compute/logs.rst
   compute/nova-conf-samples.rst
   compute/samples/index.rst
   tables/conf-changes/nova.rst

The Compute service is a cloud computing fabric controller,
which is the main part of an IaaS system.
You can use OpenStack Compute to host and manage cloud computing systems.
This section describes the Compute service configuration options.

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.

To configure your Compute installation,
you must define configuration options in these files:

* ``nova.conf``. Contains most of the Compute configuration options.
  Resides in the ``/etc/nova`` directory.
* ``api-paste.ini``. Defines Compute limits.
  Resides in the ``/etc/nova`` directory.
* Related Image service and Identity service management configuration files.
