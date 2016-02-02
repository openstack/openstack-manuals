.. _launch-instance-manila:

Shared File Systems
~~~~~~~~~~~~~~~~~~~

Before being able to create a share, the manila with the generic driver and
the DHSS mode enabled requires the definition of at least an image,
a network and a share-network for being used to create a share server.
For that back end configuration, the share server is an instance where
NFS/CIFS shares are served.

.. note::

   This configuration automatically creates a cinder volume for every share.
   The cinder volumes are attached to share servers according to the
   definition of a share network.

Determine the configuration of the share server
-----------------------------------------------

#. Source the admin credentials to gain access to admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create a default share type before running manila-share service:

   .. code-block:: console

      $ manila type-create default_share_type True
      +--------------------------------------+--------------------+------------+------------+-------------------------------------+-------------------------+$
      | ID                                   | Name               | Visibility | is_default | required_extra_specs                | optional_extra_specs    |$
      +--------------------------------------+--------------------+------------+------------+-------------------------------------+-------------------------+$
      | 8a35da28-0f74-490d-afff-23664ecd4f01 | default_share_type | public     | -          | driver_handles_share_servers : True | snapshot_support : True |$
      +--------------------------------------+--------------------+------------+------------+-------------------------------------+-------------------------+$

#. Create a manila share server image to the Image service:

   .. code-block:: console

      $ glance image-create \
      --copy-from http://tarballs.openstack.org/manila-image-elements/images/manila-service-image-master.qcow2 \
      --name "manila-service-image" \
      --disk-format qcow2 \
      --container-format bare \
      --visibility public --progress
      [=============================>] 100%
      +------------------+--------------------------------------+
      | Property         | Value                                |
      +------------------+--------------------------------------+
      | checksum         | 48a08e746cf0986e2bc32040a9183445     |
      | container_format | bare                                 |
      | created_at       | 2016-01-26T19:52:24Z                 |
      | disk_format      | qcow2                                |
      | id               | 1fc7f29e-8fe6-44ef-9c3c-15217e83997c |
      | min_disk         | 0                                    |
      | min_ram          | 0                                    |
      | name             | manila-service-image                 |
      | owner            | e2c965830ecc4162a002bf16ddc91ab7     |
      | protected        | False                                |
      | size             | 306577408                            |
      | status           | active                               |
      | tags             | []                                   |
      | updated_at       | 2016-01-26T19:52:28Z                 |
      | virtual_size     | None                                 |
      | visibility       | public                               |
      +------------------+--------------------------------------+

#. List available networks in order to get id and subnets of the private
   network:

   .. code-block:: console

      $ neutron net-list
      +--------------------------------------+---------+----------------------------------------------------+
      | id                                   | name    | subnets                                            |
      +--------------------------------------+---------+----------------------------------------------------+
      | 0e62efcd-8cee-46c7-b163-d8df05c3c5ad | public  | 5cc70da8-4ee7-4565-be53-b9c011fca011 10.3.31.0/24  |
      | 7c6f9b37-76b4-463e-98d8-27e5686ed083 | private | 3482f524-8bff-4871-80d4-5774c2730728 172.16.1.0/24 |
      +--------------------------------------+---------+----------------------------------------------------+

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ source demo-openrc.sh

   .. code-block:: console

      $ manila share-network-create --name demo-share-network1 \
      --neutron-net-id PRIVATE_NETWORK_ID \
      --neutron-subnet-id PRIVATE_NETWORK_SUBNET_ID
      +-------------------+--------------------------------------+
      | Property          | Value                                |
      +-------------------+--------------------------------------+
      | name              | demo-share-network1                  |
      | segmentation_id   | None                                 |
      | created_at        | 2016-01-26T20:03:41.877838           |
      | neutron_subnet_id | 3482f524-8bff-4871-80d4-5774c2730728 |
      | updated_at        | None                                 |
      | network_type      | None                                 |
      | neutron_net_id    | 7c6f9b37-76b4-463e-98d8-27e5686ed083 |
      | ip_version        | None                                 |
      | nova_net_id       | None                                 |
      | cidr              | None                                 |
      | project_id        | e2c965830ecc4162a002bf16ddc91ab7     |
      | id                | 58b2f0e6-5509-4830-af9c-97f525a31b14 |
      | description       | None                                 |
      +-------------------+--------------------------------------+

Create a share
--------------

#. Create a NFS share using the share network:

   .. code-block:: console

      $ manila create NFS 1 --name demo-share1 --share-network demo-share-network1
      +-----------------------------+--------------------------------------+
      | Property                    | Value                                |
      +-----------------------------+--------------------------------------+
      | status                      | None                                 |
      | share_type_name             | None                                 |
      | description                 | None                                 |
      | availability_zone           | None                                 |
      | share_network_id            | None                                 |
      | export_locations            | []                                   |
      | host                        | None                                 |
      | snapshot_id                 | None                                 |
      | is_public                   | False                                |
      | task_state                  | None                                 |
      | snapshot_support            | True                                 |
      | id                          | 016ca18f-bdd5-48e1-88c0-782e4c1aa28c |
      | size                        | 1                                    |
      | name                        | demo-share1                          |
      | share_type                  | None                                 |
      | created_at                  | 2016-01-26T20:08:50.502877           |
      | export_location             | None                                 |
      | share_proto                 | NFS                                  |
      | consistency_group_id        | None                                 |
      | source_cgsnapshot_member_id | None                                 |
      | project_id                  | 48e8c35b2ac6495d86d4be61658975e7     |
      | metadata                    | {}                                   |
      +-----------------------------+--------------------------------------+

#. After some time, the share status should change from ``creating``
   to ``available``:

   .. code-block:: console

      $ manila list
      +--------------------------------------+-------------+------+-------------+-----------+-----------+--------------------------------------+---------------------------------------------------------------+-----------------------------+-------------------+
      | ID                                   | Name        | Size | Share Proto | Status    | Is Public | Share Type                           | Export location                                               | Host                        | Availability Zone |
      +--------------------------------------+-------------+------+-------------+-----------+-----------+--------------------------------------+---------------------------------------------------------------+-----------------------------+-------------------+
      | 5f8a0574-a95e-40ff-b898-09fd8d6a1fac | demo-share1 | 1    | NFS         | available | False     | 8a35da28-0f74-490d-afff-23664ecd4f01 | 10.254.0.6:/shares/share-0bfd69a1-27f0-4ef5-af17-7cd50bce6550 | storagenode@generic#GENERIC | nova              |
      +--------------------------------------+-------------+------+-------------+-----------+-----------+--------------------------------------+---------------------------------------------------------------+-----------------------------+-------------------+

#. Configure user access to the new share before attempting to mount it via
   the network:

   .. important ::

      The image used for launching an instance and mounting a share must have
      the NFS packages provided by the distro. Example: The cirros image
      created at the image service section is not enough.

   .. important ::

      Use an instance that is connected to the private network used to create
      the share-network.

   .. code-block:: console

      $ manila access-allow demo-share1 ip INSTANCE_PRIVATE_NETWORK_IP

Mount the share from an instance
--------------------------------

#. Create a folder where the mount will be placed:

   .. code-block:: console

      $ mkdir ~/test_folder

#. Mount the NFS share in the instance using the export location of the share:

   .. code-block:: console

      $ mount -v 10.254.0.6:/shares/share-0bfd69a1-27f0-4ef5-af17-7cd50bce6550 ~/test_folder


For more information about how to manage shares, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

Return to :ref:`launch-instance`.
