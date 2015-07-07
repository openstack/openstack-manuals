.. highlight:: ini
   :linenothreshold: 1


SQL database
~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <http://www.postgresql.org/>`__.


**To install and configure the database server**

1. Install the packages:

   .. only:: rdo or ubuntu or obs

      .. note::

         The Python MySQL library is compatible with MariaDB.

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install mariadb-server python-mysqldb

   .. only:: debian

      .. code-block:: console

         # apt-get install mysql-server python-mysqldb

   .. only:: rdo

      .. code-block:: console

         # yum install mariadb mariadb-server MySQL-python

   .. only:: obs

      .. code-block:: console

         # zypper install mariadb-client mariadb python-mysql

.. only:: ubuntu or debian

   2. Choose a suitable password for the database root account.

   3. Create and edit the :file:`/etc/mysql/conf.d/mysqld_openstack.cnf` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           collation-server = utf8_general_ci
           init-connect = 'SET NAMES utf8'
           character-set-server = utf8


.. only:: obs or rdo

   2. Create and edit the :file:`/etc/my.cnf.d/mariadb_openstack.cnf` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           collation-server = utf8_general_ci
           init-connect = 'SET NAMES utf8'
           character-set-server = utf8

**To finalize installation**

.. only:: ubuntu or debian

   1. Restart the database service:

      .. code-block:: console

         # service mysql restart

.. only:: rdo or obs

   1. Start the database service and configure it to start when the system
      boots:

      .. only:: rdo

         .. code-block:: console

            # systemctl enable mariadb.service
            # systemctl start mariadb.service

      .. only:: obs

         .. code-block:: console

            # systemctl enable mysql.service
            # systemctl start mysql.service

.. only:: ubuntu or debian

   2. Secure the database service:

      .. literalinclude:: mariadb_output.txt

.. only:: rdo or obs

   2. Secure the database service including choosing a suitable
      password for the root account:

      .. literalinclude:: mariadb_output.txt
