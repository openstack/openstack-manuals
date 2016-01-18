=================
Capacity planning
=================

An important consideration in running a cloud over time is projecting growth
and utilization trends in order to plan capital expenditures for the short and
long term. Gather utilization meters for compute, network, and storage, along
with historical records of these meters. While securing major anchor tenants
can lead to rapid jumps in the utilization rates of all resources, the steady
adoption of the cloud inside an organization or by consumers in a public
offering also creates a steady trend of increased utilization.

Capacity constraints for a general purpose cloud environment include:

* Compute limits
* Storage limits

A relationship exists between the size of the compute environment and
the supporting OpenStack infrastructure controller nodes requiring
support.

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
compute hosts directly affects network and datacenter resources.

Compute host components can also be upgraded to account for increases in
demand; this is known as vertical scaling. Upgrading CPUs with more
cores, or increasing the overall server memory, can add extra needed
capacity depending on whether the running applications are more CPU
intensive or memory intensive.

Another option is to assess the average workloads and increase the
number of instances that can run within the compute environment by
adjusting the overcommit ratio.

.. note::

   It is important to remember that changing the CPU overcommit ratio
   can have a detrimental effect and cause a potential increase in a
   noisy neighbor.

Insufficient disk capacity could also have a negative effect on overall
performance including CPU and memory usage. Depending on the back-end
architecture of the OpenStack Block Storage layer, capacity includes
adding disk shelves to enterprise storage systems or installing
additional block storage nodes. Upgrading directly attached storage
installed in compute hosts, and adding capacity to the shared storage
for additional ephemeral storage to instances, may be necessary.

For a deeper discussion on many of these topics, refer to the `OpenStack
Operations Guide <http://docs.openstack.org/ops>`_.
