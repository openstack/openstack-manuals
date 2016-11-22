==============
Choosing a CPU
==============

The type of CPU in your compute node is a very important choice. First, ensure
that the CPU supports virtualization by way of *VT-x* for Intel chips and
*AMD-v* for AMD chips.

.. tip::

   Consult the vendor documentation to check for virtualization support. For
   Intel, read `“Does my processor support Intel® Virtualization Technology?”
   <http://www.intel.com/support/processors/sb/cs-030729.htm>`_. For AMD, read
   `AMD Virtualization
   <http://www.amd.com/en-us/innovations/software-technologies/server-solution/virtualization>`_.
   Your CPU may support virtualization but it may be disabled.
   Consult your BIOS documentation for how to enable CPU features.

The number of cores that the CPU has also affects the decision. It is common
for current CPUs to have up to 24 cores. Additionally, if an Intel CPU supports
hyperthreading, those 24 cores are doubled to 48 cores. If you purchase a
server that supports multiple CPUs, the number of cores is further multiplied.

.. note::

   **Multithread Considerations**

   Hyper-Threading is Intel's proprietary simultaneous multithreading
   implementation used to improve parallelization on their CPUs. You might
   consider enabling Hyper-Threading to improve the performance of
   multithreaded applications.

   Whether you should enable Hyper-Threading on your CPUs depends upon your use
   case. For example, disabling Hyper-Threading can be beneficial in intense
   computing environments. We recommend performance testing with
   your local workload with both Hyper-Threading on and off to determine what
   is more appropriate in your case.
