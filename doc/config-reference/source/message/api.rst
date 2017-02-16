=========================
Message API configuration
=========================

The Message service has two APIs: the HTTP REST API for WSGI transport driver,
and the Websocket API for Websocket transport driver. The Message service can
use only one transport driver at the same time. See :doc:`zaqar-drivers` for
driver options.

The functionality and behavior of the APIs are defined by API versions. For
example, the Websocket API v2 acts the same as the HTTP REST API v2. For now
there are v1, v1.1 and v2 versions of HTTP REST API and only v2 version of
Websocket API.

Permission control options in each API version:

* The v1 does not have any permission options.
* The v1.1 has only ``admin_mode`` option which controls the global
  permission to access the pools and flavors functionality.
* The v2 has only:

  * RBAC policy options: ``policy_default_rule``, ``policy_dirs``,
    ``policy_file`` which controls the permissions to access each type of
    functionality for different types of users. See :doc:`../policy-yaml-file`.
  * ``secret_key`` option which defines a secret key to use for signing
    special URLs. These are called pre-signed URLs and give temporary
    permissions to outsiders of the system.

Configuration options
~~~~~~~~~~~~~~~~~~~~~

The Message service can be configured by changing the following options:

.. include:: ../tables/zaqar-api.rst
