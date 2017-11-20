==================================
Container reconciler configuration
==================================

Find an example container sync realms configuration at
``etc/container-reconciler.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-container-reconciler-DEFAULT.rst
.. include:: ../tables/swift-container-reconciler-app-proxy-server.rst
.. include:: ../tables/swift-container-reconciler-container-reconciler.rst
.. include:: ../tables/swift-container-reconciler-filter-cache.rst
.. include:: ../tables/swift-container-reconciler-filter-catch_errors.rst
.. include:: ../tables/swift-container-reconciler-filter-proxy-logging.rst
.. include:: ../tables/swift-container-reconciler-pipeline-main.rst

Sample container sync reconciler configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/container-reconciler.conf-sample?h=mitaka-eol
