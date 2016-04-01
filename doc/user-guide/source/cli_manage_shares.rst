.. _share:

=============
Manage shares
=============

A share is provided by file storage. You can give access to a share to
instances. To create and manage shares, you use ``manila`` client commands.

Create a share network
~~~~~~~~~~~~~~~~~~~~~~

#. Create a share network.

   .. code-block:: console

      $ manila share-network-create \
          --name mysharenetwork \
          --description "My Manila network" \
          --neutron-net-id dca0efc7-523d-43ef-9ded-af404a02b055 \
          --neutron-subnet-id 29ecfbd5-a9be-467e-8b4a-3415d1f82888
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | name              | mysharenetwork                       |
      | segmentation_id   | None                                 |
      | created_at        | 2016-03-24T14:13:02.888816           |
      | neutron_subnet_id | 29ecfbd5-a9be-467e-8b4a-3415d1f82888 |
      | updated_at        | None                                 |
      | network_type      | None                                 |
      | neutron_net_id    | dca0efc7-523d-43ef-9ded-af404a02b055 |
      | ip_version        | None                                 |
      | nova_net_id       | None                                 |
      | cidr              | None                                 |
      | project_id        | 907004508ef4447397ce6741a8f037c1     |
      | id                | c895fe26-92be-4152-9e6c-f2ad230efb13 |
      | description       | My Manila network                    |
      +-------------------+--------------------------------------+

#. List share networks.

   .. code-block:: console

      $ manila share-network-list
      +--------------------------------------+----------------+
      | id                                   | name           |
      +--------------------------------------+----------------+
      | c895fe26-92be-4152-9e6c-f2ad230efb13 | mysharenetwork |
      +--------------------------------------+----------------+

Create a share
~~~~~~~~~~~~~~

#. Create a share.

   .. code-block:: console

      $ manila create NFS 1 \
          --name myshare \
          --description "My Manila share" \
          --share-network mysharenetwork \
          --share-type default
      +-----------------------------+--------------------------------------+
      | Property                    | Value                                |
      +-----------------------------+--------------------------------------+
      | status                      | creating                             |
      | share_type_name             | default                              |
      | description                 | My Manila share                      |
      | availability_zone           | None                                 |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13 |
      | share_server_id             | None                                 |
      | host                        |                                      |
      | access_rules_status         | active                               |
      | snapshot_id                 | None                                 |
      | is_public                   | False                                |
      | task_state                  | None                                 |
      | snapshot_support            | True                                 |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 |
      | size                        | 1                                    |
      | name                        | myshare                              |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf |
      | has_replicas                | False                                |
      | replication_type            | None                                 |
      | created_at                  | 2016-03-24T14:15:34.000000           |
      | share_proto                 | NFS                                  |
      | consistency_group_id        | None                                 |
      | source_cgsnapshot_member_id | None                                 |
      | project_id                  | 907004508ef4447397ce6741a8f037c1     |
      | metadata                    | {}                                   |
      +-----------------------------+--------------------------------------+

#. Show a share.

   .. code-block:: console

      $ manila show myshare
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | available                                                     |
      | share_type_name             | default                                                       |
      | description                 | My Manila share                                               |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = b6bd76ce-12a2-42a9-a30a-8a43b503867d                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      |                             | path = 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 6921e862-88bc-49a5-a2df-efeed9acd583                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | None                                                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400                          |
      | size                        | 1                                                             |
      | name                        | myshare                                                       |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:15:34.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+

#. List shares.

   .. code-block:: console

      $ manila list
      +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | ID                                   | Name    | Size | Share Proto | Status    | Is Public | Share Type Name | Host                        | Availability Zone |
      +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 | myshare | 1    | NFS         | available | False     | default         | nosb-devstack@london#LONDON | nova              |
      +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+

#. List share export locations.

   .. code-block:: console

      $ manila share-export-location-list myshare
      +--------------------------------------+--------------------------------------------------------+-----------+
      | ID                                   | Path                                                   | Preferred |
      +--------------------------------------+--------------------------------------------------------+-----------+
      | 6921e862-88bc-49a5-a2df-efeed9acd583 | 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   | False     |
      | b6bd76ce-12a2-42a9-a30a-8a43b503867d | 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d | False     |
      +--------------------------------------+--------------------------------------------------------+-----------+

Allow read-write access
~~~~~~~~~~~~~~~~~~~~~~~

#. Allow access.

   .. code-block:: console

      $ manila access-allow myshare ip 10.0.0.0/24
      +--------------+--------------------------------------+
      | Property     | Value                                |
      +--------------+--------------------------------------+
      | share_id     | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 |
      | access_type  | ip                                   |
      | access_to    | 10.0.0.0/24                          |
      | access_level | rw                                   |
      | state        | new                                  |
      | id           | 0c8470ca-0d77-490c-9e71-29e1f453bf97 |
      +--------------+--------------------------------------+

#. List access.

   .. code-block:: console

      $ manila access-list myshare
      +--------------------------------------+-------------+-------------+--------------+--------+
      | id                                   | access_type | access_to   | access_level | state  |
      +--------------------------------------+-------------+-------------+--------------+--------+
      | 0c8470ca-0d77-490c-9e71-29e1f453bf97 | ip          | 10.0.0.0/24 | rw           | active |
      +--------------------------------------+-------------+-------------+--------------+--------+

   The access is created.

Allow read-only access
~~~~~~~~~~~~~~~~~~~~~~

#. Allow access.

   .. code-block:: console

      $ manila access-allow myshare ip 20.0.0.0/24 --access-level ro
      +--------------+--------------------------------------+
      | Property     | Value                                |
      +--------------+--------------------------------------+
      | share_id     | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 |
      | access_type  | ip                                   |
      | access_to    | 20.0.0.0/24                          |
      | access_level | ro                                   |
      | state        | new                                  |
      | id           | f151ad17-654d-40ce-ba5d-98a5df67aadc |
      +--------------+--------------------------------------+

#. List access.

   .. code-block:: console

      $ manila access-list myshare
      +--------------------------------------+-------------+-------------+--------------+--------+
      | id                                   | access_type | access_to   | access_level | state  |
      +--------------------------------------+-------------+-------------+--------------+--------+
      | 0c8470ca-0d77-490c-9e71-29e1f453bf97 | ip          | 10.0.0.0/24 | rw           | active |
      | f151ad17-654d-40ce-ba5d-98a5df67aadc | ip          | 20.0.0.0/24 | ro           | active |
      +--------------------------------------+-------------+-------------+--------------+--------+

   The access is created.

Deny access
~~~~~~~~~~~

#. Deny access.

   .. code-block:: console

      $ manila access-deny myshare 0c8470ca-0d77-490c-9e71-29e1f453bf97
      $ manila access-deny myshare f151ad17-654d-40ce-ba5d-98a5df67aadc

#. List access.

   .. code-block:: console

      $ manila access-list myshare
      +----+-------------+-----------+--------------+-------+
      | id | access type | access to | access level | state |
      +----+-------------+-----------+--------------+-------+
      +----+-------------+-----------+--------------+-------+

   The access is removed.

Create snapshot
~~~~~~~~~~~~~~~

#. Create a snapshot.

   .. code-block:: console

      $ manila snapshot-create --name mysnapshot --description "My Manila snapshot" myshare
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | status            | creating                             |
      | share_id          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 |
      | description       | My Manila snapshot                   |
      | created_at        | 2016-03-24T14:39:58.232844           |
      | share_proto       | NFS                                  |
      | provider_location | None                                 |
      | id                | e744ca47-0931-4e81-9d9f-2ead7d7c1640 |
      | size              | 1                                    |
      | share_size        | 1                                    |
      | name              | mysnapshot                           |
      +-------------------+--------------------------------------+

#. List snapshots.

   .. code-block:: console

      $ manila snapshot-list
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | ID                                   | Share ID                             | Status    | Name       | Share Size |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | e744ca47-0931-4e81-9d9f-2ead7d7c1640 | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 | available | mysnapshot | 1          |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+

Create share from snapshot
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a share from a snapshot.

   .. code-block:: console

      $ manila create NFS 1 \
          --snapshot-id e744ca47-0931-4e81-9d9f-2ead7d7c1640 \
          --share-network mysharenetwork \
          --name mysharefromsnap
      +-----------------------------+--------------------------------------+
      | Property                    | Value                                |
      +-----------------------------+--------------------------------------+
      | status                      | creating                             |
      | share_type_name             | default                              |
      | description                 | None                                 |
      | availability_zone           | nova                                 |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13 |
      | share_server_id             | None                                 |
      | host                        | nosb-devstack@london#LONDON          |
      | access_rules_status         | active                               |
      | snapshot_id                 | e744ca47-0931-4e81-9d9f-2ead7d7c1640 |
      | is_public                   | False                                |
      | task_state                  | None                                 |
      | snapshot_support            | True                                 |
      | id                          | e73ebcd3-4764-44f0-9b42-fab5cf34a58b |
      | size                        | 1                                    |
      | name                        | mysharefromsnap                      |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf |
      | has_replicas                | False                                |
      | replication_type            | None                                 |
      | created_at                  | 2016-03-24T14:41:36.000000           |
      | share_proto                 | NFS                                  |
      | consistency_group_id        | None                                 |
      | source_cgsnapshot_member_id | None                                 |
      | project_id                  | 907004508ef4447397ce6741a8f037c1     |
      | metadata                    | {}                                   |
      +-----------------------------+--------------------------------------+

#. List shares.

   .. code-block:: console

      $ manila list
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | ID                                   | Name            | Size | Share Proto | Status    | Is Public | Share Type Name | Host                        | Availability Zone |
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 | myshare         | 1    | NFS         | available | False     | default         | nosb-devstack@london#LONDON | nova              |
      | e73ebcd3-4764-44f0-9b42-fab5cf34a58b | mysharefromsnap | 1    | NFS         | available | False     | default         | nosb-devstack@london#LONDON | nova              |
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+

#. Show the share created from snapshot.

   .. code-block:: console

      $ manila show mysharefromsnap
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | available                                                     |
      | share_type_name             | default                                                       |
      | description                 | None                                                          |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-4c00cb49-51d9-478e-abc1-d1853efaf6d3 |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = 5419fb40-04b9-4a52-b08e-19aa1ce13a5c                     |
      |                             | share_instance_id = 4c00cb49-51d9-478e-abc1-d1853efaf6d3      |
      |                             | path = 10.0.0.3:/share-4c00cb49-51d9-478e-abc1-d1853efaf6d3   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 26f55e4c-6edc-4e55-8c55-c62b7db1aa9f                     |
      |                             | share_instance_id = 4c00cb49-51d9-478e-abc1-d1853efaf6d3      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | e744ca47-0931-4e81-9d9f-2ead7d7c1640                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | e73ebcd3-4764-44f0-9b42-fab5cf34a58b                          |
      | size                        | 1                                                             |
      | name                        | mysharefromsnap                                               |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:41:36.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+

Delete share
~~~~~~~~~~~~

#. Delete a share.

   .. code-block:: console

      $ manila delete mysharefromsnap

#. List shares.

   .. code-block:: console

      $ manila list
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | ID                                   | Name            | Size | Share Proto | Status    | Is Public | Share Type Name | Host                        | Availability Zone |
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+
      | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 | myshare         | 1    | NFS         | available | False     | default         | nosb-devstack@london#LONDON | nova              |
      | e73ebcd3-4764-44f0-9b42-fab5cf34a58b | mysharefromsnap | 1    | NFS         | deleting  | False     | default         | nosb-devstack@london#LONDON | nova              |
      +--------------------------------------+-----------------+------+-------------+-----------+-----------+-----------------+-----------------------------+-------------------+

   The share is being deleted.

Delete snapshot
~~~~~~~~~~~~~~~

#. List snapshots before deleting.

   .. code-block:: console

      $ manila snapshot-list
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | ID                                   | Share ID                             | Status    | Name       | Share Size |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | e744ca47-0931-4e81-9d9f-2ead7d7c1640 | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400 | available | mysnapshot | 1          |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+

#. Delete a snapshot.

   .. code-block:: console

      $ manila snapshot-delete mysnapshot

#. List snapshots after deleting.

   .. code-block:: console

      $ manila snapshot-list

      +----+----------+--------+------+------------+
      | ID | Share ID | Status | Name | Share Size |
      +----+----------+--------+------+------------+
      +----+----------+--------+------+------------+

   The snapshot is deleted.

Extend share
~~~~~~~~~~~~

#. Extend share.

   .. code-block:: console

      $ manila extend myshare 2

#. Show the share while it is being extended.

   .. code-block:: console

      $ manila show myshare
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | extending                                                     |
      | share_type_name             | default                                                       |
      | description                 | My Manila share                                               |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = b6bd76ce-12a2-42a9-a30a-8a43b503867d                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      |                             | path = 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 6921e862-88bc-49a5-a2df-efeed9acd583                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | None                                                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400                          |
      | size                        | 1                                                             |
      | name                        | myshare                                                       |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:15:34.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+

#. Show the share after it is extended.

   .. code-block:: console

      $ manila show myshare
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | available                                                     |
      | share_type_name             | default                                                       |
      | description                 | My Manila share                                               |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = b6bd76ce-12a2-42a9-a30a-8a43b503867d                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      |                             | path = 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 6921e862-88bc-49a5-a2df-efeed9acd583                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | None                                                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400                          |
      | size                        | 2                                                             |
      | name                        | myshare                                                       |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:15:34.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+

Shrink share
~~~~~~~~~~~~

#. Shrink a share.

   .. code-block:: console

      $ manila shrink myshare 1

#. Show the share while it is being shrunk.

   .. code-block:: console

      $ manila show myshare
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | shrinking                                                     |
      | share_type_name             | default                                                       |
      | description                 | My Manila share                                               |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = b6bd76ce-12a2-42a9-a30a-8a43b503867d                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      |                             | path = 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 6921e862-88bc-49a5-a2df-efeed9acd583                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | None                                                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400                          |
      | size                        | 2                                                             |
      | name                        | myshare                                                       |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:15:34.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+

#. Show the share after it is being shrunk.

   .. code-block:: console

      $ manila show myshare
      +-----------------------------+---------------------------------------------------------------+
      | Property                    | Value                                                         |
      +-----------------------------+---------------------------------------------------------------+
      | status                      | available                                                     |
      | share_type_name             | default                                                       |
      | description                 | My Manila share                                               |
      | availability_zone           | nova                                                          |
      | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13                          |
      | export_locations            |                                                               |
      |                             | path = 10.254.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d |
      |                             | preferred = False                                             |
      |                             | is_admin_only = False                                         |
      |                             | id = b6bd76ce-12a2-42a9-a30a-8a43b503867d                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      |                             | path = 10.0.0.3:/share-e1c2d35e-fe67-4028-ad7a-45f668732b1d   |
      |                             | preferred = False                                             |
      |                             | is_admin_only = True                                          |
      |                             | id = 6921e862-88bc-49a5-a2df-efeed9acd583                     |
      |                             | share_instance_id = e1c2d35e-fe67-4028-ad7a-45f668732b1d      |
      | share_server_id             | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                          |
      | host                        | nosb-devstack@london#LONDON                                   |
      | access_rules_status         | active                                                        |
      | snapshot_id                 | None                                                          |
      | is_public                   | False                                                         |
      | task_state                  | None                                                          |
      | snapshot_support            | True                                                          |
      | id                          | 8d8b854b-ec32-43f1-acc0-1b2efa7c3400                          |
      | size                        | 1                                                             |
      | name                        | myshare                                                       |
      | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                          |
      | has_replicas                | False                                                         |
      | replication_type            | None                                                          |
      | created_at                  | 2016-03-24T14:15:34.000000                                    |
      | share_proto                 | NFS                                                           |
      | consistency_group_id        | None                                                          |
      | source_cgsnapshot_member_id | None                                                          |
      | project_id                  | 907004508ef4447397ce6741a8f037c1                              |
      | metadata                    | {}                                                            |
      +-----------------------------+---------------------------------------------------------------+
