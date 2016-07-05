=============
Compute nodes
=============

.. toctree::
  :maxdepth: 3

  design-compute-tech


This chapter describes some of the choices you need to consider
when designing and building your compute nodes. Compute nodes form the
resource core of the OpenStack Compute cloud, providing the processing, memory,
network and storage resources to run instances.

Overview
~~~~~~~~

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


Choosing a CPU
~~~~~~~~~~~~~~

The type of CPU in your compute node is a very important choice. First,
ensure that the CPU supports virtualization by way of *VT-x* for Intel
chips and *AMD-v* for AMD chips.

.. tip::

   Consult the vendor documentation to check for virtualization
   support. For Intel, read `“Does my processor support Intel® Virtualization
   Technology?” <http://www.intel.com/support/processors/sb/cs-030729.htm>`_.
   For AMD, read `AMD Virtualization
   <http://www.amd.com/en-us/innovations/software-technologies/server-solution/virtualization>`_.
   Note that your CPU may support virtualization but it may be
   disabled. Consult your BIOS documentation for how to enable CPU
   features.

The number of cores that the CPU has also affects the decision. It's
common for current CPUs to have up to 12 cores. Additionally, if an
Intel CPU supports hyperthreading, those 12 cores are doubled to 24
cores. If you purchase a server that supports multiple CPUs, the number
of cores is further multiplied.

.. note::

   **Multithread Considerations**

   Hyper-Threading is Intel's proprietary simultaneous multithreading
   implementation used to improve parallelization on their CPUs. You might
   consider enabling Hyper-Threading to improve the performance of
   multithreaded applications.

   Whether you should enable Hyper-Threading on your CPUs depends upon your
   use case. For example, disabling Hyper-Threading can be beneficial in
   intense computing environments. We recommend that you do performance
   testing with your local workload with both Hyper-Threading on and off to
   determine what is more appropriate in your case.

Choosing a Hypervisor
~~~~~~~~~~~~~~~~~~~~~

A hypervisor provides software to manage virtual machine access to the
underlying hardware. The hypervisor creates, manages, and monitors
virtual machines. OpenStack Compute supports many hypervisors to various
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

Instance Storage Solutions
~~~~~~~~~~~~~~~~~~~~~~~~~~

As part of the procurement for a compute cluster, you must specify some
storage for the disk on which the instantiated instance runs. There are
three main approaches to providing this temporary-style storage, and it
is important to understand the implications of the choice.

They are:

* Off compute node storage—shared file system
* On compute node storage—shared file system
* On compute node storage—nonshared file system

In general, the questions you should ask when selecting storage are as
follows:

* What is the platter count you can achieve?
* Do more spindles result in better I/O despite network access?
* Which one results in the best cost-performance scenario you are aiming for?
* How do you manage the storage operationally?

Many operators use separate compute and storage hosts. Compute services
and storage services have different requirements, and compute hosts
typically require more CPU and RAM than storage hosts. Therefore, for a
fixed budget, it makes sense to have different configurations for your
compute nodes and your storage nodes. Compute nodes will be invested in
CPU and RAM, and storage nodes will be invested in block storage.

However, if you are more restricted in the number of physical hosts you
have available for creating your cloud and you want to be able to
dedicate as many of your hosts as possible to running instances, it
makes sense to run compute and storage on the same machines.

The three main approaches to instance storage are provided in the next
few sections.

Off Compute Node Storage—Shared File System
-------------------------------------------

In this option, the disks storing the running instances are hosted in
servers outside of the compute nodes.

If you use separate compute and storage hosts, you can treat your
compute hosts as "stateless." As long as you don't have any instances
currently running on a compute host, you can take it offline or wipe it
completely without having any effect on the rest of your cloud. This
simplifies maintenance for the compute hosts.

There are several advantages to this approach:

*  If a compute node fails, instances are usually easily recoverable.
*  Running a dedicated storage system can be operationally simpler.
*  You can scale to any number of spindles.
*  It may be possible to share the external storage for other purposes.

The main downsides to this approach are:

* Depending on design, heavy I/O usage from some instances can affect
  unrelated instances.
* Use of the network can decrease performance.

On Compute Node Storage—Shared File System
------------------------------------------

In this option, each compute node is specified with a significant amount
of disk space, but a distributed file system ties the disks from each
compute node into a single mount.

The main advantage of this option is that it scales to external storage
when you require additional storage.

However, this option has several downsides:

* Running a distributed file system can make you lose your data
  locality compared with nonshared storage.
* Recovery of instances is complicated by depending on multiple hosts.
* The chassis size of the compute node can limit the number of spindles
  able to be used in a compute node.
* Use of the network can decrease performance.

On Compute Node Storage—Nonshared File System
---------------------------------------------

In this option, each compute node is specified with enough disks to
store the instances it hosts.

There are two main reasons why this is a good idea:

* Heavy I/O usage on one compute node does not affect instances on
  other compute nodes.
* Direct I/O access can increase performance.

This has several downsides:

* If a compute node fails, the instances running on that node are lost.
* The chassis size of the compute node can limit the number of spindles
  able to be used in a compute node.
* Migrations of instances from one node to another are more complicated
  and rely on features that may not continue to be developed.
* If additional storage is required, this option does not scale.

Running a shared file system on a storage system apart from the computes
nodes is ideal for clouds where reliability and scalability are the most
important factors. Running a shared file system on the compute nodes
themselves may be best in a scenario where you have to deploy to
preexisting servers for which you have little to no control over their
specifications. Running a nonshared file system on the compute nodes
themselves is a good option for clouds with high I/O requirements and
low concern for reliability.

Issues with Live Migration
--------------------------

Live migration is an integral part of the operations of the
cloud. This feature provides the ability to seamlessly move instances
from one physical host to another, a necessity for performing upgrades
that require reboots of the compute hosts, but only works well with
shared storage.

Live migration can also be done with nonshared storage, using a feature
known as *KVM live block migration*. While an earlier implementation of
block-based migration in KVM and QEMU was considered unreliable, there
is a newer, more reliable implementation of block-based live migration
as of QEMU 1.4 and libvirt 1.0.2 that is also compatible with OpenStack.

Choice of File System
---------------------

If you want to support shared-storage live migration, you need to
configure a distributed file system.

Possible options include:

* NFS (default for Linux)
* GlusterFS
* MooseFS
* Lustre

We recommend that you choose the option operators are most familiar with.
NFS is the easiest to set up and there is extensive community knowledge
about it.

Overcommitting
~~~~~~~~~~~~~~

OpenStack allows you to overcommit CPU and RAM on compute nodes. This
allows you to increase the number of instances you can have running on
your cloud, at the cost of reducing the performance of the instances.
OpenStack Compute uses the following ratios by default:

* CPU allocation ratio: 16:1
* RAM allocation ratio: 1.5:1

The default CPU allocation ratio of 16:1 means that the scheduler
allocates up to 16 virtual cores per physical core. For example, if a
physical node has 12 cores, the scheduler sees 192 available virtual
cores. With typical flavor definitions of 4 virtual cores per instance,
this ratio would provide 48 instances on a physical node.

The formula for the number of virtual instances on a compute node is
``(OR*PC)/VC``, where:

OR
    CPU overcommit ratio (virtual cores per physical core)

PC
    Number of physical cores

VC
    Number of virtual cores per instance

Similarly, the default RAM allocation ratio of 1.5:1 means that the
scheduler allocates instances to a physical node as long as the total
amount of RAM associated with the instances is less than 1.5 times the
amount of RAM available on the physical node.

For example, if a physical node has 48 GB of RAM, the scheduler
allocates instances to that node until the sum of the RAM associated
with the instances reaches 72 GB (such as nine instances, in the case
where each instance has 8 GB of RAM).

.. note::
   Regardless of the overcommit ratio, an instance can not be placed
   on any physical node with fewer raw (pre-overcommit) resources than
   the instance flavor requires.

You must select the appropriate CPU and RAM allocation ratio for your
particular use case.

Logging
~~~~~~~

Logging is described in more detail in `Logging and Monitoring
<http://docs.openstack.org/ops-guide/ops-logging-monitoring.html>`_. However,
it is an important design consideration to take into account before
commencing operations of your cloud.

OpenStack produces a great deal of useful logging information, however;
but for the information to be useful for operations purposes, you should
consider having a central logging server to send logs to, and a log
parsing/analysis system (such as logstash).

Networking
~~~~~~~~~~

Networking in OpenStack is a complex, multifaceted challenge. See
:doc:`design-networking`.
