=======================
Use incremental backups
=======================

Incremental backups let you chain together a series of backups. You
start with a regular backup. Then, when you want to create a subsequent
incremental backup, you specify the parent backup.

Restoring a database instance from an incremental backup is the same as
creating a database instance from a regular backup—the Database service
handles the complexities of applying the chain of incremental backups.

This example shows you how to use incremental backups with a MySQL
database.

**Assumptions.** Assume that you have created a regular
backup for the following database instance:

-  Instance name: ``guest1``

-  ID of the instance (``INSTANCE_ID``):
   ``792a6a56-278f-4a01-9997-d997fa126370``

-  ID of the regular backup artifact (``BACKUP_ID``):
   ``6dc3a9b7-1f3e-4954-8582-3f2e4942cddd``

Create and use incremental backups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. **Create your first incremental backup**

   Use the :command:`trove backup-create` command and specify:

   -  The ``INSTANCE_ID`` of the database instance you are doing the
      incremental backup for (in this example,
      ``792a6a56-278f-4a01-9997-d997fa126370``)

   -  The name of the incremental backup you are creating: ``backup1.1``

   -  The ``BACKUP_ID`` of the parent backup. In this case, the parent
      is the regular backup, with an ID of
      ``6dc3a9b7-1f3e-4954-8582-3f2e4942cddd``

   .. code-block:: console

      $ trove backup-create INSTANCE_ID backup1.1  --parent BACKUP_ID

      +-------------+--------------------------------------+
      |   Property  |                Value                 |
      +-------------+--------------------------------------+
      |   created   |         2014-03-19T14:09:13          |
      | description |                 None                 |
      |      id     | 1d474981-a006-4f62-b25f-43d7b8a7097e |
      | instance_id | 792a6a56-278f-4a01-9997-d997fa126370 |
      | locationRef |                 None                 |
      |     name    |              backup1.1               |
      |  parent_id  | 6dc3a9b7-1f3e-4954-8582-3f2e4942cddd |
      |     size    |                 None                 |
      |    status   |                 NEW                  |
      |   updated   |         2014-03-19T14:09:13          |
      +-------------+--------------------------------------+

   Note that this command returns both the ID of the database instance
   you are incrementally backing up (``instance_id``) and a new ID for
   the new incremental backup artifact you just created (``id``).

#. **Create your second incremental backup**

   The name of your second incremental backup is ``backup1.2``. This
   time, when you specify the parent, pass in the ID of the incremental
   backup you just created in the previous step (``backup1.1``). In this
   example, it is ``1d474981-a006-4f62-b25f-43d7b8a7097e``.

   .. code-block:: console

      $ trove backup-create INSTANCE_ID  backup1.2  --parent BACKUP_ID

      +-------------+--------------------------------------+
      |   Property  |                Value                 |
      +-------------+--------------------------------------+
      |   created   |         2014-03-19T14:09:13          |
      | description |                 None                 |
      |      id     | bb84a240-668e-49b5-861e-6a98b67e7a1f |
      | instance_id | 792a6a56-278f-4a01-9997-d997fa126370 |
      | locationRef |                 None                 |
      |     name    |              backup1.2               |
      |  parent_id  | 1d474981-a006-4f62-b25f-43d7b8a7097e |
      |     size    |                 None                 |
      |    status   |                 NEW                  |
      |   updated   |         2014-03-19T14:09:13          |
      +-------------+--------------------------------------+

#. **Restore using incremental backups**

   Now assume that your ``guest1`` database instance is damaged and you
   need to restore it from your incremental backups. In this example,
   you use the :command:`trove create` command to create a new database
   instance called ``guest2``.

   To incorporate your incremental backups, you simply use the
   `--backup`` parameter to pass in the ``BACKUP_ID`` of your most
   recent incremental backup. The Database service handles the
   complexities of applying the chain of all previous incremental
   backups.

   .. code-block:: console

      $ trove create guest2 10 --size 1 --backup BACKUP_ID

      +-------------------+-----------------------------------------------------------+
      |      Property     |                       Value                               |
      +-------------------+-----------------------------------------------------------+
      |      created      |                  2014-03-19T14:10:56                      |
      |     datastore     |         {u'version': u'mysql-5.5', u'type': u'mysql'}     |
      | datastore_version |                      mysql-5.5                            |
      |       flavor      | {u'id': u'10', u'links':                                  |
      |                   | [{u'href': u'https://10.125.1.135:8779/v1.0/              |
      |                   |  626734041baa4254ae316de52a20b390/flavors/10', u'rel':    |
      |                   |  u'self'}, {u'href': u'https://10.125.1.135:8779/         |
      |                   |  flavors/10', u'rel': u'bookmark'}]}                      |
      |         id        |         a3680953-eea9-4cf2-918b-5b8e49d7e1b3              |
      |        name       |                      guest2                               |
      |       status      |                      BUILD                                |
      |      updated      |                  2014-03-19T14:10:56                      |
      |       volume      |                   {u'size': 1}                            |
      +-------------------+-----------------------------------------------------------+

