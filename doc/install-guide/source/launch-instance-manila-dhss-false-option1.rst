.. _launch-instance-manila-option1:

Option 1 - Create shares without share servers management support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a share type
-------------------

Disable DHSS before creating a share using the LVM driver.

#. Source the admin credentials to gain access to admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. Create a default share type with DHSS disabled:

   .. code-block:: console

      $ manila type-create default_share_type False
      +----------------------+--------------------------------------+
      | Property             | Value                                |
      +----------------------+--------------------------------------+
      | required_extra_specs | driver_handles_share_servers : False |
      | Name                 | default_share_type                   |
      | Visibility           | public                               |
      | is_default           | -                                    |
      | ID                   | 3df065c8-6ca4-4b80-a5cb-e633c0439097 |
      | optional_extra_specs | snapshot_support : True              |
      +----------------------+--------------------------------------+

Create a share
--------------

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ . demo-openrc

#. Create a NFS share:

   .. code-block:: console

      $ manila create NFS 1 --name share1
      +-----------------------------+--------------------------------------+
      | Property                    | Value                                |
      +-----------------------------+--------------------------------------+
      | status                      | creating                             |
      | share_type_name             | default_share_type                   |
      | description                 | None                                 |
      | availability_zone           | None                                 |
      | share_network_id            | None                                 |
      | host                        |                                      |
      | access_rules_status         | active                               |
      | snapshot_id                 | None                                 |
      | is_public                   | False                                |
      | task_state                  | None                                 |
      | snapshot_support            | True                                 |
      | id                          | 55c401b3-3112-4294-aa9f-3cc355a4e361 |
      | size                        | 1                                    |
      | name                        | share1                               |
      | share_type                  | c6dfcfc6-9920-420e-8b0a-283d578efef5 |
      | has_replicas                | False                                |
      | replication_type            | None                                 |
      | created_at                  | 2016-03-30T19:10:33.000000           |
      | share_proto                 | NFS                                  |
      | consistency_group_id        | None                                 |
      | source_cgsnapshot_member_id | None                                 |
      | project_id                  | 3a46a53a377642a284e1d12efabb3b5a     |
      | metadata                    | {}                                   |
      +-----------------------------+--------------------------------------+

#. After some time, the share status should change from ``creating``
   to ``available``:

   .. code-block:: console

      $ manila list
      +--------------------------------------+--------+------+-------------+-----------+-----------+--------------------+-----------------------------+-------------------+
      | ID                                   | Name   | Size | Share Proto | Status    | Is Public | Share Type Name    | Host                        | Availability Zone |
      +--------------------------------------+--------+------+-------------+-----------+-----------+--------------------+-----------------------------+-------------------+
      | 55c401b3-3112-4294-aa9f-3cc355a4e361 | share1 | 1    | NFS         | available | False     | default_share_type | storage@lvm#lvm-single-pool | nova              |
      +--------------------------------------+--------+------+-------------+-----------+-----------+--------------------+-----------------------------+-------------------+

#. Determine export IP address of the share:

   .. code-block:: console

      $ manila show share1
      +-----------------------------+------------------------------------------------------------------------------------+
      | Property                    | Value                                                                              |
      +-----------------------------+------------------------------------------------------------------------------------+
      | status                      | available                                                                          |
      | share_type_name             | default_share_type                                                                 |
      | description                 | None                                                                               |
      | availability_zone           | nova                                                                               |
      | share_network_id            | None                                                                               |
      | export_locations            |                                                                                    |
      |                             | path = 10.0.0.41:/var/lib/manila/mnt/share-8e13a98f-c310-41df-ac90-fc8bce4910b8    |
      |                             | id = 3c8d0ada-cadf-48dd-85b8-d4e8c3b1e204                                          |
      |                             | preferred = False                                                                  |
      | host                        | storage@lvm#lvm-single-pool                                                        |
      | access_rules_status         | active                                                                             |
      | snapshot_id                 | None                                                                               |
      | is_public                   | False                                                                              |
      | task_state                  | None                                                                               |
      | snapshot_support            | True                                                                               |
      | id                          | 55c401b3-3112-4294-aa9f-3cc355a4e361                                               |
      | size                        | 1                                                                                  |
      | name                        | share1                                                                             |
      | share_type                  | c6dfcfc6-9920-420e-8b0a-283d578efef5                                               |
      | has_replicas                | False                                                                              |
      | replication_type            | None                                                                               |
      | created_at                  | 2016-03-30T19:10:33.000000                                                         |
      | share_proto                 | NFS                                                                                |
      | consistency_group_id        | None                                                                               |
      | source_cgsnapshot_member_id | None                                                                               |
      | project_id                  | 3a46a53a377642a284e1d12efabb3b5a                                                   |
      | metadata                    | {}                                                                                 |
      +-----------------------------+------------------------------------------------------------------------------------+

#. Configure user access to the new share before attempting to mount it via
   the network:

   .. code-block:: console

      $ manila access-allow share1 ip INSTANCE_IP_ADDRESS
      +--------------+--------------------------------------+
      | Property     | Value                                |
      +--------------+--------------------------------------+
      | share_id     | 55c401b3-3112-4294-aa9f-3cc355a4e361 |
      | access_type  | ip                                   |
      | access_to    | 10.0.0.41                            |
      | access_level | rw                                   |
      | state        | new                                  |
      | id           | f88eab01-7197-44bf-ad0f-d6ca6f99fc96 |
      +--------------+--------------------------------------+

   Replace ``INSTANCE_IP_ADDRESS`` with the IP address of the instance.

   .. note::

      The instance must have connectivity to the management IP address on
      the storage node.

Mount the share from an instance
--------------------------------

#. Create a folder where the mount will be placed:

   .. code-block:: console

      $ mkdir ~/test_folder

#. Mount the NFS share in the instance using the export location of the share:

   .. code-block:: console

      # mount -t nfs 10.0.0.41:/var/lib/manila/mnt/share-b94a4dbf-49e2-452c-b9c7-510277adf5c6 ~/test_folder

For more information about how to manage shares, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

Return to :ref:`launch-instance`.
