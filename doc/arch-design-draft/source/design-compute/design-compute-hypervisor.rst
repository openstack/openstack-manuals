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

Probably the most important factor in your choice of hypervisor is your
current usage or experience. Aside from that, there are practical
concerns to do with feature parity, documentation, and the level of
community experience.

For example, KVM is the most widely adopted hypervisor in the OpenStack
community. Besides KVM, more deployments run Xen, LXC, VMware, and
Hyper-V than the others listed. However, each of these are lacking some
feature support or the documentation on how to use them with OpenStack
is out of date.

The best information available to support your choice is found on the
`Hypervisor Support Matrix
<http://docs.openstack.org/developer/nova/support-matrix.html>`_
and in the `configuration reference
<http://docs.openstack.org/mitaka/config-reference/compute/hypervisors.html>`_.

.. note::

   It is also possible to run multiple hypervisors in a single
   deployment using host aggregates or cells. However, an individual
   compute node can run only a single hypervisor at a time.
