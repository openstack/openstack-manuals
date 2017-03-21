======================
Choosing a hypervisor
======================

A hypervisor provides software to manage virtual machine access to the
underlying hardware. The hypervisor creates, manages, and monitors
virtual machines. OpenStack Compute (nova) supports many hypervisors to various
degrees, including:

* `KVM <https://www.linux-kvm.org/page/Main_Page>`_
* `LXC <https://linuxcontainers.org/>`_
* `QEMU <https://wiki.qemu.org/Main_Page>`_
* `VMware ESX/ESXi <https://www.vmware.com/support/vsphere-hypervisor>`_
* `Xen <https://www.xenproject.org/>`_
* `Hyper-V <https://technet.microsoft.com/en-us/library/hh831531.aspx>`_
* `Docker <https://www.docker.com/>`_

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
<https://docs.openstack.org/developer/nova/support-matrix.html>`_
and `Hypervisors
<https://docs.openstack.org/ocata/config-reference/compute/hypervisors.html>`_
in the Configuration Reference.
