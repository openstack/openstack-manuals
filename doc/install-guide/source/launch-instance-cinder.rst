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
      +---------------------------------------+--------------------------------------+
      |                Property               |                Value                 |
      +---------------------------------------+--------------------------------------+
      |              attachments              |                  []                  |
      |           availability_zone           |                 nova                 |
      |                bootable               |                false                 |
      |          consistencygroup_id          |                 None                 |
      |               created_at              |      2015-10-12T16:02:29.000000      |
      |              description              |                 None                 |
      |               encrypted               |                False                 |
      |                   id                  | 09e3743e-192a-4ada-b8ee-d35352fa65c4 |
      |                metadata               |                  {}                  |
      |              multiattach              |                False                 |
      |                  name                 |               volume1                |
      |      os-vol-tenant-attr:tenant_id     |   ed0b60bf607743088218b0a533d5943f   |
      |   os-volume-replication:driver_data   |                 None                 |
      | os-volume-replication:extended_status |                 None                 |
      |           replication_status          |               disabled               |
      |                  size                 |                  1                   |
      |              snapshot_id              |                 None                 |
      |              source_volid             |                 None                 |
      |                 status                |               creating               |
      |                user_id                |   58126687cbcc4888bfa9ab73a2256f27   |
      |              volume_type              |                 None                 |
      +---------------------------------------+--------------------------------------+

#. After a short time, the volume status should change from ``creating``
   to ``available``:

   .. code-block:: console

      $ cinder list
      +--------------------------------------+-----------+---------+------+-------------+----------+-------------+-------------+
      |                  ID                  |   Status  |   Name  | Size | Volume Type | Bootable | Multiattach | Attached to |
      +--------------------------------------+-----------+---------+------+-------------+----------+-------------+-------------+
      | 09e3743e-192a-4ada-b8ee-d35352fa65c4 | available | volume1 |  1   |      -      |  false   |    False    |             |
      +--------------------------------------+-----------+---------+------+-------------+----------+-------------+-------------+

Attach the volume to an instance
--------------------------------

#. Attach a volume to an instance:

   .. code-block:: console

      $ nova volume-attach INSTANCE_NAME VOLUME_ID

   Replace ``INSTANCE_NAME`` with the name of the instance and ``VOLUME_ID``
   with the ID of the volume you want to attach to it.

   **Example**

   Attach the ``09e3743e-192a-4ada-b8ee-d35352fa65c4`` volume to the
   ``public-instance`` instance:

   .. code-block:: console

      $ nova volume-attach public-instance 09e3743e-192a-4ada-b8ee-d35352fa65c4
      +----------+--------------------------------------+
      | Property | Value                                |
      +----------+--------------------------------------+
      | device   | /dev/vdb                             |
      | id       | 158bea89-07db-4ac2-8115-66c0d6a4bb48 |
      | serverId | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf |
      | volumeId | 09e3743e-192a-4ada-b8ee-d35352fa65c4 |
      +----------+--------------------------------------+

#. List volumes:

   .. code-block:: console

      $ nova volume-list
      +--------------------------------------+-----------+--------------+------+-------------+--------------------------------------+
      | ID                                   | Status    | Display Name | Size | Volume Type | Attached to                          |
      +--------------------------------------+-----------+--------------+------+-------------+--------------------------------------+
      | 09e3743e-192a-4ada-b8ee-d35352fa65c4 | in-use    |              | 1    | -           | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf |
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

      You must create a file system on the device and mount it
      to use the volume.

For more information about how to manage volumes, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

Return to :ref:`launch-instance`.
