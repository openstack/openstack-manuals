====================================
Compute server architecture overview
====================================

When designing compute resource pools, consider the number of processors,
amount of memory, network requirements, the quantity of storage required for
each hypervisor, and any requirements for bare metal hosts provisioned
through ironic.

When architecting an OpenStack cloud, as part of the planning process, you
must not only determine what hardware to utilize but whether compute
resources will be provided in a single pool or in multiple pools or
availability zones. You should consider if the cloud will provide distinctly
different profiles for compute.

For example, CPU, memory or local storage based compute nodes. For NFV
or HPC based clouds, there may even be specific network configurations that
should be reserved for those specific workloads on specific compute nodes. This
method of designing specific resources into groups or zones of compute can be
referred to as bin packing.

.. note::

  In a bin packing design, each independent resource pool provides service for
  specific flavors. Since instances are scheduled onto compute hypervisors,
  each independent node's resources will be allocated to efficiently use the
  available hardware. While bin packing can separate workload specific
  resources onto individual servers, bin packing also requires a common
  hardware design, with all hardware nodes within a compute resource pool
  sharing a common processor, memory, and storage layout. This makes it easier
  to deploy, support, and maintain nodes throughout their lifecycle.

Increasing the size of the supporting compute environment increases the network
traffic and messages, adding load to the controllers and administrative
services used to support the OpenStack cloud or networking nodes. When
considering hardware for controller nodes, whether using the monolithic
controller design, where all of the controller services live on one or more
physical hardware nodes, or in any of the newer shared nothing control plane
models, adequate resources must be allocated and scaled to meet scale
requirements. Effective monitoring of the environment will help with capacity
decisions on scaling. Proper planning will help avoid bottlenecks and network
oversubscription as the cloud scales.

Compute nodes automatically attach to OpenStack clouds, resulting in a
horizontally scaling process when adding extra compute capacity to an
OpenStack cloud. To further group compute nodes and place nodes into
appropriate availability zones and host aggregates, additional work is
required. It is necessary to plan rack capacity and network switches as scaling
out compute hosts directly affects data center infrastructure resources as
would any other infrastructure expansion.

While not as common in large enterprises, compute host components can also be
upgraded to account for increases in
demand, known as vertical scaling. Upgrading CPUs with more
cores, or increasing the overall server memory, can add extra needed
capacity depending on whether the running applications are more CPU
intensive or memory intensive. We recommend a rolling upgrade of compute
nodes for redundancy and availability.
After the upgrade, when compute nodes return to the OpenStack cluster, they
will be re-scanned and the new resources will be discovered adjusted in the
OpenStack database.

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
performance including CPU and memory usage. Depending on the back end
architecture of the OpenStack Block Storage layer, capacity includes
adding disk shelves to enterprise storage systems or installing
additional Block Storage nodes. Upgrading directly attached storage
installed in Compute hosts, and adding capacity to the shared storage
for additional ephemeral storage to instances, may be necessary.

Consider the Compute requirements of non-hypervisor nodes (also referred to as
resource nodes). This includes controller, Object Storage nodes, Block Storage
nodes, and networking services.

The ability to create pools or availability zones for unpredictable workloads
should be considered. In some cases, the demand for certain instance types or
flavors may not justify individual hardware design. Allocate hardware designs
that are capable of servicing the most common instance requests. Adding
hardware to the overall architecture can be done later.
