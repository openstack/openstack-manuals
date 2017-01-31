===========================
Image service property keys
===========================

The following keys, together with the components to which they are specific,
can be used with the property option for both the
:command:`openstack image set` and :command:`openstack image create` commands.
For example:

.. code-block:: console

   $ openstack image set IMG-UUID --property architecture=x86_64

.. note::

   Behavior set using image properties overrides behavior set using flavors.
   For more information, refer to the `Manage images
   <https://docs.openstack.org/admin-guide/common/cli-manage-images.html>`_
   in the OpenStack Administrator Guide.

.. list-table:: Image service property keys
   :widths: 15 35 50 90
   :header-rows: 1

   * - Specific to
     - Key
     - Description
     - Supported values
   * - All
     - ``architecture``
     - The CPU architecture that must be supported by the hypervisor. For
       example, ``x86_64``, ``arm``, or ``ppc64``. Run :command:`uname -m`
       to get the architecture of a machine. We strongly recommend using
       the architecture data vocabulary defined by the `libosinfo project
       <http://libosinfo.org/>`_ for this purpose.
     - * ``alpha`` - `DEC 64-bit RISC
         <https://en.wikipedia.org/wiki/DEC_Alpha>`_
       * ``armv7l`` - `ARM Cortex-A7 MPCore
         <https://en.wikipedia.org/wiki/ARM_architecture>`_
       * ``cris`` - `Ethernet, Token Ring, AXis—Code Reduced Instruction
         Set <https://en.wikipedia.org/wiki/ETRAX_CRIS>`_
       * ``i686`` - `Intel sixth-generation x86 (P6 micro architecture)
         <https://en.wikipedia.org/wiki/X86>`_
       * ``ia64`` - `Itanium <https://en.wikipedia.org/wiki/Itanium>`_
       * ``lm32`` - `Lattice Micro32
         <https://en.wikipedia.org/wiki/Milkymist>`_
       * ``m68k`` - `Motorola 68000
         <https://en.wikipedia.org/wiki/Motorola_68000_family>`_
       * ``microblaze`` - `Xilinx 32-bit FPGA (Big Endian)
         <https://en.wikipedia.org/wiki/MicroBlaze>`_
       * ``microblazeel`` - `Xilinx 32-bit FPGA (Little Endian)
         <https://en.wikipedia.org/wiki/MicroBlaze>`_
       * ``mips`` - `MIPS 32-bit RISC (Big Endian)
         <https://en.wikipedia.org/wiki/MIPS_architecture>`_
       * ``mipsel`` - `MIPS 32-bit RISC (Little Endian)
         <https://en.wikipedia.org/wiki/MIPS_architecture>`_
       * ``mips64`` - `MIPS 64-bit RISC (Big Endian)
         <https://en.wikipedia.org/wiki/MIPS_architecture>`_
       * ``mips64el`` - `MIPS 64-bit RISC (Little Endian)
         <https://en.wikipedia.org/wiki/MIPS_architecture>`_
       * ``openrisc`` - `OpenCores RISC
         <https://en.wikipedia.org/wiki/OpenRISC#QEMU_support>`_
       * ``parisc`` - `HP Precision Architecture RISC
         <https://en.wikipedia.org/wiki/PA-RISC>`_
       * parisc64 - `HP Precision Architecture 64-bit RISC
         <https://en.wikipedia.org/wiki/PA-RISC>`_
       * ppc - `PowerPC 32-bit <https://en.wikipedia.org/wiki/PowerPC>`_
       * ppc64 - `PowerPC 64-bit <https://en.wikipedia.org/wiki/PowerPC>`_
       * ppcemb - `PowerPC (Embedded 32-bit)
         <https://en.wikipedia.org/wiki/PowerPC>`_
       * s390 - `IBM Enterprise Systems Architecture/390
         <https://en.wikipedia.org/wiki/S390>`_
       * s390x - `S/390 64-bit <https://en.wikipedia.org/wiki/S390x>`_
       * sh4 - `SuperH SH-4 (Little Endian)
         <https://en.wikipedia.org/wiki/SuperH>`_
       * sh4eb - `SuperH SH-4 (Big Endian)
         <https://en.wikipedia.org/wiki/SuperH>`_
       * sparc - `Scalable Processor Architecture, 32-bit
         <https://en.wikipedia.org/wiki/Sparc>`_
       * sparc64 - `Scalable Processor Architecture, 64-bit
         <https://en.wikipedia.org/wiki/Sparc>`_
       * unicore32 - `Microprocessor Research and Development Center RISC
         Unicore32 <https://en.wikipedia.org/wiki/Unicore>`_
       * x86_64 - `64-bit extension of IA-32
         <https://en.wikipedia.org/wiki/X86>`_
       * xtensa - `Tensilica Xtensa configurable microprocessor core
         <https://en.wikipedia.org/wiki/Xtensa#Processor_Cores>`_
       * xtensaeb - `Tensilica Xtensa configurable microprocessor core
         <https://en.wikipedia.org/wiki/Xtensa#Processor_Cores>`_ (Big Endian)
   * - All
     - ``hypervisor_type``
     - The hypervisor type. Note that ``qemu`` is used for both QEMU and KVM
       hypervisor types.
     - ``hyperv``, ``ironic``, ``lxc``, ``qemu``, ``uml``, ``vmware``, or
       ``xen``.
   * - All
     - ``instance_type_rxtx_factor``
     - Optional property allows created servers to have a different bandwidth
       cap than that defined in the network they are attached to. This factor
       is multiplied by the ``rxtx_base`` property of the network. The
       ``rxtx_base`` property defaults to ``1.0``, which is the same as the
       attached network. This parameter is only available for Xen or NSX based
       systems.
     - Float (default value is ``1.0``)
   * - All
     - ``instance_uuid``
     - For snapshot images, this is the UUID of the server used to create this
       image.
     - Valid server UUID
   * - All
     - ``img_config_drive``
     - Specifies whether the image needs a config drive.
     - ``mandatory`` or ``optional`` (default if property is not used).
   * - All
     - ``kernel_id``
     - The ID of an image stored in the Image service that should be used as
       the kernel when booting an AMI-style image.
     - Valid image ID
   * - All
     - ``os_distro``
     - The common name of the operating system distribution in lowercase
       (uses the same data vocabulary as the
       `libosinfo project`_). Specify only a recognized
       value for this field. Deprecated values are listed to assist you in
       searching for the recognized value.
     - * ``arch`` - Arch Linux. Do not use ``archlinux`` or ``org.archlinux``.
       * ``centos`` - Community Enterprise Operating System. Do not use
         ``org.centos`` or ``CentOS``.
       * ``debian`` - Debian. Do not use ``Debian` or ``org.debian``.
       * ``fedora`` - Fedora. Do not use ``Fedora``, ``org.fedora``, or
         ``org.fedoraproject``.
       * ``freebsd`` - FreeBSD. Do not use ``org.freebsd``, ``freeBSD``, or
         ``FreeBSD``.
       * ``gentoo`` - Gentoo Linux. Do not use ``Gentoo`` or ``org.gentoo``.
       * ``mandrake`` - Mandrakelinux (MandrakeSoft) distribution. Do not use
         ``mandrakelinux`` or ``MandrakeLinux``.
       * ``mandriva`` - Mandriva Linux. Do not use ``mandrivalinux``.
       * ``mes`` - Mandriva Enterprise Server. Do not use ``mandrivaent`` or
         ``mandrivaES``.
       * ``msdos`` - Microsoft Disc Operating System. Do not use ``ms-dos``.
       * ``netbsd`` - NetBSD. Do not use ``NetBSD`` or ``org.netbsd``.
       * ``netware`` - Novell NetWare. Do not use ``novell`` or ``NetWare``.
       * ``openbsd`` - OpenBSD. Do not use ``OpenBSD`` or ``org.openbsd``.
       * ``opensolaris`` - OpenSolaris. Do not use ``OpenSolaris`` or
         ``org.opensolaris``.
       * ``opensuse`` - openSUSE. Do not use ``suse``, ``SuSE``, or
         `` org.opensuse``.
       * ``rhel`` - Red Hat Enterprise Linux. Do not use ``redhat``, ``RedHat``,
         or ``com.redhat``.
       * ``sled`` - SUSE Linux Enterprise Desktop. Do not use ``com.suse``.
       * ``ubuntu`` - Ubuntu. Do not use ``Ubuntu``, ``com.ubuntu``,
         ``org.ubuntu``, or ``canonical``.
       * ``windows`` - Microsoft Windows. Do not use ``com.microsoft.server``
         or ``windoze``.
   * - All
     - ``os_version``
     - The operating system version as specified by the distributor.
     - Valid version number (for example, ``11.10``).
   * - All
     - ``os_secure_boot``
     - Secure Boot is a security standard. When the instance starts,
       Secure Boot first examines software such as firmware and OS by their
       signature and only allows them to run if the signatures are valid.

       For Hyper-V: Images must be prepared as Generation 2 VMs. Instance must
       also contain ``hw_machine_type=hyperv-gen2`` image property. Linux
       guests will also require bootloader's digital signature provided as
       ``os_secure_boot_signature`` and
       ``hypervisor_version_requires'>=10.0'`` image properties.
     - * ``required`` - Enable the Secure Boot feature.
       * ``disabled`` or ``optional`` - (default) Disable the Secure Boot
         feature.
   * - All
     - ``ramdisk_id``
     - The ID of image stored in the Image service that should be used as the
       ramdisk when booting an AMI-style image.
     - Valid image ID.
   * - All
     - ``vm_mode``
     - The virtual machine mode. This represents the host/guest ABI
       (application binary interface) used for the virtual machine.
     - * ``hvm`` - Fully virtualized. This is the mode used by QEMU and KVM.
       * ``xen`` - Xen 3.0 paravirtualized.
       * ``uml`` - User Mode Linux paravirtualized.
       * ``exe`` - Executables in containers. This is the mode used by LXC.
   * - libvirt API driver
     - ``hw_cpu_sockets``
     - The preferred number of sockets to expose to the guest.
     - Integer.
   * - libvirt API driver
     - ``hw_cpu_cores``
     - The preferred number of cores to expose to the guest.
     - Integer.
   * - libvirt API driver
     - ``hw_cpu_threads``
     - The preferred number of threads to expose to the guest.
     - Integer.
   * - libvirt API driver
     - ``hw_disk_bus``
     - Specifies the type of disk controller to attach disk devices to.
     - One of ``scsi``, ``virtio``, ``uml``, ``xen``, ``ide``, or ``usb``.
   * - libvirt API driver
     - ``hw_rng_model``
     - Adds a random-number generator device to the image's instances. The
       cloud administrator can enable and control device behavior by
       configuring the instance's flavor. By default:

       * The generator device is disabled.
       * ``/dev/random`` is used as the default entropy source. To specify a
         physical HW RNG device, use the following option in the nova.conf
         file:

       .. code-block:: ini

          rng_dev_path=/dev/hwrng

     - ``virtio``, or other supported device.
   * - libvirt API driver, Hyper-V driver
     - ``hw_machine_type``
     - For libvirt: Enables booting an ARM system using the specified machine
       type. By default, if an ARM image is used and its type is not specified,
       Compute uses ``vexpress-a15`` (for ARMv7) or ``virt`` (for AArch64)
       machine types.

       For Hyper-V: Specifies whether the Hyper-V instance will be a generation
       1 or generation 2 VM. By default, if the property is not provided, the
       instances will be generation 1 VMs. If the image is specific for
       generation 2 VMs but the property is not provided accordingly, the
       instance will fail to boot.
     - For libvirt: Valid types can be viewed by using the
       :command:`virsh capabilities` command (machine types are displayed in
       the ``machine`` tag).

       For hyper-V: Acceptable values are either ``hyperv-gen1`` or
       ``hyperv-gen2``.
   * - libvirt API driver
     - ``hw_scsi_model``
     - Enables the use of VirtIO SCSI (``virtio-scsi``) to provide block
       device access for compute instances; by default, instances use VirtIO
       Block (``virtio-blk``). VirtIO SCSI is a para-virtualized SCSI
       controller device that provides improved scalability and performance,
       and supports advanced SCSI hardware.
     - ``virtio-scsi``
   * - libvirt API driver
     - ``hw_serial_port_count``
     - Specifies the count of serial ports that should be provided. If
       ``hw:serial_port_count`` is not set in the flavor's extra_specs, then
       any count is permitted. If ``hw:serial_port_count`` is set, then this
       provides the default serial port count. It is permitted to override the
       default serial port count, but only with a lower value.
     - Integer
   * - libvirt API driver
     - ``hw_video_model``
     - The video image driver used.
     - ``vga``, ``cirrus``, ``vmvga``, ``xen``, or ``qxl``.
   * - libvirt API driver
     - ``hw_video_ram``
     - Maximum RAM for the video image. Used only if a ``hw_video:ram_max_mb``
       value has been set in the flavor's extra_specs and that value is higher
       than the value set in ``hw_video_ram``.
     - Integer in MB (for example, ``64``).
   * - libvirt API driver
     - ``hw_watchdog_action``
     - Enables a virtual hardware watchdog device that carries out the
       specified action if the server hangs. The watchdog uses the
       ``i6300esb`` device (emulating a PCI Intel 6300ESB). If
       ``hw_watchdog_action`` is not specified, the watchdog is disabled.
     - * ``disabled`` - (default) The device is not attached. Allows the user to
         disable the watchdog for the image, even if it has been enabled using
         the image's flavor.
       * ``reset`` - Forcefully reset the guest.
       * ``poweroff`` - Forcefully power off the guest.
       * ``pause`` - Pause the guest.
       * ``none`` - Only enable the watchdog; do nothing if the server hangs.
   * - libvirt API driver
     - ``os_command_line``
     - The kernel command line to be used by the ``libvirt`` driver, instead
       of the default. For Linux Containers (LXC), the value is used as
       arguments for initialization. This key is valid only for Amazon kernel,
       ``ramdisk``, or machine images (``aki``, ``ari``, or ``ami``).
     -
   * - libvirt API driver and VMware API driver
     - ``hw_vif_model``
     - Specifies the model of virtual network interface device to use.
     - The valid options depend on the configured hypervisor.
        * ``KVM`` and ``QEMU``: ``e1000``, ``ne2k_pci``, ``pcnet``,
          ``rtl8139``, and ``virtio``.
        * VMware: ``e1000``, ``e1000e``, ``VirtualE1000``, ``VirtualE1000e``,
          ``VirtualPCNet32``, ``VirtualSriovEthernetCard``, and
          ``VirtualVmxnet``.
        * Xen: ``e1000``, ``netfront``, ``ne2k_pci``, ``pcnet``, and
          ``rtl8139``.
   * - libvirt API driver
     - ``hw_vif_multiqueue_enabled``
     - If ``true``, this enables the ``virtio-net multiqueue`` feature. In
       this case, the driver sets the number of queues equal to the number
       of guest vCPUs. This makes the network performance scale across a
       number of vCPUs.
     - ``true`` | ``false``
   * - libvirt API driver
     - ``hw_boot_menu``
     - If ``true``, enables the BIOS bootmenu. In cases where both the image
       metadata and Extra Spec are set, the Extra Spec setting is used. This
       allows for flexibility in setting/overriding the default behavior as
       needed.
     - ``true`` or ``false``
   * - VMware API driver
     - ``vmware_adaptertype``
     - The virtual SCSI or IDE controller used by the hypervisor.
     - ``lsiLogic``, ``lsiLogicsas``, ``busLogic``, ``ide``, or
       ``paraVirtual``.
   * - VMware API driver
     - ``vmware_ostype``
     - A VMware GuestID which describes the operating system installed in
       the image. This value is passed to the hypervisor when creating a
       virtual machine. If not specified, the key defaults to ``otherGuest``.
     - See `thinkvirt.com <http://www.thinkvirt.com/?q=node/181>`_.
   * - VMware API driver
     - ``vmware_image_version``
     - Currently unused.
     - ``1``
   * - XenAPI driver
     - ``auto_disk_config``
     - If ``true``, the root partition on the disk is automatically resized
       before the instance boots. This value is only taken into account by
       the Compute service when using a Xen-based hypervisor with the
       ``XenAPI`` driver. The Compute service will only attempt to resize if
       there is a single partition on the image, and only if the partition
       is in ``ext3`` or ``ext4`` format.
     - ``true`` or ``false``
   * - XenAPI driver
     - ``os_type``
     - The operating system installed on the image. The ``XenAPI`` driver
       contains logic that takes different actions depending on the value of
       the ``os_type`` parameter of the image. For example, for
       ``os_type=windows`` images, it creates a FAT32-based swap partition
       instead of a Linux swap partition, and it limits the injected host
       name to less than 16 characters.
     - ``linux`` or ``windows``.
