SUSE SQL database
~~~~~~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <https://www.postgresql.org/>`__.


Install and configure components
--------------------------------

#. Install the packages:





.. code-block:: console

   # zypper install mariadb-client mariadb python-PyMySQL

.. end





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


Finalize installation
---------------------



#. Start the database service and configure it to start when the system
   boots:



.. code-block:: console

   # systemctl enable mysql.service
   # systemctl start mysql.service

.. end



2. Secure the database service by running the ``mysql_secure_installation``
   script. In particular, choose a suitable password for the database
   ``root`` account:

   .. code-block:: console

      # mysql_secure_installation

   .. end

