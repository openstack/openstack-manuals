=============
Manage images
=============

The cloud operator assigns roles to users. Roles determine who can
upload and manage images. The operator might restrict image upload and
management to only cloud administrators or operators.

You can upload images through the ``glance`` client or the Image service
API. Besides, you can use the ``nova`` client for the image management.
The latter provides mechanisms to list and delete images, set and delete
image metadata, and create images of a running instance of snapshot and
backup types.

After you upload an image, you cannot change it.

For details about image creation, see the `Virtual Machine Image
Guide <http://docs.openstack.org/image-guide/>`__.

List or get details for images (glance)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To get a list of images and to then get further details about a single
image, use :command:`glance image-list` and :command:`glance image-show`
commands.

.. code-block:: console

   $ glance image-list
   +----------+---------------------------------+-------------+------------------+----------+--------+
   | ID       | Name                            | Disk Format | Container Format | Size     | Status |
   +----------+---------------------------------+-------------+------------------+----------+--------+
   | 397e7... | cirros-0.3.2-x86_64-uec         | ami         | ami              | 25165824 | active |
   | df430... | cirros-0.3.2-x86_64-uec-kernel  | aki         | aki              | 4955792  | active |
   | 3cf85... | cirros-0.3.2-x86_64-uec-ramdisk | ari         | ari              | 3714968  | active |
   | 7e514... | myCirrosImage                   | ami         | ami              | 14221312 | active |
   +----------+---------------------------------+-------------+------------------+----------+--------+

.. code-block:: console

   $ glance image-show myCirrosImage
   +---------------------------------------+--------------------------------------+
   | Property                              | Value                                |
   +---------------------------------------+--------------------------------------+
   | Property 'base_image_ref'             | 397e713c-b95b-4186-ad46-6126863ea0a9 |
   | Property 'image_location'             | snapshot                             |
   | Property 'image_state'                | available                            |
   | Property 'image_type'                 | snapshot                             |
   | Property 'instance_type_ephemeral_gb' | 0                                    |
   | Property 'instance_type_flavorid'     | 2                                    |
   | Property 'instance_type_id'           | 5                                    |
   | Property 'instance_type_memory_mb'    | 2048                                 |
   | Property 'instance_type_name'         | m1.small                             |
   | Property 'instance_type_root_gb'      | 20                                   |
   | Property 'instance_type_rxtx_factor'  | 1                                    |
   | Property 'instance_type_swap'         | 0                                    |
   | Property 'instance_type_vcpu_weight'  | None                                 |
   | Property 'instance_type_vcpus'        | 1                                    |
   | Property 'instance_uuid'              | 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 |
   | Property 'kernel_id'                  | df430cc2-3406-4061-b635-a51c16e488ac |
   | Property 'owner_id'                   | 66265572db174a7aa66eba661f58eb9e     |
   | Property 'ramdisk_id'                 | 3cf852bd-2332-48f4-9ae4-7d926d50945e |
   | Property 'user_id'                    | 376744b5910b4b4da7d8e6cb483b06a8     |
   | checksum                              | 8e4838effa1969ad591655d6485c7ba8     |
   | container_format                      | ami                                  |
   | created_at                            | 2013-07-22T19:45:58                  |
   | deleted                               | False                                |
   | disk_format                           | ami                                  |
   | id                                    | 7e5142af-1253-4634-bcc6-89482c5f2e8a |
   | is_public                             | False                                |
   | min_disk                              | 0                                    |
   | min_ram                               | 0                                    |
   | name                                  | myCirrosImage                        |
   | owner                                 | 66265572db174a7aa66eba661f58eb9e     |
   | protected                             | False                                |
   | size                                  | 14221312                             |
   | status                                | active                               |
   | updated_at                            | 2013-07-22T19:46:42                  |
   +---------------------------------------+--------------------------------------+

When viewing a list of images, you can also use ``grep`` to filter the
list, as follows:

.. code-block:: console

   $ glance image-list | grep 'cirros'
   | 397e713c-b95b-4186-ad46-612... | cirros-0.3.2-x86_64-uec         | ami | ami | 25165824 | active |
   | df430cc2-3406-4061-b635-a51... | cirros-0.3.2-x86_64-uec-kernel  | aki | aki | 4955792  | active |
   | 3cf852bd-2332-48f4-9ae4-7d9... | cirros-0.3.2-x86_64-uec-ramdisk | ari | ari | 3714968  | active |

.. note::

   To store location metadata for images, which enables direct file access for a client, update the ``/etc/glance/glance-api.conf`` file with the following statements:

   *  ``show_multiple_locations = True``

   *  ``filesystem_store_metadata_file = filePath``, where filePath points to a JSON file that defines the mount point for OpenStack images on your system and a unique ID. For example:

   .. code-block:: json

      [{
          "id": "2d9bb53f-70ea-4066-a68b-67960eaae673",
          "mountpoint": "/var/lib/glance/images/"
      }]

   After you restart the Image service, you can use the following syntax to view the image's location information:

   .. code-block:: console

      $ glance --os-image-api-version 2 image-show imageID

   For example, using the image ID shown above, you would issue the command as follows:

   .. code-block:: console

      $ glance --os-image-api-version 2 image-show 2d9bb53f-70ea-4066-a68b-67960eaae673

Create or update an image (glance)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an image, use :command:`glance image-create`:

.. code-block:: console

   $ glance image-create imageName

To update an image by name or ID, use :command:`glance image-update`:

.. code-block:: console

   $ glance image-update imageName

The following list explains the optional arguments that you can use with
the ``create`` and ``update`` commands to modify image properties. For
more information, refer to Image service chapter in the `OpenStack
Command-Line Interface
Reference <http://docs.openstack.org/cli-reference/index.html>`__.

``--name NAME``
  The name of the image.

``--disk-format DISK_FORMAT``
  The disk format of the image. Acceptable formats are ami, ari, aki,
  vhd, vmdk, raw, qcow2, vdi, and iso.

``--container-format CONTAINER_FORMAT``
  The container format of the image. Acceptable formats are ami, ari,
  aki, bare, docker, and ovf.

``--owner TENANT_ID --size SIZE``
  The tenant who should own the image. The size of image data, in
  bytes.

``--min-disk DISK_GB``
  The minimum size of the disk needed to boot the image, in
  gigabytes.

``--min-ram DISK_RAM``
  The minimum amount of RAM needed to boot the image, in megabytes.

``--location IMAGE_URL``
  The URL where the data for this image resides. For example, if the
  image data is stored in swift, you could specify
  ``swift://account:key@example.com/container/obj``.

``--file FILE``
  Local file that contains the disk image to be uploaded during the
  update. Alternatively, you can pass images to the client through
  stdin.

``--checksum CHECKSUM``
  Hash of image data to use for verification.

``--copy-from IMAGE_URL``
  Similar to `--location` in usage, but indicates that the image
  server should immediately copy the data and store it in its
  configured image store.

``--is-public [True|False]``
  Makes an image accessible for all the tenants (admin-only by
  default).

``--is-protected [True|False]``
  Prevents an image from being deleted.

``--property KEY=VALUE``
  Arbitrary property to associate with image. This option can be used
  multiple times.

``--purge-props``
  Deletes all image properties that are not explicitly set in the
  update request. Otherwise, those properties not referenced are
  preserved.

``--human-readable``
  Prints the image size in a human-friendly format.


The following example shows the command that you would use to upload a
CentOS 6.3 image in qcow2 format and configure it for public access:

.. code-block:: console

   $ glance image-create --name centos63-image --disk-format qcow2 \
     --container-format bare --is-public True --file ./centos63.qcow2

The following example shows how to update an existing image with a
properties that describe the disk bus, the CD-ROM bus, and the VIF
model:

.. note::

   When you use OpenStack with VMware vCenter Server, you need to specify
   the ``vmware_disktype`` and ``vmware_adaptertype`` properties with
   :command:`glance image-create`.
   Also, we recommend that you set the ``hypervisor_type="vmware"`` property.
   For more information, see `Images with VMware vSphere
   <http://docs.openstack.org/liberty/config-reference/content/vmware.html#VMware_images>`_
   in the *OpenStack Configuration Reference*.

.. code-block:: console

   $ glance image-update \
       --property hw_disk_bus=scsi \
       --property hw_cdrom_bus=ide \
       --property hw_vif_model=e1000 \
       f16-x86_64-openstack-sda

Currently the libvirt virtualization tool determines the disk, CD-ROM,
and VIF device models based on the configured hypervisor type
(``libvirt_type`` in ``/etc/nova/nova.conf`` file). For the sake of optimal
performance, libvirt defaults to using virtio for both disk and VIF
(NIC) models. The disadvantage of this approach is that it is not
possible to run operating systems that lack virtio drivers, for example,
BSD, Solaris, and older versions of Linux and Windows.

If you specify a disk or CD-ROM bus model that is not supported, see
the Disk_and_CD-ROM_bus_model_values_table_.
If you specify a VIF model that is not supported, the instance fails to
launch. See the VIF_model_values_table_.

The valid model values depend on the ``libvirt_type`` setting, as shown
in the following tables.

.. _Disk_and_CD-ROM_bus_model_values_table:

**Disk and CD-ROM bus model values**

+-------------------------+--------------------------+
| libvirt\_type setting   | Supported model values   |
+=========================+==========================+
| qemu or kvm             | *  ide                   |
|                         |                          |
|                         | *  scsi                  |
|                         |                          |
|                         | *  virtio                |
+-------------------------+--------------------------+
| xen                     | *  ide                   |
|                         |                          |
|                         | *  xen                   |
+-------------------------+--------------------------+


.. _VIF_model_values_table:

**VIF model values**

+-------------------------+--------------------------+
| libvirt\_type setting   | Supported model values   |
+=========================+==========================+
| qemu or kvm             | *  e1000                 |
|                         |                          |
|                         | *  ne2k\_pci             |
|                         |                          |
|                         | *  pcnet                 |
|                         |                          |
|                         | *  rtl8139               |
|                         |                          |
|                         | *  virtio                |
+-------------------------+--------------------------+
| xen                     | *  e1000                 |
|                         |                          |
|                         | *  netfront              |
|                         |                          |
|                         | *  ne2k\_pci             |
|                         |                          |
|                         | *  pcnet                 |
|                         |                          |
|                         | *  rtl8139               |
+-------------------------+--------------------------+
| vmware                  | *  VirtualE1000          |
|                         |                          |
|                         | *  VirtualPCNet32        |
|                         |                          |
|                         | *  VirtualVmxnet         |
+-------------------------+--------------------------+

Troubleshoot image creation
~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you encounter problems in creating an image in Image service or
Compute, the following information may help you troubleshoot the
creation process.

*  Ensure that the version of qemu you are using is version 0.14 or
   later. Earlier versions of qemu result in an ``unknown option -s``
   error message in the ``nova-compute.log`` file.

*  Examine the ``/var/log/nova-api.log`` and
   ``/var/log/nova-compute.log`` log files for error messages.
