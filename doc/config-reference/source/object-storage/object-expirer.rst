============================
Object expirer configuration
============================

Find an example object expirer configuration at
``etc/object-expirer.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-object-expirer-DEFAULT.rst
.. include:: ../tables/swift-object-expirer-app-proxy-server.rst
.. include:: ../tables/swift-object-expirer-filter-cache.rst
.. include:: ../tables/swift-object-expirer-filter-catch_errors.rst
.. include:: ../tables/swift-object-expirer-filter-proxy-logging.rst
.. include:: ../tables/swift-object-expirer-object-expirer.rst
.. include:: ../tables/swift-object-expirer-pipeline-main.rst

Sample object expirer configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://opendev.org/openstack/swift/raw/tag/newton-eol/etc/object-expirer.conf-sample
