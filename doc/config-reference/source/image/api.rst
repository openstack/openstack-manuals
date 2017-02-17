=======================
Image API configuration
=======================

The Image service has two APIs: the user-facing API, and the registry
API, which is for internal requests that require access to the database.

Both of the APIs currently have two major versions: v1 (SUPPORTED) and
v2 (CURRENT). You can run either or both versions by setting
appropriate values of ``enable_v1_api``, ``enable_v2_api``,
``enable_v1_registry``, and ``enable_v2_registry``.
Running ``glance-registry`` is optional if using the v2 ``glance-api``
as it can connect directly to the database.

To assist you in formulating your deployment strategy for the Image APIs,
the Glance team has published a statement concerning the status and
development plans of the APIs: `Using public Image API
<https://docs.openstack.org/developer/glance/glanceapi.html>`_.

Configuration options
~~~~~~~~~~~~~~~~~~~~~

Tables of all the options used to configure the APIs, including enabling
SSL and modifying WSGI settings are found below.

.. include:: ../tables/glance-api.rst
.. include:: ../tables/glance-ca.rst
