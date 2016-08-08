.. _shared_file_systems_cgroups:

==================
Consistency groups
==================

Consistency groups enable you to create snapshots from multiple file system
shares at the same point in time. For example, a database might place its
tables, logs, and configurations on separate shares. Store logs, tables,
and configurations at the same point in time to effectively restore a
database.

The Shared File System service allows you to create a snapshot of the
consistency group and restore all shares that were associated with a
consistency group.

.. important::

   The **consistency groups and snapshots** are an **experimental**
   Shared File Systems API in the Liberty release.
   Contributors can change or remove the experimental part of the
   Shared File Systems API in further releases without maintaining
   backward compatibility. Experimental APIs have an
   ``X-OpenStack-Manila-API-Experimental: true`` header in
   their HTTP requests.

Consistency groups
------------------

.. note::

   Before using consistency groups, make sure the Shared File System driver
   that you are running has consistency group support. You can check it in the
   ``manila-scheduler`` service reports. The ``consistency_group_support`` can
   have the following values:

   * ``pool`` or ``host``. Consistency groups are supported. Specifies the
     level of consistency groups support.

   * ``false``. Consistency groups are not supported.

The :command:`manila cg-create` command creates a new consistency group.
With this command, you can specify a share network, and one or more share
types. In the example a consistency group ``cgroup1`` was created by
specifying two comma-separated share types:

.. code-block:: console

   $ manila cg-create --name cgroup1 --description "My first CG." --share-types my_type1,default --share-network my_share_net
   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | status               | creating                             |
   | description          | My first CG.                         |
   | source_cgsnapshot_id | None                                 |
   | created_at           | 2015-09-29T15:01:12.102472           |
   | share_network_id     | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a |
   | share_server_id      | None                                 |
   | host                 | None                                 |
   | project_id           | 20787a7ba11946adad976463b57d8a2f     |
   | share_types          | a4218aa5-f16a-42b3-945d-113496d40558 |
   |                      | c0086582-30a6-4060-b096-a42ec9d66b86 |
   | id                   | 6fdd91bc-7a48-48b4-8e40-0f4f98d0ecd6 |
   | name                 | cgroup1                              |
   +----------------------+--------------------------------------+

Check that consistency group status is ``available``:

.. code-block:: console

   $ manila cg-show cgroup1
   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | status               | available                            |
   | description          | My first CG.                         |
   | source_cgsnapshot_id | None                                 |
   | created_at           | 2015-09-29T15:05:40.000000           |
   | share_network_id     | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a |
   | share_server_id      | None                                 |
   | host                 | manila@generic1#GENERIC1             |
   | project_id           | 20787a7ba11946adad976463b57d8a2f     |
   | share_types          | c0086582-30a6-4060-b096-a42ec9d66b86 |
   |                      | a4218aa5-f16a-42b3-945d-113496d40558 |
   | id                   | 6fdd91bc-7a48-48b4-8e40-0f4f98d0ecd6 |
   | name                 | cgroup1                              |
   +----------------------+--------------------------------------+

To add a share to the consistency group, create a share by adding the
:option:`--consistency-group` option where you specify the ID of the consistency
group in ``available`` status:

.. code-block:: console

   $ manila create nfs 1 --name "Share2" --description "My second share" \
   --share-type default --share-network my_share_net --consistency-group cgroup1
   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | None                                 |
   | share_type_name             | default                              |
   | description                 | My second share                      |
   | availability_zone           | None                                 |
   | share_network_id            | None                                 |
   | export_locations            | []                                   |
   | share_server_id             | None                                 |
   | host                        | None                                 |
   | snapshot_id                 | None                                 |
   | is_public                   | False                                |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | 7bcd888b-681b-4836-ac9c-c3add4e62537 |
   | size                        | 1                                    |
   | name                        | Share2                               |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86 |
   | created_at                  | 2015-09-29T15:09:24.156387           |
   | export_location             | None                                 |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | 6fdd91bc-7a48-48b4-8e40-0f4f98d0ecd6 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f     |
   | metadata                    | {}                                   |
   +-----------------------------+--------------------------------------+

Administrators can rename the consistency group, or change its
description using the :command:`manila cg-update` command. Delete the group
with the :command:`manila cg-delete` command.

As an administrator, you can also reset the state of a consistency group and
force delete a specified consistency group in any state. Use the
``policy.json`` file to grant permissions for these actions to other roles.

Use :command:`manila cg-reset-state [--state <state>] <consistency_group>`
to update the state of a consistency group explicitly. A valid value of a
status are ``available``, ``error``, ``creating``, ``deleting``,
``error_deleting``. If no state is provided, ``available`` will be used.

.. code-block:: console

   $ manila cg-reset-state cgroup1 --state error

Use :command:`manila cg-delete <consistency_group> [<consistency_group> ...]`
to soft-delete one or more consistency groups.

.. note::

   A consistency group can be deleted only if it has no dependent
   :ref:`shared-file-systems-cgsnapshots`.

.. code-block:: console

   $ manila cg-delete cgroup1

Use :command:`manila cg-delete --force <consistency_group>
[<consistency_group> ...]`
to force-delete a specified consistency group in any state.

.. code-block:: console

   $ manila cg-delete --force cgroup1

.. _shared-file-systems-cgsnapshots:

Consistency group snapshots
---------------------------

To create a snapshot, specify the ID or name of the consistency group.
After creating a consistency group snapshot, it is possible to generate
a new consistency group.

Create a snapshot of consistency group ``cgroup1``:

.. code-block:: console

   $ manila cg-snapshot-create cgroup1 --name CG_snapshot1 --description "A snapshot of the first CG."
   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | status               | creating                             |
   | name                 | CG_snapshot1                         |
   | created_at           | 2015-09-29T15:26:16.839704           |
   | consistency_group_id | 6fdd91bc-7a48-48b4-8e40-0f4f98d0ecd6 |
   | project_id           | 20787a7ba11946adad976463b57d8a2f     |
   | id                   | 876ad24c-1efd-4607-a2b1-6a2c90034fa5 |
   | description          | A snapshot of the first CG.          |
   +----------------------+--------------------------------------+

Check the status of created consistency group snapshot:

.. code-block:: console

   $ manila cg-snapshot-show CG_snapshot1
   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | status               | available                            |
   | name                 | CG_snapshot1                         |
   | created_at           | 2015-09-29T15:26:22.000000           |
   | consistency_group_id | 6fdd91bc-7a48-48b4-8e40-0f4f98d0ecd6 |
   | project_id           | 20787a7ba11946adad976463b57d8a2f     |
   | id                   | 876ad24c-1efd-4607-a2b1-6a2c90034fa5 |
   | description          | A snapshot of the first CG.          |
   +----------------------+--------------------------------------+

Administrators can rename a consistency group snapshot, change its
description using the :command:`cg-snapshot-update` command, or delete
it with the :command:`cg-snapshot-delete` command.

A consistency group snapshot can have ``members``. To add a member,
include the :option:`--consistency-group` optional parameter in the
create share command. This ID must match the ID of the consistency group from
which the consistency group snapshot was created. Then, while restoring data,
and operating with consistency group snapshots, you can quickly
find which shares belong to a specified consistency group.

You created the share ``Share2`` in ``cgroup1`` consistency group. Since
you made a snapshot of it, you can see that the only member of the consistency
group snapshot is ``Share2`` share:

.. code-block:: console

   $ manila cg-snapshot-members CG_snapshot1
   +--------------+------+----------------------------+----------------+--------------+--------------+
   | Id           | Size | Created_at                 | Share_protocol | Share_id     | Share_type_id|
   +--------------+------+----------------------------+----------------+--------------+--------------+
   | 5c62af2b-... | 1    | 2015-09-29T15:26:22.000000 | NFS            | 7bcd888b-... | c0086582-... |
   +--------------+------+----------------------------+----------------+--------------+--------------+

After you create a consistency group snapshot, you can create a consistency
group from the new snapshot:

.. code-block:: console

   $ manila cg-create --source-cgsnapshot-id 876ad24c-1efd-4607-a2b1-6a2c90034fa5 --name cgroup2 --description "A consistency group from a CG snapshot."
   +----------------------+-----------------------------------------+
   | Property             | Value                                   |
   +----------------------+-----------------------------------------+
   | status               | creating                                |
   | description          | A consistency group from a CG snapshot. |
   | source_cgsnapshot_id | 876ad24c-1efd-4607-a2b1-6a2c90034fa5    |
   | created_at           | 2015-09-29T15:47:47.937991              |
   | share_network_id     | None                                    |
   | share_server_id      | None                                    |
   | host                 | manila@generic1#GENERIC1                |
   | project_id           | 20787a7ba11946adad976463b57d8a2f        |
   | share_types          | c0086582-30a6-4060-b096-a42ec9d66b86    |
   |                      | a4218aa5-f16a-42b3-945d-113496d40558    |
   | id                   | ffee08d9-c86c-45e5-861e-175c731daca2    |
   | name                 | cgroup2                                 |
   +----------------------+-----------------------------------------+

Check the consistency group list. Two groups now appear:

.. code-block:: console

   $ manila cg-list
   +-------------------+---------+-----------------------------------------+-----------+
   | id                | name    | description                             | status    |
   +-------------------+---------+-----------------------------------------+-----------+
   | 6fdd91bc-7a48-... | cgroup1 | My first CG.                            | available |
   | ffee08d9-c86c-... | cgroup2 | A consistency group from a CG snapshot. | available |
   +-------------------+---------+-----------------------------------------+-----------+

Check a list of the shares. New share with
``ba52454e-2ea3-47fa-a683-3176a01295e6`` ID appeared after the
consistency group ``cgroup2`` was built from a snapshot with a member.

.. code-block:: console

   $ manila list
   +------+-------+-----+------------+----------+----------+-----------+--------------------------+
   | ID   | Name  | Size| Share Proto| Status   | Is Public| Share Type| Host                     |
   +------+-------+-----+------------+----------+----------+-----------+--------------------------+
   | 7bc..| Share2| 1   | NFS        | available| False    | c008658...| manila@generic1#GENERIC1 |
   | ba5..| None  | 1   | NFS        | available| False    | c008658...| manila@generic1#GENERIC1 |
   +------+-------+-----+------------+----------+----------+-----------+--------------------------+

Print detailed information about new share:

.. note::

   Pay attention on the ``source_cgsnapshot_member_id`` and
   ``consistency_group_id`` fields in a new share. It has
   ``source_cgsnapshot_member_id`` that is equal to the ID of the consistency
   group snapshot and ``consistency_group_id`` that is equal to the ID of
   ``cgroup2`` created from a snapshot.

.. code-block:: console

   $ manila show ba52454e-2ea3-47fa-a683-3176a01295e6
   +-----------------------------+---------------------------------------------------------------+
   | Property                    | Value                                                         |
   +-----------------------------+---------------------------------------------------------------+
   | status                      | available                                                     |
   | share_type_name             | default                                                       |
   | description                 | None                                                          |
   | availability_zone           | None                                                          |
   | share_network_id            | None                                                          |
   | export_locations            | 10.254.0.5:/shares/share-5acadf4d-f81a-4515-b5ce-3ab641ab4d1e |
   | share_server_id             | None                                                          |
   | host                        | manila@generic1#GENERIC1                                      |
   | snapshot_id                 | None                                                          |
   | is_public                   | False                                                         |
   | task_state                  | None                                                          |
   | snapshot_support            | True                                                          |
   | id                          | ba52454e-2ea3-47fa-a683-3176a01295e6                          |
   | size                        | 1                                                             |
   | name                        | None                                                          |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86                          |
   | created_at                  | 2015-09-29T15:47:48.000000                                    |
   | share_proto                 | NFS                                                           |
   | consistency_group_id        | ffee08d9-c86c-45e5-861e-175c731daca2                          |
   | source_cgsnapshot_member_id | 5c62af2b-0870-4d00-b3fa-174831eb15ca                          |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f                              |
   | metadata                    | {}                                                            |
   +-----------------------------+---------------------------------------------------------------+

As an administrator, you can also reset the state of a consistency group
snapshot with the :command:`cg-snapshot-reset-state` command, and force delete a specified
consistency group snapshot in any state using the :command:`cg-snapshot-delete` command
with the :option:`--force` key. Use the ``policy.json`` file to grant permissions for
these actions to other roles.
