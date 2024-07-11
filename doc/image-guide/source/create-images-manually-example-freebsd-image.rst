======================
Example: FreeBSD image
======================

This example creates a minimal FreeBSD image that is
compatible with OpenStack and ``bsd-cloudinit``.
The ``bsd-cloudinit`` program is independently maintained
and in active development. The best source of information
on the current state of the project is at
`bsd-cloudinit <http://pellaeon.github.io/bsd-cloudinit/>`_.

KVM with virtio drivers is used as the virtualization platform
because that is the most widely used among OpenStack operators.
If you use a different platform for your cloud virtualization,
use that same platform in the image creation step.

This example shows how to create a FreeBSD 10 image. To create
a FreeBSD 9.2 image, follow these steps with the noted differences.

.. contents:: :depth: 2

Prerequisites
-------------

#. Make a virtual drive:

   .. code-block:: console

      $ qemu-img create -f qcow2 freebsd.qcow2 1G

   The minimum supported disk size for FreeBSD is 1 GB.
   Because the goal is to make the smallest possible base image,
   the example uses that minimum size. This size is sufficient to
   include the optional ``doc``, ``games``, and ``lib32`` collections.
   To include the ``ports`` collection, add another 1 GB.
   To include ``src``, add 512 MB.

#. Get the installer ISO:

   .. code-block:: console

      $ curl ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/ISO-IMAGES/10.1/FreeBSD-10.1-RELEASE-amd64-bootonly.iso \
        > FreeBSD-10.1-RELEASE-amd64-bootonly.iso

#. Launch a VM on your local workstation.
   Use the same hypervisor, virtual disk, and virtual network drivers
   as you use in your production environment.

   The following command uses the minimum amount of RAM, which is 256 MB:

   .. code-block:: console

      $ kvm -smp 1 -m 256 -cdrom FreeBSD-10.1-RELEASE-amd64-bootonly.iso \
        -drive if=virtio,file=freebsd.qcow2 \
        -net nic,model=virtio -net user

   You can specify up to 1 GB additional RAM to make the
   installation process run faster.

   This VM must also have Internet access to download packages.

   .. note::

      By using the same hypervisor, you can ensure that you
      emulate the same devices that exist in production.
      However, if you use full hardware virtualization instead of
      paravirtualization, you do not need to use the same hypervisor;
      you must use the same type of virtualized hardware because
      FreeBSD device names are related to their drivers.
      If the name of your root block device or primary network
      interface in production differs than the names used during
      image creation, errors can occur.

   You now have a VM that boots from the downloaded install ISO and
   is connected to the blank virtual disk that you created previously.

Installation
------------

#. To install the operating system, complete the following
   steps inside the VM:

   #. When prompted, choose to run the ISO in :guilabel:`Install` mode.

   #. Accept the default keymap or select an appropriate mapping
      for your needs.

   #. Provide a host name for your image. If you use ``bsd-cloudinit``,
      it overrides this value with the name provided by OpenStack
      when an instance boots from this image.

   #. When prompted about the optional ``doc``, ``games``,
      ``lib32``, ``ports``, and ``src`` system components,
      select only those that you need.
      It is possible to have a fully functional installation
      without selecting additional components selected.
      As noted previously, a minimal system with a 1 GB virtual disk
      supports ``doc``, ``games``, and ``lib32`` inclusive.
      The ``ports`` collection requires at least 1 GB additional
      space and possibly more if you plan to install many ports.
      The ``src`` collection requires an additional 512 MB.

   #. Configure the primary network interface to use DHCP.
      In this example, which uses a virtio network device,
      this interface is named ``vtnet0``.

   #. Accept the default network mirror.

   #. Set up disk partitioning.

      Disk partitioning is a critical element of the image creation
      process and the auto-generated default partitioning scheme
      does not work with ``bsd-cloudinit`` at this time.

      Because the default does not work, you must select manual
      partitioning. The partition editor should list only one
      block device. If you use virtio for the disk device driver,
      it is named ``vtbd0``. Select this device and run the
      :command:`create` command three times:

      #. Select :guilabel:`Create` to create a partition table.
         This action is the default when no partition table exists.
         Then, select :guilabel:`GPT GUID Partition Table` from
         the list. This choice is the default.

      #. Create two partitions:

         * First partition: A 64 kB ``freebsd-boot`` partition
           with no mount point.
         * Second partition: A ``freebsd-ufs`` partition with
           a mount point of ``/`` with all remaining free space.

      The following figure shows a completed partition table
      with a 1 GB virtual disk:

      .. figure:: figures/freebsd-partitions.png
         :width: 100%

      Select :guilabel:`Finish` and then :guilabel:`Commit`
      to commit your changes.

      .. note::

         If you modify this example, the root partition,
         which is mounted on ``/``, must be the last partition
         on the drive so that it can expand at run time to
         the disk size that your instance type provides.
         Also note that ``bsd-cloudinit`` currently has a
         hard-coded assumption that this is the second partition.

#. Select a root password.

#. Select the CMOS time zone.

   The virtualized CMOS almost always stores its time in UTC,
   so unless you know otherwise, select UTC.

#. Select the time zone appropriate to your environment.

#. From the list of services to start on boot, you must select
   :guilabel:`ssh`. Optionally, select other services.

#. Optionally, add users.

   You do not need to add users at this time.
   The ``bsd-cloudinit`` program adds a ``freebsd`` user account
   if one does not exist. The ``ssh`` keys for this user are
   associated with OpenStack. To customize this user account,
   you can create it now. For example, you might want to
   customize the shell for the user.

#. Final config

   This menu enables you to update previous settings.
   Check that the settings are correct, and click :guilabel:`exit`.

#. After you exit, you can open a shell to complete manual
   configuration steps. Select :guilabel:`Yes` to make a few
   OpenStack-specific changes:

   #. Set up the console:

      .. code-block:: console

         # echo 'console="comconsole,vidconsole"' >> /boot/loader.conf

      This sets console output to go to the serial console,
      which is displayed by :command:`nova consolelog`,
      and the video console for sites with VNC or Spice configured.

   #. Minimize boot delay:

      .. code-block:: console

         # echo 'autoboot_delay="1"' >> /boot/loader.conf

   #. Download the latest ``bsd-cloudinit-installer``.
      The download commands differ between FreeBSD 10.1 and 9.2
      because of differences in how the :command:`fetch`
      command handles HTTPS URLs.

      In FreeBSD 10.1 the :command:`fetch` command verifies SSL
      peers by default, so you need to install the ``ca_root_nss``
      package that contains certificate authority root certificates
      and tell :command:`fetch` where to find them.
      For FreeBSD 10.1 run these commands:

      .. code-block:: console

         # pkg install ca_root_nss
         # fetch --ca-cert=/usr/local/share/certs/ca-root-nss.crt \
           https://raw.github.com/pellaeon/bsd-cloudinit-installer/master/installer.sh

      FreeBSD 9.2 :command:`fetch` does not support peer-verification
      for https. For FreeBSD 9.2, run this command:

      .. code-block:: console

         # fetch https://raw.github.com/pellaeon/bsd-cloudinit-installer/master/installer.sh

   #. Run the installer:

      .. code-block:: console

         # sh ./installer.sh

      Issue this command to download and install the latest
      ``bsd-cloudinit`` package, and install the necessary prerequisites.

   #. Install ``sudo`` and configure the ``freebsd`` user
      to have passwordless access:

      .. code-block:: console

         # pkg install sudo
         # echo 'freebsd ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/10-cloudinit

#. Power off the system:

   .. code-block:: console

      # shutdown -h now
