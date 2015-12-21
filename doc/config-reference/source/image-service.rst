=============
Image service
=============

.. toctree::

   image-service/image_service_api.rst
   image-service/image_service_rpc.rst
   image-service/image_service_ISO_support.rst
   image-service/image_service_backends.rst
   image-service/sample-configuration-files.rst
   tables/conf-changes/glance.rst

Compute relies on an external image service to store virtual machine images and
maintain a catalog of available images. By default, Compute is configured to
use the Image service (glance), which is currently the only supported image
service.

If your installation requires :command:`euca2ools` to register new images, you
must run the ``nova-objectstore`` service. This service provides an Amazon S3
front end for the Image service, which is required by :command:`euca2ools`.

To customize the Compute service, use the configuration option settings
documented in :ref:`nova-glance` and :ref:`nova-s3`.

You can modify many options in the Image service. The following tables provide
a comprehensive list.

.. include:: tables/glance-auth_token.rst
.. include:: tables/glance-common.rst
.. include:: tables/glance-cors.rst
.. include:: tables/glance-database.rst
.. include:: tables/glance-imagecache.rst
.. include:: tables/glance-logging.rst
.. include:: tables/glance-policy.rst
.. include:: tables/glance-profiler.rst
.. include:: tables/glance-redis.rst
.. include:: tables/glance-registry.rst
.. include:: tables/glance-replicator.rst
.. include:: tables/glance-scrubber.rst
.. include:: tables/glance-taskflow.rst
.. include:: tables/glance-testing.rst
