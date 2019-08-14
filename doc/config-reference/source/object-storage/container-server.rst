==============================
Container server configuration
==============================

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://opendev.org/openstack/swift/raw/tag/newton-eol/etc/container-server.conf-sample
