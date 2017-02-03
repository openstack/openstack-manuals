===============
Compute service
===============

The Compute service is a cloud computing fabric controller,
which is the main part of an *Infrastructure as a Service* (IaaS) system.
You can use OpenStack Compute to host and manage cloud computing systems.
This section describes the Compute service configuration options.

To configure your Compute installation,
you must define configuration options in these files:

* ``nova.conf`` contains most of the Compute configuration options and
  resides in the ``/etc/nova`` directory.
* ``api-paste.ini`` defines Compute limits and resides in the
  ``/etc/nova`` directory.
* Related Image service and Identity service management configuration files.

For a quick overview:

.. toctree::
   :maxdepth: 1

   The full set of available options <compute/config-options>
   tables/conf-changes/nova

A list of config options based on different topics can be found below:

.. toctree::
   :maxdepth: 1

   compute/nova-conf.rst
   compute/api.rst
   compute/resize.rst
   compute/database-connections.rst
   compute/fibre-channel.rst
   compute/iscsi-offload.rst
   compute/hypervisors.rst
   compute/schedulers.rst
   compute/cells.rst
   compute/logs.rst
   compute/nova-conf-samples.rst
   compute/samples/index.rst

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.


