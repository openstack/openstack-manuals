==========================
Proxy server configuration
==========================

Find an example proxy server configuration at
``etc/proxy-server.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-proxy-server-app-proxy-server.rst
.. include:: ../tables/swift-proxy-server-pipeline-main.rst
.. include:: ../tables/swift-proxy-server-filter-account-quotas.rst
.. include:: ../tables/swift-proxy-server-filter-authtoken.rst
.. include:: ../tables/swift-proxy-server-filter-cache.rst
.. include:: ../tables/swift-proxy-server-filter-catch_errors.rst
.. include:: ../tables/swift-proxy-server-filter-container_sync.rst
.. include:: ../tables/swift-proxy-server-filter-dlo.rst
.. include:: ../tables/swift-proxy-server-filter-versioned_writes.rst
.. include:: ../tables/swift-proxy-server-filter-gatekeeper.rst
.. include:: ../tables/swift-proxy-server-filter-healthcheck.rst
.. include:: ../tables/swift-proxy-server-filter-keystoneauth.rst
.. include:: ../tables/swift-proxy-server-filter-list-endpoints.rst
.. include:: ../tables/swift-proxy-server-filter-proxy-logging.rst
.. include:: ../tables/swift-proxy-server-filter-tempauth.rst
.. include:: ../tables/swift-proxy-server-filter-xprofile.rst

Sample proxy server configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=mitaka-eol
