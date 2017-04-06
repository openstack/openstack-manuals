============================
Account server configuration
============================

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/swift/plain/etc/account-server.conf-sample?h=stable/ocata
