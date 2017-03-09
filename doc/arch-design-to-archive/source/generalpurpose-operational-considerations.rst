==========================
Operational considerations
==========================

In the planning and design phases of the build out, it is important to
include the operation's function. Operational factors affect the design
choices for a general purpose cloud, and operations staff are often
tasked with the maintenance of cloud environments for larger
installations.

Expectations set by the Service Level Agreements (SLAs) directly affect
knowing when and where you should implement redundancy and high
availability. SLAs are contractual obligations that provide assurances
for service availability. They define the levels of availability that
drive the technical design, often with penalties for not meeting
contractual obligations.

SLA terms that affect design include:

* API availability guarantees implying multiple infrastructure services
  and highly available load balancers.

* Network uptime guarantees affecting switch design, which might
  require redundant switching and power.

* Factor in networking security policy requirements in to your
  deployments.

Support and maintainability
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To be able to support and maintain an installation, OpenStack cloud
management requires operations staff to understand and comprehend design
architecture content. The operations and engineering staff skill level,
and level of separation, are dependent on size and purpose of the
installation. Large cloud service providers, or telecom providers, are
more likely to be managed by specially trained, dedicated operations
organizations. Smaller implementations are more likely to rely on
support staff that need to take on combined engineering, design and
operations functions.

Maintaining OpenStack installations requires a variety of technical
skills. You may want to consider using a third-party management company
with special expertise in managing OpenStack deployment.

Monitoring
~~~~~~~~~~

OpenStack clouds require appropriate monitoring platforms to ensure
errors are caught and managed appropriately. Specific meters that are
critically important to monitor include:

* Image disk utilization

* Response time to the :term:`Compute API <Compute API (Nova API)>`

Leveraging existing monitoring systems is an effective check to ensure
OpenStack environments can be monitored.

Downtime
~~~~~~~~

To effectively run cloud installations, initial downtime planning
includes creating processes and architectures that support the
following:

* Planned (maintenance)

* Unplanned (system faults)

Resiliency of overall system and individual components are going to be
dictated by the requirements of the SLA, meaning designing for
:term:`high availability (HA)` can have cost ramifications.

Capacity planning
~~~~~~~~~~~~~~~~~

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

Assessing the average workloads and increasing the number of instances
that can run within the compute environment by adjusting the overcommit
ratio is another option. It is important to remember that changing the
CPU overcommit ratio can have a detrimental effect and cause a potential
increase in a noisy neighbor. The additional risk of increasing the
overcommit ratio is more instances failing when a compute host fails.

Compute host components can also be upgraded to account for increases in
demand; this is known as vertical scaling. Upgrading CPUs with more
cores, or increasing the overall server memory, can add extra needed
capacity depending on whether the running applications are more CPU
intensive or memory intensive.

Insufficient disk capacity could also have a negative effect on overall
performance including CPU and memory usage. Depending on the back-end
architecture of the OpenStack Block Storage layer, capacity includes
adding disk shelves to enterprise storage systems or installing
additional block storage nodes. Upgrading directly attached storage
installed in compute hosts, and adding capacity to the shared storage
for additional ephemeral storage to instances, may be necessary.

For a deeper discussion on many of these topics, refer to the `OpenStack
Operations Guide <https://docs.openstack.org/ops>`_.
