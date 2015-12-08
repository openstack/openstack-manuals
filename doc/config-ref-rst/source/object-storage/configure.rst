========================
Configure Object Storage
========================

OpenStack Object Storage uses multiple configuration files for multiple
services and background daemons, and ``paste.deploy`` to manage server
configurations. Default configuration options appear in the ``[DEFAULT]``
section. You can override the default values by setting values in the other
sections.

Object server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Find an example object server configuration at
``etc/object-server.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-object-server-DEFAULT.rst
.. include:: ../tables/swift-object-server-app-object-server.rst
.. include:: ../tables/swift-object-server-pipeline-main.rst
.. include:: ../tables/swift-object-server-object-replicator.rst
.. include:: ../tables/swift-object-server-object-updater.rst
.. include:: ../tables/swift-object-server-object-auditor.rst
.. include:: ../tables/swift-object-server-filter-healthcheck.rst
.. include:: ../tables/swift-object-server-filter-recon.rst
.. include:: ../tables/swift-object-server-filter-xprofile.rst

Sample object server configuration file
---------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/object-server.conf-sample?h=stable/liberty

Object expirer configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
----------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/object-expirer.conf-sample?h=stable/liberty

Container server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Find an example container server configuration at
``etc/container-server.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-container-server-DEFAULT.rst
.. include:: ../tables/swift-container-server-app-container-server.rst
.. include:: ../tables/swift-container-server-pipeline-main.rst
.. include:: ../tables/swift-container-server-container-replicator.rst
.. include:: ../tables/swift-container-server-container-updater.rst
.. include:: ../tables/swift-container-server-container-auditor.rst
.. include:: ../tables/swift-container-server-container-sync.rst
.. include:: ../tables/swift-container-server-filter-healthcheck.rst
.. include:: ../tables/swift-container-server-filter-recon.rst
.. include:: ../tables/swift-container-server-filter-xprofile.rst

Sample container server configuration file
------------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/container-server.conf-sample?h=stable/liberty

Container sync realms configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Find an example container sync realms configuration at
``etc/container-sync-realms.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-container-sync-realms-DEFAULT.rst
.. include:: ../tables/swift-container-sync-realms-realm1.rst
.. include:: ../tables/swift-container-sync-realms-realm2.rst

Sample container sync realms configuration file
-----------------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/container-sync-realms.conf-sample?h=stable/liberty

Container reconciler configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
---------------------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/container-reconciler.conf-sample?h=stable/liberty

Account server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Find an example account server configuration at
``etc/account-server.conf-sample`` in the source code repository.

The available configuration options are:

.. include:: ../tables/swift-account-server-DEFAULT.rst
.. include:: ../tables/swift-account-server-app-account-server.rst
.. include:: ../tables/swift-account-server-pipeline-main.rst
.. include:: ../tables/swift-account-server-account-replicator.rst
.. include:: ../tables/swift-account-server-account-auditor.rst
.. include:: ../tables/swift-account-server-account-reaper.rst
.. include:: ../tables/swift-account-server-filter-healthcheck.rst
.. include:: ../tables/swift-account-server-filter-recon.rst
.. include:: ../tables/swift-account-server-filter-xprofile.rst

Sample account server configuration file
----------------------------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/account-server.conf-sample?h=stable/liberty

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

   https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/liberty

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
