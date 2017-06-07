================================
Launch an instance from a volume
================================

You can boot instances from a volume instead of an image.

To complete these tasks, use these parameters on the
:command:`openstack server create` command:

.. tabularcolumns:: |p{0.3\textwidth}|p{0.25\textwidth}|p{0.4\textwidth}|
.. list-table::
   :header-rows: 1
   :widths: 30 15 30

   * - Task
     - openstack server create parameter
     - Information
   * - Boot an instance from an image and attach a non-bootable
       volume.
     - ``--block-device-mapping``
     -  :ref:`Boot_instance_from_image_and_attach_non-bootable_volume`
   * - Create a volume from an image and boot an instance from that
       volume.
     - ``--volume``
     - :ref:`Create_volume_from_image_and_boot_instance`
   * - Boot from an existing source volume or snapshot.
     - ``--volume``
     - :ref:`Create_volume_from_image_and_boot_instance`

.. note::

   To attach a volume to a running instance, see
   :ref:`Attach_a_volume_to_an_instance`.

.. _Boot_instance_from_image_and_attach_non-bootable_volume:

Boot instance from image and attach non-bootable volume
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a non-bootable volume and attach that volume to an instance that
you boot from an image.

To create a non-bootable volume, do not create it from an image. The
volume must be entirely empty with no partition table and no file
system.

#. Create a non-bootable volume.

   .. code-block:: console

      $ openstack volume create --size 8 my-volume
      +---------------------+--------------------------------------+
      | Field               | Value                                |
      +---------------------+--------------------------------------+
      | attachments         | []                                   |
      | availability_zone   | nova                                 |
      | bootable            | false                                |
      | consistencygroup_id | None                                 |
      | created_at          | 2017-06-10T13:45:19.588269           |
      | description         | None                                 |
      | encrypted           | False                                |
      | id                  | e77b30a9-2c1b-4f3a-b161-e09685296a83 |
      | migration_status    | None                                 |
      | multiattach         | False                                |
      | name                | my-volume                            |
      | properties          |                                      |
      | replication_status  | disabled                             |
      | size                | 8                                    |
      | snapshot_id         | None                                 |
      | source_volid        | None                                 |
      | status              | creating                             |
      | type                | lvmdriver-1                          |
      | updated_at          | None                                 |
      | user_id             | 07a3f50419714d90b55edb6505b7cc1d     |
      +---------------------+--------------------------------------+

#. List volumes.

   .. code-block:: console

      $ openstack volume list
      +--------------------------------------+--------------+-----------+------+-------------+
      | ID                                   | Display Name | Status    | Size | Attached to |
      +--------------------------------------+--------------+-----------+------+-------------+
      | e77b30a9-2c1b-4f3a-b161-e09685296a83 | my-volume    | available |    8 |             |
      +--------------------------------------+--------------+-----------+------+-------------+

#. Boot an instance from an image and attach the empty volume to the
   instance, use the ``--block-device-mapping`` parameter.

   For example:

   .. code-block:: console

      $ openstack server create --flavor FLAVOR --image IMAGE \
        --block-device-mapping DEV-NAME=ID:TYPE:SIZE:DELETE_ON_TERMINATE \
        NAME

   The parameters are:

   - ``--flavor``
     The flavor ID or name.

   - ``--image``
     The image ID or name.

   - ``--block-device-mapping``
     DEV-NAME=ID:TYPE:SIZE:DELETE_ON_TERMINATE

     **DEV-NAME**
       The device name to attch the volume when the instance is booted.

     **ID**
       The ID of the source object.

     **TYPE**
       Which type object to create the volume.
       ``volume`` chooses volume to create. ``snapshot`` chooses snapshot
       to create.

     **SIZE**
       The size(GB) of the volume that is created.

     **DELETE_ON_TERMINATE**
       What to do with the volume when the instance is terminated.
       ``false`` does not delete the volume. ``true`` deletes the
       volume.

   - ``NAME``. The name for the server.

   .. code-block:: console

      $ openstack server create --flavor 2 --image c76cf108-1760-45aa-8559-28176f2c0530 \
        --block-device-mapping \
        myVolumeAttach=e77b30a9-2c1b-4f3a-b161-e09685296a83:volume:8:false \
        myInstanceWithVolume
      +--------------------------------------+--------------------------------------------+
      | Field                                | Value                                      |
      +--------------------------------------+--------------------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                                     |
      | OS-EXT-AZ:availability_zone          |                                            |
      | OS-EXT-SRV-ATTR:host                 | None                                       |
      | OS-EXT-SRV-ATTR:hypervisor_hostname  | None                                       |
      | OS-EXT-SRV-ATTR:instance_name        | instance-00000004                          |
      | OS-EXT-STS:power_state               | NOSTATE                                    |
      | OS-EXT-STS:task_state                | scheduling                                 |
      | OS-EXT-STS:vm_state                  | building                                   |
      | OS-SRV-USG:launched_at               | None                                       |
      | OS-SRV-USG:terminated_at             | None                                       |
      | accessIPv4                           |                                            |
      | accessIPv6                           |                                            |
      | addresses                            |                                            |
      | adminPass                            | UAwJJ7FZWxmA                               |
      | config_drive                         |                                            |
      | created                              | 2017-06-10T13:50:47Z                       |
      | flavor                               | m1.small (2)                               |
      | hostId                               |                                            |
      | id                                   | 555cf3e2-9ba3-46bf-9aa5-0a0c73d5b538       |
      | image                                | cirros-0.3.5-x86_64-uec (c76cf108-1760-... |
      | key_name                             | None                                       |
      | name                                 | InstanceWithVolume                         |
      | os-extended-volumes:volumes_attached | [{u'id': u'e77b30a9-2c1b-4f3a-b161-e096... |
      | progress                             | 0                                          |
      | project_id                           | ff903e4825c74f8dbc1aea6432e4f2fd           |
      | properties                           |                                            |
      | security_groups                      | [{u'name': u'default'}]                    |
      | status                               | BUILD                                      |
      | updated                              | 2017-06-10T13:50:48Z                       |
      | user_id                              | 07a3f50419714d90b55edb6505b7cc1d           |
      +--------------------------------------+--------------------------------------------+

.. _Create_volume_from_image_and_boot_instance:

Create volume from image and boot instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can create a volume from an existing image, volume, or snapshot.
This procedure shows you how to create a volume from an image, and use
the volume to boot an instance.

#. List the available images.

   .. code-block:: console

      $ openstack image list
      +-----------------+---------------------------------+--------+
      | ID              | Name                            | Status |
      +-----------------+---------------------------------+--------+
      | dfcd8407-486... | Fedora-x86_64-20-20131211.1-sda | active |
      | c76cf108-176... | cirros-0.3.5-x86_64-uec         | active |
      | 02d6b27f-40b... | cirros-0.3.5-x86_64-uec-kernel  | active |
      | 47b90a42-8f4... | cirros-0.3.5-x86_64-uec-ramdisk | active |
      +-----------------+---------------------------------+--------+

   Note the ID of the image that you want to use to create a volume.

   If you want to create a volume to a specific storage backend, you need
   to use an image which has *cinder_img_volume_type* property.
   In this case, a new volume will be created as *storage_backend1* volume
   type.

   .. code-block:: console

      $ openstack image show dfcd8407-4865-4d82-93f3-7fef323a5951
      +------------------+------------------------------------------------------+
      | Field            | Value                                                |
      +------------------+------------------------------------------------------+
      | checksum         | eb9139e4942121f22bbc2afc0400b2a4                     |
      | container_format | bare                                                 |
      | created_at       | 2017-06-10T06:46:26Z                                 |
      | disk_format      | qcow2                                                |
      | file             | /v2/images/dfcd8407-4865-4d82-93f3-7fef323a5951/file |
      | id               | dfcd8407-4865-4d82-93f3-7fef323a5951                 |
      | min_disk         | 0                                                    |
      | min_ram          | 0                                                    |
      | name             | Fedora-x86_64-20-20131211.1-sda                      |
      | owner            | 5ed8a204e27d462a8709bc8ec491e873                     |
      | protected        | False                                                |
      | schema           | /v2/schemas/image                                    |
      | size             | 25165824                                             |
      | status           | active                                               |
      | tags             |                                                      |
      | updated_at       | 2017-06-10T13:36:55Z                                 |
      | virtual_size     | None                                                 |
      | visibility       | public                                               |
      +------------------+------------------------------------------------------+

#. List the available flavors.

   .. code-block:: console

      $ openstack flavor list
      +-----+-----------+-------+------+-----------+-------+-----------+
      | ID  | Name      |   RAM | Disk | Ephemeral | VCPUs | Is_Public |
      +-----+-----------+-------+------+-----------+-------+-----------+
      | 1   | m1.tiny   |   512 |    1 |         0 |     1 | True      |
      | 2   | m1.small  |  2048 |   20 |         0 |     1 | True      |
      | 3   | m1.medium |  4096 |   40 |         0 |     2 | True      |
      | 4   | m1.large  |  8192 |   80 |         0 |     4 | True      |
      | 5   | m1.xlarge | 16384 |  160 |         0 |     8 | True      |
      +-----+-----------+-------+------+-----------+-------+-----------+

   Note the ID of the flavor that you want to use to create a volume.

#. Create a bootable volume from an image. Cinder makes a volume bootable
   when ``--image`` parameter is passed.

   .. code-block:: console

      $ openstack volume create --image IMAGE_ID --size SIZE_IN_GB bootable_volume

#. Create a VM from previously created bootable volume,
   use the ``--volume`` parameter. The volume is not
   deleted when the instance is terminated.

   .. code-block:: console

      $ openstack server create --flavor 2 --volume VOLUME_ID \
        myInstanceFromVolume
      +--------------------------------------+----------------------------------+
      | Field                                | Value                            |
      +--------------------------------------+----------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                           |
      | OS-EXT-AZ:availability_zone          |                                  |
      | OS-EXT-SRV-ATTR:host                 | None                             |
      | OS-EXT-SRV-ATTR:hypervisor_hostname  | None                             |
      | OS-EXT-SRV-ATTR:instance_name        | instance-00000005                |
      | OS-EXT-STS:power_state               | NOSTATE                          |
      | OS-EXT-STS:task_state                | scheduling                       |
      | OS-EXT-STS:vm_state                  | building                         |
      | OS-SRV-USG:launched_at               | None                             |
      | OS-SRV-USG:terminated_at             | None                             |
      | accessIPv4                           |                                  |
      | accessIPv6                           |                                  |
      | addresses                            |                                  |
      | adminPass                            | dizZcBMnWH8i                     |
      | config_drive                         |                                  |
      | created                              | 2017-06-10T14:15:10Z             |
      | flavor                               | m1.small (2)                     |
      | hostId                               |                                  |
      | id                                   | 7074c21a-22b3-4e91-9ea1-6a22c... |
      | image                                |                                  |
      | key_name                             | None                             |
      | name                                 | myInstanceFromVolume             |
      | os-extended-volumes:volumes_attached | [{u'id': u'3da01e5a-7d81-4a34... |
      | progress                             | 0                                |
      | project_id                           | ff903e4825c74f8dbc1aea6432e4f2fd |
      | properties                           |                                  |
      | security_groups                      | [{u'name': u'default'}]          |
      | status                               | BUILD                            |
      | updated                              | 2017-06-10T14:15:11Z             |
      | user_id                              | 07a3f50419714d90b55edb6505b7cc1d |
      +--------------------------------------+----------------------------------+

#. List volumes to see the bootable volume and its attached
   ``myInstanceFromVolume`` instance.

   .. code-block:: console

      $ openstack volume list
      +---------------------+-----------------+--------+------+---------------------------------+
      | ID                  | Display Name    | Status | Size | Attached to                     |
      +---------------------+-----------------+--------+------+---------------------------------+
      | 3da01e5a-7d81-4a34- | bootable_volume | in-use |    2 | Attached to myInstanceFromVolume|
      | a182-1958d10f7758   |                 |        |      | on /dev/vda                     |
      +---------------------+-----------------+--------+------+---------------------------------+

.. _Attach_swap_or_ephemeral_disk_to_an_instance:

Attach swap or ephemeral disk to an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To attach swap or ephemeral disk to an instance, you need create new
flavor first. This procedure shows you how to boot an instance with
a 512 MB swap disk and 2 GB ephemeral disk.

#. Create a new flavor.

   .. code-block:: console

      $ openstack flavor create --vcpus 1 --ram 64 --disk 1 \
        --swap 512 --ephemeral 2 my_flavor

   .. note::

      The flavor defines the maximum swap and ephemeral disk size. You
      cannot exceed these maximum values.

#. Create a server with 512 MB swap disk and 2 GB ephemeral disk.

   .. code-block:: console

      $ openstack server create --image IMAGE_ID --flavor \
        my_flavor NAME

