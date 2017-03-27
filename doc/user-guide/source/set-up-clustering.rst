==========================
Set up database clustering
==========================

You can store data across multiple machines by setting up MongoDB
sharded clusters.

Each cluster includes:

-  One or more *shards*. Each shard consists of a three member replica
   set (three instances organized as a replica set).

-  One or more *query routers*. A query router is the machine that your
   application actually connects to. This machine is responsible for
   communicating with the config server to figure out where the
   requested data is stored. It then accesses and returns the data from
   the appropriate shard(s).

-  One or more *config servers*. Config servers store the metadata that
   links requested data with the shard that contains it.

This example shows you how to set up a MongoDB sharded cluster.

.. note::

   **Before you begin.** Make sure that:

   -  The administrative user has registered a MongoDB datastore type and
      version.

   -  The administrative user has created an appropriate :ref:`flavor that
      meets the MongoDB minimum requirements <create_db>`.

Set up clustering
~~~~~~~~~~~~~~~~~

#. **Create a cluster**

   Create a cluster by using the :command:`trove cluster-create` command. This
   command creates a one-shard cluster. Pass in:

   -  The name of the cluster.

   -  The name and version of the datastore you want to use.

   -  The three instances you want to include in the replication set for
      the first shard. Specify each instance by using the ``--instance``
      argument and the associated flavor ID and volume size. Use the
      same flavor ID and volume size for each instance. In this example,
      flavor ``7`` is a custom flavor that meets the MongoDB minimum
      requirements.

   .. code-block:: console

      $ trove cluster-create cluster1 mongodb "2.4" \
        --instance flavor=7,volume=2 --instance flavor=7,volume=2 \
        --instance flavor=7,volume=2
       +-------------------+--------------------------------------+
       | Property          | Value                                |
       +-------------------+--------------------------------------+
       | created           | 2014-08-16T01:46:51                  |
       | datastore         | mongodb                              |
       | datastore_version | 2.4                                  |
       | id                | aa6ef0f5-dbef-48cd-8952-573ad881e717 |
       | name              | cluster1                             |
       | task_description  | Building the initial cluster.        |
       | task_name         | BUILDING                             |
       | updated           | 2014-08-16T01:46:51                  |
       +-------------------+--------------------------------------+

#. **Display cluster information**

   Display information about a cluster by using the
   :command:`trove cluster-show` command. Pass in the ID of the cluster.

   The cluster ID displays when you first create a cluster. (If you need
   to find it later on, use the :command:`trove cluster-list` command to list
   the names and IDs of all the clusters in your system.)

   .. code-block:: console

      $ trove cluster-show CLUSTER_ID
       +-------------------+--------------------------------------+
       | Property          | Value                                |
       +-------------------+--------------------------------------+
       | created           | 2014-08-16T01:46:51                  |
       | datastore         | mongodb                              |
       | datastore_version | 2.4                                  |
       | id                | aa6ef0f5-dbef-48cd-8952-573ad881e717 |
       | ip                | 10.0.0.2                             |
       | name              | cluster1                             |
       | task_description  | No tasks for the cluster.            |
       | task_name         | NONE                                 |
       | updated           | 2014-08-16T01:59:33                  |
       +-------------------+--------------------------------------+


   .. note::

      **Your application connects to this IP address.** The :command:`trove cluster-show`
      command displays the IP address of the query router.
      This is the IP address your application uses to retrieve data from
      the database.

#. **List cluster instances**

   List the instances in a cluster by using the
   :command:`trove cluster-instances` command.

   .. code-block:: console

      $ trove cluster-instances CLUSTER_ID
      +--------------------------------------+----------------+-----------+------+
      | ID                                   | Name           | Flavor ID | Size |
      +--------------------------------------+----------------+-----------+------+
      | 45532fc4-661c-4030-8ca4-18f02aa2b337 | cluster1-rs1-1 | 7         |    2 |
      | 7458a98d-6f89-4dfd-bb61-5cf1dd65c121 | cluster1-rs1-2 | 7         |    2 |
      | b37634fb-e33c-4846-8fe8-cf2b2c95e731 | cluster1-rs1-3 | 7         |    2 |
      +--------------------------------------+----------------+-----------+------+

   **Naming conventions for replication sets and instances.** Note
   that the ``Name`` column displays an instance name that includes the
   replication set name. The replication set names and instance names
   are automatically generated, following these rules:

   -  **Replication set name.** This name consists of the cluster
      name, followed by the string -rs\ *n*, where *n* is 1 for
      the first replication set you create, 2 for the second replication
      set, and so on. In this example, the cluster name is ``cluster1``,
      and there is only one replication set, so the replication set name
      is ``cluster1-rs1``.

   -  **Instance name.** This name consists of the replication set
      name followed by the string -*n*, where *n* is 1 for the
      first instance in a replication set, 2 for the second
      instance, and so on. In this example, the instance names are
      ``cluster1-rs1-1``, ``cluster1-rs1-2``, and ``cluster1-rs1-3``.

#. **List clusters**

   List all the clusters in your system, using the
   :command:`trove cluster-list` command.

   .. code-block:: console

      $ trove cluster-list
      +--------------------------------------+----------+-----------+-------------------+-----------+
      | ID                                   | Name     | Datastore | Datastore Version | Task Name |
      +--------------------------------------+----------+-----------+-------------------+-----------+
      | aa6ef0f5-dbef-48cd-8952-573ad881e717 | cluster1 | mongodb   | 2.4               | NONE      |
      | b8829c2a-b03a-49d3-a5b1-21ec974223ee | cluster2 | mongodb   | 2.4               | BUILDING  |
      +--------------------------------------+----------+-----------+-------------------+-----------+

#. **Delete a cluster**

   Delete a cluster, using the :command:`trove cluster-delete` command.

   .. code-block:: console

      $ trove cluster-delete CLUSTER_ID

Query routers and config servers
--------------------------------

Each cluster includes at least one query router and one config server.
Query routers and config servers count against your quota. When you
delete a cluster, the system deletes the associated query router(s) and
config server(s).
