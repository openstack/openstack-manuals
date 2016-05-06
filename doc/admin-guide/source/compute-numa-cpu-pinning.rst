.. _section-compute-numa-cpu-pinning:

==========================================
Enabling advanced CPU topologies in guests
==========================================

The NUMA topology and CPU pinning features in OpenStack provide high level
control over how instances run on host CPUs, and the topology of CPUs inside
the instance. These features can be used to minimize latency and maximize
per-instance performance.

SMP, NUMA, and SMT overviews
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Symmetric multiprocessing (SMP) is a design found in many modern multi-core
systems. In an SMP system, there are two or more CPUs and these CPUs are
connected by some interconnect. This provides CPUs with equal access to
system resources like memory and IO ports.

Non-uniform memory access (NUMA) is a derivative of the SMP design that is
found in many multi-socket systems. In a NUMA system, system memory is divided
into cells or nodes that are associated with particular CPUs. Requests for
memory on other nodes are possible through an interconnect bus, however,
bandwidth across this shared bus is limited. As a result, competition for this
this resource can incur performance penalties.

Simultaneous Multi-Threading (SMT), known as as Hyper-Threading on Intel
platforms, is a design that is complementary to SMP. Whereas CPUs in SMP
systems share a bus and some memory, CPUs in SMT systems share many more
components. CPUs that share components are known as thread siblings. All CPUs
appear as usable CPUs on the system and can execute workloads in parallel,
however, as with NUMA, threads compete for shared resources.

Customizing instance NUMA topologies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   The functionality described below is currently only supported by the
   libvirt/KVM driver.

When running workloads on NUMA hosts, it is important that the vCPUs executing
processes are on the same NUMA node as the memory used by these processes.
This ensures all memory accesses are local to the node and thus do not consume
the limited cross-node memory bandwidth, adding latency to memory accesses.
Similarly, large pages are assigned from memory and benefit from the same
performance improvements as memory allocated using standard pages, thus, they
also should be local. Finally, PCI devices are directly associated with
specific NUMA nodes for the purposes of DMA. Instances that use PCI or SR-IOV
devices should be placed on the NUMA node associated with the said devices.

By default, an instance will float across all NUMA nodes on a host. NUMA
awareness can be enabled implicitly, through the use of hugepages or pinned
CPUs, or explicitly, through the use of flavor extra specs or image metadata.
In all cases, the ``NUMATopologyFilter`` filter must be enabled. Details on
this filter are provided in `Scheduling`_ configuration guide.

.. warning::

   The NUMA node(s) used are normally chosen at random. However, if a PCI
   passthrough or SR-IOV device is attached to the instance, then the NUMA
   node that the device is associated with will be used. This can provide
   important performance improvements, however, booting a large number of
   similar instances can result in unbalanced NUMA node usage. Care should
   be taken to mitigate this issue. See this `discussion`_ for more details.

.. warning::

   Inadequate per-node resources will result in scheduling failures.  Resources
   that are specific to a node include not only CPUs and memory, but also PCI
   and SR-IOV resources. It is not possible to use multiple resources from
   different nodes without requesting a multi-node layout. As such, it may be
   necessary to ensure PCI or SR-IOV resources are associated with the same
   NUMA node or force a multi-node layout.

When used, NUMA awareness allows the operating system of the instance to
intelligently schedule the workloads that it runs and minimize cross-node
memory bandwidth. To restrict an instance's vCPUs to a single host NUMA node,
run:

.. code-block:: console

   # openstack flavor set m1.large --property hw:numa_nodes=1

Some workloads have very demanding requirements for memory access latency or
bandwidth which exceed the memory bandwidth available from a single NUMA node.
For such workloads, it is beneficial to spread the instance across multiple
host NUMA nodes, even if the instance's RAM/vCPUs could theoretically fit on a
single NUMA node. To force an instance's vCPUs to spread across two host NUMA
nodes, run:

.. code-block:: console

   # openstack flavor set m1.large --property hw:numa_nodes=2

The allocation of instances vCPUs and memory from different host NUMA nodes can
be configured. This allows for asymmetric allocation of vCPUs and memory, which
can be important for some workloads. To spread the six vCPUs and 6 GB of memory
of an instance across two NUMA nodes and create an asymmetric 1:2 vCPU and
memory mapping between the two nodes, run:

.. code-block:: console

   # openstack flavor set m1.large --property hw:numa_nodes=2
   # openstack flavor set m1.large \  # configure guest node 0
       --property hw:numa_cpus.0=0,1 \
       --property hw:numa_mem.0=2048
   # openstack flavor set m1.large \  # configure guest node 1
       --property hw:numa_cpus.1=2,3,4,5 \
       --property hw:numa_mem.1=4096

For more information about the syntax for ``hw:numa_nodes``, ``hw:numa_cpus.N``
and ``hw:num_mem.N``, refer to the `Flavors`_ guide.

Customizing instance CPU policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   The functionality described below is currently only supported by the
   libvirt/KVM driver.

By default, instance vCPU processes are not assigned to any particular host
CPU, instead, they float across host CPUs like any other process. This allows
for features like overcommitting of CPUs. In heavily contended systems, this
provides optimal system performance at the expense of performance and latency
for individual instances.

Some workloads require real-time or near real-time behavior, which is not
possible with the latency introduced by the default CPU policy. For such
workloads, it is beneficial to control which host CPUs are bound to an
instance's vCPUs. This process is known as pinning. No instance with pinned
CPUs can use the CPUs of another pinned instance, thus preventing resource
contention between instances. To configure a flavor to use pinned vCPUs, a
use a dedicated CPU policy. To force this, run:

.. code-block:: console

   # openstack flavor set m1.large --property hw:cpu_policy=dedicated

.. warning::

   Host aggregates should be used to separate pinned instances from unpinned
   instances as the latter will not respect the resourcing requirements of
   the former.

When running workloads on SMT hosts, it is important to be aware of the impact
that thread siblings can have. Thread siblings share a number of components
and contention on these components can impact performance. To configure how
to use threads, a CPU thread policy should be specified. For workloads where
sharing benefits performance, use thread siblings. To force this, run:

.. code-block:: console

   # openstack flavor set m1.large \
       --property hw:cpu_policy=dedicated \
       --property hw:cpu_thread_policy=require

For other workloads where performance is impacted by contention for resources,
use non-thread siblings or non-SMT hosts. To force this, run:

.. code-block:: console

   # openstack flavor set m1.large \
       --property hw:cpu_policy=dedicated \
       --property hw:cpu_thread_policy=isolate

Finally, for workloads where performance is minimally impacted, use thread
siblings if available. This is the default, but it can be set explicitly:

.. code-block:: console

   # openstack flavor set m1.large \
       --property hw:cpu_policy=dedicated \
       --property hw:cpu_thread_policy=prefer

.. note::

   There is no correlation required between the NUMA topology exposed in the
   instance and how the instance is actually pinned on the host. This is by
   design. See this `bug <https://bugs.launchpad.net/nova/+bug/1466780>`_ for
   more information.

For more information about the syntax for ``hw:cpu_policy`` and
``hw:cpu_thread_policy``, refer to the `Flavors`_ guide.

.. Links
.. _`Scheduling`: http://docs.openstack.org/mitaka/config-reference/compute/scheduler.html
.. _`Flavors`: http://docs.openstack.org/admin-guide/compute-flavors.html
.. _`discussion`: http://lists.openstack.org/pipermail/openstack-dev/2016-March/090367.html
