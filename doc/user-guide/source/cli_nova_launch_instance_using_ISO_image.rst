==================================
Launch an instance using ISO image
==================================

.. _Boot_instance_from_ISO_image:

Boot an instance from an ISO image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports booting instances using ISO images. But before you
make such instances functional, use the :command:`nova boot` command
with the following parameters to boot an instance.

.. code-block:: console

    $ nova boot \
        --image ubuntu-14.04.2-server-amd64.iso \
        --block-device source=blank,dest=volume,size=10,shutdown=preserve \
        --nic net-id = NETWORK_UUID \
        --flavor 2 INSTANCE_NAME
    +--------------------------------------+--------------------------------------------+
    | Property                             | Value                                      |
    +--------------------------------------+--------------------------------------------+
    | OS-DCF:diskConfig                    | MANUAL                                     |
    | OS-EXT-AZ:availability_zone          | nova                                       |
    | OS-EXT-SRV-ATTR:host                 | -                                          |
    | OS-EXT-SRV-ATTR:hypervisor_hostname  | -                                          |
    | OS-EXT-SRV-ATTR:instance_name        | instance-00000004                          |
    | OS-EXT-STS:power_state               | 0                                          |
    | OS-EXT-STS:task_state                | scheduling                                 |
    | OS-EXT-STS:vm_state                  | building                                   |
    | OS-SRV-USG:launched_at               | -                                          |
    | OS-SRV-USG:terminated_at             | -                                          |
    | accessIPv4                           |                                            |
    | accessIPv6                           |                                            |
    | adminPass                            | ZaiYeC8iucgU                               |
    | config_drive                         |                                            |
    | created                              | 2015-06-01T16:34:50Z                       |
    | flavor                               | m1.small (2)                               |
    | hostId                               |                                            |
    | id                                   | 1e1797f3-1662-49ff-ae8c-a77e82ee1571       |
    | image                                | ubuntu-14.04.2-server-amd64.iso            |
    | key_name                             | -                                          |
    | metadata                             | {}                                         |
    | name                                 | INSTANCE_NAME                              |
    | os-extended-volumes:volumes_attached | []                                         |
    | progress                             | 0                                          |
    | security_groups                      | default                                    |
    | status                               | BUILD                                      |
    | tenant_id                            | ccef9e62b1e645df98728fb2b3076f27           |
    | updated                              | 2014-05-09T16:34:51Z                       |
    | user_id                              | fef060ae7bfd4024b3edb97dff59017a           |
    +--------------------------------------+--------------------------------------------+

In this command, ``ubuntu-14.04.2-server-amd64.iso`` is the ISO image,
and ``INSTANCE_NAME`` is the name of the new instance. ``NETWORK_UUID``
is a valid network id in your system.

.. note::

   You need the Block Storage service, and the parameter
   ``shutdown=preserve`` is also mandatory, thus the volume will be
   preserved after the shutdown of the instance.

After the instance is successfully launched, connect to the instance
using a remote console and follow the instructions to install the
system as using ISO images on regular computers. When the installation
is finished and system is rebooted, the instance asks you again to
install the operating system, which means your instance is not usable.
If you have problems with image creation, please check the
`Virtual Machine Image Guide
<http://docs.openstack.org/image-guide/create-images-manually.html>`_
for reference.

.. _Make_instance_booted_from_ISO_image_functional:

Make the instances booted from ISO image functional
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now complete the following steps to make your instances created
using ISO image actually functional.

#. Delete the instance using the following command.

   .. code-block:: console

      $ nova delete INSTANCE_NAME

#. After you delete the instance, the system you have just installed
   using your ISO image remains, because the parameter
   ``shutdown=preserve`` was set, so run the following command.

   .. code-block:: console

      $ cinder list
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      |       ID        |   Status  |      Name    | Size | Volume Type | Bootable | Attached to |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+
      | d620d971-b16... | available | 655ef3e4-... |  8   |     None    |  false   |             |
      +-----------------+-----------+--------------+------+-------------+----------+-------------+

   You get a list with all the volumes in your system. In this list,
   you can find the volume that is attached to your ISO created
   instance, with the false bootable property.

#. Upload the volume to glance.

   .. code-block:: console

      $ cinder upload-to-image VOLUME_UUID IMAGE_NAME
      $ glance image-list
      +-------------------+------------+-------------+------------------+------------+--------+
      | ID                | Name       | Disk Format | Container Format | Size       | Status |
      +-------------------+------------+-------------+------------------+------------+--------+
      | 74303284-f802-... | IMAGE_NAME | iso         | bare             | 764321792  | active |
      +-------------------+------------+-------------+------------------+------------+--------+

   The ``VOLUME_UUID`` is the uuid of the volume that is attached to
   your ISO created instance, and the ``IMAGE_NAME`` is the name that
   you give to your new image.

#. After the image is successfully uploaded, you can use the new
   image to boot instances.

   The instances launched using this image contain the system that
   you have just installed using the ISO image.
