.. _launch-instance-cinder:

Block Storage
~~~~~~~~~~~~~

Create a volume
---------------

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ . demo-openrc

   .. end

#. Create a 1 GB volume:

   .. code-block:: console

      $ openstack volume create --size 1 volume1

      +---------------------+--------------------------------------+
      | Field               | Value                                |
      +---------------------+--------------------------------------+
      | attachments         | []                                   |
      | availability_zone   | nova                                 |
      | bootable            | false                                |
      | consistencygroup_id | None                                 |
      | created_at          | 2016-03-08T14:30:48.391027           |
      | description         | None                                 |
      | encrypted           | False                                |
      | id                  | a1e8be72-a395-4a6f-8e07-856a57c39524 |
      | multiattach         | False                                |
      | name                | volume1                              |
      | properties          |                                      |
      | replication_status  | disabled                             |
      | size                | 1                                    |
      | snapshot_id         | None                                 |
      | source_volid        | None                                 |
      | status              | creating                             |
      | type                | None                                 |
      | updated_at          | None                                 |
      | user_id             | 684286a9079845359882afc3aa5011fb     |
      +---------------------+--------------------------------------+

   .. end

#. After a short time, the volume status should change from ``creating``
   to ``available``:

   .. code-block:: console

      $ openstack volume list

      +--------------------------------------+--------------+-----------+------+-------------+
      | ID                                   | Display Name | Status    | Size | Attached to |
      +--------------------------------------+--------------+-----------+------+-------------+
      | a1e8be72-a395-4a6f-8e07-856a57c39524 | volume1      | available |    1 |             |
      +--------------------------------------+--------------+-----------+------+-------------+

   .. end

Attach the volume to an instance
--------------------------------

#. Attach a volume to an instance:

   .. code-block:: console

      $ openstack server add volume INSTANCE_NAME VOLUME_NAME

   .. end

   Replace ``INSTANCE_NAME`` with the name of the instance and ``VOLUME_NAME``
   with the name of the volume you want to attach to it.

   **Example**

   Attach the ``volume1`` volume to the ``provider-instance`` instance:

   .. code-block:: console

      $ openstack server add volume provider-instance volume1

   .. end

   .. note::

      This command provides no output.

#. List volumes:

   .. code-block:: console

      $ openstack volume list

      +--------------------------------------+--------------+--------+------+--------------------------------------------+
      | ID                                   | Display Name | Status | Size | Attached to                                |
      +--------------------------------------+--------------+--------+------+--------------------------------------------+
      | a1e8be72-a395-4a6f-8e07-856a57c39524 | volume1      | in-use |    1 | Attached to provider-instance on /dev/vdb  |
      +--------------------------------------+--------------+--------+------+--------------------------------------------+

   .. end

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

   .. end

   .. note::

      You must create a file system on the device and mount it
      to use the volume.

For more information about how to manage volumes, see the
`python-openstackclient documentation for Pike
<https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/volume.html>`_
or the
`python-openstackclient documentation for Queens
<https://docs.openstack.org/python-openstackclient/queens/cli/command-objects/volume.html>`_.

Return to :ref:`launch-instance`.
