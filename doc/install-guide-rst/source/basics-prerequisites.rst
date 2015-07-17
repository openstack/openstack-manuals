Before you begin
~~~~~~~~~~~~~~~~

For best performance, we recommend that your environment meets or
exceeds the hardware requirements in
:ref:`figure-neutron-network-hw` or
:ref:`figure-legacy-network-hw`.  However, OpenStack does not require a
significant amount of resources and the following minimum requirements
should support a proof-of-concept environment with core services
and several :term:`CirrOS` instances:

-  Controller Node: 1 processor, 2 GB memory, and 5 GB storage

-  Network Node: 1 processor, 512 MB memory, and 5 GB storage

-  Compute Node: 1 processor, 2 GB memory, and 10 GB storage

To minimize clutter and provide more resources for OpenStack, we
recommend a minimal installation of your Linux distribution. Also, we
strongly recommend that you install a 64-bit version of your
distribution on at least the compute node. If you install a 32-bit
version of your distribution on the compute node, attempting to start an
instance using a 64-bit image will fail.

.. note::

   A single disk partition on each node works for most basic
   installations. However, you should consider
   :term:`Logical Volume Manager (LVM)` for installations with
   optional services such as Block Storage.

Many users build their test environment on a
:term:`virtual machine (VM)`. The primary benefits of VMs include
the following:

-  One physical server can support multiple nodes, each with almost any
   number of network interfaces.

-  Ability to take periodic "snap shots" throughout the installation
   process and "roll back" to a working configuration in the event of a
   problem.

However, VMs will reduce performance of your instances, particularly if
your hypervisor and/or processor lacks support for hardware acceleration
of nested VMs.

.. note::

   If you choose to install on VMs, make sure your hypervisor permits
   :term:`promiscuous mode` and disables MAC address filtering on the
   :term:`external network`.

For more information about system requirements, see the `OpenStack
Operations Guide <http://docs.openstack.org/ops/>`_.
