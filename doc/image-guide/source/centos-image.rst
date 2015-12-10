=====================
Example: CentOS image
=====================

This example shows you how to install a CentOS image and focuses
mainly on CentOS 6.4. Because the CentOS installation process
might differ across versions, the installation steps might
differ if you use a different version of CentOS.

Download a CentOS install ISO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to the `CentOS mirrors
   <http://www.centos.org/download/mirrors/>`_ page.
#. Click one of the ``HTTP`` links in the right-hand
   column next to one of the mirrors.
#. Click the folder link of the CentOS version that
   you want to use. For example, ``6.4/``.
#. Click the ``isos/`` folder link.
#. Click the ``x86_64/`` folder link for 64-bit images.
#. Click the netinstall ISO image that you want to download.
   For example, ``CentOS-6.4-x86_64-netinstall.iso`` is a good
   choice because it is a smaller image that downloads missing
   packages from the Internet during installation.

Start the installation process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Start the installation process using either the :command:`virt-manager`
or the :command:`virt-install` command as described in the previous section.
If you use the :command:`virt-install` command, do not forget to connect your
VNC client to the virtual machine.

Assume that:

* The name of your virtual machine image is ``centos-6.4``;
  you need this name when you use :command:`virsh` commands
  to manipulate the state of the image.
* You saved the netinstall ISO image to the ``/data/isos`` directory.

If you use the :command:`virt-install` command, the commands should look
something like this:

.. code-block:: console

   # qemu-img create -f qcow2 /tmp/centos-6.4.qcow2 10G
   # virt-install --virt-type kvm --name centos-6.4 --ram 1024 \
     --disk /tmp/centos-6.4.qcow2,format=qcow2 \
     --network network=default \
     --graphics vnc,listen=0.0.0.0 --noautoconsole \
     --os-type=linux --os-variant=rhel6 \
     --extra-args="console=tty0 console=ttyS0,115200n8 serial" \
     --location=/data/isos/CentOS-6.4-x86_64-netinstall.iso

Step through the installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At the initial Installer boot menu, choose the
:guilabel:`Install or upgrade an existing system` option.
Step through the installation prompts. Accept the defaults.

.. figure:: figures/centos-install.png
   :width: 100%

Configure TCP/IP
~~~~~~~~~~~~~~~~

The default TCP/IP settings are fine.
In particular, ensure that ``Enable IPv4 support`` is enabled
with DHCP, which is the default.

.. figure:: figures/centos-tcpip.png
   :width: 100%

Point the installer to a CentOS web server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Choose URL as the installation method.

.. figure:: figures/centos-install-method.png
   :width: 100%

Depending on the version of CentOS, the net installer requires
the user to specify either a URL or the web site and
a CentOS directory that corresponds to one of the CentOS mirrors.
If the installer asks for a single URL, a valid URL might be
``http://mirror.umd.edu/centos/6/os/x86_64``.

.. note::

   Consider using other mirrors as an alternative to ``mirror.umd.edu``.

.. figure:: figures/centos-url-setup.png
   :width: 100%

If the installer asks for web site name and CentOS directory
separately, you might enter:

* Web site name: ``mirror.umd.edu``
* CentOS directory: ``centos/6/os/x86_64``

See `CentOS mirror page <http://www.centos.org/download/mirrors/>`_
to get a full list of mirrors, click on the ``HTTP`` link
of a mirror to retrieve the web site name of a mirror.

Storage devices
~~~~~~~~~~~~~~~

If prompted about which type of devices your installation uses,
choose :guilabel:`Basic Storage Devices`.

Hostname
~~~~~~~~

The installer may ask you to choose a host name.
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

If unsure, use the default partition scheme for the installer
because no scheme is better than another.

Step through the installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Step through the installation, using the default options.
The simplest thing to do is to choose the ``Basic Server`` install
(may be called ``Server`` install on older versions of CentOS),
which installs an SSH server.

Detach the CD-ROM and reboot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the installation has completed, the
:guilabel:`Congratulations, your CentOS installation is complete`
screen appears.

.. figure:: figures/centos-complete.png
   :width: 100%

To eject a disk by using the :command:`virsh` command,
libvirt requires that you attach an empty disk at the same target
that the CDROM was previously attached, which should be ``hdc``.
You can confirm the appropriate target using the
:command:`virsh dumpxml vm-image` command.

.. code-block:: console

   # virsh dumpxml centos-6.4
   <domain type='kvm'>
     <name>centos-6.4</name>
   ...
       <disk type='block' device='cdrom'>
         <driver name='qemu' type='raw'/>
         <target dev='hdc' bus='ide'/>
         <readonly/>
         <address type='drive' controller='0' bus='1' target='0' unit='0'/>
       </disk>
   ...
   </domain>

Run the following commands from the host to eject the disk
and reboot using ``virsh``, as root. If you are using ``virt-manager``,
the commands below will work, but you can also use the GUI to detach
and reboot it by manually stopping and starting.

.. code-block:: console

   # virsh attach-disk --type cdrom --mode readonly centos-6.4 "" hdc
   # virsh destroy centos-6.4
   # virsh start centos-6.4

Log in to newly created image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you boot for the first time after installation,
you might be prompted about authentication tools.
Select :guilabel:`Exit`. Then, log in as root.

Install the ACPI service
~~~~~~~~~~~~~~~~~~~~~~~~

To enable the hypervisor to reboot or shutdown an instance,
you must install and run the ``acpid`` service on the guest system.

Run the following commands inside the CentOS guest to install the
ACPI service and configure it to start when the system boots:

.. code-block:: console

   # yum install acpid
   # chkconfig acpid on

Configure to fetch metadata
~~~~~~~~~~~~~~~~~~~~~~~~~~~

An instance must interact with the metadata service to perform
several tasks on start up. For example, the instance must get
the ssh public key and run the user data script. To ensure that
the instance performs these tasks, use one of these methods:

* Install a ``cloud-init`` RPM, which is a port of the Ubuntu
  `cloud-init <https://launchpad.net/cloud-init>`_ package.
  This is the recommended approach.
* Modify the ``/etc/rc.local`` file to fetch desired information from
  the metadata service, as described in the next section.

Use cloud-init to fetch the public key
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``cloud-init`` package automatically fetches the public key
from the metadata server and places the key in an account.
You can install ``cloud-init`` inside the CentOS guest by
adding the EPEL repo:

.. code-block:: console

   # yum install http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
   # yum install cloud-init

The account varies by distribution. On Ubuntu-based virtual machines,
the account is called ``ubuntu``. On Fedora-based virtual machines,
the account is called ``ec2-user``.

You can change the name of the account used by ``cloud-init``
by editing the ``/etc/cloud/cloud.cfg`` file and adding a line
with a different user. For example, to configure ``cloud-init``
to put the key in an account named ``admin``, add this line
to the configuration file:

.. code-block:: console

   user: admin

Write a script to fetch the public key (if no cloud-init)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

   The previous script only gets the ssh public key from the
   metadata server. It does not get user data, which is optional
   data that can be passed by the user whenrequesting a new instance.
   User data is often used to run a custom script when an instance boots.

   As the OpenStack metadata service is compatible with version
   2009-04-04 of the Amazon EC2 metadata service, consult the
   Amazon EC2 documentation on `Using Instance Metadata
   <http://docs.amazonwebservices.com/AWSEC2/2009-04-04/UserGuide/
   AESDG-chapter-instancedata.html>`_ for details on how to get user data.

Disable the zeroconf route
~~~~~~~~~~~~~~~~~~~~~~~~~~

For the instance to access the metadata service,
you must disable the default zeroconf route:

.. code-block:: console

   # echo "NOZEROCONF=yes" >> /etc/sysconfig/network

Configure console
~~~~~~~~~~~~~~~~~

For the :command:`nova console-log` command to work properly
on CentOS 6.``x``, you might need to add the following lines
to the ``/boot/grub/menu.lst`` file:

.. code-block:: console

   serial --unit=0 --speed=115200
   terminal --timeout=10 console serial
   # Edit the kernel line to add the console entries
   kernel ... console=tty0 console=ttyS0,115200n8

Shut down the instance
~~~~~~~~~~~~~~~~~~~~~~

From inside the instance, as root:

.. code-block:: console

   # /sbin/shutdown -h now

Clean up (remove MAC address details)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The operating system records the MAC address of the virtual Ethernet
card in locations such as ``/etc/sysconfig/network-scripts/ifcfg-eth0``
and ``/etc/udev/rules.d/70-persistent-net.rules`` during the instance
process. However, each time the image boots up, the virtual Ethernet
card will have a different MAC address, so this information must
be deleted from the configuration file.

There is a utility called :command:`virt-sysprep`, that performs
various cleanup tasks such as removing the MAC address references.
It will clean up a virtual machine image in place:

.. code-block:: console

   # virt-sysprep -d centos-6.4

Undefine the libvirt domain
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that you can upload the image to the Image service, you no
longer need to have this virtual machine image managed by libvirt.
Use the :command:`virsh undefine vm-image` command to inform libvirt:

.. code-block:: console

   # virsh undefine centos-6.4

Image is complete
~~~~~~~~~~~~~~~~~

The underlying image file that you created with the
:command:`qemu-img create` command is ready to be uploaded.
For example, you can upload the ``/tmp/centos-6.4.qcow2``
image to the Image service.
