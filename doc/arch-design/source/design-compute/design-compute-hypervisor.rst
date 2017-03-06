======================
Choosing a hypervisor
======================

A hypervisor provides software to manage virtual machine access to the
underlying hardware. The hypervisor creates, manages, and monitors
virtual machines. OpenStack Compute (nova) supports many hypervisors to various
degrees, including:

* `KVM <http://www.linux-kvm.org/page/Main_Page>`_
* `LXC <https://linuxcontainers.org/>`_
* `QEMU <http://wiki.qemu.org/Main_Page>`_
* `VMware ESX/ESXi <https://www.vmware.com/support/vsphere-hypervisor>`_
* `Xen <http://www.xenproject.org/>`_
* `Hyper-V <http://technet.microsoft.com/en-us/library/hh831531.aspx>`_
* `Docker <https://www.docker.com/>`_

An important factor in your choice of hypervisor is your current organization's
hypervisor usage or experience. Also important is the hypervisor's feature
parity, documentation, and the level of community experience.

As per the recent OpenStack user survey, KVM is the most widely adopted
hypervisor in the OpenStack community. Besides KVM, there are many deployments
that run other hypervisors such as LXC, VMware, Xen and Hyper-V. However, these
hypervisors are either less used, are niche hypervisors, or have limited
functionality based on the more commonly used hypervisors. This is due to gaps
in feature parity.

In addition, the nova configuration reference below details feature support for
hypervisors as well as ironic and Virtuozzo (formerly Parallels).

The best information available to support your choice is found on the
`Hypervisor Support Matrix
<https://docs.openstack.org/developer/nova/support-matrix.html>`_
and in the `configuration reference
<https://docs.openstack.org/mitaka/config-reference/compute/hypervisors.html>`_.

.. note::

   It is also possible to run multiple hypervisors in a single
   deployment using host aggregates or cells. However, an individual
   compute node can run only a single hypervisor at a time.
