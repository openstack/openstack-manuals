SQL database
~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <http://www.postgresql.org/>`__.

Install and configure components
--------------------------------

#. Install the packages:

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install mariadb-server python-pymysql

   .. only:: debian

      .. code-block:: console

         # apt-get install mysql-server python-pymysql

   .. only:: rdo

      .. code-block:: console

         # yum install mariadb mariadb-server python2-PyMySQL

   .. only:: obs

      .. code-block:: console

         # zypper install mariadb-client mariadb python-PyMySQL

.. only:: ubuntu or debian

   2. Choose a suitable password for the database ``root`` account.

   3. Create and edit the ``/etc/mysql/conf.d/openstack.cnf`` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code-block:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code-block:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           max_connections = 4096
           collation-server = utf8_general_ci
           character-set-server = utf8

.. only:: obs or rdo

   2. Create and edit the ``/etc/my.cnf.d/openstack.cnf`` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code-block:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code-block:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           max_connections = 4096
           collation-server = utf8_general_ci
           character-set-server = utf8

Finalize installation
---------------------

.. only:: ubuntu or debian

   #. Restart the database service:

      .. code-block:: console

         # service mysql restart

.. only:: rdo or obs

   #. Start the database service and configure it to start when the system
      boots:

      .. only:: rdo

         .. code-block:: console

            # systemctl enable mariadb.service
            # systemctl start mariadb.service

      .. only:: obs

         .. code-block:: console

            # systemctl enable mysql.service
            # systemctl start mysql.service

.. only:: ubuntu

   2. Secure the database service by running the ``mysql_secure_installation``
      script.

      .. code-block:: console

         # mysql_secure_installation

.. only:: rdo or obs

   2. Secure the database service by running the ``mysql_secure_installation``
      script. In particular, choose a suitable password for the database
      ``root`` account.

      .. code-block:: console

         # mysql_secure_installation
