========================
Technical considerations
========================

A hybrid cloud environment requires inspection and
understanding of technical issues in external data centers that may
not be in your control. Ideally, select an architecture
and CMP that are adaptable to changing environments.

Using diverse cloud platforms increases the risk of compatibility
issues, but clouds using the same version and distribution
of OpenStack are less likely to experience problems.

Clouds that exclusively use the same versions of OpenStack should
have no issues, regardless of distribution. More recent distributions
are less likely to encounter incompatibility between versions.
An OpenStack community initiative defines core functions that need to
remain backward compatible between supported versions. For example, the
DefCore initiative defines basic functions that every distribution must
support in order to use the name OpenStack.

Vendors can add proprietary customization to their distributions.
If an application or architecture makes use of these features, it can be
difficult to migrate to or use other types of environments.

If an environment includes non-OpenStack clouds, it may experience
compatibility problems. CMP tools must account for the differences in
the handling of operations and the implementation of services.

**Possible cloud incompatibilities**

* Instance deployment
* Network management
* Application management
* Services implementation

Capacity planning
~~~~~~~~~~~~~~~~~

One of the primary reasons many organizations use a hybrid cloud
is to increase capacity without making large capital investments.

Capacity and the placement of workloads are key design considerations
for hybrid clouds. The long-term capacity plan for these designs must
incorporate growth over time to prevent permanent consumption of more
expensive external clouds.
To avoid this scenario, account for future applications' capacity
requirements and plan growth appropriately.

It is difficult to predict the amount of load a particular
application might incur if the number of users fluctuates, or the
application experiences an unexpected increase in use.
It is possible to define application requirements in terms of
vCPU, RAM, bandwidth, or other resources and plan appropriately.
However, other clouds might not use the same meter or even the same
oversubscription rates.

Oversubscription is a method to emulate more capacity than
may physically be present.
For example, a physical hypervisor node with 32 GB RAM may host
24 instances, each provisioned with 2 GB RAM.
As long as all 24 instances do not concurrently use 2 full
gigabytes, this arrangement works well.
However, some hosts take oversubscription to extremes and,
as a result, performance can be inconsistent.
If at all possible, determine what the oversubscription rates
of each host are and plan capacity accordingly.

Utilization
~~~~~~~~~~~

A CMP must be aware of what workloads are running, where they are
running, and their preferred utilizations.
For example, in most cases it is desirable to run as many workloads
internally as possible, utilizing other resources only when necessary.
On the other hand, situations exist in which the opposite is true,
such as when an internal cloud is only for development and stressing
it is undesirable. A cost model of various scenarios and
consideration of internal priorities helps with this decision.
To improve efficiency, automate these decisions when possible.

The Telemetry service (ceilometer) provides information on the usage
of various OpenStack components. Note the following:

* If Telemetry must retain a large amount of data, for
  example when monitoring a large or active cloud, we recommend
  using a NoSQL back end such as MongoDB.
* You must monitor connections to non-OpenStack clouds
  and report this information to the CMP.

Performance
~~~~~~~~~~~

Performance is critical to hybrid cloud deployments, and they are
affected by many of the same issues as multi-site deployments, such
as network latency between sites. Also consider the time required to
run a workload in different clouds and methods for reducing this time.
This may require moving data closer to applications or applications
closer to the data they process, and grouping functionality so that
connections that require low latency take place over a single cloud
rather than spanning clouds.
This may also require a CMP that can determine which cloud can most
efficiently run which types of workloads.

As with utilization, native OpenStack tools help improve performance.
For example, you can use Telemetry to measure performance and the
Orchestration service (heat) to react to changes in demand.

.. note::

   Orchestration requires special client configurations to integrate
   with Amazon Web Services. For other types of clouds, use CMP features.

Components
~~~~~~~~~~

Using more than one cloud in any design requires consideration of
four OpenStack tools:

OpenStack Compute (nova)
  Regardless of deployment location, hypervisor choice has a direct
  effect on how difficult it is to integrate with additional clouds.

Networking (neutron)
  Whether using OpenStack Networking (neutron) or legacy
  networking (nova-network), it is necessary to understand
  network integration capabilities in order to connect between clouds.

Telemetry (ceilometer)
  Use of Telemetry depends, in large part, on what the other parts
  of the cloud you are using.

Orchestration (heat)
  Orchestration can be a valuable tool in orchestrating tasks a
  CMP decides are necessary in an OpenStack-based cloud.

Special considerations
~~~~~~~~~~~~~~~~~~~~~~

Hybrid cloud deployments require consideration of two issues that
are not common in other situations:

Image portability
  As of the Kilo release, there is no common image format that is
  usable by all clouds. Conversion or recreation of images is necessary
  if migrating between clouds. To simplify deployment, use the smallest
  and simplest images feasible, install only what is necessary, and
  use a deployment manager such as Chef or Puppet. Do not use golden
  images to speed up the process unless you repeatedly deploy the same
  images on the same cloud.

API differences
  Avoid using a hybrid cloud deployment with more than just
  OpenStack (or with different versions of OpenStack) as API changes
  can cause compatibility issues.
