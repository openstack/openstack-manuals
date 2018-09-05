======================
Choosing a hypervisor
======================

A hypervisor provides software to manage virtual machine access to the
underlying hardware. The hypervisor creates, manages, and monitors
virtual machines. OpenStack Compute (nova) supports many hypervisors to various
degrees, including:

* `Ironic <https://docs.openstack.org/ironic/latest/>`_
* `KVM <https://www.linux-kvm.org/page/Main_Page>`_
* `LXC <https://linuxcontainers.org/>`_
* `QEMU <https://wiki.qemu.org/Main_Page>`_
* `VMware ESX/ESXi <https://www.vmware.com/support/vsphere-hypervisor.html>`_
* `Xen (using libvirt) <https://www.xenproject.org>`_
* `XenServer <https://xenserver.org>`_
* `Hyper-V
  <https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-technology-overview>`_
* `PowerVM <https://www.ibm.com/us-en/marketplace/ibm-powervm>`_
* `UML <http://user-mode-linux.sourceforge.net>`_
* `Virtuozzo <https://www.virtuozzo.com/products/vz7.html>`_
* `zVM <https://www.ibm.com/it-infrastructure/z/zvm>`_

An important factor in your choice of hypervisor is your current organization's
hypervisor usage or experience. Also important is the hypervisor's feature
parity, documentation, and the level of community experience.

As per the recent OpenStack user survey, KVM is the most widely adopted
hypervisor in the OpenStack community. Besides KVM, there are many deployments
that run other hypervisors such as LXC, VMware, Xen, and Hyper-V. However,
these hypervisors are either less used, are niche hypervisors, or have limited
functionality compared to more commonly used hypervisors.

.. note::

   It is also possible to run multiple hypervisors in a single
   deployment using host aggregates or cells. However, an individual
   compute node can run only a single hypervisor at a time.

For more information about feature support for
hypervisors as well as ironic and Virtuozzo (formerly Parallels), see
`Hypervisor Support Matrix
<https://docs.openstack.org/nova/latest/user/support-matrix.html>`_
and `Hypervisors
<https://docs.openstack.org/ocata/config-reference/compute/hypervisors.html>`_
in the Configuration Reference.
