.. _launch-instance-manila-option2:

Option 2 - Create shares with share servers management support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before being able to create a share, the generic driver with the DHSS mode
enabled requires the definition of at least an image, a flavor, a network, and
a share-network for being used to create a share server where the NFS/CIFS
shares are served.

Create a share type
-------------------

Enable DHSS before creating a share using the generic driver.

#. Source the admin credentials to gain access to admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. Create a default share type with DHSS enabled:

   .. code-block:: console

      $ manila type-create generic_share_type True
      +----------------------+--------------------------------------+
      | Property             | Value                                |
      +----------------------+--------------------------------------+
      | required_extra_specs | driver_handles_share_servers : True  |
      | Name                 | generic_share_type                   |
      | Visibility           | public                               |
      | is_default           | -                                    |
      | ID                   | 3df065c8-6ca4-4b80-a5cb-e633c0439097 |
      | optional_extra_specs | snapshot_support : True              |
      +----------------------+--------------------------------------+

Create a share network
----------------------

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ . demo-openrc

#. List available networks to obtain the network and subnet ID for the
   ``selfservice`` network:

   .. code-block:: console

      $ neutron net-list
      +--------------------------------------+-------------+-----------------------------------------------------+
      | id                                   | name        | subnets                                             |
      +--------------------------------------+-------------+-----------------------------------------------------+
      | b72d8561-aceb-4e79-938f-df3a45fdeaa3 | provider    | 072dd25f-e049-454c-9b11-359c910e6668 203.0.113.0/24 |
      | 4e963f5b-b5f3-4db1-a935-0d34c8629e7b | selfservice | 005bf8d1-798e-450f-9efe-72bc0c3be491 172.16.1.0/24  |
      +--------------------------------------+-------------+-----------------------------------------------------+

#. Create the share network using the ``selfservice`` network and subnet IDs:

   .. code-block:: console

      $ manila share-network-create --name selfservice-net-share1 \
        --neutron-net-id 4e963f5b-b5f3-4db1-a935-0d34c8629e7b \
        --neutron-subnet-id 005bf8d1-798e-450f-9efe-72bc0c3be491
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | name              | selfservice-net-share1               |
      | segmentation_id   | None                                 |
      | created_at        | 2016-03-31T13:25:39.052439           |
      | neutron_subnet_id | 005bf8d1-798e-450f-9efe-72bc0c3be491 |
      | updated_at        | None                                 |
      | network_type      | None                                 |
      | neutron_net_id    | 4e963f5b-b5f3-4db1-a935-0d34c8629e7b |
      | ip_version        | None                                 |
      | nova_net_id       | None                                 |
      | cidr              | None                                 |
      | project_id        | 3a46a53a377642a284e1d12efabb3b5a     |
      | id                | 997a1a0a-4f4d-4aa3-b7ae-8ae6d9aaa828 |
      | description       | None                                 |
      +-------------------+--------------------------------------+

Create a share
--------------

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ . demo-openrc

#. Create a NFS share using the share network:

   .. code-block:: console

      $ manila create NFS 1 --name share2 \
        --share-network selfservice-net-share1 \
        --share-type generic_share_type
      +-----------------------------+--------------------------------------+
      | Property                    | Value                                |
      +-----------------------------+--------------------------------------+
      | status                      | creating                             |
      | share_type_name             | generic_share_type                   |
      | description                 | None                                 |
      | availability_zone           | None                                 |
      | share_network_id            | 997a1a0a-4f4d-4aa3-b7ae-8ae6d9aaa828 |
      | host                        |                                      |
      | access_rules_status         | active                               |
      | snapshot_id                 | None                                 |
      | is_public                   | False                                |
      | task_state                  | None                                 |
      | snapshot_support            | True                                 |
      | id                          | 6a711b95-9e03-4547-8769-74e34676cb3e |
      | size                        | 1                                    |
      | name                        | share2                               |
      | share_type                  | 8698ed92-2a1c-4c9f-aab4-a35dccd88c8f |
      | has_replicas                | False                                |
      | replication_type            | None                                 |
      | created_at                  | 2016-03-31T13:45:18.000000           |
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
      | 5f8a0574-a95e-40ff-b898-09fd8d6a1fac | share2 | 1    | NFS         | available | False     | default_share_type | storage@generic#GENERIC     | nova              |
      +--------------------------------------+--------+------+-------------+-----------+-----------+--------------------+-----------------------------+-------------------+

#. Determine export IP address of the share:

   .. code-block:: console

      $ manila show share2
      +-----------------------------+------------------------------------------------------------------------------------+
      | Property                    | Value                                                                              |
      +-----------------------------+------------------------------------------------------------------------------------+
      | status                      | available                                                                          |
      | share_type_name             | generic_share_type                                                                 |
      | description                 | None                                                                               |
      | availability_zone           | nova                                                                               |
      | share_network_id            | None                                                                               |
      | export_locations            |                                                                                    |
      |                             | path = 10.254.0.6:/shares/share-0bfd69a1-27f0-4ef5-af17-7cd50bce6550               |
      |                             | id = 3c8d0ada-cadf-48dd-85b8-d4e8c3b1e204                                          |
      |                             | preferred = False                                                                  |
      | host                        | storage@generic#GENERIC                                                            |
      | access_rules_status         | active                                                                             |
      | snapshot_id                 | None                                                                               |
      | is_public                   | False                                                                              |
      | task_state                  | None                                                                               |
      | snapshot_support            | True                                                                               |
      | id                          | 5f8a0574-a95e-40ff-b898-09fd8d6a1fac                                               |
      | size                        | 1                                                                                  |
      | name                        | share2                                                                             |
      | share_type                  | 8a35da28-0f74-490d-afff-23664ecd4f01                                               |
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

      $ manila access-allow share2 ip INSTANCE_IP_ADDRESS
      +--------------+--------------------------------------+
      | Property     | Value                                |
      +--------------+--------------------------------------+
      | share_id     | 55c401b3-3112-4294-aa9f-3cc355a4e361 |
      | access_type  | ip                                   |
      | access_to    | 172.16.1.5                           |
      | access_level | rw                                   |
      | state        | new                                  |
      | id           | f88eab01-7197-44bf-ad0f-d6ca6f99fc96 |
      +--------------+--------------------------------------+

   Replace ``INSTANCE_IP_ADDRESS`` with the IP address of the instance.

   .. note::

      The instance must use the ``selfservice`` network.

Mount the share from an instance
--------------------------------

#. Create a folder where the mount will be placed:

   .. code-block:: console

      $ mkdir ~/test_folder

#. Mount the NFS share in the instance using the export location of the share:

   .. code-block:: console

      # mount -t nfs 10.254.0.6:/shares/share-0bfd69a1-27f0-4ef5-af17-7cd50bce6550 ~/test_folder

For more information about how to manage shares, see the
`OpenStack End User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

Return to :ref:`launch-instance`.
