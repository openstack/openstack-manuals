=======================
Database configurations
=======================

You can configure OpenStack services to use any SQLAlchemy-compatible database.

To ensure that the database schema is current, run the following command:

.. code-block:: console

   # SERVICE-manage db sync

To configure the connection string for the database,
use the configuration option settings documented in the table
:ref:`common-database`.

.. include:: ../tables/common-database.rst
