Install and configure a compute node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Compute
service on a compute node. The service supports several
:term:`hypervisors <hypervisor>` to deploy :term:`instances <instance>`
or :term:`VMs <virtual machine (VM)>`. For simplicity, this configuration
uses the :term:`QEMU <Quick EMUlator (QEMU)>` hypervisor with the
:term:`KVM <kernel-based VM (KVM)>` extension
on compute nodes that support hardware acceleration for virtual machines.
On legacy hardware, this configuration uses the generic QEMU hypervisor.
You can follow these instructions with minor modifications to horizontally
scale your environment with additional compute nodes.

.. note::

   This section assumes that you are following the instructions in
   this guide step-by-step to configure the first compute node. If you
   want to configure additional compute nodes, prepare them in a similar
   fashion to the first compute node in the :ref:`example architectures
   <overview-example-architectures>` section. Each additional compute node
   requires a unique IP address.

.. toctree::
   :glob:

   nova-compute-install-*
