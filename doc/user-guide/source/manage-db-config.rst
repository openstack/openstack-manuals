=============================
Manage database configuration
=============================

You can manage database configuration tasks by using configuration
groups. Configuration groups let you set configuration options, in bulk,
on one or more databases.

This example assumes you have created a MySQL
database and shows you how to use a
configuration group to configure it. Although this example sets just one
option on one database, you can use these same procedures to set
multiple options on multiple database instances throughout your
environment. This can provide significant time savings in managing your
cloud.

Bulk-configure a database or databases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. **List available options**

   First, determine which configuration options you can set. Different
   data store versions have different configuration options.

   List the names and IDs of all available versions of the ``mysql``
   data store:

   .. code-block:: console

      $ trove datastore-version-list mysql

      +--------------------------------------+-----------+
      |                  id                  |    name   |
      +--------------------------------------+-----------+
      | eeb574ce-f49a-48b6-820d-b2959fcd38bb | mysql-5.5 |
      +--------------------------------------+-----------+

   Pass in the data store version ID with the
   :command:`trove configuration-parameter-list` command to get the available
   options:

   .. code-block:: console

      $ trove configuration-parameter-list DATASTORE_VERSION_ID

      +--------------------------------+---------+---------+----------------------+------------------+
      |              name              |   type  |   min   |         max          | restart_required |
      +--------------------------------+---------+---------+----------------------+------------------+
      |    auto_increment_increment    | integer |    1    |        65535         |      False       |
      |     auto_increment_offset      | integer |    1    |        65535         |      False       |
      |           autocommit           | integer |    0    |          1           |      False       |
      |    bulk_insert_buffer_size     | integer |    0    | 18446744073709547520 |      False       |
      |      character_set_client      |  string |         |                      |      False       |
      |    character_set_connection    |  string |         |                      |      False       |
      |     character_set_database     |  string |         |                      |      False       |
      |    character_set_filesystem    |  string |         |                      |      False       |
      |     character_set_results      |  string |         |                      |      False       |
      |      character_set_server      |  string |         |                      |      False       |
      |      collation_connection      |  string |         |                      |      False       |
      |       collation_database       |  string |         |                      |      False       |
      |        collation_server        |  string |         |                      |      False       |
      |        connect_timeout         | integer |    1    |        65535         |      False       |
      |        expire_logs_days        | integer |    1    |        65535         |      False       |
      |    innodb_buffer_pool_size     | integer |    0    |     68719476736      |       True       |
      |     innodb_file_per_table      | integer |    0    |          1           |       True       |
      | innodb_flush_log_at_trx_commit | integer |    0    |          2           |      False       |
      |     innodb_log_buffer_size     | integer | 1048576 |      4294967296      |       True       |
      |       innodb_open_files        | integer |    10   |      4294967296      |       True       |
      |   innodb_thread_concurrency    | integer |    0    |         1000         |      False       |
      |      interactive_timeout       | integer |    1    |        65535         |      False       |
      |        join_buffer_size        | integer |    0    |      4294967296      |      False       |
      |        key_buffer_size         | integer |    0    |      4294967296      |      False       |
      |          local_infile          | integer |    0    |          1           |      False       |
      |       max_allowed_packet       | integer |   1024  |      1073741824      |      False       |
      |       max_connect_errors       | integer |    1    | 18446744073709547520 |      False       |
      |        max_connections         | integer |    1    |        65535         |      False       |
      |      max_user_connections      | integer |    1    |        100000        |      False       |
      |    myisam_sort_buffer_size     | integer |    4    | 18446744073709547520 |      False       |
      |           server_id            | integer |    1    |        100000        |       True       |
      |        sort_buffer_size        | integer |  32768  | 18446744073709547520 |      False       |
      |          sync_binlog           | integer |    0    | 18446744073709547520 |      False       |
      |          wait_timeout          | integer |    1    |       31536000       |      False       |
      +--------------------------------+---------+---------+----------------------+------------------+

   In this example, the :command:`trove configuration-parameter-list` command
   returns a list of options that work with MySQL 5.5.

#. **Create a configuration group**

   A configuration group contains a comma-separated list of key-value
   pairs. Each pair consists of a configuration option and its value.

   You can create a configuration group by using the
   :command:`trove configuration-create` command. The general syntax
   for this command is:

   .. code-block:: console

      $ trove configuration-create NAME VALUES --datastore DATASTORE_NAME

   -  *NAME*. The name you want to use for this group.

   -  *VALUES*. The list of key-value pairs.

   -  *DATASTORE_NAME*. The name of the associated data store.

   Set *VALUES* as a JSON dictionary, for example:

   .. code-block:: json

      {"myFirstKey" : "someString", "mySecondKey" : 1}

   This example creates a configuration group called ``group1``.
   ``group1`` contains just one key and value pair, and this pair sets
   the ``sync_binlog`` option to ``1``.

   .. code-block:: console

      $ trove configuration-create group1 '{"sync_binlog" : 1}' --datastore mysql

      +----------------------+--------------------------------------+
      |       Property       |                Value                 |
      +----------------------+--------------------------------------+
      | datastore_version_id | eeb574ce-f49a-48b6-820d-b2959fcd38bb |
      |     description      |                 None                 |
      |          id          | 9a9ef3bc-079b-476a-9cbf-85aa64f898a5 |
      |         name         |                group1                |
      |        values        |          {"sync_binlog": 1}          |
      +----------------------+--------------------------------------+

#. **Examine your existing configuration**

   Before you use the newly-created configuration group, look at how the
   ``sync_binlog`` option is configured on your database. Replace the
   following sample connection values with values that connect to your
   database:

   .. code-block:: console

      $ mysql -u user7 -ppassword -h 172.16.200.2 myDB7
       Welcome to the MySQL monitor. Commands end with ; or \g.
       ...
       mysql> show variables like 'sync_binlog';
       +---------------+-------+
       | Variable_name | Value |
       +---------------+-------+
       | sync_binlog   | 0     |
       +---------------+-------+

   As you can see, the ``sync_binlog`` option is currently set to ``0``
   for the ``myDB7`` database.

#. **Change the database configuration using a configuration group**

   You can change a database's configuration by attaching a
   configuration group to a database instance. You do this by using the
   :command:`trove configuration-attach` command and passing in the ID of the
   database instance and the ID of the configuration group.

   Get the ID of the database instance:

   .. code-block:: console

      $ trove list

      +-------------+------------------+-----------+-------------------+--------+-----------+------+
      |     id      |       name       | datastore | datastore_version | status | flavor_id | size |
      +-------------+------------------+-----------+-------------------+--------+-----------+------+
      | 26a265dd... | mysql_instance_7 |   mysql   |     mysql-5.5     | ACTIVE |     6     |  5   |
      +-------------+------------------+-----------+-------------------+--------+-----------+------+

   Get the ID of the configuration group:

   .. code-block:: console

      $ trove configuration-list

      +-------------+--------+-------------+---------------------+
      |    id       |  name  | description |datastore_version_id |
      +-------------+--------+-------------+---------------------+
      | 9a9ef3bc... | group1 |     None    |      eeb574ce...    |
      +-------------+--------+-------------+---------------------+

   Attach the configuration group to the database instance:

   .. note::

      This command syntax pertains only to python-troveclient version
      1.0.6 and later. Earlier versions require you to pass in the
      configuration group ID as the first argument.

   .. code-block:: console

      $ trove configuration-attach DB_INSTANCE_ID CONFIG_GROUP_ID

#. **Re-examine the database configuration**

   Display the ``sync_binlog`` setting again:

   .. code-block:: console

       mysql> show variables like 'sync_binlog';
       +---------------+-------+
       | Variable_name | Value |
       +---------------+-------+
       | sync_binlog   | 1     |
       +---------------+-------+

   As you can see, the ``sync_binlog`` option is now set to ``1``, as
   specified in the ``group1`` configuration group.

**Conclusion.** Using a configuration group to set a single option on
a single database is obviously a trivial example. However, configuration
groups can provide major efficiencies when you consider that:

-  A configuration group can specify a large number of option values.

-  You can apply a configuration group to hundreds or thousands of
   database instances in your environment.

Used in this way, configuration groups let you modify your database
cloud configuration, on the fly, on a massive scale.

**Maintenance.** There are also a number of useful maintenance
features for working with configuration groups. You can:

-  Disassociate a configuration group from a database instance, using
   the :command:`trove configuration-detach` command.

-  Modify a configuration group on the fly, using the
   :command:`trove configuration-patch` command.

-  Find out what instances are using a configuration group, using the
   :command:`trove configuration-instances` command.

-  Delete a configuration group, using the
   :command:`trove configuration-delete` command. You might want to
   do this if no instances use a group.

