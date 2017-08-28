SQL database for Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <https://www.postgresql.org/>`__.

.. note::

   As of Ubuntu 16.04, MariaDB was changed to use
   the "unix_socket Authentication Plugin". Local authentication is
   now performed using the user credentials (UID), and password
   authentication is no longer used by default. This means that
   the root user no longer uses a password for local access to
   the server.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # apt install mariadb-server python-pymysql

   .. end

2. Create and edit the ``/etc/mysql/mariadb.conf.d/99-openstack.cnf`` file
   and complete the following actions:

   - Create a ``[mysqld]`` section, and set the ``bind-address``
     key to the management IP address of the controller node to
     enable access by other nodes via the management network. Set
     additional keys to enable useful options and the UTF-8
     character set:

     .. code-block:: ini

        [mysqld]
        bind-address = 10.0.0.11

        default-storage-engine = innodb
        innodb_file_per_table = on
        max_connections = 4096
        collation-server = utf8_general_ci
        character-set-server = utf8

     .. end

Finalize installation
---------------------

#. Restart the database service:

   .. code-block:: console

      # service mysql restart

   .. end

2. Secure the database service by running the ``mysql_secure_installation``
   script. In particular, choose a suitable password for the database
   ``root`` account:

   .. code-block:: console

      # mysql_secure_installation

   .. end
