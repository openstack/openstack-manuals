=============================
Backup and restore a database
=============================

You can use Database services to backup a database and store the backup
artifact in the Object Storage service. Later on, if the original
database is damaged, you can use the backup artifact to restore the
database. The restore process creates a database instance.

This example shows you how to back up and restore a MySQL database.

#. **Backup the database instance**

   As background, assume that you have created a database
   instance with the following
   characteristics:

   -  Name of the database instance: ``guest1``

   -  Flavor ID: ``10``

   -  Root volume size: ``2``

   -  Databases: ``db1`` and ``db2``

   -  Users: The ``user1`` user with the ``password`` password

   First, get the ID of the ``guest1`` database instance by using the
   :command:`trove list` command:

   .. code-block:: console

      $ trove list

      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+
      |                  id                  |  name  | datastore | datastore_version | status | flavor_id | size |
      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+
      | 97b4b853-80f6-414f-ba6f-c6f455a79ae6 | guest1 |   mysql   |     mysql-5.5     | ACTIVE |     10    |  2   |
      +--------------------------------------+--------+-----------+-------------------+--------+-----------+------+

   Back up the database instance by using the :command:`trove backup-create`
   command. In this example, the backup is called ``backup1``. In this
   example, replace ``INSTANCE_ID`` with
   ``97b4b853-80f6-414f-ba6f-c6f455a79ae6``:

   .. note::

      This command syntax pertains only to python-troveclient version
      1.0.6 and later. Earlier versions require you to pass in the backup
      name as the first argument.

   .. code-block:: console

      $ trove backup-create INSTANCE_ID backup1

      +-------------+--------------------------------------+
      |   Property  |                Value                 |
      +-------------+--------------------------------------+
      |   created   |         2014-03-18T17:09:07          |
      | description |                 None                 |
      |      id     | 8af30763-61fd-4aab-8fe8-57d528911138 |
      | instance_id | 97b4b853-80f6-414f-ba6f-c6f455a79ae6 |
      | locationRef |                 None                 |
      |     name    |               backup1                |
      |  parent_id  |                 None                 |
      |     size    |                 None                 |
      |    status   |                 NEW                  |
      |   updated   |         2014-03-18T17:09:07          |
      +-------------+--------------------------------------+

   Note that the command returns both the ID of the original instance
   (``instance_id``) and the ID of the backup artifact (``id``).

   Later on, use the :command:`trove backup-list` command to get this
   information:

   .. code-block:: console

      $ trove backup-list
      +--------------------------------------+--------------------------------------+---------+-----------+-----------+---------------------+
      |                  id                  |             instance_id              |   name  |   status  | parent_id |       updated       |
      +--------------------------------------+--------------------------------------+---------+-----------+-----------+---------------------+
      | 8af30763-61fd-4aab-8fe8-57d528911138 | 97b4b853-80f6-414f-ba6f-c6f455a79ae6 | backup1 | COMPLETED |    None   | 2014-03-18T17:09:11 |
      +--------------------------------------+--------------------------------------+---------+-----------+-----------+---------------------+

   You can get additional information about the backup by using the
   :command:`trove backup-show` command and passing in the ``BACKUP_ID``,
   which is ``8af30763-61fd-4aab-8fe8-57d528911138``.

   .. code-block:: console

      $ trove backup-show BACKUP_ID

      +-------------+----------------------------------------------------+
      |   Property  |                   Value                            |
      +-------------+----------------------------------------------------+
      |   created   |              2014-03-18T17:09:07                   |
      | description |                   None                             |
      |      id     |                 8af...138                          |
      | instance_id |                 97b...ae6                          |
      | locationRef | http://10.0.0.1:.../.../8af...138.xbstream.gz.enc  |
      |     name    |                 backup1                            |
      |  parent_id  |                  None                              |
      |     size    |                  0.17                              |
      |    status   |               COMPLETED                            |
      |   updated   |           2014-03-18T17:09:11                      |
      +-------------+----------------------------------------------------+

#. **Restore a database instance**

   Now assume that your ``guest1`` database instance is damaged and you
   need to restore it. In this example, you use the :command:`trove create`
   command to create a new database instance called ``guest2``.

   -  You specify that the new ``guest2`` instance has the same flavor
      (``10``) and the same root volume size (``2``) as the original
      ``guest1`` instance.

   -  You use the ``--backup`` argument to indicate that this new
      instance is based on the backup artifact identified by
      ``BACKUP_ID``. In this example, replace ``BACKUP_ID`` with
      ``8af30763-61fd-4aab-8fe8-57d528911138``.

   .. code-block:: console

      $ trove create guest2 10 --size 2 --backup BACKUP_ID

      +-------------------+----------------------------------------------+
      |      Property     |                Value                         |
      +-------------------+----------------------------------------------+
      |      created      |         2014-03-18T17:12:03                  |
      |     datastore     | {u'version': u'mysql-5.5', u'type': u'mysql'}|
      |datastore_version  |                mysql-5.5                     |
      |       flavor      | {u'id': u'10', u'links': [{u'href': ...]}    |
      |         id        |  ac7a2b35-a9b4-4ff6-beac-a1bcee86d04b        |
      |        name       |                guest2                        |
      |       status      |                 BUILD                        |
      |      updated      |          2014-03-18T17:12:03                 |
      |       volume      |             {u'size': 2}                     |
      +-------------------+----------------------------------------------+

#. **Verify backup**

   Now check that the new ``guest2`` instance has the same
   characteristics as the original ``guest1`` instance.

   Start by getting the ID of the new ``guest2`` instance.

   .. code-block:: console

      $ trove list

      +-----------+--------+-----------+-------------------+--------+-----------+------+
      |     id    |  name  | datastore | datastore_version | status | flavor_id | size |
      +-----------+--------+-----------+-------------------+--------+-----------+------+
      | 97b...ae6 | guest1 |   mysql   |     mysql-5.5     | ACTIVE |     10    |  2   |
      | ac7...04b | guest2 |   mysql   |     mysql-5.5     | ACTIVE |     10    |  2   |
      +-----------+--------+-----------+-------------------+--------+-----------+------+

   Use the :command:`trove show` command to display information about the new
   guest2 instance. Pass in guest2's ``INSTANCE_ID``, which is
   ``ac7a2b35-a9b4-4ff6-beac-a1bcee86d04b``.

   .. code-block:: console

      $ trove show INSTANCE_ID

      +-------------------+--------------------------------------+
      |      Property     |                Value                 |
      +-------------------+--------------------------------------+
      |      created      |         2014-03-18T17:12:03          |
      |     datastore     |                mysql                 |
      | datastore_version |              mysql-5.5               |
      |       flavor      |                  10                  |
      |         id        | ac7a2b35-a9b4-4ff6-beac-a1bcee86d04b |
      |         ip        |               10.0.0.3               |
      |        name       |                guest2                |
      |       status      |                ACTIVE                |
      |      updated      |         2014-03-18T17:12:06          |
      |       volume      |                  2                   |
      |    volume_used    |                 0.18                 |
      +-------------------+--------------------------------------+

   Note that the data store, flavor ID, and volume size have the same
   values as in the original ``guest1`` instance.

   Use the :command:`trove database-list` command to check that the original
   databases (``db1`` and ``db2``) are present on the restored instance.

   .. code-block:: console

      $ trove database-list INSTANCE_ID

      +--------------------+
      |        name        |
      +--------------------+
      |        db1         |
      |        db2         |
      | performance_schema |
      |        test        |
      +--------------------+

   Use the :command:`trove user-list` command to check that the original user
   (``user1``) is present on the restored instance.

   .. code-block:: console

      $ trove user-list INSTANCE_ID

      +--------+------+-----------+
      |  name  | host | databases |
      +--------+------+-----------+
      | user1  |  %   |  db1, db2 |
      +--------+------+-----------+

#. **Notify users**

   Tell the users who were accessing the now-disabled ``guest1``
   database instance that they can now access ``guest2``. Provide them
   with ``guest2``'s name, IP address, and any other information they
   might need. (You can get this information by using the
   :command:`trove show` command.)

#. **Clean up**

   At this point, you might want to delete the disabled ``guest1``
   instance, by using the :command:`trove delete` command.

   .. code-block:: console

      $ trove delete INSTANCE_ID

