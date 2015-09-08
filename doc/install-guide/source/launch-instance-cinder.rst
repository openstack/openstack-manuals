.. _launch-instance-cinder:

Block Storage
~~~~~~~~~~~~~

Create a volume
---------------

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ source demo-openrc.sh

#. Create a 1 GB volume:

   .. code-block:: console

      $ cinder create --display-name volume1 1
      +---------------------+--------------------------------------+
      |       Property      |                Value                 |
      +---------------------+--------------------------------------+
      |     attachments     |                  []                  |
      |  availability_zone  |                 nova                 |
      |       bootable      |                false                 |
      |      created_at     |      2015-09-22T13:36:19.457750      |
      | display_description |                 None                 |
      |     display_name    |               volume1                |
      |      encrypted      |                False                 |
      |          id         | 0a816b7c-e578-4290-bb74-c13b8b90d4e7 |
      |       metadata      |                  {}                  |
      |     multiattach     |                false                 |
      |         size        |                  1                   |
      |     snapshot_id     |                 None                 |
      |     source_volid    |                 None                 |
      |        status       |               creating               |
      |     volume_type     |                 None                 |
      +---------------------+--------------------------------------+

#. After a short time, the volume status should change from ``creating``
   to ``available``:

   .. code-block:: console

      $ cinder list
      +--------------------------------------+-----------+--------------+------+-------------+----------+-------------+
      |                  ID                  |   Status  | Display Name | Size | Volume Type | Bootable | Attached to |
      +--------------------------------------+-----------+--------------+------+-------------+----------+-------------+
      | 0a816b7c-e578-4290-bb74-c13b8b90d4e7 | available |   volume1    |  1   |      -      |  false   |             |
      +--------------------------------------+-----------+--------------+------+-------------+----------+-------------+

Attach the volume to an instance
--------------------------------

#. Attach a volume to an instance:

   .. code-block:: console

      $ nova volume-attach INSTANCE_NAME VOLUME_ID

   Replace ``INSTANCE_NAME`` with the name of the instance and ``VOLUME_ID``
   with the ID of the volume you want to attach to it.

   **Example**

   Attach the ``0a816b7c-e578-4290-bb74-c13b8b90d4e7`` volume to the
   ``public-instance`` instance:

   .. code-block:: console

      $ nova volume-attach public-instance1 0a816b7c-e578-4290-bb74-c13b8b90d4e7
      +----------+--------------------------------------+
      | Property | Value                                |
      +----------+--------------------------------------+
      | device   | /dev/vdb                             |
      | id       | 158bea89-07db-4ac2-8115-66c0d6a4bb48 |
      | serverId | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf |
      | volumeId | 0a816b7c-e578-4290-bb74-c13b8b90d4e7 |
      +----------+--------------------------------------+

#. List volumes:

   .. code-block:: console

      $ nova volume-list
      +--------------------------------------+-----------+--------------+------+-------------+--------------------------------------+
      | ID                                   | Status    | Display Name | Size | Volume Type | Attached to                          |
      +--------------------------------------+-----------+--------------+------+-------------+--------------------------------------+
      | 158bea89-07db-4ac2-8115-66c0d6a4bb48 | in-use    |              | 1    | -           | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf |
      +--------------------------------------+-----------+--------------+------+-------------+--------------------------------------+

#. Access your instance using SSH and use the ``fdisk`` command to verify
   presence of the volume as the ``/dev/vdb`` block storage device:

   .. code-block:: console

      $ sudo fdisk -l

      Disk /dev/vda: 1073 MB, 1073741824 bytes
      255 heads, 63 sectors/track, 130 cylinders, total 2097152 sectors
      Units = sectors of 1 * 512 = 512 bytes
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disk identifier: 0x00000000

         Device Boot      Start         End      Blocks   Id  System
     /dev/vda1   *       16065     2088449     1036192+  83  Linux

      Disk /dev/vdb: 1073 MB, 1073741824 bytes
      16 heads, 63 sectors/track, 2080 cylinders, total 2097152 sectors
      Units = sectors of 1 * 512 = 512 bytes
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disk identifier: 0x00000000

      Disk /dev/vdb doesn't contain a valid partition table

   .. note::

      You must create a partition table and file system to use the volume.

For more information about how to manage volumes, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

Return to :ref:`launch-instance`.
