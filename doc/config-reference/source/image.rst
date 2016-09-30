=============
Image service
=============

.. toctree::
   :maxdepth: 1

   image/api.rst
   image/backends.rst
   image/config-options.rst
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
