=====================
Example: Fedora image
=====================

This example shows you how to install a Fedora image and focuses
mainly on Fedora 25. Because the Fedora installation process
might differ across versions, the installation steps might
differ if you use a different version of Fedora.

.. contents:: :depth: 2

Download a Fedora install ISO
-----------------------------

#. Visit the `Fedora download site <https://getfedora.org/>`_.

#. Navigate to the
   `Download Fedora Server page <https://getfedora.org/en/server/download/>`_
   for a Fedora Server ISO image.

#. Choose the ISO image you want to download.

   For example, the ``Netinstall Image`` is a good choice because it is a
   smaller image that downloads missing packages from the Internet during
   installation.

Start the installation process
------------------------------

Start the installation process using either the :command:`virt-manager`
or the :command:`virt-install` command as described previously.
If you use the :command:`virt-install` command, do not forget to connect your
VNC client to the virtual machine.

Assume that:

* The name of your virtual machine image is ``fedora``;
  you need this name when you use :command:`virsh` commands
  to manipulate the state of the image.
* You saved the netinstall ISO image to the ``/tmp`` directory.

If you use the :command:`virt-install` command, the commands should look
something like this:

.. code-block:: console

   # qemu-img create -f qcow2 /tmp/fedora.qcow2 10G
   # virt-install --virt-type kvm --name fedora --ram 1024 \
     --disk /tmp/fedora.qcow2,format=qcow2 \
     --network network=default \
     --graphics vnc,listen=0.0.0.0 --noautoconsole \
     --os-type=linux --os-variant=fedora23 \
     --location=/tmp/Fedora-Server-netinst-x86_64-25-1.3.iso

Step through the installation
-----------------------------

After the installation program starts, choose your preferred language and click
:guilabel:`Continue` to get to the installation summary. Accept the defaults.

Review the Ethernet status
~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure that the Ethernet setting is ``ON``. Additionally, make sure that
``IPv4 Settings' Method`` is ``Automatic (DHCP)``, which is the default.

Hostname
~~~~~~~~

The installer allows you to choose a host name.
The default (``localhost.localdomain``) is fine.
You install the ``cloud-init`` package later,
which sets the host name on boot when a new instance
is provisioned using this image.

Partition the disks
~~~~~~~~~~~~~~~~~~~

There are different options for partitioning the disks.
The default installation uses LVM partitions, and creates
three partitions (``/boot``, ``/``, ``swap``), which works fine.
Alternatively, you might want to create a single ext4
partition that is mounted to ``/``, which also works fine.

If unsure, use the default partition scheme for the installer.
While no scheme is inherently better than another, having the
partition that you want to dynamically grow at the end of the
list will allow it to grow without crossing another
partition's boundary.

Select software to install
~~~~~~~~~~~~~~~~~~~~~~~~~~

Step through the installation, using the default options.
The simplest thing to do is to choose the ``Minimal Install``
install, which installs an SSH server.

Set the root password
~~~~~~~~~~~~~~~~~~~~~

During the installation, remember to set the root password when prompted.

Detach the CD-ROM and reboot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wait until the installation is complete.

To eject a disk by using the :command:`virsh` command,
libvirt requires that you attach an empty disk at the same target
that the CD-ROM was previously attached, which may be ``hda``.
You can confirm the appropriate target using the
:command:`virsh dumpxml vm-image` command.

.. code-block:: console

   # virsh dumpxml fedora
   <domain type='kvm' id='30'>
     <name>fedora</name>
   ...
       <disk type='file' device='cdrom'>
         <driver name='qemu' type='raw'/>
         <source file='/tmp/Fedora-Server-netinst-x86_64-25-1.3.iso'/>
         <backingStore/>
         <target dev='hda' bus='ide'/>
         <readonly/>
         <alias name='ide0-0-0'/>
         <address type='drive' controller='0' bus='0' target='0' unit='0'/>
       </disk>
   ...
   </domain>

Run the following commands from the host to eject the disk
and reboot using ``virsh``, as root. If you are using ``virt-manager``,
the commands below will work, but you can also use the GUI to detach
and reboot it by manually stopping and starting.

.. code-block:: console

   # virsh attach-disk --type cdrom --mode readonly fedora "" hda
   # virsh reboot fedora

Install the ACPI service
------------------------

To enable the hypervisor to reboot or shutdown an instance,
you must install and run the ``acpid`` service on the guest system.

Log in as root to the Fedora guest and run the following commands
to install the ACPI service and configure it to start when the
system boots:

.. code-block:: console

   # dnf install acpid
   # systemctl enable acpid

Configure cloud-init to fetch metadata
--------------------------------------

An instance must interact with the metadata service to perform
several tasks on start up. For example, the instance must get
the ssh public key and run the user data script. To ensure that
the instance performs these tasks, use the ``cloud-init``
package.

The ``cloud-init`` package automatically fetches the public key
from the metadata server and places the key in an account.
Install ``cloud-init`` inside the Fedora guest by
running:

.. code-block:: console

   # yum install cloud-init

The account varies by distribution. On Fedora-based virtual machines,
the account is called ``fedora``.

You can change the name of the account used by ``cloud-init``
by editing the ``/etc/cloud/cloud.cfg`` file and adding a line
with a different user. For example, to configure ``cloud-init``
to put the key in an account named ``admin``, use the following
syntax in the configuration file:

.. code-block:: console

   users:
     - name: admin
       (...)

Install cloud-utils-growpart to allow partitions to resize
----------------------------------------------------------

In order for the root partition to properly resize, install the
``cloud-utils-growpart`` package, which contains the proper tools
to allow the disk to resize using cloud-init.

.. code-block:: console

   # dnf install cloud-utils-growpart

Disable the zeroconf route
--------------------------

For the instance to access the metadata service,
you must disable the default zeroconf route:

.. code-block:: console

   # echo "NOZEROCONF=yes" >> /etc/sysconfig/network

Configure console
-----------------

For the :command:`nova console-log` command to work properly
on Fedora, you might need to do the following steps:

#. Edit the ``/etc/default/grub`` file and configure the
   ``GRUB_CMDLINE_LINUX`` option. Delete the ``rhgb quiet``
   and add ``console=tty0 console=ttyS0,115200n8`` to the option.
   For example:

   .. code-block:: none

     ...
     GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap console=tty0 console=ttyS0,115200n8"

#. Run the following command to save the changes:

   .. code-block:: console

     # grub2-mkconfig -o /boot/grub2/grub.cfg
     Generating grub configuration file ...
     Found linux image: /boot/vmlinuz-4.10.10-200.fc25.x86_64
     Found initrd image: /boot/initramfs-4.10.10-200.fc25.x86_64.img
     Found linux image: /boot/vmlinuz-0-rescue-c613978614c7426ea3e550527f63710c
     Found initrd image: /boot/initramfs-0-rescue-c613978614c7426ea3e550527f63710c.img
     done

Shut down the instance
----------------------

From inside the instance, run as root:

.. code-block:: console

   # poweroff

Clean up (remove MAC address details)
-------------------------------------

The operating system records the MAC address of the virtual Ethernet
card in locations such as ``/etc/sysconfig/network-scripts/ifcfg-eth0``
during the instance process. However, each time the image boots up, the virtual
Ethernet card will have a different MAC address, so this information must
be deleted from the configuration file.

There is a utility called :command:`virt-sysprep`, that performs
various cleanup tasks such as removing the MAC address references.
It will clean up a virtual machine image in place:

.. code-block:: console

   # virt-sysprep -d fedora

Undefine the libvirt domain
---------------------------

Now that you can upload the image to the Image service, you no
longer need to have this virtual machine image managed by libvirt.
Use the :command:`virsh undefine vm-image` command to inform libvirt:

.. code-block:: console

   # virsh undefine fedora

Image is complete
-----------------

The underlying image file that you created with the
:command:`qemu-img create` command is ready to be uploaded.
For example, you can upload the ``/tmp/fedora.qcow2``
image to the Image service by using the :command:`openstack image create`
command. For more information, see the
`python-openstackclient command list
<https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/image.html>`__.
