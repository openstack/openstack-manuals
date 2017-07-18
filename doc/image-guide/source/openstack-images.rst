==================
Image requirements
==================

Linux
~~~~~

For a Linux-based image to have full functionality in an
OpenStack Compute cloud, there are a few requirements.
For some of these, you can fulfill the requirements by installing the
`cloud-init <https://cloudinit.readthedocs.org/en/latest/>`_ package.
Read this section before you create your own image to be sure that
the image supports the OpenStack features that you plan to use.

* Disk partitions and resize root partition on boot (``cloud-init``)
* No hard-coded MAC address information
* SSH server running
* Disable firewall
* Access instance using ssh public key (``cloud-init``)
* Process user data and other metadata (``cloud-init``)
* Paravirtualized Xen support in Linux kernel
  (Xen hypervisor only with Linux kernel version < 3.0)

Disk partitions and resize root partition on boot (cloud-init)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you create a Linux image, you must decide how to partition the disks.
The choice of partition method can affect the resizing functionality,
as described in the following sections.

The size of the disk in a virtual machine image is determined
when you initially create the image.
However, OpenStack lets you launch instances with different size
drives by specifying different flavors.
For example, if your image was created with a 5 GB disk, and you
launch an instance with a flavor of ``m1.small``.
The resulting virtual machine instance has, by default,
a primary disk size of 20 GB. When the disk for an instance is
resized up, zeros are just added to the end.

Your image must be able to resize its partitions on boot to
match the size requested by the user.
Otherwise, after the instance boots, you must manually resize the
partitions to access the additional storage to which you
have access when the disk size associated with the flavor
exceeds the disk size with which your image was created.

Xen: one ext3/ext4 partition (no LVM)
-------------------------------------

If you use the OpenStack XenAPI driver, the Compute service automatically
adjusts the partition and file system for your instance on boot.
Automatic resize occurs if the following conditions are all true:

* ``auto_disk_config=True`` is set as a property on the image
  in the image registry.
* The disk on the image has only one partition.
* The file system on the one partition is ext3 or ext4.

Therefore, if you use Xen, we recommend that when you create your images,
you create a single ext3 or ext4 partition (not managed by LVM).
Otherwise, read on.

Non-Xen with cloud-init/cloud-tools: one ext3/ext4 partition (no LVM)
---------------------------------------------------------------------

You must configure these items for your image:

* The partition table for the image describes the original size of the image.
* The file system for the image fills the original size of the image.

Then, during the boot process, you must:

* Modify the partition table to make it aware of the additional space:

  * If you do not use LVM, you must modify the table to extend the
    existing root partition to encompass this additional space.

  * If you use LVM, you can add a new LVM entry to the partition table,
    create a new LVM physical volume, add it to the volume group,
    and extend the logical partition with the root volume.

* Resize the root volume file system.

Depending on your distribution, the simplest way to support this is to install
in your image:

* the `cloud-init <https://launchpad.net/cloud-init>`__ package,
* the `cloud-utils <https://launchpad.net/cloud-utils>`_ package,
  which, on Ubuntu and Debian, also contains the ``growpart`` tool for
  extending partitions,
* if you use Fedora, CentOS 7, or RHEL 7, the ``cloud-utils-growpart``
  package, which contains the ``growpart`` tool for extending partitions,
* if you use Ubuntu or Debian, the
  `cloud-initramfs-growroot <https://launchpad.net/cloud-initramfs-tools>`_
  package , which supports resizing root partition on the first boot.

With these packages installed, the image performs the root partition
resize on boot. For example, in the ``/etc/rc.local`` file.

If you cannot install ``cloud-initramfs-tools``, Robert Plestenjak
has a GitHub project called `linux-rootfs-resize
<https://github.com/flegmatik/linux-rootfs-resize>`_
that contains scripts that update a ramdisk by using
``growpart`` so that the image resizes properly on boot.

If you can install the ``cloud-init`` and ``cloud-utils`` packages,
we recommend that when you create your images, you create
a single ext3 or ext4 partition (not managed by LVM).

Non-Xen without cloud-init/cloud-tools: LVM
-------------------------------------------

If you cannot install ``cloud-init`` and ``cloud-tools`` inside of
your guest, and you want to support resize, you must write
a script that your image runs on boot to modify the partition table.
In this case, we recommend using LVM to manage your partitions.
Due to a limitation in the Linux kernel (as of this writing),
you cannot modify a partition table of a raw disk that has
partitions currently mounted, but you can do this for LVM.

Your script must do something like the following:

#. Detect if any additional space is available on the disk.
   For example, parse the output of
   ``parted /dev/sda --script "print free"``.
#. Create a new LVM partition with the additional space.
   For example, ``parted /dev/sda --script "mkpart lvm ..."``.
#. Create a new physical volume. For example, ``pvcreate /dev/sda6``.
#. Extend the volume group with this physical partition.
   For example, ``vgextend vg00 /dev/sda6``.
#. Extend the logical volume contained the root partition by
   the amount of space. For example,
   ``lvextend /dev/mapper/node-root /dev/sda6``.
#. Resize the root file system. For example,
   ``resize2fs /dev/mapper/node-root``.

You do not need a ``/boot`` partition unless your image is an older
Linux distribution that requires that ``/boot`` is not managed by LVM.

No hard-coded MAC address information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must remove the network persistence rules in the
image because they cause the network interface in the
instance to come up as an interface other than eth0.
This is because your image has a record of the MAC address of
the network interface card when it was first installed,
and this MAC address is different each time the instance boots.
You should alter the following files:

* Replace ``/etc/udev/rules.d/70-persistent-net.rules`` with
  an empty file (contains network persistence rules, including MAC address).
* Replace ``/lib/udev/rules.d/75-persistent-net-generator.rules``
  with an empty file (this generates the file above).
* Remove the HWADDR line from ``/etc/sysconfig/network-scripts/ifcfg-eth0``
  on Fedora-based images.

.. note::

   If you delete the network persistent rules files,
   you may get a ``udev kernel`` warning at boot time,
   which is why we recommend replacing them with empty files instead.

Ensure ssh server runs
~~~~~~~~~~~~~~~~~~~~~~

You must install an ssh server into the image and ensure
that it starts up on boot, or you cannot connect to your
instance by using ssh when it boots inside of OpenStack.
This package is typically called ``openssh-server``.

Disable firewall
~~~~~~~~~~~~~~~~

In general, we recommend that you disable any firewalls
inside of your image and use OpenStack security groups to
restrict access to instances.
The reason is that having a firewall installed on your
instance can make it more difficult to troubleshoot
networking issues if you cannot connect to your instance.

Access instance by using ssh public key (cloud-init)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The typical way that users access virtual machines
running on OpenStack is to ssh using public key authentication.
For this to work, your virtual machine image must be configured
to download the ssh public key from the OpenStack metadata
service or config drive, at boot time.

If both the XenAPI agent and ``cloud-init`` are present
in an image, ``cloud-init`` handles ssh-key injection.
The system assumes ``cloud-init`` is present when the image
has the ``cloud_init_installed`` property.

Use cloud-init to fetch the public key
--------------------------------------

The ``cloud-init`` package automatically fetches the public key
from the metadata server and places the key in an account.
The account varies by distribution.
On Ubuntu-based virtual machines, the account is called ``ubuntu``,
on Fedora-based virtual machines, the account is called ``fedora``,
and on CentOS-based virtual machines, the account is called ``centos``.

You can change the name of the account used by ``cloud-init``
by editing the ``/etc/cloud/cloud.cfg`` file and adding a line
with a different user. For example, to configure ``cloud-init``
to put the key in an account named ``admin``, use the following syntax
in the configuration file:

.. code-block:: yaml

   users:
     - name: admin
       (...)

Write a custom script to fetch the public key
---------------------------------------------

If you are unable or unwilling to install ``cloud-init`` inside
the guest, you can write a custom script to fetch the public key
and add it to a user account.

To fetch the ssh public key and add it to the root account,
edit the ``/etc/rc.local`` file and add the following lines
before the line ``touch /var/lock/subsys/local``.
This code fragment is taken from the
`rackerjoe oz-image-build CentOS 6 template <https://github.com/
rackerjoe/oz-image-build/blob/master/templates/centos60_x86_64.tdl>`_.

.. code-block:: bash

   if [ ! -d /root/.ssh ]; then
     mkdir -p /root/.ssh
     chmod 700 /root/.ssh
   fi

   # Fetch public key using HTTP
   ATTEMPTS=30
   FAILED=0
   while [ ! -f /root/.ssh/authorized_keys ]; do
     curl -f http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key > /tmp/metadata-key 2>/dev/null
     if [ $? -eq 0 ]; then
       cat /tmp/metadata-key >> /root/.ssh/authorized_keys
       chmod 0600 /root/.ssh/authorized_keys
       restorecon /root/.ssh/authorized_keys
       rm -f /tmp/metadata-key
       echo "Successfully retrieved public key from instance metadata"
       echo "*****************"
       echo "AUTHORIZED KEYS"
       echo "*****************"
       cat /root/.ssh/authorized_keys
       echo "*****************"
     else
       FAILED=`expr $FAILED + 1`
       if [ $FAILED -ge $ATTEMPTS ]; then
         echo "Failed to retrieve public key from instance metadata after $FAILED attempts, quitting"
         break
       fi
       echo "Could not retrieve public key from instance metadata (attempt #$FAILED/$ATTEMPTS), retrying in 5 seconds..."
       sleep 5
     fi
   done

.. note::

   Some VNC clients replace : (colon) with ; (semicolon) and
   _ (underscore) with - (hyphen).
   If editing a file over a VNC session, make sure it is
   http: not http; and authorized_keys not authorized-keys.

Process user data and other metadata (cloud-init)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition to the ssh public key, an image might need
additional information from OpenStack, such as
to povide user data to instances,
that the user submitted when requesting the image.
For example, you might want to set the host name of the instance
when it is booted. Or, you might wish to configure your image
so that it executes user data content as a script on boot.

You can access this information through the metadata
service or referring to `Store metadata on the configuration drive
<https://docs.openstack.org/user-guide/cli-config-drive.html>`_.
As the OpenStack metadata service is compatible with version
2009-04-04 of the Amazon EC2 metadata service, consult the
Amazon EC2 documentation on
`Using Instance Metadata <http://docs.amazonwebservices.com/
AWSEC2/2009-04-04/UserGuide/AESDG-chapter-instancedata.html>`_
for details on how to retrieve the user data.

The easiest way to support this type of functionality is
to install the ``cloud-init`` package into your image,
which is configured by default to treat user data as
an executable script, and sets the host name.

.. _write-to-console:

Ensure image writes boot log to console
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must configure the image so that the kernel writes
the boot log to the ``ttyS0`` device. In particular, the
``console=tty0 console=ttyS0,115200n8`` arguments must be passed to
the kernel on boot.

If your image uses ``grub2`` as the boot loader,
there should be a line in the grub configuration file.
For example, ``/boot/grub/grub.cfg``, which looks something like this:

.. code-block:: console

   linux /boot/vmlinuz-3.2.0-49-virtual root=UUID=6d2231e4-0975-4f35-a94f-56738c1a8150 ro console=tty0 console=ttyS0,115200n8

If ``console=tty0 console=ttyS0,115200n8`` does not appear, you must
modify your grub configuration. In general, you should not update the
``grub.cfg`` directly, since it is automatically generated.
Instead, you should edit the ``/etc/default/grub`` file and modify the
value of the ``GRUB_CMDLINE_LINUX_DEFAULT`` variable:

.. code-block:: bash

   GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200n8"

Next, update the grub configuration. On Debian-based
operating systems such as Ubuntu, run this command:

.. code-block:: console

   # update-grub

On Fedora-based systems, such as RHEL and CentOS,
and on openSUSE, run this command:

.. code-block:: console

   # grub2-mkconfig -o /boot/grub2/grub.cfg

Paravirtualized Xen support in the kernel (Xen hypervisor only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prior to Linux kernel version 3.0, the mainline branch of
the Linux kernel did not have support for paravirtualized
Xen virtual machine instances (what Xen calls DomU guests).
If you are running the Xen hypervisor with paravirtualization,
and you want to create an image for an older Linux distribution
that has a pre 3.0 kernel, you must ensure that the image
boots a kernel that has been compiled with Xen support.

Manage the image cache
~~~~~~~~~~~~~~~~~~~~~~

Use options in the ``nova.conf`` file to control whether, and for how long,
unused base images are stored in the ``/var/lib/nova/instances/_base/``.
If you have configured live migration of instances, all your compute
nodes share one common ``/var/lib/nova/instances/`` directory.

For information about the libvirt images in OpenStack, see
`The life of an OpenStack libvirt image from Pádraig Brady
<http://www.pixelbeat.org/docs/openstack_libvirt_images/>`_.

.. tabularcolumns:: |l|p{0.4\textwidth}|
.. list-table:: Image cache management configuration options
   :widths: 50 50
   :header-rows: 1

   * - Configuration option=Default value
     - (Type) Description
   * - preallocate_images=none
     - (StrOpt) VM image preallocation mode:

       none
        No storage provisioning occurs up front.
       space
        Storage is fully allocated at instance start.
        The ``$instance_dir/`` images are
        `fallocated <http://www.kernel.org/doc/man-pages/online/pages/man2/fallocate.2.html>`_
        to immediately determine if enough space is available,
        and to possibly improve VM I/O performance due to ongoing
        allocation avoidance, and better locality of block allocations.
   * - remove_unused_base_images=True
     - (BoolOpt) Should unused base images be removed?
       When set to True, the interval at which base images are
       removed are set with the following two settings.
       If set to False base images are never removed by Compute.
   * - remove_unused_original_minimum_age_seconds=86400
     - (IntOpt) Unused unresized base images younger than this are
       not removed. Default is 86400 seconds, or 24 hours.
   * - remove_unused_resized_minimum_age_seconds=3600
     - (IntOpt) Unused resized base images younger than this are
       not removed. Default is 3600 seconds, or one hour.

To see how the settings affect the deletion of a running instance,
check the directory where the images are stored:

.. code-block:: console

   # ls -lash /var/lib/nova/instances/_base/

In the ``/var/log/compute/compute.log`` file, look for the identifier:

.. code-block:: console

   2012-02-18 04:24:17 41389 WARNING nova.virt.libvirt.imagecache [-] Unknown base file: /var/lib/nova/instances/_base/06a057b9c7b0b27e3b496f53d1e88810a0d1d5d3_20
   2012-02-18 04:24:17 41389 INFO nova.virt.libvirt.imagecache [-] Removable base files: /var/lib/nova/instances/_base/06a057b9c7b0b27e3b496f53d1e88810a0d1d5d3 /var/lib/nova/instances/_base/06a057b9c7b0b27e3b496f53d1e88810a0d1d5d3_20
   2012-02-18 04:24:17 41389 INFO nova.virt.libvirt.imagecache [-] Removing base file: /var/lib/nova/instances/_base/06a057b9c7b0b27e3b496f53d1e88810a0d1d5d3

Because 86400 seconds (24 hours) is the default time for
``remove_unused_original_minimum_age_seconds``,
you can either wait for that time interval to see the base image
removed, or set the value to a shorter time period in the ``nova.conf`` file.
Restart all nova services after changing a setting in the ``nova.conf`` file.
