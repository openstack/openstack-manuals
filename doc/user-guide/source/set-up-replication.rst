===========================
Set up database replication
===========================

You can create a replica of an existing database instance. When you make
subsequent changes to the original instance, the system automatically
applies those changes to the replica.

-  Replicas are read-only.

-  When you create a replica, do not specify the ``--users`` or
   ``--databases`` options.

-  You can choose a smaller volume or flavor for a replica than for the
   original, but the replica's volume must be big enough to hold the
   data snapshot from the original.

This example shows you how to replicate a MySQL database instance.

Set up replication
~~~~~~~~~~~~~~~~~~

#. **Get the instance ID**

   Get the ID of the original instance you want to replicate:

   .. code-block:: console

      $ trove list
      +-----------+------------+-----------+-------------------+--------+-----------+------+
      |     id    |  name      | datastore | datastore_version | status | flavor_id | size |
      +-----------+------------+-----------+-------------------+--------+-----------+------+
      | 97b...ae6 | base_1     |   mysql   |     mysql-5.5     | ACTIVE |     10    |  2   |
      +-----------+------------+-----------+-------------------+--------+-----------+------+

#. **Create the replica**

   Create a new instance that will be a replica of the original
   instance. You do this by passing in the ``--replica_of`` option with
   the :command:`trove create` command. This example creates a replica
   called ``replica_1``. ``replica_1`` is a replica of the original instance,
   ``base_1``:

   .. code-block:: console

      $ trove create replica_1 6 --size=5 --datastore_version mysql-5.5 \
        --datastore mysql --replica_of ID_OF_ORIGINAL_INSTANCE

#. **Verify replication status**

   Pass in ``replica_1``'s instance ID with the :command:`trove show` command
   to verify that the newly created ``replica_1`` instance is a replica
   of the original ``base_1``. Note that the ``replica_of`` property is
   set to the ID of ``base_1``.

   .. code-block:: console

      $ trove show INSTANCE_ID_OF_REPLICA_1
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | created           | 2014-09-16T11:16:49                  |
      | datastore         | mysql                                |
      | datastore_version | mysql-5.5                            |
      | flavor            | 6                                    |
      | id                | 49c6eff6-ef91-4eff-91c0-efbda7e83c38 |
      | name              | replica_1                            |
      | replica_of        | 97b4b853-80f6-414f-ba6f-c6f455a79ae6 |
      | status            | BUILD                                |
      | updated           | 2014-09-16T11:16:49                  |
      | volume            | 5                                    |
      +-------------------+--------------------------------------+

   Now pass in ``base_1``'s instance ID with the :command:`trove show` command
   to list the replica(s) associated with the original instance. Note
   that the ``replicas`` property is set to the ID of ``replica_1``. If
   there are multiple replicas, they appear as a comma-separated list.

   .. code-block:: console

      $ trove show INSTANCE_ID_OF_BASE_1
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | created           | 2014-09-16T11:04:56                  |
      | datastore         | mysql                                |
      | datastore_version | mysql-5.5                            |
      | flavor            | 6                                    |
      | id                | 97b4b853-80f6-414f-ba6f-c6f455a79ae6 |
      | ip                | 172.16.200.2                         |
      | name              | base_1                               |
      | replicas          | 49c6eff6-ef91-4eff-91c0-efbda7e83c38 |
      | status            | ACTIVE                               |
      | updated           | 2014-09-16T11:05:06                  |
      | volume            | 5                                    |
      | volume_used       | 0.11                                 |
      +-------------------+--------------------------------------+

#. **Detach the replica**

   If the original instance goes down, you can detach the replica. The
   replica becomes a standalone database instance. You can then take the
   new standalone instance and create a new replica of that instance.

   You detach a replica using the :command:`trove detach-replica` command:

   .. code-block:: console

      $ trove detach-replica INSTANCE_ID_OF_REPLICA
