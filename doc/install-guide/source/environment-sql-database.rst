SQL database
~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <https://www.postgresql.org/>`__.

.. note::

   If you see ``Too many connections`` or ``Too many open files``
   error log messages on OpenStack services, verify that maximum number of
   connection settings are well applied to your environment.
   In MariaDB, you may also need to change
   `open_files_limit <https://mariadb.com/kb/en/library/server-system-variables/#open_files_limit>`__
   configuration.

.. toctree::
   :glob:

   environment-sql-database-*

