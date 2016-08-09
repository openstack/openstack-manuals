========================
Configure Object Storage
========================

OpenStack Object Storage uses multiple configuration files for multiple
services and background daemons, and ``paste.deploy`` to manage server
configurations. Default configuration options appear in the ``[DEFAULT]``
section. You can override the default values by setting values in the other
sections.

Proxy server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

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
--------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/mitaka

Proxy server memcache configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Find an example memcache configuration for the proxy server at
``etc/memcache.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-memcache-memcache.rst

Rsyncd configuration
~~~~~~~~~~~~~~~~~~~~

Find an example rsyncd configuration at ``etc/rsyncd.conf-sample`` in
the source code repository.

The available configuration options are:

.. include:: ../tables/swift-rsyncd-account.rst
.. include:: ../tables/swift-rsyncd-container.rst
.. include:: ../tables/swift-rsyncd-object.rst
.. include:: ../tables/swift-rsyncd-object6010.rst
.. include:: ../tables/swift-rsyncd-object6020.rst
.. include:: ../tables/swift-rsyncd-object6030.rst
.. include:: ../tables/swift-rsyncd-object6040.rst
.. include:: ../tables/swift-rsyncd-object_sda.rst
.. include:: ../tables/swift-rsyncd-object_sdb.rst
.. include:: ../tables/swift-rsyncd-object_sdc.rst
