============================
Example: CentOS Stream image
============================

This example shows you how to install a CentOS Stream image and focuses
mainly on CentOS Stream 9. Because the CentOS installation process
might differ across versions, the installation steps might
differ if you use a different version of CentOS.

.. contents:: :depth: 3

.. note::
   This is just an example, adjust paths and commands according to your
   environment

Download a CentOS install ISO
-----------------------------

* Navigate to the `CentOS mirrors
  <https://mirrormanager.fedoraproject.org/mirrors/CentOS>`_ page.
* Choose one of the mirrors and navigate to ``9-stream/BaseOS/x86_64/iso``.
  Download a ISO, choose ``boot`` to download packages during install,
  otherwise choose ``dvd``

Start the installation process
------------------------------

Start the installation process using either the :command:`virt-manager`
or the :command:`virt-install` command as described in the
`Tools: libvirt and virsh/virt-manager <https://docs.openstack.org/image-guide/create-images-manually-tools-libvirt.html>`_
page.

virt-install
~~~~~~~~~~~~

If you use the :command:`virt-install` command, do not forget to connect your
VNC client to the virtual machine.

The command should look something like this:

.. code-block:: console

   $ sudo virt-install --virt-type kvm --name my-centos --ram 2048 \
     --network network=default \
     --graphics vnc,listen=0.0.0.0 --noautoconsole \
     --os-type=linux --os-variant=centos-stream9 \
     --location=~/Downloads/CentOS-Stream-9-20240819.0-x86_64-dvd1.iso

virt-manager
~~~~~~~~~~~~

.. note::

   `See here <https://wiki.libvirt.org/CreatingNewVM_in_VirtualMachineManager.html>`_
   for libvirt wiki about new VM creation in virt-manager

When creating a new VM from the downloaded ISO, :command:`virt-manager` should
automatically detect the OS. If it fails, manually select CentOS Stream as OS.
Default settings should be fine.

Step through the installation
-----------------------------

.. note::
   This guide focuses on the steps specific to create a OpenStack image, for a
   general overview of installation process see `CentOS Documentation
   <https://docs.centos.org/en-US/docs>`_

In ``Installation Summary`` follow the instructions below.

DHCP and hostname
~~~~~~~~~~~~~~~~~

In ``Network & Host Name`` ensure that ``Ethernet`` is on and in
``Configure.../IPv4 Settings`` the ``Method`` is set to ``Automatic (DHCP)``.
The same page allows for host name selection - leave it to default as the
``cloud-init`` package will be installed later.

Select installation option
~~~~~~~~~~~~~~~~~~~~~~~~~~

In ``Software Selection`` choose what to install, the default is ``Server with
GUI``, the smallest choice is ``Minimal Install``.

Create a working user
~~~~~~~~~~~~~~~~~~~~~

Configure a root password in ``Root Password``, as this will be needed later to
finalize the installation. By default it will be then blocked by cloud-init. It
is also possible to create an adiministrator user, as it will be later deleted
by virt-sysprep.

Detach the CD-ROM and reboot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**virt-install**

To eject a disk by using the :command:`virsh` command,
libvirt requires that you attach an empty disk at the same target
that the CD-ROM was previously attached, which may be ``hda``.
You can confirm the appropriate target using the
:command:`virsh dumpxml vm-image` command.

.. code-block:: console

   $ sudo virsh dumpxml my-centos
   <domain type='kvm' id='19'>
     <name>centos</name>
   ...
       <disk type='block' device='cdrom'>
         <driver name='qemu' type='raw'/>
         <target dev='hda' bus='ide'/>
         <readonly/>
         <address type='drive' controller='0' bus='1' target='0' unit='0'/>
       </disk>
   ...
   </domain>

Run the following commands from the host to eject the disk
and reboot using ``virsh``, as root.

.. code-block:: console

   $ sudo virsh attach-disk --type cdrom --mode readonly my-centos "" hda
   $ sudo virsh reboot my-centos

**virt-manager**

If you are using ``virt-manager``, the commands above will work, but you can
also use the GUI to detach and reboot.

Finalize installation
---------------------

Install the ACPI service
~~~~~~~~~~~~~~~~~~~~~~~~

To enable the hypervisor to reboot or shutdown an instance,
you must install and run the ``acpid`` service on the guest system.

Log in to the CentOS guest and run the following commands
to install the ACPI service and configure it to start when the
system boots:

.. code-block:: console

   # dnf install acpid
   # systemctl enable acpid

Configure to fetch metadata
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::
   Check `cloud-init documentation <https://cloudinit.readthedocs.io>`_ for
   more information

An instance must interact with the metadata service to perform
several tasks on start up. For example, the instance must get
the ssh public key and run the user data script. To ensure that
the instance performs these tasks, install the ``cloud-init`` utility.

The ``cloud-init`` package automatically fetches the public key
from the metadata server and places the key in an account.
Install ``cloud-init`` inside the CentOS guest by
running:

.. code-block:: console

   # dnf install cloud-init

The account varies by distribution. On CentOS Stream virtual machines,
the account is called ``cloud-user``.

You can change the name of the account used by ``cloud-init``
by editing the ``/etc/cloud/cloud.cfg`` file and adding a line
with a different user. For example, to configure ``cloud-init``
to put the key in an account named ``admin``, use the following
syntax in the configuration file:

.. code-block:: console

   users:
     - name: admin
       (...)

Cloud-init alternatives
~~~~~~~~~~~~~~~~~~~~~~~

.. warning::
   This method is not recommended as only gets the ssh public key from the
   metadata server. It does not get user data, which is optional
   data that can be passed by the user when requesting a new instance.
   User data is often used to run a custom script when an instance boots.

If you are not able to install the ``cloud-init`` package in your
image, to fetch the ssh public key and add it to the root account,
edit the ``/etc/rc.d/rc.local`` file and add the following lines
before the line ``touch /var/lock/subsys/local``:

.. code-block:: bash

   if [ ! -d /root/.ssh ]; then
     mkdir -p /root/.ssh
     chmod 700 /root/.ssh
   fi

   # Fetch public key using HTTP
   ATTEMPTS=30
   FAILED=0
   while [ ! -f /root/.ssh/authorized_keys ]; do
     curl -f http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key \
       > /tmp/metadata-key 2>/dev/null
     if [ \$? -eq 0 ]; then
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
     fi
   done

.. note::

   Some VNC clients replace the colon (``:``) with a semicolon
   (``;``) and the underscore (``_``) with a hyphen (``-``).
   Make sure to specify ``http:`` and not ``http;``.
   Make sure to specify ``authorized_keys`` and not ``authorized-keys``.

.. note::

   With this method, previous CentOS versions needed to disable the zeroconf
   route, this is not needed `as of EL8
   <https://access.redhat.com/solutions/5692821>`_.

Allow partitions to resize
~~~~~~~~~~~~~~~~~~~~~~~~~~

In order for the root partition to properly resize, install the
``cloud-utils-growpart`` package, which contains the proper tools
to allow the disk to resize using cloud-init.

.. code-block:: console

   # dnf install cloud-utils-growpart

Configure console
~~~~~~~~~~~~~~~~~

.. warning::
   Actually this does not work even following https://access.redhat.com/solutions/3443551

For the :command:`openstack console log` command to work properly, instance
must be configured to sent output to a serial console.

#. Edit the ``/etc/default/grub`` file and append
   ``console=tty0 console=ttyS0,115200n8`` to ``GRUB_CMDLINE_LINUX``.

   For example:

   .. code-block:: none

     ...
     GRUB_CMDLINE_LINUX="resume=/dev/mapper/cs-swap rd.lvm.lv=cs/root rd.lvm.lv=cs/swap console=tty0 console=ttyS0,115200n8"

#. Then regenerate GRUB configuration:

   .. code-block:: console

     # grub2-mkconfig -o /boot/grub2/grub.cfg --update-bls-cmdline

Customize
~~~~~~~~~

If you are building an image manually, you are probably interested in
customizing it, now it's time to apply your edits.

Shut down the instance
~~~~~~~~~~~~~~~~~~~~~~

Shutdown the VM:

.. code-block:: console

   # shutdown now

Clean up
--------

The image needs to be cleaned up of details such as the MAC address - the tool
used is `virt-sysprep <https://libguestfs.org/virt-sysprep.1.html>`_, part of `libguestfs <https://libguestfs.org>`_

.. code-block:: console

   sudo virt-sysprep -d my-centos

Resize the image
----------------

Resize and compress the image to remove unused space (the image will then use
available space after initialization) using `virt-sparsify <https://libguestfs.org/virt-sparsify.1.html>`_, part of
`libguestfs <https://libguestfs.org>`_

.. code-block:: console

   sudo virt-sparsify --compress /var/lib/libvirt/images/my-centos.qcow2 ~/upload.qcow2

Image is complete
-----------------

The resized image is now ready to be uploaded using
:command:`openstack image create`. For more information, see the
`python-openstackclient command list
<https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/image.html>`__.


Undefine the libvirt domain
---------------------------

Now that you can upload the image to the Image service, you no
longer need to have this virtual machine image managed by libvirt.

.. code-block:: console

   $ sudo virsh undefine my-centos

Or if you used :command:`virt-manager`, delete it through the GUI.

