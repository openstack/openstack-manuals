=====================
Example: Fedora image
=====================

Download a `Fedora <http://getfedora.org/>`_ ISO image.
This procedure lets you create a Fedora 20 image.

#. Start the installation using :command:`virt-install` as shown below:

   .. code-block:: console

      # qemu-img create -f qcow2 fedora-20.qcow2 8G
      # virt-install --connect=qemu:///system --network=bridge:virbr0 \
        --extra-args="console=tty0 console=ttyS0,115200 serial rd_NO_PLYMOUTH" \
        --name=fedora-20 --disk path=/var/lib/libvirt/images/fedora-20.qcow2,format=qcow2,size=10,cache=none \
        --ram 2048 --vcpus=2 --check-cpu --accelerate --os-type linux --os-variant fedora19 \
        --hvm --location=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os/ \
        --nographics

   This will launch a VM and start the installation process.

   .. code-block:: console

      Starting install...
      Retrieving file .treeinfo...                      | 2.2 kB  00:00:00 !!!
      Retrieving file vmlinuz...                        | 9.8 MB  00:00:05 !!!
      Retrieving file initrd.img...                     |  66 MB  00:00:37 !!!
      Allocating 'fedora-20.qcow2'                      |  10 GB  00:00:00
      Creating domain...                                |    0 B  00:00:00
      Connected to domain fedora-20
      Escape character is ^]
      [    0.000000] Initializing cgroup subsys cpuset
      [    0.000000] Initializing cgroup subsys cpu
      [    0.000000] Initializing cgroup subsys cpuacct
      ...
      ...
      ...
      [  OK  ] Reached target Local File Systems (Pre).
      Starting installer, one moment...
      anaconda 20.25.15-1 for Fedora 20 started.
      ========================================================================
      ========================================================================

#. Choose the VNC or text mode to set the installation options.

   .. code-block:: console

      Text mode provides a limited set of installation options.
      It does not offer custom partitioning for full control over the
      disk layout. Would you like to use VNC mode instead?

      1) Start VNC

      2) Use text mode

      Please make your choice from above ['q' to quit | 'c' to continue |
      'r' to refresh]:

#. Set the timezone, network configuration, installation source,
   and the root password. Optionally, you can choose to create a user.

#. Set up the installation destination as shown below:

   .. code-block:: console

      ========================================================================
      Probing storage...
      Installation Destination

      [x] 1) Virtio Block Device: 10.24 GB (vda)

      1 disk selected; 10.24 GB capacity; 10.24 GB free ...

      Please make your choice from above ['q' to quit | 'c' to continue |
      'r' to refresh]: c
      ========================================================================
      ========================================================================
      Autopartitioning Options

      [ ] 1) Replace Existing Linux system(s)

      [x] 2) Use All Space

      [ ] 3) Use Free Space

      Installation requires partitioning of your hard drive. Select what space
      to use for the install target.

      Please make your choice from above ['q' to quit | 'c' to continue |
      'r' to refresh]: 2
      ========================================================================
      ========================================================================
      Autopartitioning Options

      [ ] 1) Replace Existing Linux system(s)

      [x] 2) Use All Space

      [ ] 3) Use Free Space

      Installation requires partitioning of your hard drive. Select what space
      to use for the install target.

      Please make your choice from above ['q' to quit | 'c' to continue |
      'r' to refresh]: c
      ========================================================================
      ========================================================================
      Partition Scheme Options

      [ ] 1) Standard Partition

      [x] 2) LVM

      [ ] 3) BTRFS

      Select a partition scheme configuration.

      Please make your choice from above ['q' to quit | 'c' to continue |
      'r' to refresh]: c
      Generating updated storage configuration
      Checking storage configuration...
      ========================================================================


#. Run the following commands from the host to eject the disk and
   reboot using the :command:`virsh` command, as root.

   .. code-block:: console

      # virsh attach-disk --type cdrom --mode readonly fedora-20 "" hdc
      # virsh destroy fedora-20
      # virsh start fedora-20

   You can also use the GUI to detach and reboot it by manually
   stopping and starting.

#. Log in as root user when you boot for the first time after installation.

#. Install and run the ``acpid`` service on the guest system to enable
   the virtual machine to reboot or shutdown an instance.

   Run the following commands inside the Fedora guest to install the
   ACPI service and configure it to start when the system boots:

   .. code-block:: console

      # yum install acpid
      # chkconfig acpid on

#. Install the ``cloud-init`` package inside the Fedora guest by adding
   the EPEL repo:

   The ``cloud-init`` package automatically fetches the public key
   from the metadata server and places the key in an account.

   .. code-block:: console

      # yum install http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
      # yum install cloud-init

   You can change the name of the account used by ``cloud-init``
   by editing the ``/etc/cloud/cloud.cfg`` file and adding a line with
   a different user. For example, to configure ``cloud-init`` to put the
   key in an account named admin, add this line to the configuration file:

   .. code-block:: console

      user: admin

#. Disable the default ``zeroconf`` route for the instance to access
   the metadata service:

   .. code-block:: console

      # echo "NOZEROCONF=yes" >> /etc/sysconfig/network

#. For the :command:`nova console-log` command to work properly on
   Fedora 20, you might need to add the following lines to
   the ``/boot/grub/menu.lst`` file:

   .. code-block:: console

      serial --unit=0 --speed=115200
      terminal --timeout=10 console serial
      # Edit the kernel line to add the console entries
      kernel ... console=tty0 console=ttyS0,115200n8

#. Shut down the instance from inside the instance as a root user:

   .. code-block:: console

      # /sbin/shutdown -h now

#. Clean up and remove MAC address details.

   The operating system records the MAC address of the virtual Ethernet
   card in locations such as ``/etc/sysconfig/network-scripts/ifcfg-eth0``
   and ``/etc/udev/rules.d/70-persistent-net.rules`` during the instance
   process. However, each time the image boots up, the virtual Ethernet
   card will have a different MAC address, so this information must be
   deleted from the configuration file.

   Use the :command:`virt-sysprep` utility. This performs various cleanup
   tasks such as removing the MAC address references.
   It will clean up a virtual machine image in place:

   .. code-block:: console

      # virt-sysprep -d fedora-20

#. Undefine the domain since you no longer need to have this
   virtual machine image managed by libvirt:

   .. code-block:: console

      # virsh undefine fedora-20

The underlying image file that you created with the
:command:`qemu-img create` command is ready to be uploaded to the
Image service by using the :command:`openstack image create`
command. For more information, see the
`Create or update an image
<https://docs.openstack.org/user-guide/common/cli-manage-images.html#create-or-update-an-image-glance>`__.
