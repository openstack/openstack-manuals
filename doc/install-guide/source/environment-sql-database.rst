SQL database
~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <http://www.postgresql.org/>`__.

.. only:: ubuntu

   .. note::

      As of Ubuntu 15.10, MariaDB was changed to use
      the "unix_socket Authentication Plugin". Local authentication is
      now preformed using the user credentials (UID) and password
      authentication is no longer used by default. This means that
      the root user no longer uses a password for local access to
      the server.

.. endonly

Install and configure components
--------------------------------

#. Install the packages:

   .. only:: ubuntu

      .. code-block:: console

         # apt install mariadb-server python-pymysql

      .. end

   .. endonly

   .. only:: debian

      .. code-block:: console

         # apt install mysql-server python-pymysql

      .. end

   .. endonly

   .. only:: rdo

      .. code-block:: console

         # yum install mariadb mariadb-server python2-PyMySQL

      .. end

   .. endonly

   .. only:: obs

      .. code-block:: console

         # zypper install mariadb-client mariadb python-PyMySQL

      .. end

   .. endonly

.. only:: debian

   2. Create and edit the ``/etc/mysql/conf.d/openstack.cnf`` file
      and complete the following actions:

      - Create a ``[mysqld]`` section, and set the ``bind-address``
        key to the management IP address of the controller node to
        enable access by other nodes via the management network. Set
        additional keys to enable useful options and the UTF-8
        character set:

        .. path /etc/mysql/conf.d/openstack.cnf
        .. code-block:: ini

           [mysqld]
           bind-address = 10.0.0.11

           default-storage-engine = innodb
           innodb_file_per_table = on
           max_connections = 4096
           collation-server = utf8_general_ci
           character-set-server = utf8

        .. end

.. endonly

.. only:: ubuntu

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

.. endonly

.. only:: obs or rdo

   2. Create and edit the ``/etc/my.cnf.d/openstack.cnf`` file
      and complete the following actions:

      - Create a ``[mysqld]`` section, and set the ``bind-address``
        key to the management IP address of the controller node to
        enable access by other nodes via the management network. Set
        additional keys to enable useful options and the UTF-8
        character set:

        .. path /etc/my.cnf.d/openstack.cnf
        .. code-block:: ini

           [mysqld]
           bind-address = 10.0.0.11

           default-storage-engine = innodb
           innodb_file_per_table = on
           max_connections = 4096
           collation-server = utf8_general_ci
           character-set-server = utf8

        .. end

.. endonly

Finalize installation
---------------------

.. only:: ubuntu or debian

   #. Restart the database service:

      .. code-block:: console

         # service mysql restart

      .. end

.. endonly

.. only:: rdo or obs

   #. Start the database service and configure it to start when the system
      boots:

      .. only:: rdo

         .. code-block:: console

            # systemctl enable mariadb.service
            # systemctl start mariadb.service

         .. end

      .. endonly

      .. only:: obs

         .. code-block:: console

            # systemctl enable mysql.service
            # systemctl start mysql.service

         .. end

      .. endonly

.. only:: rdo or obs or ubuntu

   2. Secure the database service by running the ``mysql_secure_installation``
      script. In particular, choose a suitable password for the database
      ``root`` account:

      .. code-block:: console

         # mysql_secure_installation

      .. end

.. endonly
