===========================
Object server configuration
===========================

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://opendev.org/openstack/swift/raw/tag/newton-eol/etc/object-server.conf-sample
