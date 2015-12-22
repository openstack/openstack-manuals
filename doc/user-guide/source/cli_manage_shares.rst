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

      $ manila share-network-create --name mysharenetwork --description "My Manila network" --neutron-net-id 394246ed-d3fd-4a30-a456-7042ce3429b9 --neutron-subnet-id 8f56d97d-8495-4a5b-8544-9ae4ee9390fc

      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | name              | mysharenetwork                       |
      | segmentation_id   | None                                 |
      | created_at        | 2015-08-17T21:13:29.607489           |
      | neutron_subnet_id | 8f56d97d-8495-4a5b-8544-9ae4ee9390fc |
      | updated_at        | None                                 |
      | network_type      | None                                 |
      | neutron_net_id    | 394246ed-d3fd-4a30-a456-7042ce3429b9 |
      | ip_version        | None                                 |
      | nova_net_id       | None                                 |
      | cidr              | None                                 |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791     |
      | id                | ccd6b453-8b05-4508-bbce-93bfe660451f |
      | description       | My Manila network                    |
      +-------------------+--------------------------------------+

#. List share networks.

   .. code-block:: console

      $ manila share-network-list

      +--------------------------------------+----------------+
      | id                                   | name           |
      +--------------------------------------+----------------+
      | ccd6b453-8b05-4508-bbce-93bfe660451f | mysharenetwork |
      +--------------------------------------+----------------+

Create a share
~~~~~~~~~~~~~~

#. Create a share.

   .. code-block:: console

      $ manila create --name myshare --description "My Manila share" --share-network ccd6b453-8b05-4508-bbce-93bfe660451f NFS 1

      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | status            | creating                             |
      | description       | My Manila share                      |
      | availability_zone | nova                                 |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f |
      | export_locations  | []                                   |
      | host              | None                                 |
      | snapshot_id       | None                                 |
      | is_public         | False                                |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | size              | 1                                    |
      | name              | myshare                              |
      | share_type        | default                              |
      | created_at        | 2015-08-17T21:17:23.777696           |
      | export_location   | None                                 |
      | share_proto       | NFS                                  |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791     |
      | metadata          | {}                                   |
      +-------------------+--------------------------------------+

#. Show a share.

   .. code-block:: console

      $ manila show 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | status            | creating                             |
      | description       | My Manila share                      |
      | availability_zone | nova                                 |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f |
      | export_locations  | []                                   |
      | host              | ubuntuManila@generic1#GENERIC1       |
      | snapshot_id       | None                                 |
      | is_public         | False                                |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | size              | 1                                    |
      | name              | myshare                              |
      | share_type        | default                              |
      | created_at        | 2015-08-17T21:17:23.000000           |
      | export_location   | None                                 |
      | share_proto       | NFS                                  |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791     |
      | metadata          | {}                                   |
      +-------------------+--------------------------------------+

#. List shares.

   .. code-block:: console

      $ manila list

     +--------------------------------------+---------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | ID                                   | Name    | Size | Share Proto | Status    | Is Public | Share Type | Export location                                               | Host                           |
     +--------------------------------------+---------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | 2fe736d1-08ac-46f9-a482-8f224405f2a7 | myshare | 1    | NFS         | available | False     | default    | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 | ubuntuManila@generic1#GENERIC1 |
     +--------------------------------------+---------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+

Allow access
~~~~~~~~~~~~

#. Allow access.

   .. code-block:: console

      $ manila access-allow 2fe736d1-08ac-46f9-a482-8f224405f2a7 ip 192.100.00.168

      +--------------+--------------------------------------+
      | Property     | Value                                |
      +--------------+--------------------------------------+
      | share_id     | 2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | deleted      | False                                |
      | created_at   | 2015-08-17T21:36:52.025125           |
      | updated_at   | None                                 |
      | access_type  | ip                                   |
      | access_to    | 192.100.00.168                       |
      | access_level | rw                                   |
      | state        | new                                  |
      | deleted_at   | None                                 |
      | id           | d73d04ca-a97e-42bb-94b1-e01c72c8e50e |
      +--------------+--------------------------------------+


#. List access.

   .. code-block:: console

      $ manila access-list 2fe736d1-08ac-46f9-a482-8f224405f2a7

     +--------------------------------------+-------------+----------------+--------------+--------+
     | id                                   | access type | access to      | access level | state  |
     +--------------------------------------+-------------+----------------+--------------+--------+
     | d73d04ca-a97e-42bb-94b1-e01c72c8e50e | ip          | 192.100.00.168 | rw           | active |
     +--------------------------------------+-------------+----------------+--------------+--------+

   The access is created.

Deny access
~~~~~~~~~~~

#. Deny access.

   .. code-block:: console

      $ manila access-deny 2fe736d1-08ac-46f9-a482-8f224405f2a7 d73d04ca-a97e-42bb-94b1-e01c72c8e50e

#. List access.

   .. code-block:: console

      $ manila access-list 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +----+-------------+-----------+--------------+-------+
      | id | access type | access to | access level | state |
      +----+-------------+-----------+--------------+-------+
      +----+-------------+-----------+--------------+-------+

   The access is removed.

Create snapshot
~~~~~~~~~~~~~~~

#. Create a snapshot.

   .. code-block:: console

      $ manila snapshot-create --name mysnapshot --description "My Manila snapshot" 2fe736d1-08ac-46f9-a482-8f224405f2a7

     +-------------+--------------------------------------+
     | Property    | Value                                |
     +-------------+--------------------------------------+
     | status      | creating                             |
     | share_id    | 2fe736d1-08ac-46f9-a482-8f224405f2a7 |
     | name        | mysnapshot                           |
     | created_at  | 2015-08-17T21:50:53.295017           |
     | share_proto | NFS                                  |
     | id          | 1a411703-baef-495f-8e9c-b60e68f2e657 |
     | size        | 1                                    |
     | share_size  | 1                                    |
     | description | My Manila snapshot                   |
     +-------------+--------------------------------------+

#. List snapshots.

   .. code-block:: console

      $ manila snapshot-list

      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | ID                                   | Share ID                             | Status    | Name       | Share Size |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | 1a411703-baef-495f-8e9c-b60e68f2e657 | 2fe736d1-08ac-46f9-a482-8f224405f2a7 | available | mysnapshot | 1          |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+

Create share from snapshot
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a share from a snapshot.

   .. code-block:: console

      $ manila create --snapshot-id 1a411703-baef-495f-8e9c-b60e68f2e657 --share-network ccd6b453-8b05-4508-bbce-93bfe660451f --name mysharefromsnap NFS 1

      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | status            | creating                             |
      | description       | None                                 |
      | availability_zone | nova                                 |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f |
      | export_locations  | []                                   |
      | host              | ubuntuManila@generic1#GENERIC1       |
      | snapshot_id       | 1a411703-baef-495f-8e9c-b60e68f2e657 |
      | is_public         | False                                |
      | id                | bcc5b2a7-862b-418a-9607-5d669619d652 |
      | size              | 1                                    |
      | name              | mysharefromsnap                      |
      | share_type        | default                              |
      | created_at        | 2015-08-17T21:54:43.000000           |
      | export_location   | None                                 |
      | share_proto       | NFS                                  |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791     |
      | metadata          | {}                                   |
      +-------------------+--------------------------------------+


#. List shares.

   .. code-block:: console

      $ manila list

     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | ID                                   | Name            | Size | Share Proto | Status    | Is Public | Share Type | Export location                                               | Host                           |
     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | 2fe736d1-08ac-46f9-a482-8f224405f2a7 | myshare         | 1    | NFS         | available | False     | default    | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 | ubuntuManila@generic1#GENERIC1 |
     | bcc5b2a7-862b-418a-9607-5d669619d652 | mysharefromsnap | 1    | NFS         | creating  | False     | default    | None                                                          | ubuntuManila@generic1#GENERIC1 |
     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+

#. Show the share created from snapshot.

   .. code-block:: console

      $ manila show bcc5b2a7-862b-418a-9607-5d669619d652

      +-------------------+---------------------------------------------------------------+
      | Property          | Value                                                         |
      +-------------------+---------------------------------------------------------------+
      | status            | available                                                     |
      | description       | None                                                          |
      | availability_zone | nova                                                          |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f                          |
      | export_locations  | 10.254.0.3:/shares/share-bcc5b2a7-862b-418a-9607-5d669619d652 |
      | host              | ubuntuManila@generic1#GENERIC1                                |
      | snapshot_id       | 1a411703-baef-495f-8e9c-b60e68f2e657                          |
      | is_public         | False                                                         |
      | id                | bcc5b2a7-862b-418a-9607-5d669619d652                          |
      | size              | 1                                                             |
      | name              | mysharefromsnap                                               |
      | share_type        | default                                                       |
      | created_at        | 2015-08-17T21:54:43.000000                                    |
      | share_proto       | NFS                                                           |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791                              |
      | metadata          | {}                                                            |
      +-------------------+---------------------------------------------------------------+

Delete share
~~~~~~~~~~~~

#. Delete a share.

   .. code-block:: console

      $ manila delete bcc5b2a7-862b-418a-9607-5d669619d652

#. List shares.

   .. code-block:: console

      $ manila list

     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | ID                                   | Name            | Size | Share Proto | Status    | Is Public | Share Type | Export location                                               | Host                           |
     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+
     | 2fe736d1-08ac-46f9-a482-8f224405f2a7 | myshare         | 1    | NFS         | available | False     | default    | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 | ubuntuManila@generic1#GENERIC1 |
     | bcc5b2a7-862b-418a-9607-5d669619d652 | mysharefromsnap | 1    | NFS         | deleting  | False     | default    | 10.254.0.3:/shares/share-bcc5b2a7-862b-418a-9607-5d669619d652 | ubuntuManila@generic1#GENERIC1 |
     +--------------------------------------+-----------------+------+-------------+-----------+-----------+------------+---------------------------------------------------------------+--------------------------------+

   The share is being deleted.

Delete snapshot
~~~~~~~~~~~~~~~

#. List snapshots before deleting.

   .. code-block:: console

      $ manila snapshot-list

      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | ID                                   | Share ID                             | Status    | Name       | Share Size |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+
      | 1a411703-baef-495f-8e9c-b60e68f2e657 | 2fe736d1-08ac-46f9-a482-8f224405f2a7 | available | mysnapshot | 1          |
      +--------------------------------------+--------------------------------------+-----------+------------+------------+

#. Delete a snapshot.

   .. code-block:: console

      $ manila snapshot-delete 1a411703-baef-495f-8e9c-b60e68f2e657xyang@ubuntuManila:~/devstack$ manila snapshot-list

#. List snapshots after deleting.

   .. code-block:: console

      +----+----------+--------+------+------------+
      | ID | Share ID | Status | Name | Share Size |
      +----+----------+--------+------+------------+
      +----+----------+--------+------+------------+

   The snapshot is deleted.

Extend share
~~~~~~~~~~~~

#. Extend share.

   .. code-block:: console

      $ manila extend 2fe736d1-08ac-46f9-a482-8f224405f2a7 2

#. Show the share while it is being extended.

   .. code-block:: console

      $ manila show 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +-------------------+---------------------------------------------------------------+
      | Property          | Value                                                         |
      +-------------------+---------------------------------------------------------------+
      | status            | extending                                                     |
      | description       | My Manila share                                               |
      | availability_zone | nova                                                          |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f                          |
      | export_locations  | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | host              | ubuntuManila@generic1#GENERIC1                                |
      | snapshot_id       | None                                                          |
      | is_public         | False                                                         |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7                          |
      | size              | 1                                                             |
      | name              | myshare                                                       |
      | share_type        | default                                                       |
      | created_at        | 2015-08-17T21:17:23.000000                                    |
      | share_proto       | NFS                                                           |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791                              |
      | metadata          | {}                                                            |
      +-------------------+---------------------------------------------------------------+

#. Show the share after it is extended.

   .. code-block:: console

      $ manila show 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +-------------------+---------------------------------------------------------------+
      | Property          | Value                                                         |
      +-------------------+---------------------------------------------------------------+
      | status            | available                                                     |
      | description       | My Manila share                                               |
      | availability_zone | nova                                                          |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f                          |
      | export_locations  | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | host              | ubuntuManila@generic1#GENERIC1                                |
      | snapshot_id       | None                                                          |
      | is_public         | False                                                         |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7                          |
      | size              | 2                                                             |
      | name              | myshare                                                       |
      | share_type        | default                                                       |
      | created_at        | 2015-08-17T21:17:23.000000                                    |
      | share_proto       | NFS                                                           |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791                              |
      | metadata          | {}                                                            |
      +-------------------+---------------------------------------------------------------+

Shrink share
~~~~~~~~~~~~

#. Shrink a share.

   .. code-block:: console

      $ manila shrink 2fe736d1-08ac-46f9-a482-8f224405f2a7 1

#. Show the share while it is being shrunk.

   .. code-block:: console

      $ manila show 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +-------------------+---------------------------------------------------------------+
      | Property          | Value                                                         |
      +-------------------+---------------------------------------------------------------+
      | status            | shrinking                                                     |
      | description       | My Manila share                                               |
      | availability_zone | nova                                                          |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f                          |
      | export_locations  | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | host              | ubuntuManila@generic1#GENERIC1                                |
      | snapshot_id       | None                                                          |
      | is_public         | False                                                         |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7                          |
      | size              | 2                                                             |
      | name              | myshare                                                       |
      | share_type        | default                                                       |
      | created_at        | 2015-08-17T21:17:23.000000                                    |
      | share_proto       | NFS                                                           |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791                              |
      | metadata          | {}                                                            |
      +-------------------+---------------------------------------------------------------+

#. Show the share after it is being shrunk.

   .. code-block:: console

      $ manila show 2fe736d1-08ac-46f9-a482-8f224405f2a7

      +-------------------+---------------------------------------------------------------+
      | Property          | Value                                                         |
      +-------------------+---------------------------------------------------------------+
      | status            | available                                                     |
      | description       | My Manila share                                               |
      | availability_zone | nova                                                          |
      | share_network_id  | ccd6b453-8b05-4508-bbce-93bfe660451f                          |
      | export_locations  | 10.254.0.3:/shares/share-2fe736d1-08ac-46f9-a482-8f224405f2a7 |
      | host              | ubuntuManila@generic1#GENERIC1                                |
      | snapshot_id       | None                                                          |
      | is_public         | False                                                         |
      | id                | 2fe736d1-08ac-46f9-a482-8f224405f2a7                          |
      | size              | 1                                                             |
      | name              | myshare                                                       |
      | share_type        | default                                                       |
      | created_at        | 2015-08-17T21:17:23.000000                                    |
      | share_proto       | NFS                                                           |
      | project_id        | d80a6323e99f4f22a26ad2accd3ec791                              |
      | metadata          | {}                                                            |
      +-------------------+---------------------------------------------------------------+
