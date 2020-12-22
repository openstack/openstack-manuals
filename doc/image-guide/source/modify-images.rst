=============
Modify images
=============

Once you have obtained a virtual machine image, you may want to
make some changes to it before uploading it to the Image service.
Here we describe several tools available that allow you to modify images.

.. warning::

   Do not attempt to use these tools to modify an image
   that is attached to a running virtual machine.
   These tools are designed only to modify the images that
   are not currently running.

guestfish
~~~~~~~~~

The ``guestfish`` program is a tool from the
`libguestfs <http://libguestfs.org/>`_ project that allows
you to modify the files inside of a virtual machine image.

.. note::

   ``guestfish`` does not mount the image directly into the
   local file system. Instead, it provides you with a shell
   interface that enables you to view, edit, and delete files.
   Many of :command:`guestfish` commands, such as :command:`touch`,
   :command:`chmod`, and :command:`rm`, resemble traditional bash commands.

Example guestfish session
-------------------------

Sometimes you must modify a virtual machine image to remove
any traces of the MAC address that was assigned to the virtual
network interface card when the image was first created.
This is because the MAC address is different when the virtual
machine images boots.
This example shows how to use the ``guestfish`` to remove
references to the old MAC address by deleting the
``/etc/udev/rules.d/70-persistent-net.rules`` file and
removing the ``HWADDR`` line from the
``/etc/sysconfig/network-scripts/ifcfg-eth0`` file.

Assume that you have a CentOS qcow2 image called ``centos63_desktop.img``.
Mount the image in read-write mode as root, as follows:

.. code-block:: console

   # guestfish --rw -a centos63_desktop.img

   Welcome to guestfish, the libguestfs filesystem interactive shell for
   editing virtual machine filesystems.

   Type: 'help' for help on commands
   'man' to read the manual
   'quit' to quit the shell

   ><fs>

This starts a guestfish session.

.. note::

   the guestfish prompt looks like a fish: ``><fs>``.

We must first use the :command:`run` command at the guestfish
prompt before we can do anything else.
This will launch a virtual machine, which will
be used to perform all of the file manipulations.

.. code-block:: console

   ><fs> run

#. We can now view the file systems in the image using the
   :command:`list-filesystems` command:

   .. code-block:: console

      ><fs> list-filesystems
      /dev/vda1: ext4
      /dev/vg_centosbase/lv_root: ext4
      /dev/vg_centosbase/lv_swap: swap

#. We need to mount the logical volume that contains the root partition:

   .. code-block:: console

      ><fs> mount /dev/vg_centosbase/lv_root /

#. Next, we want to delete a file. We can use the :command:`rm` guestfish
   command, which works the same way it does in a traditional shell.

   .. code-block:: console

      ><fs> rm /etc/udev/rules.d/70-persistent-net.rules

#. We want to edit the ``ifcfg-eth0`` file to remove the ``HWADDR`` line.
   The :command:`edit` command will copy the file to the host,
   invoke your editor, and then copy the file back.

   .. code-block:: console

      ><fs> edit /etc/sysconfig/network-scripts/ifcfg-eth0

#. If you want to modify this image to load the 8021q kernel
   at boot time, you must create an executable script in the
   ``/etc/sysconfig/modules/`` directory.
   You can use the :command:`touch` guestfish command to create
   an empty file, the :command:`edit` command to edit it,
   and the :command:`chmod` command to make it executable.

   .. code-block:: console

      ><fs> touch /etc/sysconfig/modules/8021q.modules
      ><fs> edit /etc/sysconfig/modules/8021q.modules

#. We add the following line to the file and save it:

   .. code-block:: console

      modprobe 8021q

#. Then we set to executable:

   .. code-block:: console

      ><fs> chmod 0755 /etc/sysconfig/modules/8021q.modules

#. We are done, so we can exit using the :command:`exit` command:

   .. code-block:: console

      ><fs> exit

Go further with guestfish
-------------------------

There is an enormous amount of functionality in guestfish
and a full treatment is beyond the scope of this document.
Instead, we recommend that you read the
`guestfs-recipes <http://libguestfs.org/guestfs-recipes.1.html>`_
documentation page for a sense of what is possible with these tools.

guestmount
~~~~~~~~~~

For some types of changes, you may find it easier to
mount the image's file system directly in the guest.
The ``guestmount`` program, also from the
libguestfs project, allows you to do so.

#. For example, to mount the root partition from our
   ``centos63_desktop.qcow2`` image to ``/mnt``, we can do:

   .. code-block:: console

      # guestmount -a centos63_desktop.qcow2 -m /dev/vg_centosbase/lv_root --rw /mnt

#. If we did not know in advance what the mount point is in
   the guest, we could use the ``-i`` (inspect) flag to tell guestmount
   to automatically determine what mount point to use:

   .. code-block:: console

      # guestmount -a centos63_desktop.qcow2 -i --rw /mnt

#. Once mounted, we could do things like list the installed packages using rpm:

   .. code-block:: console

      # rpm -qa --dbpath /mnt/var/lib/rpm

#. Once done, we unmount:

   .. code-block:: console

      # umount /mnt

virt-* tools
~~~~~~~~~~~~

The `libguestfs <http://libguestfs.org/>`_
project has a number of other useful tools, including:

* `virt-edit <http://libguestfs.org/virt-edit.1.html>`_
  for editing a file inside of an image.
* `virt-df <http://libguestfs.org/virt-df.1.html>`_
  for displaying free space inside of an image.
* `virt-resize <http://libguestfs.org/virt-resize.1.html>`_
  for resizing an image.
* `virt-sysprep <http://libguestfs.org/virt-sysprep.1.html>`_
  for preparing an image for distribution (for example, delete
  SSH host keys, remove MAC address info, or remove user accounts).
* `virt-sparsify <http://libguestfs.org/virt-sparsify.1.html>`_
  for making an image sparse.
* `virt-p2v <http://libguestfs.org/virt-v2v/>`_
  for converting a physical machine to an image that runs on KVM.
* `virt-v2v <http://libguestfs.org/virt-v2v/>`_
  for converting Xen and VMware images to KVM images.

Modify a single file inside of an image
---------------------------------------

This example shows how to use :command:`virt-edit` to modify a file.
The command can take either a filename as an argument with the
``-a`` flag, or a domain name as an argument with the ``-d`` flag.
The following examples shows how to use this to modify the
``/etc/shadow`` file in instance with libvirt domain name
``instance-000000e1`` that is currently running:

.. code-block:: console

   # virsh shutdown instance-000000e1
   # virt-edit -d instance-000000e1 /etc/shadow
   # virsh start instance-000000e1

Resize an image
---------------

Here is an example of how to use :command:`virt-resize` to resize an image.
Assume we have a 16 GB Windows image in qcow2 format that we want to
resize to 50 GB.

#. First, we use :command:`virt-filesystems` to identify the partitions:

   .. code-block:: console

      # virt-filesystems --long --parts --blkdevs -h -a /data/images/win2012.qcow2
      Name       Type       MBR  Size  Parent
      /dev/sda1  partition  07   350M  /dev/sda
      /dev/sda2  partition  07   16G   /dev/sda
      /dev/sda   device     -    16G   -

#. In this case, it is the ``/dev/sda2`` partition that we want to resize.
   We create a new qcow2 image and use the :command:`virt-resize` command to
   write a resized copy of the original into the new image:

   .. code-block:: console

      # qemu-img create -f qcow2 /data/images/win2012-50gb.qcow2 50G
      # virt-resize --expand /dev/sda2 /data/images/win2012.qcow2 \
        /data/images/win2012-50gb.qcow2
      Examining /data/images/win2012.qcow2 ...
      **********

      Summary of changes:

      /dev/sda1: This partition will be left alone.

      /dev/sda2: This partition will be resized from 15.7G to 49.7G.  The
          filesystem ntfs on /dev/sda2 will be expanded using the
          'ntfsresize' method.

      **********
      Setting up initial partition table on /data/images/win2012-50gb.qcow2 ...
      Copying /dev/sda1 ...
       100% [                                                                 ] 00:00
      Copying /dev/sda2 ...
       100% [                                                                 ] 00:00
      Expanding /dev/sda2 using the 'ntfsresize' method ...

      Resize operation completed with no errors. Before deleting the old
      disk, carefully check that the resized disk boots and works correctly.

Loop devices, kpartx, network block devices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you do not have access to the libguestfs, you can mount
image file systems directly in the host using loop
devices, kpartx, and network block devices.

.. warning::

   Mounting untrusted guest images using the tools described in
   this section is a security risk, always use libguestfs tools
   such as guestfish and guestmount if you have access to them.
   See `A reminder why you should never mount guest disk images
   on the host OS <https://www.berrange.com/posts/2013/02/20/
   a-reminder-why-you-should-never-mount-guest-disk-images-on-the-host-os/>`_
   by Daniel Berrangé for more details.

Mount a raw image (without LVM)
-------------------------------

If you have a raw virtual machine image that is not using
LVM to manage its partitions, use the :command:`losetup` command
to find an unused loop device.

.. code-block:: console

   # losetup -f
   /dev/loop0

In this example, ``/dev/loop0`` is free.
Associate a loop device with the raw image:

.. code-block:: console

   # losetup /dev/loop0 fedora17.img

If the image only has a single partition,
you can mount the loop device directly:

.. code-block:: console

   # mount /dev/loop0 /mnt

If the image has multiple partitions, use :command:`kpartx` to expose the
partitions as separate devices (for example, ``/dev/mapper/loop0p1``),
then mount the partition that corresponds to the root file system:

.. code-block:: console

   # kpartx -av /dev/loop0

If the image has, say three partitions (/boot, /, swap),
there should be one new device created per partition:

.. code-block:: console

   $ ls -l /dev/mapper/loop0p*
   brw-rw---- 1 root disk 43, 49 2012-03-05 15:32 /dev/mapper/loop0p1
   brw-rw---- 1 root disk 43, 50 2012-03-05 15:32 /dev/mapper/loop0p2
   brw-rw---- 1 root disk 43, 51 2012-03-05 15:32 /dev/mapper/loop0p3

To mount the second partition, as root:

.. code-block:: console

   # mkdir /mnt/image
   # mount /dev/mapper/loop0p2 /mnt/image

Once you are done, to clean up:

.. code-block:: console

   # umount /mnt/image
   # rmdir /mnt/image
   # kpartx -d /dev/loop0
   # losetup -d /dev/loop0

Mount a raw image (with LVM)
----------------------------

If your partitions are managed with LVM, use :command:`losetup`
and :command:`kpartx` commands as in the previous example to expose the
partitions to the host.

.. code-block:: console

   # losetup -f
   /dev/loop0
   # losetup /dev/loop0 rhel62.img
   # kpartx -av /dev/loop0

Next, you need to use the :command:`vgscan` command to identify the LVM
volume groups and then the :command:`vgchange` command to expose the volumes
as devices:

.. code-block:: console

   # vgscan
   Reading all physical volumes. This may take a while...
   Found volume group "vg_rhel62x8664" using metadata type lvm2
   # vgchange -ay
   2 logical volume(s) in volume group "vg_rhel62x8664" now active
   # mount /dev/vg_rhel62x8664/lv_root /mnt

Clean up when you are done:

.. code-block:: console

   # umount /mnt
   # vgchange -an vg_rhel62x8664
   # kpartx -d /dev/loop0
   # losetup -d /dev/loop0

Mount a qcow2 image (without LVM)
---------------------------------

You need the ``nbd`` (network block device) kernel module
loaded to mount qcow2 images. This will load it with support
for 16 block devices, which is fine for our purposes. As root:

.. code-block:: console

   # modprobe nbd max_part=16

Assuming the first block device (``/dev/nbd0``) is not currently
in use, we can expose the disk partitions using the
:command:`qemu-nbd` and :command:`partprobe` commands. As root:

.. code-block:: console

   # qemu-nbd -c /dev/nbd0 image.qcow2
   # partprobe /dev/nbd0

If the image has, say three partitions (/boot, /, swap),
there should be one new device created for each partition:

.. code-block:: console

   $ ls -l /dev/nbd0*
   brw-rw---- 1 root disk 43, 48 2012-03-05 15:32 /dev/nbd0
   brw-rw---- 1 root disk 43, 49 2012-03-05 15:32 /dev/nbd0p1
   brw-rw---- 1 root disk 43, 50 2012-03-05 15:32 /dev/nbd0p2
   brw-rw---- 1 root disk 43, 51 2012-03-05 15:32 /dev/nbd0p3

.. note::

   If the network block device you selected was already in use,
   the initial :command:`qemu-nbd` command will fail silently, and the
   ``/dev/nbd0p{1,2,3}`` device files will not be created.

If the image partitions are not managed with LVM,
they can be mounted directly:

.. code-block:: console

   # mkdir /mnt/image
   # mount /dev/nbd0p2 /mnt/image

When you are done, clean up:

.. code-block:: console

   # umount /mnt/image
   # rmdir /mnt/image
   # qemu-nbd -d /dev/nbd0

Mount a qcow2 image (with LVM)
------------------------------

If the image partitions are managed with LVM, after you use
:command:`qemu-nbd` and :command:`partprobe`, you must use
:command:`vgscan` and :command:`vgchange -ay` in order to
expose the LVM partitions as devices that can be mounted:

.. code-block:: console

   # modprobe nbd max_part=16
   # qemu-nbd -c /dev/nbd0 image.qcow2
   # partprobe /dev/nbd0
   # vgscan
   Reading all physical volumes. This may take a while...
   Found volume group "vg_rhel62x8664" using metadata type lvm2
   # vgchange -ay
   2 logical volume(s) in volume group "vg_rhel62x8664" now active
   # mount /dev/vg_rhel62x8664/lv_root /mnt

When you are done, clean up:

.. code-block:: console

   # umount /mnt
   # vgchange -an vg_rhel62x8664
   # qemu-nbd -d /dev/nbd0
