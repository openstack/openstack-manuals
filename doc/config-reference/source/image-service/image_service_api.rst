=================
Configure the API
=================

The Image service has two APIs: the user-facing API, and the registry
API, which is for internal requests that require access to the database.

Both of the APIs currently have two major versions, v1 and v2. It is
possible to run either or both versions, by setting appropriate values
of ``enable_v1_api``, ``enable_v2_api``, ``enable_v1_registry`` and
``enable_v2_registry``. If the v2 API is used, running
``glance-registry`` is optional, as v2 of ``glance-api`` can connect
directly to the database.

Tables of all the options used to configure the APIs, including enabling
SSL and modifying WSGI settings are found below.

.. include:: ../tables/glance-api.rst
.. include:: ../tables/glance-ca.rst
