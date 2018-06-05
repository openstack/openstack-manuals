.. _choosing-a-cpu:

==============
Choosing a CPU
==============

The type of CPU in your compute node is a very important decision. You must
ensure that the CPU supports virtualization by way of *VT-x* for Intel chips
and *AMD-v* for AMD chips.

.. tip::

   Consult the vendor documentation to check for virtualization support. For
   Intel CPUs, see
   `Does my processor support Intel® Virtualization Technology?
   <https://www.intel.com/content/www/us/en/support/processors/000005486.html>`_. For AMD CPUs,
   see `AMD Virtualization
   <https://www.amd.com/en-us/innovations/software-technologies/server-solution/virtualization>`_.
   Your CPU may support virtualization but it may be disabled. Consult your
   BIOS documentation for how to enable CPU features.

The number of cores that the CPU has also affects your decision. It is
common for current CPUs to have up to 24 cores. Additionally, if an Intel CPU
supports hyper-threading, those 24 cores are doubled to 48 cores. If you
purchase a server that supports multiple CPUs, the number of cores is further
multiplied.

As of the Kilo release, key enhancements have been added to the
OpenStack code to improve guest performance. These improvements allow the
Compute service to take advantage of greater insight into a compute host's
physical layout and therefore make smarter decisions regarding workload
placement. Administrators can use this functionality to enable smarter planning
choices for use cases like NFV (Network Function Virtualization) and HPC (High
Performance Computing).

Considering non-uniform memory access (NUMA) is important when selecting CPU
sizes and types, as there are use cases that use NUMA pinning to reserve host
cores for operating system processes. These reduce the available CPU for
workloads and protects the operating system.

.. tip::

  When CPU pinning is requested for a guest, it is assumed
  there is no overcommit (or, an overcommit ratio of 1.0). When dedicated
  resourcing is not requested for a workload, the normal overcommit ratios
  are applied.

  Therefore, we recommend that host aggregates are used to separate not
  only bare metal hosts, but hosts that will provide resources for workloads
  that require dedicated resources. This said, when workloads are provisioned
  to NUMA host aggregates, NUMA nodes are chosen at random and vCPUs can float
  across NUMA nodes on a host. If workloads require SR-IOV or DPDK, they should
  be assigned to a NUMA node aggregate with hosts that supply the
  functionality. More importantly, the workload or vCPUs that are executing
  processes for a workload should be on the same NUMA node due to the limited
  amount of cross-node memory bandwidth. In all cases, the ``NUMATopologyFilter``
  must be enabled for ``nova-scheduler``.

Additionally, CPU selection may not be one-size-fits-all across enterprises,
but more of a list of SKUs that are tuned for the enterprise workloads.

For more information about NUMA, see `CPU topologies
<https://docs.openstack.org/admin-guide/compute-cpu-topologies.html>`_ in
the Administrator Guide.

In order to take advantage of these new enhancements in the Compute service,
compute hosts must be using NUMA capable CPUs.

.. tip::

   **Multithread Considerations**

   Hyper-Threading is Intel's proprietary simultaneous multithreading
   implementation used to improve parallelization on their CPUs. You might
   consider enabling Hyper-Threading to improve the performance of
   multithreaded applications.

   Whether you should enable Hyper-Threading on your CPUs depends upon your use
   case. For example, disabling Hyper-Threading can be beneficial in intense
   computing environments. We recommend performance testing with your local
   workload with both Hyper-Threading on and off to determine what is more
   appropriate in your case.

   In most cases, hyper-threading CPUs can provide a 1.3x to 2.0x performance
   benefit over non-hyper-threaded CPUs depending on types of workload.
