.. _create_db:

============================
Create and access a database
============================
Assume that you have installed the Database service and populated your
data store with images for the type and versions of databases that you
want, and that you can create and access a database.

This example shows you how to create and access a MySQL 5.5 database.

Create and access a database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. **Determine which flavor to use for your database**

   When you create a database instance, you must specify a nova flavor.
   The flavor indicates various characteristics of the instance, such as
   RAM and root volume size. You will need to create or
   obtain new nova flavors that work for databases.

   The first step is to list flavors by using the
   :command:`openstack flavor list` command.

   .. code-block:: console

      $ openstack flavor list

   Now take a look at the minimum requirements for various database
   instances:

   +--------------------+--------------------+--------------------+--------------------+
   | Database           | RAM (MB)           | Disk (GB)          | VCPUs              |
   +====================+====================+====================+====================+
   | MySQL              | 512                | 5                  | 1                  |
   +--------------------+--------------------+--------------------+--------------------+
   | Cassandra          | 2048               | 5                  | 1                  |
   +--------------------+--------------------+--------------------+--------------------+
   | MongoDB            | 1024               | 5                  | 1                  |
   +--------------------+--------------------+--------------------+--------------------+
   | Redis              | 512                | 5                  | 1                  |
   +--------------------+--------------------+--------------------+--------------------+

   -  If you have a custom flavor that meets the needs of the database
      that you want to create, proceed to
      :ref:`Step 2 <create-database-instance>` and use that flavor.

   -  If your environment does not have a suitable flavor, an
      administrative user must create a custom flavor by using the
      :command:`openstack flavor create` command.

   **MySQL example.** This example creates a flavor that you can use
   with a MySQL database. This example has the following attributes:

   -  Flavor name: ``mysql_minimum``

   -  Flavor ID: You must use an ID that is not already in use. In this
      example, IDs 1 through 5 are in use, so use ID ``6``.

   -  RAM: ``512``

   -  Root volume size in GB: ``5``

   -  Virtual CPUs: ``1``

   .. code-block:: console

      $ openstack flavor create mysql-minimum --id 6 --ram 512 --disk 5 --vcpus 1
      +----------------------------+---------------+
      | Field                      | Value         |
      +----------------------------+---------------+
      | OS-FLV-DISABLED:disabled   | False         |
      | OS-FLV-EXT-DATA:ephemeral  | 0             |
      | disk                       | 5             |
      | id                         | 6             |
      | name                       | mysql-minimum |
      | os-flavor-access:is_public | True          |
      | properties                 |               |
      | ram                        | 512           |
      | rxtx_factor                | 1.0           |
      | swap                       |               |
      | vcpus                      | 1             |
      +----------------------------+---------------+

   .. _create-database-instance:

#. **Create a database instance**

   This example creates a database instance with the following
   characteristics:

   -  Name of the instance: ``mysql_instance_1``

   -  Database flavor: ``6``

   In addition, this command specifies these options for the instance:

   -  A volume size of ``5`` (5 GB).

   -  The ``myDB`` database.

   -  The database is based on the ``mysql`` data store and the
      ``mysql-5.5`` datastore\_version.

   -  The ``userA`` user with the ``password`` password.

   .. code-block:: console

      $ trove create mysql_instance_1 6 --size 5 --databases myDB \
          --users userA:password --datastore_version mysql-5.5 \
          --datastore mysql
      +-------------------+---------------------------------------------------------------------------------------t-----------------------------------------------------------------------------------------------------------------+
      |      Property     |                                                                                                  Value                                                                                                  |
      +-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
      |      created      |                                                                                           2014-05-29T21:26:21                                                                                           |
      |     datastore     |                                                                              {u'version': u'mysql-5.5', u'type': u'mysql'}                                                                              |
      | datastore_version |                                                                                                mysql-5.5                                                                                                |
      |       flavor      | {u'id': u'6', u'links': [{u'href': u'https://controller:8779/v1.0/46d0bc4fc32e4b9e8520f8fc62199f58/flavors/6', u'rel': u'self'}, {u'href': u'https://controller:8779/flavors/6', u'rel': u'bookmark'}]} |
      |         id        |                                                                                   5599dad6-731e-44df-bb60-488da3da9cfe                                                                                  |
      |        name       |                                                                                             mysql_instance_1                                                                                            |
      |       status      |                                                                                                  BUILD                                                                                                  |
      |      updated      |                                                                                           2014-05-29T21:26:21                                                                                           |
      |       volume      |                                                                                               {u'size': 5}                                                                                              |
      +-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

#. **Get the IP address of the database instance**

   First, use the :command:`trove list` command to list all instances and
   their IDs:

   .. code-block:: console

      $ trove list
      +--------------------------------------+------------------+-----------+-------------------+--------+-----------+------+
      |                  id                  |       name       | datastore | datastore_version | status | flavor_id | size |
      +--------------------------------------+------------------+-----------+-------------------+--------+-----------+------+
      | 5599dad6-731e-44df-bb60-488da3da9cfe | mysql_instance_1 |   mysql   |     mysql-5.5     | BUILD  |     6     |  5   |
      +--------------------------------------+------------------+-----------+-------------------+--------+-----------+------+

   This command returns the instance ID of your new instance.

   You can now pass in the instance ID with the :command:`trove show` command
   to get the IP address of the instance. In this example, replace
   ``INSTANCE_ID`` with ``5599dad6-731e-44df-bb60-488da3da9cfe``.

   .. code-block:: console

      $ trove show INSTANCE_ID

      +-------------------+--------------------------------------+
      |      Property     |                Value                 |
      +-------------------+--------------------------------------+
      |      created      |         2014-05-29T21:26:21          |
      |     datastore     |                mysql                 |
      | datastore_version |              mysql-5.5               |
      |       flavor      |                  6                   |
      |         id        | 5599dad6-731e-44df-bb60-488da3da9cfe |
      |         ip        |             172.16.200.2             |
      |        name       |           mysql_instance_1           |
      |       status      |                BUILD                 |
      |      updated      |         2014-05-29T21:26:54          |
      |       volume      |                  5                   |
      +-------------------+--------------------------------------+

   This command returns the IP address of the database instance.

#. **Access the new database**

   You can now access the new database you just created (myDB) by using
   typical database access commands. In this MySQL example, replace
   ``IP_ADDRESS`` with ``172.16.200.2``.

   .. code-block:: console

      $ mysql -u userA -p password -h IP_ADDRESS myDB

