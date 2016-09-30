======================
Database configuration
======================

You can configure OpenStack Compute to use any SQLAlchemy-compatible database.
The database name is ``nova``. The ``nova-conductor`` service is the only
service that writes to the database. The other Compute services access
the database through the ``nova-conductor`` service.

To ensure that the database schema is current, run the following command:

.. code-block:: console

   # nova-manage db sync

If ``nova-conductor`` is not used, entries to the database are mostly
written by the ``nova-scheduler`` service, although all services must
be able to update entries in the database.

In either case, use the configuration option settings documented in
:doc:`../common-configurations/database` to configure the connection string
for the nova database.
