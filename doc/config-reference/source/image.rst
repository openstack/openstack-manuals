=============
Image service
=============

.. toctree::

   image/api.rst
   image/rpc.rst
   image/backends.rst
   image/logs.rst
   image/sample-configuration-files.rst
   tables/conf-changes/glance.rst

Compute relies on an external image service to store virtual machine images and
maintain a catalog of available images. By default, Compute is configured to
use the Image service (glance), which is currently the only supported image
service.

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.

To customize the Compute service, use the configuration option settings
documented in :ref:`nova-glance`.

You can modify many options in the Image service. The following tables provide
a comprehensive list.

.. include:: tables/glance-common.rst
.. include:: tables/glance-imagecache.rst
.. include:: tables/glance-profiler.rst
.. include:: tables/glance-redis.rst
.. include:: tables/glance-registry.rst
.. include:: tables/glance-replicator.rst
.. include:: tables/glance-scrubber.rst
.. include:: tables/glance-taskflow.rst
.. include:: tables/glance-testing.rst
