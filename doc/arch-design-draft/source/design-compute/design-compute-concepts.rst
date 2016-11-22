=========
Overview
=========

When designing compute resource pools, consider the number of processors,
amount of memory, and the quantity of storage required for each hypervisor.

Determine whether compute resources will be provided in a single pool or in
multiple pools. In most cases, multiple pools of resources can be allocated
and addressed on demand, commonly referred to as bin packing.

In a bin packing design, each independent resource pool provides service
for specific flavors. Since instances are scheduled onto compute hypervisors,
each independent node's resources will be allocated to efficiently use the
available hardware. Bin packing also requires a common hardware design,
with all hardware nodes within a compute resource pool sharing a common
processor, memory, and storage layout. This makes it easier to deploy,
support, and maintain nodes throughout their lifecycle.

Increasing the size of the supporting compute environment increases the
network traffic and messages, adding load to the controller or
networking nodes. Effective monitoring of the environment will help with
capacity decisions on scaling.

Compute nodes automatically attach to OpenStack clouds, resulting in a
horizontally scaling process when adding extra compute capacity to an
OpenStack cloud. Additional processes are required to place nodes into
appropriate availability zones and host aggregates. When adding
additional compute nodes to environments, ensure identical or functional
compatible CPUs are used, otherwise live migration features will break.
It is necessary to add rack capacity or network switches as scaling out
compute hosts directly affects data center resources.

Compute host components can also be upgraded to account for increases in
demand, known as vertical scaling. Upgrading CPUs with more
cores, or increasing the overall server memory, can add extra needed
capacity depending on whether the running applications are more CPU
intensive or memory intensive.

When selecting a processor, compare features and performance
characteristics. Some processors include features specific to
virtualized compute hosts, such as hardware-assisted virtualization, and
technology related to memory paging (also known as EPT shadowing). These
types of features can have a significant impact on the performance of
your virtual machine.

The number of processor cores and threads impacts the number of worker
threads which can be run on a resource node. Design decisions must
relate directly to the service being run on it, as well as provide a
balanced infrastructure for all services.

Another option is to assess the average workloads and increase the
number of instances that can run within the compute environment by
adjusting the overcommit ratio. This ratio is configurable for CPU and
memory. The default CPU overcommit ratio is 16:1, and the default memory
overcommit ratio is 1.5:1. Determining the tuning of the overcommit
ratios during the design phase is important as it has a direct impact on
the hardware layout of your compute nodes.

.. note::

   Changing the CPU overcommit ratio can have a detrimental effect
   and cause a potential increase in a noisy neighbor.

Insufficient disk capacity could also have a negative effect on overall
performance including CPU and memory usage. Depending on the back-end
architecture of the OpenStack Block Storage layer, capacity includes
adding disk shelves to enterprise storage systems or installing
additional Block Storage nodes. Upgrading directly attached storage
installed in Compute hosts, and adding capacity to the shared storage
for additional ephemeral storage to instances, may be necessary.

Consider the Compute requirements of non-hypervisor nodes (also referred to as
resource nodes). This includes controller, Object Storage nodes, Block Storage
nodes, and networking services.

The ability to add Compute resource pools for unpredictable workloads should
be considered. In some cases, the demand for certain instance types or flavors
may not justify individual hardware design. Allocate hardware designs that are
capable of servicing the most common instance requests. Adding hardware to the
overall architecture can be done later.
