.. _database_module_usage:

=====================================
Create and use modules for a database
=====================================

To continue with this document, we recommend that you have installed
the Database service and populated your data store with images for the
type and versions of databases that you want, and that you can create
and access a database.

This example shows you how to create and apply modules to a MySQL 5.6
database and redis 3.2.6 database cluster.

Create and apply a module to a mysql database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. **Create the module file and trove module**

   If you wish to apply a module, you must create the module first
   and register it with the trove service. A user can not directly
   apply a module to a trove instance.

   The module created here is a demo module called ping. It is the
   basic type made for testing purposes. To create it, it is as
   simple as the following :command: ``echo`` command:

   .. code-block:: console

      $ echo "message=Module.V1" > ping1.dat

   You can create a test module and mysql database with the module
   applied by doing the following:

   .. code-block:: console

      $ trove module-create mymod ping ping1.dat --live_update \
        --datastore mysql

      +----------------------+--------------------------------------+
      | Property             | Value                                |
      +----------------------+--------------------------------------+
      | apply_order          | 5                                    |
      | auto_apply           | False                                |
      | created              | 2017-06-02T17:06:21                  |
      | datastore            | all                                  |
      | datastore_id         | None                                 |
      | datastore_version    | all                                  |
      | datastore_version_id | None                                 |
      | description          | None                                 |
      | id                   | 0065a8ed-0668-4db5-a4ad-d88d0a166388 |
      | instance_count       | 2                                    |
      | is_admin             | True                                 |
      | live_update          | True                                 |
      | md5                  | 7f700cc7b99606615f8b51946f6d3228     |
      | name                 | mymod                                |
      | priority_apply       | False                                |
      | tenant               | eac1e46e5f7840e39012aff46a92073a     |
      | tenant_id            | eac1e46e5f7840e39012aff46a92073a     |
      | type                 | ping                                 |
      | updated              | 2017-06-02T17:06:21                  |
      | visible              | True                                 |
      +----------------------+--------------------------------------+

      $ trove create myinst 15 --size 1 --module mymod --datastore mysql

      +-------------------------+--------------------------------------+
      | Property                | Value                                |
      +-------------------------+--------------------------------------+
      | created                 | 2017-06-02T17:22:24                  |
      | datastore               | mysql                                |
      | datastore_version       | 5.6                                  |
      | encrypted_rpc_messaging | True                                 |
      | flavor                  | 15                                   |
      | id                      | 6221b30c-8292-4378-b624-c7e9b0f8ba9e |
      | name                    | myinst                               |
      | region                  | RegionOne                            |
      | server_id               | None                                 |
      | status                  | BUILD                                |
      | tenant_id               | eac1e46e5f7840e39012aff46a92073a     |
      | updated                 | 2017-06-02T17:22:24                  |
      | volume                  | 1                                    |
      | volume_id               | None                                 |
      +-------------------------+--------------------------------------+

.. _show_and_list_modules:

#. **Show and list modules**

   You can view the modules on your instance by doing the following:

   .. code-block:: console

      $ trove module-query myinst

      +-------+------+-----------+---------+--------+-----------+------------------------+------------------------+
      | Name  | Type | Datastore | Version | Status | Message   | Created                | Updated                |
      +-------+------+-----------+---------+--------+-----------+------------------------+------------------------+
      | mymod | ping | all       | all     | OK     | Module.V1 | 2017-06-02 17:23:40.50 | 2017-06-02 17:23:40.50 |
      +-------+------+-----------+---------+--------+-----------+------------------------+------------------------+

   You can count the instances each module is applied to by doing the
   following:

   .. code-block:: console

      $ trove module-instance-count mymod

      +-------------+---------------------+---------------------+----------------------------------+---------+-------+
      | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
      +-------------+---------------------+---------------------+----------------------------------+---------+-------+
      | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |    True |     1 |
      +-------------+---------------------+---------------------+----------------------------------+---------+-------+

   You can list the instances that have a particular module applied
   by doing the following:

   .. code-block:: console

      $ trove module-instances mymod

      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+-----------+----------------------------------+
      | ID                                   | Name   | Datastore | Datastore Version | Status | Flavor ID | Size | Region    | Tenant ID                        |
      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+-----------+----------------------------------+
      | 6221b30c-8292-4378-b624-c7e9b0f8ba9e | myinst | mysql     | 5.6               | ACTIVE | 15        |    1 | RegionOne | eac1e46e5f7840e39012aff46a92073a |
      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+-----------+----------------------------------+


Updating and creating a second module for a redis cluster
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To update a module you should have another file ready to update the
module with:

.. code-block:: console

   $ echo "message=Module.V2" > ping2.dat
   $ trove module-update mymod --file ping2.dat

   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | apply_order          | 5                                    |
   | auto_apply           | False                                |
   | created              | 2017-06-02T17:06:21                  |
   | datastore            | all                                  |
   | datastore_id         | None                                 |
   | datastore_version    | all                                  |
   | datastore_version_id | None                                 |
   | description          | None                                 |
   | id                   | 0065a8ed-0668-4db5-a4ad-d88d0a166388 |
   | is_admin             | True                                 |
   | live_update          | True                                 |
   | md5                  | ba7c204979c8de54be6efb70a17d40b9     |
   | name                 | mymod                                |
   | priority_apply       | False                                |
   | tenant               | eac1e46e5f7840e39012aff46a92073a     |
   | tenant_id            | eac1e46e5f7840e39012aff46a92073a     |
   | type                 | ping                                 |
   | updated              | 2017-06-02T17:56:12                  |
   | visible              | True                                 |
   +----------------------+--------------------------------------+

Now to show the usage with a redis cluster, create as follows:

.. code-block:: console

   $ trove cluster-create myclust redis 3.2.6 \
     --instance=flavor=15,volume=1,module=mymod \
     --instance=flavor=15,volume=1,module=mymod \
     --instance=flavor=15,volume=1,module=mymod

   +-------------------+--------------------------------------+
   | Property          | Value                                |
   +-------------------+--------------------------------------+
   | created           | 2017-06-02T18:00:17                  |
   | datastore         | redis                                |
   | datastore_version | 3.2.6                                |
   | id                | e4d91ca6-5980-430c-94d0-bf7abc63f712 |
   | instance_count    | 3                                    |
   | name              | myclust                              |
   | task_description  | Building the initial cluster.        |
   | task_name         | BUILDING                             |
   | updated           | 2017-06-02T18:00:17                  |
   +-------------------+--------------------------------------+

The original :command: ``count`` command will show the first instance,
unless the ``--include_clustered`` option is used. You can see the
MD5 from each applied module, and you know that the single instance
one is not current.

.. code-block:: console

   $ trove module-instance-count mymod

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |    True |     3 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

Update the module again. By doing this, it will cause the instances
to report their module is not current.

.. code-block:: console

   $ echo "message=Module.V3" > ping3.dat
   $ trove module-update mymod --file ping3.dat

   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | apply_order          | 5                                    |
   | auto_apply           | False                                |
   | created              | 2017-06-02T17:06:21                  |
   | datastore            | all                                  |
   | datastore_id         | None                                 |
   | datastore_version    | all                                  |
   | datastore_version_id | None                                 |
   | description          | None                                 |
   | id                   | 0065a8ed-0668-4db5-a4ad-d88d0a166388 |
   | is_admin             | True                                 |
   | live_update          | True                                 |
   | md5                  | 869744bdd18e306a96c145df562065ab     |
   | name                 | mymod                                |
   | priority_apply       | False                                |
   | tenant               | eac1e46e5f7840e39012aff46a92073a     |
   | tenant_id            | eac1e46e5f7840e39012aff46a92073a     |
   | type                 | ping                                 |
   | updated              | 2017-06-02T18:06:53                  |
   | visible              | True                                 |
   +----------------------+--------------------------------------+

   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |   False |     3 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

To update an instance in a cluster you can use the
:command:`trove module-apply` command:

.. code-block:: console

   $ trove cluster-instances myclust

   +--------------------------------------+------------------+-----------+------+--------+
   | ID                                   | Name             | Flavor ID | Size | Status |
   +--------------------------------------+------------------+-----------+------+--------+
   | 393462d5-906d-4214-af0d-538b7f618b2d | myclust-member-2 | 15        |    1 | ACTIVE |
   | a3fc5326-e1b6-456a-a8b1-08ad6bbb2278 | myclust-member-3 | 15        |    1 | ACTIVE |
   | cba31d4b-d038-42c2-ab03-56c6c176b49d | myclust-member-1 | 15        |    1 | ACTIVE |
   +--------------------------------------+------------------+-----------+------+--------+

   $ trove module-apply 393462d5-906d-4214-af0d-538b7f618b2d mymod

   +-------+------+-----------+---------+--------+-----------+
   | Name  | Type | Datastore | Version | Status | Message   |
   +-------+------+-----------+---------+--------+-----------+
   | mymod | ping | all       | all     | OK     | Module.V3 |
   +-------+------+-----------+---------+--------+-----------+

   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |   False |     2 |
   | mymod       | 2017-06-02T18:18:37 | 2017-06-02T18:18:37 | 869744bdd18e306a96c145df562065ab |    True |     1 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

For variety in this example, create one more instance and module:

.. code-block:: console

   $ trove create myinst_2 15 --size 1 --module mymod

   +-------------------------+--------------------------------------+
   | Property                | Value                                |
   +-------------------------+--------------------------------------+
   | created                 | 2017-06-02T18:21:56                  |
   | datastore               | redis                                |
   | datastore_version       | 3.2.6                                |
   | encrypted_rpc_messaging | True                                 |
   | flavor                  | 15                                   |
   | id                      | cdd85d94-13a0-4d90-89eb-9c05523d2ac6 |
   | name                    | myinst_2                             |
   | region                  | RegionOne                            |
   | server_id               | None                                 |
   | status                  | BUILD                                |
   | tenant_id               | eac1e46e5f7840e39012aff46a92073a     |
   | updated                 | 2017-06-02T18:21:56                  |
   | volume                  | 1                                    |
   | volume_id               | None                                 |
   +-------------------------+--------------------------------------+

   $ echo "message=Module.V4" > ping4.dat
   $ trove module-update mymod --file ping4.dat

   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | apply_order          | 5                                    |
   | auto_apply           | False                                |
   | created              | 2017-06-02T17:06:21                  |
   | datastore            | all                                  |
   | datastore_id         | None                                 |
   | datastore_version    | all                                  |
   | datastore_version_id | None                                 |
   | description          | None                                 |
   | id                   | 0065a8ed-0668-4db5-a4ad-d88d0a166388 |
   | is_admin             | True                                 |
   | live_update          | True                                 |
   | md5                  | 6e2c81c1547d640b4c6e7752ed0e33ab     |
   | name                 | mymod                                |
   | priority_apply       | False                                |
   | tenant               | eac1e46e5f7840e39012aff46a92073a     |
   | tenant_id            | eac1e46e5f7840e39012aff46a92073a     |
   | type                 | ping                                 |
   | updated              | 2017-06-02T18:26:22                  |
   | visible              | True                                 |
   +----------------------+--------------------------------------+

Now we have 2 single instances, and 3 cluster instances on various
versions of the module, none current.

.. code-block:: console

   $ trove list

   +--------------------------------------+----------+-----------+-------------------+--------+-----------+------+-----------+
   | ID                                   | Name     | Datastore | Datastore Version | Status | Flavor ID | Size | Region    |
   +--------------------------------------+----------+-----------+-------------------+--------+-----------+------+-----------+
   | 6221b30c-8292-4378-b624-c7e9b0f8ba9e | myinst   | mysql     | 5.6               | ACTIVE | 15        |    1 | RegionOne |
   | cdd85d94-13a0-4d90-89eb-9c05523d2ac6 | myinst_2 | redis     | 3.2.6             | ACTIVE | 15        |    1 | RegionOne |
   +--------------------------------------+----------+-----------+-------------------+--------+-----------+------+-----------+

   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |   False |     2 |
   | mymod       | 2017-06-02T18:18:37 | 2017-06-02T18:21:57 | 869744bdd18e306a96c145df562065ab |   False |     2 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

When the latest module was created, the ``--include_clustered`` was
not used. Use the :command:`trove module-reapply` command:

.. code-block:: console

   $ trove module-reapply mymod --md5=869744bdd18e306a96c145df562065ab --include_clustered
   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |   False |     2 |
   | mymod       | 2017-06-02T18:38:48 | 2017-06-02T18:38:48 | 6e2c81c1547d640b4c6e7752ed0e33ab |    True |     2 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

Now they are both updated. If the ``--force`` flag is used, it can
reapply to already applied instances. Notice that the only thing that
changes is the minimum and maximum updated date fields.

.. code-block:: console

   $ trove module-reapply mymod --md5=6e2c81c1547d640b4c6e7752ed0e33ab --include_clustered --force
   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T17:22:25 | 2017-06-02T17:22:25 | 7f700cc7b99606615f8b51946f6d3228 |   False |     1 |
   | mymod       | 2017-06-02T18:00:18 | 2017-06-02T18:00:18 | ba7c204979c8de54be6efb70a17d40b9 |   False |     2 |
   | mymod       | 2017-06-02T18:40:45 | 2017-06-02T18:40:46 | 6e2c81c1547d640b4c6e7752ed0e33ab |    True |     2 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+

To bring every instance to the current version, use some of the
optional arguments to control how many instances are updated at the
same time. This is useful to avoid potential network issues, if the
module payload is large. Since we are not using the ``--force`` flag,
the minimum updated date will not change.

.. code-block:: console

   $ trove module-reapply mymod --include_clustered --batch_size=1 --delay=3
   $ trove module-instance-count mymod --include_clustered

   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | Module Name | Min Updated Date    | Max Updated Date    | Module MD5                       | Current | Count |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
   | mymod       | 2017-06-02T18:40:45 | 2017-06-02T18:44:10 | 6e2c81c1547d640b4c6e7752ed0e33ab |    True |     5 |
   +-------------+---------------------+---------------------+----------------------------------+---------+-------+
