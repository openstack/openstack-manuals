==========================
Operational considerations
==========================

There are a number of operational considerations that affect the design
of compute-focused OpenStack clouds, including:

* Enforcing strict API availability requirements

* Understanding and dealing with failure scenarios

* Managing host maintenance schedules

Service-level agreements (SLAs) are contractual obligations that ensure
the availability of a service. When designing an OpenStack cloud,
factoring in promises of availability implies a certain level of
redundancy and resiliency.

Monitoring
~~~~~~~~~~

OpenStack clouds require appropriate monitoring platforms to catch and
manage errors.

.. note::

   We recommend leveraging existing monitoring systems to see if they
   are able to effectively monitor an OpenStack environment.

Specific meters that are critically important to capture include:

* Image disk utilization

* Response time to the Compute API

Capacity planning
~~~~~~~~~~~~~~~~~

Adding extra capacity to an OpenStack cloud is a horizontally scaling
process.

We recommend similar (or the same) CPUs when adding extra nodes to the
environment. This reduces the chance of breaking live-migration features
if they are present. Scaling out hypervisor hosts also has a direct
effect on network and other data center resources. We recommend you
factor in this increase when reaching rack capacity or when requiring
extra network switches.

Changing the internal components of a Compute host to account for
increases in demand is a process known as vertical scaling. Swapping a
CPU for one with more cores, or increasing the memory in a server, can
help add extra capacity for running applications.

Another option is to assess the average workloads and increase the
number of instances that can run within the compute environment by
adjusting the overcommit ratio.

.. note::

   It is important to remember that changing the CPU overcommit ratio
   can have a detrimental effect and cause a potential increase in a
   noisy neighbor.

The added risk of increasing the overcommit ratio is that more instances
fail when a compute host fails. We do not recommend that you increase
the CPU overcommit ratio in compute-focused OpenStack design
architecture, as it can increase the potential for noisy neighbor
issues.
