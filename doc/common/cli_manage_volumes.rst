.. _volume:

==============
Manage volumes
==============

A volume is a detachable block storage device, similar to a USB hard
drive. You can attach a volume to only one instance. To create and
manage volumes, you use a combination of ``nova`` and ``cinder`` client
commands.

Migrate a volume
~~~~~~~~~~~~~~~~

As an administrator, you can migrate a volume with its data from one
location to another in a manner that is transparent to users and
workloads. You can migrate only detached volumes with no snapshots.

Possible use cases for data migration include:

*  Bring down a physical storage device for maintenance without
   disrupting workloads.

*  Modify the properties of a volume.

*  Free up space in a thinly-provisioned back end.

Migrate a volume with the :command:`cinder migrate` command, as shown in the
following example:

.. code-block:: console

   $ cinder migrate volumeID destinationHost --force-host-copy True|False

In this example, :option:`--force-host-copy True` forces the generic
host-based migration mechanism and bypasses any driver optimizations.

.. note::

   If the volume has snapshots, the specified host destination cannot accept
   the volume. If the user is not an administrator, the migration fails.

Create a volume
~~~~~~~~~~~~~~~

This example creates a ``my-new-volume`` volume based on an image.

#. List images, and note the ID of the image that you want to use for your
   volume:

   .. code-block:: console

      $ nova image-list
      +-----------------------+---------------------------------+--------+--------------------------+
      | ID                    | Name                            | Status | Server                   |
      +-----------------------+---------------------------------+--------+--------------------------+
      | 397e713c-b95b-4186... | cirros-0.3.2-x86_64-uec         | ACTIVE |                          |
      | df430cc2-3406-4061... | cirros-0.3.2-x86_64-uec-kernel  | ACTIVE |                          |
      | 3cf852bd-2332-48f4... | cirros-0.3.2-x86_64-uec-ramdisk | ACTIVE |                          |
      | 7e5142af-1253-4634... | myCirrosImage                   | ACTIVE | 84c6e57d-a6b1-44b6-81... |
      | 89bcd424-9d15-4723... | mysnapshot                      | ACTIVE | f51ebd07-c33d-4951-87... |
      +-----------------------+---------------------------------+--------+--------------------------+

#. List the availability zones, and note the ID of the availability zone in
   which you want to create your volume:

   .. code-block:: console

      $ cinder availability-zone-list
      +------+-----------+
      | Name |   Status  |
      +------+-----------+
      | nova | available |
      +------+-----------+

#. Create a volume with 8 gibibytes (GiB) of space, and specify the
   availability zone and image:

   .. code-block:: console

      $ cinder create 8 --display-name my-new-volume \
        --image-id 397e713c-b95b-4186-ad46-6126863ea0a9 \
        --availability-zone nova
      +---------------------+--------------------------------------+
      |       Property      |                Value                 |
      +---------------------+--------------------------------------+
      |     attachments     |                  []                  |
      |  availability_zone  |                 nova                 |
      |       bootable      |                false                 |
      |      created_at     |      2013-07-25T17:02:12.472269      |
      | display_description |                 None                 |
      |     display_name    |            my-new-volume             |
      |          id         | 573e024d-5235-49ce-8332-be1576d323f8 |
      |       image_id      | 397e713c-b95b-4186-ad46-6126863ea0a9 |
      |       metadata      |                  {}                  |
      |         size        |                  8                   |
      |     snapshot_id     |                 None                 |
      |     source_volid    |                 None                 |
      |        status       |               creating               |
      |     volume_type     |                 None                 |
      +---------------------+--------------------------------------+

#. To verify that your volume was created successfully, list the available
   volumes:

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      |    ID           |   Status  |   Display Name  | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      | 573e024d-523... | available |  my-new-volume  |  8   |     None    |   true   |             |
      | bd7cf584-45d... | available | my-bootable-vol |  8   |     None    |   true   |             |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+

   If your volume was created successfully, its status is ``available``. If
   its status is ``error``, you might have exceeded your quota.

.. _Create_a_volume_from_specified_volume_type:

Create a volume from specified volume type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cinder supports these three ways to specify ``volume type`` during
volume creation.

#. volume_type
#. cinder_img_volume_type (via glance image metadata)
#. default_volume_type (via cinder.conf)

.. _volume_type:

volume_type
-----------

User can specify `volume type` when creating a volume.

.. code-block:: console

      $ cinder create --name <volume name> --volume-type <volume type> <size>

.. _cinder_img_volume_type:

cinder_img_volume_type
----------------------

If glance image has ``cinder_img_volume_type`` property, Cinder uses this
parameter to specify ``volume type`` when creating a volume.

Choose glance image which has "cinder_img_volume_type" property and create
a volume from the image.

.. code-block:: console

      $ glance image-list
      +--------------------------------------+---------------------------------+
      | ID                                   | Name                            |
      +--------------------------------------+---------------------------------+
      | a8701119-ca8d-4957-846c-9f4d27f251fa | cirros-0.3.4-x86_64-uec         |
      | 6cf01154-0408-416a-b69c-b28b48c5d28a | cirros-0.3.4-x86_64-uec-kernel  |
      | de457c7c-2038-435d-abed-5dfa6430e66e | cirros-0.3.4-x86_64-uec-ramdisk |
      +--------------------------------------+---------------------------------+

      $ glance image-show a8701119-ca8d-4957-846c-9f4d27f251fa
      +------------------------+--------------------------------------+
      | Property               | Value                                |
      +------------------------+--------------------------------------+
      | checksum               | eb9139e4942121f22bbc2afc0400b2a4     |
      | cinder_img_volume_type | lvmdriver-1                          |
      | container_format       | ami                                  |
      | created_at             | 2016-02-07T19:39:13Z                 |
      | disk_format            | ami                                  |
      | id                     | a8701119-ca8d-4957-846c-9f4d27f251fa |
      | kernel_id              | 6cf01154-0408-416a-b69c-b28b48c5d28a |
      | min_disk               | 0                                    |
      | min_ram                | 0                                    |
      | name                   | cirros-0.3.4-x86_64-uec              |
      | owner                  | 4c0dbc92040c41b1bdb3827653682952     |
      | protected              | False                                |
      | ramdisk_id             | de457c7c-2038-435d-abed-5dfa6430e66e |
      | size                   | 25165824                             |
      | status                 | active                               |
      | tags                   | []                                   |
      | updated_at             | 2016-02-22T23:01:54Z                 |
      | virtual_size           | None                                 |
      | visibility             | public                               |
      +------------------------+--------------------------------------+

      $ cinder create --name test --image-id a8701119-ca8d-4957-846c-9f4d27f251fa 1
      +---------------------------------------+--------------------------------------+
      |                Property               |                Value                 |
      +---------------------------------------+--------------------------------------+
      |              attachments              |                  []                  |
      |           availability_zone           |                 nova                 |
      |                bootable               |                false                 |
      |          consistencygroup_id          |                 None                 |
      |               created_at              |      2016-02-22T23:17:51.000000      |
      |              description              |                 None                 |
      |               encrypted               |                False                 |
      |                   id                  | 123ad92f-8f4c-4639-ab10-3742a1d9b47c |
      |                metadata               |                  {}                  |
      |            migration_status           |                 None                 |
      |              multiattach              |                False                 |
      |                  name                 |                 test                 |
      |         os-vol-host-attr:host         |                 None                 |
      |     os-vol-mig-status-attr:migstat    |                 None                 |
      |     os-vol-mig-status-attr:name_id    |                 None                 |
      |      os-vol-tenant-attr:tenant_id     |   4c0dbc92040c41b1bdb3827653682952   |
      |   os-volume-replication:driver_data   |                 None                 |
      | os-volume-replication:extended_status |                 None                 |
      |           replication_status          |               disabled               |
      |                  size                 |                  1                   |
      |              snapshot_id              |                 None                 |
      |              source_volid             |                 None                 |
      |                 status                |               creating               |
      |               updated_at              |                 None                 |
      |                user_id                |   9a125f3d111e47e6a25f573853b32fd9   |
      |              volume_type              |             lvmdriver-1              |
      +---------------------------------------+--------------------------------------+

.. _default_volume_type:

default_volume_type
-------------------

If above parameters are not set, Cinder uses default_volume_type which is
defined in cinder.conf during volume creation.

Example cinder.conf file configuration.

.. code-block:: console

   [default]
   default_volume_type = lvmdriver-1

.. _Attach_a_volume_to_an_instance:

Attach a volume to an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Attach your volume to a server, specifying the server ID and the volume
   ID:

   .. code-block:: console

      $ nova volume-attach 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 \
        573e024d-5235-49ce-8332-be1576d323f8 /dev/vdb
      +----------+--------------------------------------+
      | Property | Value                                |
      +----------+--------------------------------------+
      | device   | /dev/vdb                             |
      | serverId | 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 |
      | id       | 573e024d-5235-49ce-8332-be1576d323f8 |
      | volumeId | 573e024d-5235-49ce-8332-be1576d323f8 |
      +----------+--------------------------------------+

   Note the ID of your volume.

#. Show information for your volume:

   .. code-block:: console

      $ cinder show 573e024d-5235-49ce-8332-be1576d323f8

   The output shows that the volume is attached to the server with ID
   ``84c6e57d-a6b1-44b6-81eb-fcb36afd31b5``, is in the nova availability
   zone, and is bootable.

   .. code-block:: console

      +------------------------------+------------------------------------------+
      |           Property           |                Value                     |
      +------------------------------+------------------------------------------+
      |         attachments          |         [{u'device': u'/dev/vdb',        |
      |                              |        u'server_id': u'84c6e57d-a        |
      |                              |           u'id': u'573e024d-...          |
      |                              |        u'volume_id': u'573e024d...       |
      |      availability_zone       |                  nova                    |
      |           bootable           |                  true                    |
      |          created_at          |       2013-07-25T17:02:12.000000         |
      |     display_description      |                  None                    |
      |         display_name         |             my-new-volume                |
      |              id              |   573e024d-5235-49ce-8332-be1576d323f8   |
      |           metadata           |                   {}                     |
      |    os-vol-host-attr:host     |                devstack                  |
      | os-vol-tenant-attr:tenant_id |     66265572db174a7aa66eba661f58eb9e     |
      |             size             |                   8                      |
      |         snapshot_id          |                  None                    |
      |         source_volid         |                  None                    |
      |            status            |                 in-use                   |
      |    volume_image_metadata     |       {u'kernel_id': u'df430cc2...,      |
      |                              |        u'image_id': u'397e713c...,       |
      |                              |        u'ramdisk_id': u'3cf852bd...,     |
      |                              |u'image_name': u'cirros-0.3.2-x86_64-uec'}|
      |         volume_type          |                  None                    |
      +------------------------------+------------------------------------------+

.. _Resize_a_volume:

Resize a volume
~~~~~~~~~~~~~~~

#. To resize your volume, you must first detach it from the server.
   To detach the volume from your server, pass the server ID and volume ID
   to the following command:

   .. code-block:: console

      $ nova volume-detach 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5   573e024d-5235-49ce-8332-be1576d323f8

   The :command:`volume-detach` command does not return any output.

#. List volumes:

   .. code-block:: console

      $ cinder list
      +----------------+-----------+-----------------+------+-------------+----------+-------------+
      |       ID       |   Status  |   Display Name  | Size | Volume Type | Bootable | Attached to |
      +----------------+-----------+-----------------+------+-------------+----------+-------------+
      | 573e024d-52... | available |  my-new-volume  |  8   |     None    |   true   |             |
      | bd7cf584-45... | available | my-bootable-vol |  8   |     None    |   true   |             |
      +----------------+-----------+-----------------+------+-------------+----------+-------------+

   Note that the volume is now available.

#. Resize the volume by passing the volume ID and the new size (a value
   greater than the old one) as parameters:

   .. code-block:: console

      $ cinder extend 573e024d-5235-49ce-8332-be1576d323f8 10

   The :command:`extend` command does not return any output.

Delete a volume
~~~~~~~~~~~~~~~

#. To delete your volume, you must first detach it from the server.
   To detach the volume from your server and check for the list of existing
   volumes, see steps 1 and 2 in Resize_a_volume_.

   Delete the volume using either the volume name or ID:

   .. code-block:: console

      $ cinder delete my-new-volume

   The :command:`delete` command does not return any output.

#. List the volumes again, and note that the status of your volume is
   ``deleting``:

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      |        ID       |   Status  |   Display Name  | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      | 573e024d-523... |  deleting |  my-new-volume  |  8   |     None    |   true   |             |
      | bd7cf584-45d... | available | my-bootable-vol |  8   |     None    |   true   |             |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+

   When the volume is fully deleted, it disappears from the list of
   volumes:

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      |       ID        |   Status  |   Display Name  | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+
      | bd7cf584-45d... | available | my-bootable-vol |  8   |     None    |   true   |             |
      +-----------------+-----------+-----------------+------+-------------+----------+-------------+

Transfer a volume
~~~~~~~~~~~~~~~~~

You can transfer a volume from one owner to another by using the
:command:`cinder transfer*` commands. The volume donor, or original owner,
creates a transfer request and sends the created transfer ID and
authorization key to the volume recipient. The volume recipient, or new
owner, accepts the transfer by using the ID and key.

.. note::

   The procedure for volume transfer is intended for tenants (both the
   volume donor and recipient) within the same cloud.

Use cases include:

*  Create a custom bootable volume or a volume with a large data set and
   transfer it to a customer.

*  For bulk import of data to the cloud, the data ingress system creates
   a new Block Storage volume, copies data from the physical device, and
   transfers device ownership to the end user.

Create a volume transfer request
--------------------------------

#. While logged in as the volume donor, list the available volumes:

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      |        ID       |   Status  | Display Name | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      | 72bfce9f-cac... |   error   |     None     |  1   |     None    |  false   |             |
      | a1cdace0-08e... | available |     None     |  1   |     None    |  false   |             |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+

#. As the volume donor, request a volume transfer authorization code for a
   specific volume:

   .. code-block:: console

      $ cinder transfer-create volumeID

   The volume must be in an ``available`` state or the request will be
   denied. If the transfer request is valid in the database (that is, it
   has not expired or been deleted), the volume is placed in an
   ``awaiting transfer`` state. For example:

   .. code-block:: console

      $ cinder transfer-create a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f

   The output shows the volume transfer ID in the ``id`` row and the
   authorization key.

   .. code-block:: console

      +------------+--------------------------------------+
      |  Property  |                Value                 |
      +------------+--------------------------------------+
      |  auth_key  |           b2c8e585cbc68a80           |
      | created_at |      2013-10-14T15:20:10.121458      |
      |     id     | 6e4e9aa4-bed5-4f94-8f76-df43232f44dc |
      |    name    |                 None                 |
      | volume_id  | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f |
      +------------+--------------------------------------+

   .. note::

      Optionally, you can specify a name for the transfer by using the
      ``--display-name displayName`` parameter.

   .. note::

      While the ``auth_key`` property is visible in the output of
      ``cinder transfer-create VOLUME_ID``, it will not be available in
      subsequent ``cinder transfer-show TRANSFER_ID`` commands.

#. Send the volume transfer ID and authorization key to the new owner (for
   example, by email).

#. View pending transfers:

   .. code-block:: console

      $ cinder transfer-list
      +--------------------------------------+--------------------------------------+------+
      |               ID                     |             VolumeID                 | Name |
      +--------------------------------------+--------------------------------------+------+
      | 6e4e9aa4-bed5-4f94-8f76-df43232f44dc | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f | None |
      +--------------------------------------+--------------------------------------+------+

#. After the volume recipient, or new owner, accepts the transfer, you can
   see that the transfer is no longer available:

   .. code-block:: console

      $ cinder transfer-list
      +----+-----------+------+
      | ID | Volume ID | Name |
      +----+-----------+------+
      +----+-----------+------+

Accept a volume transfer request
--------------------------------

#. As the volume recipient, you must first obtain the transfer ID and
   authorization key from the original owner.

#. Accept the request:

   .. code-block:: console

      $ cinder transfer-accept transferID authKey

   For example:

   .. code-block:: console

      $ cinder transfer-accept 6e4e9aa4-bed5-4f94-8f76-df43232f44dc   b2c8e585cbc68a80
      +-----------+--------------------------------------+
      |  Property |                Value                 |
      +-----------+--------------------------------------+
      |     id    | 6e4e9aa4-bed5-4f94-8f76-df43232f44dc |
      |    name   |                 None                 |
      | volume_id | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f |
      +-----------+--------------------------------------+

   .. note::

      If you do not have a sufficient quota for the transfer, the transfer
      is refused.

Delete a volume transfer
------------------------

#. List available volumes and their statuses:

   .. code-block:: console

      $ cinder list
      +-------------+-----------------+--------------+------+-------------+----------+-------------+
      |     ID      |      Status     | Display Name | Size | Volume Type | Bootable | Attached to |
      +-------------+-----------------+--------------+------+-------------+----------+-------------+
      | 72bfce9f... |      error      |     None     |  1   |     None    |  false   |             |
      | a1cdace0... |awaiting-transfer|     None     |  1   |     None    |  false   |             |
      +-------------+-----------------+--------------+------+-------------+----------+-------------+

#. Find the matching transfer ID:

   .. code-block:: console

      $ cinder transfer-list
      +--------------------------------------+--------------------------------------+------+
      |               ID                     |             VolumeID                 | Name |
      +--------------------------------------+--------------------------------------+------+
      | a6da6888-7cdf-4291-9c08-8c1f22426b8a | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f | None |
      +--------------------------------------+--------------------------------------+------+

#. Delete the volume:

   .. code-block:: console

      $ cinder transfer-delete transferID

   For example:

   .. code-block:: console

      $ cinder transfer-delete a6da6888-7cdf-4291-9c08-8c1f22426b8a

#. Verify that transfer list is now empty and that the volume is again
   available for transfer:

   .. code-block:: console

      $ cinder transfer-list
      +----+-----------+------+
      | ID | Volume ID | Name |
      +----+-----------+------+
      +----+-----------+------+

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      |       ID        |   Status  | Display Name | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      | 72bfce9f-ca...  |   error   |     None     |  1   |     None    |  false   |             |
      | a1cdace0-08...  | available |     None     |  1   |     None    |  false   |             |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+

Manage and unmanage a snapshot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A snapshot is a point in time version of a volume. As an administrator,
you can manage and unmanage snapshots.

Manage a snapshot
-----------------

Manage a snapshot with the :command:`cinder snapshot-manage` command:

.. code-block:: console

   $ cinder snapshot-manage VOLUME_ID IDENTIFIER --id-type ID-TYPE \
     --name NAME --description DESCRIPTION --metadata METADATA

The arguments to be passed are:

``VOLUME_ID``
 The ID of a volume that is the parent of the snapshot, and managed by the
 Block Storage service.

``IDENTIFIER``
 Name, ID, or other identifier for an existing snapshot.

:option:`--id-type`
 Type of back-end device the identifier provided. Is typically ``source-name``
 or ``source-id``. Defaults to ``source-name``.

:option:`--name`
 Name of the snapshot. Defaults to ``None``.

:option:`--description`
 Description of the snapshot. Defaults to ``None``.

:option:`--metadata`
 Metadata key-value pairs. Defaults to ``None``.

The following example manages the ``my-snapshot-id`` snapshot with the
``my-volume-id`` parent volume:

.. code-block:: console

   $ cinder snapshot-manage my-volume-id my-snapshot-id

Unmanage a snapshot
-------------------

Unmanage a snapshot with the :command:`cinder snapshot-unmanage` command:

.. code-block:: console

   $ cinder snapshot-umanage SNAPSHOT

The arguments to be passed are:

SNAPSHOT
 Name or ID of the snapshot to unmanage.

The following example unmanages the ``my-snapshot-id`` image:

.. code-block:: console

   $ cinder snapshot-unmanage my-snapshot-id
