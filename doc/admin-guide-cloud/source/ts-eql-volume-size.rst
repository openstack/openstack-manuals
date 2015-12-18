========================================================================
Addressing discrepancies in reported volume sizes for EqualLogic storage
========================================================================

Problem
~~~~~~~

There is a discrepancy between both the actual volume size in EqualLogic
(EQL) storage and the image size in the Image service, with what is
reported to OpenStack database. This could lead to confusion
if a user is creating volumes from an image that was uploaded from an EQL
volume (through the Image service). The image size is slightly larger
than the target volume size; this is because EQL size reporting accounts
for additional storage used by EQL for internal volume metadata.

To reproduce the issue follow the steps in the following procedure.

This procedure assumes that the EQL array is provisioned, and that
appropriate configuration settings have been included in
``/etc/cinder/cinder.conf`` to connect to the EQL array.

Create a new volume. Note the ID and size of the volume. In the
following example, the ID and size are
``74cf9c04-4543-47ae-a937-a9b7c6c921e7`` and ``1``, respectively:

.. code-block:: console

   $ cinder create --display-name volume1 1

   +-----------------------+-------------------------------------------+
   |   Property            |   Value                                   |
   +-----------------------+-------------------------------------------+
   |   attachments         |   []                                      |
   |   availability zone   |   nova                                    |
   |   bootable            |   false                                   |
   |   created_at          |   2014-03-21T18:31:54.248775              |
   |   display_description |   None                                    |
   |   display_name        |   volume1                                 |
   |   id                  |   74cf9c04-4543-47ae-a937-a9b7c6c921e7    |
   |   metadata            |   {}                                      |
   |   size                |   1                                       |
   |   snapshot_id         |   None                                    |
   |   source volid        |   None                                    |
   |   status              |   creating                                |
   |   volume type         |   None                                    |
   +-----------------------+-------------------------------------------+

Verify the volume size on the EQL array by using its command-line
interface.

The actual size (``VolReserve``) is 1.01 GB. The EQL Group Manager
should also report a volume size of 1.01 GB:

.. code-block:: console

   eql> volume select volume-74cf9c04-4543-47ae-a937-a9b7c6c921e7
   eql (volume_volume-74cf9c04-4543-47ae-a937-a9b7c6c921e7)> show
   _______________________________ Volume Information ________________________________
   Name: volume-74cf9c04-4543-47ae-a937-a9b7c6c921e7
   Size: 1GB
   VolReserve: 1.01GB
   VolReservelnUse: 0MB
   ReplReservelnUse: 0MB
   iSCSI Alias: volume-74cf9c04-4543-47ae-a937-a9b7c6c921e7
   iSCSI Name: iqn.2001-05.com.equallogic:0-8a0906-19f91850c-067000000b4532cl-volume-74cf9c04-4543-47ae-a937-a9b7c6c921e7
   ActualMembers: 1
   Snap-Warn: 10%
   Snap-Depletion: delete-oldest
   Description:
   Snap-Reserve: 100%
   Snap-Reserve-Avail: 100% (1.01GB)
   Permission: read-write
   DesiredStatus: online
   Status: online
   Connections: O
   Snapshots: O
   Bind:
   Type: not-replicated
   ReplicationReserveSpace: 0MB

Create a new image from this volume:

.. code-block:: console

   $ cinder upload-to-image --disk-format raw \
     --container-format bare volume1 image_from_volume1

   +---------------------+---------------------------------------+
   |       Property      |                 Value                 |
   +---------------------+---------------------------------------+
   |   container_format  |                  bare                 |
   |     disk_format     |                  raw                  |
   | display_description |                  None                 |
   |          id         | 74cf9c04-4543-47ae-a937-a9b7c6c921e7  |
   |       image_id      | 3020a21d-ba37-4495-8899-07fc201161b9  |
   |      image_name     |          image_from_volume1           |
   |         size        |                  1                    |
   |        status       |              uploading                |
   |      updated_at     |      2014-03-21T18:31:55.000000       |
   |     volume_type     |                 None                  |
   +---------------------+---------------------------------------+

When you uploaded the volume in the previous step, the Image service
reported the volume's size as ``1`` (GB). However, when using
:command:`glance image-list` to list the image, the displayed size is
1085276160 bytes, or roughly 1.01 GB:

+-----------------------+---------+-----------+--------------+--------------+
| Name                  | Disk    | Container | Size         | Status       |
|                       | Format  | Format    |              |              |
+=======================+=========+===========+==============+==============+
| image\_from\_volume1  | raw     | bare      | *1085276160* | active       |
+-----------------------+---------+-----------+--------------+--------------+



Create a new volume using the previous image (``image_id 3020a21d-ba37-4495
-8899-07fc201161b9`` in this example) as
the source. Set the target volume size to 1 GB; this is the size
reported by the ``cinder`` tool when you uploaded the volume to the
Image service:

.. code-block:: console

   $ cinder create --display-name volume2 \
     --image-id 3020a21d-ba37-4495-8899-07fc201161b9 1
   ERROR: Invalid input received: Size of specified image 2 is larger
   than volume size 1. (HTTP 400) (Request-ID: req-4b9369c0-dec5-4e16-a114-c0cdl6bSd210)

The attempt to create a new volume based on the size reported by the
``cinder`` tool will then fail.

Solution
~~~~~~~~

To work around this problem, increase the target size of the new image
to the next whole number. In the problem example, you created a 1 GB
volume to be used as volume-backed image, so a new volume using this
volume-backed image should use a size of 2 GB:

.. code-block:: console

   $ cinder create --display-name volume2 \
     --image-id 3020a21d-ba37-4495-8899-07fc201161b9 1

   +---------------------+--------------------------------------+
   |       Property      |                Value                 |
   +---------------------+--------------------------------------+
   |     attachments     |                  []                  |
   |  availability_zone  |                 nova                 |
   |      bootable       |                false                 |
   |     created_at      |      2014-03-21T19:25:31.564482      |
   | display_description |               None                   |
   |    display_name     |             volume2                  |
   |         id          | 64e8eb18-d23f-437b-bcac-b3S2afa6843a |
   |      image_id       | 3020a21d-ba37-4495-8899-07fc20116lb9 |
   |      metadata       |                  []                  |
   |        size         |                  2                   |
   |    snapshot_id      |                 None                 |
   |    source_volid     |                 None                 |
   |       status        |               creating               |
   |    volume_type      |                 None                 |
   +---------------------+--------------------------------------+

.. note::

   The dashboard suggests a suitable size when you create a new volume
   based on a volume-backed image.

You can then check this new volume into the EQL array:

.. code-block:: console

   eql> volume select volume-64e8eb18-d23f-437b-bcac-b352afa6843a
   eql (volume_volume-61e8eb18-d23f-437b-bcac-b352afa6843a)> show
   ______________________________ Volume Information _______________________________
   Name: volume-64e8eb18-d23f-437b-bcac-b352afa6843a
   Size: 2GB
   VolReserve: 2.01GB
   VolReserveInUse: 1.01GB
   ReplReserveInUse: 0MB
   iSCSI Alias: volume-64e8eb18-d23f-437b-bcac-b352afa6843a
   iSCSI Name: iqn.2001-05.com.equallogic:0-8a0906-e3091850e-eae000000b7S32cl-volume-64e8eb18-d23f-437b-bcac-b3S2afa6Bl3a
   ActualMembers: 1
   Snap-Warn: 10%
   Snap-Depletion: delete-oldest
   Description:
   Snap-Reserve: 100%
   Snap-Reserve-Avail: 100% (2GB)
   Permission: read-write
   DesiredStatus: online
   Status: online
   Connections: 1
   Snapshots: O
   Bind:
   Type: not-replicated
   ReplicationReserveSpace: 0MB
