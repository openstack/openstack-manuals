.. _shared_file_systems_snapshots:

===============
Share snapshots
===============

The Shared File Systems service provides a snapshot mechanism to help users
restore data by running the :command:`manila snapshot-create` command.

To export a snapshot, create a share from it, then mount the new share
to an instance. Copy files from the attached share into the archive.

To import a snapshot, create a new share with appropriate size, attach it to
instance, and then copy a file from the archive to the attached file
system.

.. note::

   You cannot delete a share while it has saved dependent snapshots.

Create a snapshot from the share:

.. code-block:: console

   $ manila snapshot-create Share1 --name Snapshot1 --description "Snapshot of Share1"
   +-------------+--------------------------------------+
   | Property    | Value                                |
   +-------------+--------------------------------------+
   | status      | creating                             |
   | share_id    | aca648eb-8c03-4394-a5cc-755066b7eb66 |
   | name        | Snapshot1                            |
   | created_at  | 2015-09-25T05:27:38.862040           |
   | share_proto | NFS                                  |
   | id          | 962e8126-35c3-47bb-8c00-f0ee37f42ddd |
   | size        | 1                                    |
   | share_size  | 1                                    |
   | description | Snapshot of Share1                   |
   +-------------+--------------------------------------+

Update snapshot name or description if needed:

.. code-block:: console

   $ manila snapshot-rename Snapshot1 Snapshot_1 --description "Snapshot of Share1. Updated."

Check that status of a snapshot is ``available``:

.. code-block:: console

   $ manila snapshot-show Snapshot1
   +-------------+--------------------------------------+
   | Property    | Value                                |
   +-------------+--------------------------------------+
   | status      | available                            |
   | share_id    | aca648eb-8c03-4394-a5cc-755066b7eb66 |
   | name        | Snapshot1                            |
   | created_at  | 2015-09-25T05:27:38.000000           |
   | share_proto | NFS                                  |
   | id          | 962e8126-35c3-47bb-8c00-f0ee37f42ddd |
   | size        | 1                                    |
   | share_size  | 1                                    |
   | description | Snapshot of Share1                   |
   +-------------+--------------------------------------+

To restore your data from a snapshot, use :command:`manila create` with
key ``--snapshot-id``. This creates a new share from an
existing snapshot. Create a share from a snapshot and check whether
it is available:

.. code-block:: console

   $ manila create nfs 1 --name Share2 --metadata source=snapshot --description "Share from a snapshot." --snapshot-id 962e8126-35c3-47bb-8c00-f0ee37f42ddd
   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | None                                 |
   | share_type_name             | default                              |
   | description                 | Share from a snapshot.               |
   | availability_zone           | None                                 |
   | share_network_id            | None                                 |
   | export_locations            | []                                   |
   | share_server_id             | None                                 |
   | host                        | None                                 |
   | snapshot_id                 | 962e8126-35c3-47bb-8c00-f0ee37f42ddd |
   | is_public                   | False                                |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | b6b0617c-ea51-4450-848e-e7cff69238c7 |
   | size                        | 1                                    |
   | name                        | Share2                               |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86 |
   | created_at                  | 2015-09-25T06:25:50.240417           |
   | export_location             | None                                 |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | None                                 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f     |
   | metadata                    | {u'source': u'snapshot'}             |
   +-----------------------------+--------------------------------------+

   $ manila show Share2
   +-----------------------------+-------------------------------------------+
   | Property                    | Value                                     |
   +-----------------------------+-------------------------------------------+
   | status                      | available                                 |
   | share_type_name             | default                                   |
   | description                 | Share from a snapshot.                    |
   | availability_zone           | nova                                      |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a      |
   | export_locations            | 10.254.0.3:/shares/share-1dc2a471-3d47-...|
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961      |
   | host                        | manila@generic1#GENERIC1                  |
   | snapshot_id                 | 962e8126-35c3-47bb-8c00-f0ee37f42ddd      |
   | is_public                   | False                                     |
   | task_state                  | None                                      |
   | snapshot_support            | True                                      |
   | id                          | b6b0617c-ea51-4450-848e-e7cff69238c7      |
   | size                        | 1                                         |
   | name                        | Share2                                    |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86      |
   | created_at                  | 2015-09-25T06:25:50.000000                |
   | share_proto                 | NFS                                       |
   | consistency_group_id        | None                                      |
   | source_cgsnapshot_member_id | None                                      |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f          |
   | metadata                    | {u'source': u'snapshot'}                  |
   +-----------------------------+-------------------------------------------+

You can soft-delete a snapshot using :command:`manila snapshot-delete
<snapshot_name_or_ID>`. If a snapshot is in busy state, and during
the delete an ``error_deleting`` status appeared, administrator can
force-delete it or explicitly reset the state.

Use :command:`snapshot-reset-state [--state <state>] <snapshot>` to update
the state of a snapshot explicitly. A valid value of a status are
``available``, ``error``, ``creating``, ``deleting``, ``error_deleting``.
If no state is provided, the ``available`` state will be used.

Use :command:`manila snapshot-force-delete <snapshot>` to force-delete
a specified share snapshot in any state.
