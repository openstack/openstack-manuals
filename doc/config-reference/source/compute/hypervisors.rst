===========
Hypervisors
===========

.. toctree::
   :maxdepth: 1

   hypervisor-basics.rst
   hypervisor-kvm.rst
   hypervisor-qemu.rst
   hypervisor-xen-api.rst
   hypervisor-xen-libvirt.rst
   hypervisor-lxc.rst
   hypervisor-vmware.rst
   hypervisor-hyper-v.rst
   hypervisor-virtuozzo.rst

OpenStack Compute supports many hypervisors, which might make it difficult
for you to choose one. Most installations use only one hypervisor.
However, you can use :ref:`ComputeFilter` and :ref:`ImagePropertiesFilter`
to schedule different hypervisors within the same installation.
The following links help you choose a hypervisor.
See https://docs.openstack.org/developer/nova/support-matrix.html
for a detailed list of features and support across the hypervisors.

The following hypervisors are supported:

* `KVM <http://www.linux-kvm.org/page/Main_Page>`_ -
  Kernel-based Virtual Machine. The virtual disk formats that it
  supports is inherited from QEMU since it uses a modified QEMU
  program to launch the virtual machine. The supported formats
  include raw images, the qcow2, and VMware formats.

* `LXC <https://linuxcontainers.org/>`_ - Linux Containers
  (through libvirt), used to run Linux-based virtual machines.

* `QEMU <http://wiki.qemu.org/Manual>`_ - Quick EMUlator,
  generally only used for development purposes.

* `UML <http://user-mode-linux.sourceforge.net/>`_ - User Mode Linux,
  generally only used for development purposes.

* `VMware vSphere
  <https://www.vmware.com/support/vsphere-hypervisor>`_
  5.1.0 and newer, runs VMware-based Linux and Windows images through a
  connection with a vCenter server.

* `Xen (using libvirt) <http://www.xenproject.org>`_ - Xen Project
  Hypervisor using libvirt as management interface into ``nova-compute``
  to run Linux, Windows, FreeBSD and NetBSD virtual machines.

* `XenServer <http://xenserver.org>`_ - XenServer,
  Xen Cloud Platform (XCP) and other XAPI based Xen variants runs Linux
  or Windows virtual machines. You must install the ``nova-compute``
  service in a para-virtualized VM.

* `Hyper-V <http://www.microsoft.com/en-us/server-cloud/solutions/
  virtualization.aspx>`_ - Server virtualization with Microsoft Hyper-V,
  use to run Windows, Linux, and FreeBSD virtual machines.
  Runs ``nova-compute`` natively on the Windows virtualization platform.

* `Virtuozzo <https://virtuozzo.com/products/#product-virtuozzo/>`_
  7.0.0 and newer - OS Containers and Kernel-based Virtual Machines
  supported via libvirt virt_type=parallels. The supported formats
  include ploop and qcow2 images.
