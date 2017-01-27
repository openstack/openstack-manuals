.. _config-ovs-dpdk:

===============================
Open vSwitch with DPDK datapath
===============================

This page serves as a guide for how to use the OVS with DPDK datapath
functionality available in the Networking service as of the Mitaka release.

The basics
~~~~~~~~~~

Open vSwitch (OVS) provides support for a Data Plane Development Kit (DPDK)
datapath since OVS 2.2, and a DPDK-backed ``vhost-user`` virtual interface
since OVS 2.4. The DPDK datapath provides lower latency and higher performance
than the standard kernel OVS datapath, while DPDK-backed ``vhost-user``
interfaces can connect guests to this datapath. For more information on DPDK,
refer to the `DPDK <http://dpdk.org/>`__ website.

OVS with DPDK, or OVS-DPDK, can be used to provide high-performance networking
between instances on OpenStack compute nodes.

Prerequisites
-------------

Using DPDK in OVS requires the following minimum software versions:

* OVS 2.4
* DPDK 2.0
* QEMU 2.1.0
* libvirt 1.2.13

Multiqueue support is available if the following newer versions are used:

* OVS 2.5
* DPDK 2.2
* QEMU 2.5
* libvirt 1.2.17

In both cases, install and configure Open vSwitch with DPDK support for each
node. For more information, see the
`OVS-DPDK <https://github.com/openvswitch/ovs/blob/v2.5.0/INSTALL.DPDK.md>`__
installation guide.

Using vhost-user interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once OVS is correctly configured with DPDK support, ``vhost-user`` interfaces
are completely transparent to the guest. However, guests must request large
pages. This can be done through flavors. For example:

.. code-block:: console

   $ openstack flavor set m1.large --property hw:mem_page_size=large

For more information about the syntax for ``hw:mem_page_size``, refer to the
`Flavors <https://docs.openstack.org/admin-guide/compute-flavors.html>`__ guide.

.. note::

   ``vhost-user`` requires file descriptor-backed shared memory. Currently, the
   only way to request this is by requesting large pages. This is why instances
   spawned on hosts with OVS-DPDK must request large pages. The aggregate
   flavor affinity filter can be used to associate flavors with large page
   support to hosts with OVS-DPDK support.

Create and add ``vhost-user`` network interfaces to instances in the same
fashion as conventional interfaces. These interfaces can use the kernel
``virtio-net`` driver or a DPDK-compatible driver in the guest

.. code-block:: console

   $ openstack server create --nic net-id=$net_id ... testserver

Known limitations
~~~~~~~~~~~~~~~~~

* This feature is only supported when using the libvirt compute driver, and the
  KVM/QEMU hypervisor.
* Large pages are required for each instance running on hosts with OVS-DPDK.
  If large pages are not present in the guest, the interface will appear but
  will not function.
* Expect performance degradation of services using tap devices: these devices
  do not support DPDK. Example services include DVR, FWaaS, or LBaaS.
