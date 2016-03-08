==========================
Performance considerations
==========================

Performance is a critical considertion when designing any cloud, and becomes
increasingly important as size and complexity grow. While single-site, private
clouds can be closely controlled, multi-site and hybrid deployments require
more careful planning to reduce problems such as network latency between sites.

For example, you should consider the time required to
run a workload in different clouds and methods for reducing this time.
This may require moving data closer to applications or applications
closer to the data they process, and grouping functionality so that
connections that require low latency take place over a single cloud
rather than spanning clouds.

This may also require a CMP that can determine which cloud can most
efficiently run which types of workloads.

Using native OpenStack tools can help improve performance.
For example, you can use Telemetry to measure performance and the
Orchestration service (heat) to react to changes in demand.

.. note::

   Orchestration requires special client configurations to integrate
   with Amazon Web Services. For other types of clouds, use CMP features.

Cloud resource deployment
 The cloud user expects repeatable, dependable, and deterministic processes
 for launching and deploying cloud resources. You could deliver this through
 a web-based interface or publicly available API endpoints. All appropriate
 options for requesting cloud resources must be available through some type
 of user interface, a command-line interface (CLI), or API endpoints.

Consumption model
 Cloud users expect a fully self-service and on-demand consumption model.
 When an OpenStack cloud reaches the massively scalable size, expect
 consumption as a service in each and every way.

 * Everything must be capable of automation. For example, everything from
   compute hardware, storage hardware, networking hardware, to the installation
   and configuration of the supporting software. Manual processes are
   impractical in a massively scalable OpenStack design architecture.

 * Massively scalable OpenStack clouds require extensive metering and
   monitoring functionality to maximize the operational efficiency by keeping
   the operator informed about the status and state of the infrastructure. This
   includes full scale metering of the hardware and software status. A
   corresponding framework of logging and alerting is also required to store
   and enable operations to act on the meters provided by the metering and
   monitoring solutions. The cloud operator also needs a solution that uses the
   data provided by the metering and monitoring solution to provide capacity
   planning and capacity trending analysis.

Location
 For many use cases the proximity of the user to their workloads has a
 direct influence on the performance of the application and therefore
 should be taken into consideration in the design. Certain applications
 require zero to minimal latency that can only be achieved by deploying
 the cloud in multiple locations. These locations could be in different
 data centers, cities, countries or geographical regions, depending on
 the user requirement and location of the users.

Input-Output requirements
 Input-Output performance requirements require researching and
 modeling before deciding on a final storage framework. Running
 benchmarks for Input-Output performance provides a baseline for
 expected performance levels. If these tests include details, then
 the resulting data can help model behavior and results during
 different workloads. Running scripted smaller benchmarks during the
 lifecycle of the architecture helps record the system health at
 different points in time. The data from these scripted benchmarks
 assist in future scoping and gaining a deeper understanding of an
 organization's needs.

Scale
 Scaling storage solutions in a storage-focused OpenStack
 architecture design is driven by initial requirements, including
 :term:`IOPS`, capacity, bandwidth, and future needs. Planning
 capacity based on projected needs over the course of a budget cycle
 is important for a design. The architecture should balance cost and
 capacity, while also allowing flexibility to implement new
 technologies and methods as they become available.


Network considerations
~~~~~~~~~~~~~~~~~~~~~~

It is important to consider the functionality, security, scalability,
availability, and testability of the network when choosing a CMP and cloud
provider.

* Decide on a network framework and design minimum functionality tests.
  This ensures testing and functionality persists during and after
  upgrades.
* Scalability across multiple cloud providers may dictate which underlying
  network framework you choose in different cloud providers.
  It is important to present the network API functions and to verify
  that functionality persists across all cloud endpoints chosen.
* High availability implementations vary in functionality and design.
  Examples of some common methods are active-hot-standby, active-passive,
  and active-active.
  Development of high availability and test frameworks is necessary to
  insure understanding of functionality and limitations.
* Consider the security of data between the client and the endpoint,
  and of traffic that traverses the multiple clouds.

For example, degraded video streams and low quality VoIP sessions negatively
impact user experience and may lead to productivity and economic loss.

Network misconfigurations
 Configuring incorrect IP addresses, VLANs, and routers can cause
 outages to areas of the network or, in the worst-case scenario, the
 entire cloud infrastructure. Automate network configurations to
 minimize the opportunity for operator error as it can cause
 disruptive problems.

Capacity planning
 Cloud networks require management for capacity and growth over time.
 Capacity planning includes the purchase of network circuits and
 hardware that can potentially have lead times measured in months or
 years.

Network tuning
 Configure cloud networks to minimize link loss, packet loss, packet
 storms, broadcast storms, and loops.

Single Point Of Failure (SPOF)
 Consider high availability at the physical and environmental layers.
 If there is a single point of failure due to only one upstream link,
 or only one power supply, an outage can become unavoidable.

Complexity
 An overly complex network design can be difficult to maintain and
 troubleshoot. While device-level configuration can ease maintenance
 concerns and automated tools can handle overlay networks, avoid or
 document non-traditional interconnects between functions and
 specialized hardware to prevent outages.

Non-standard features
 There are additional risks that arise from configuring the cloud
 network to take advantage of vendor specific features. One example
 is multi-link aggregation (MLAG) used to provide redundancy at the
 aggregator switch level of the network. MLAG is not a standard and,
 as a result, each vendor has their own proprietary implementation of
 the feature. MLAG architectures are not interoperable across switch
 vendors, which leads to vendor lock-in, and can cause delays or
 inability when upgrading components.

Dynamic resource expansion or bursting
 An application that requires additional resources may suit a multiple
 cloud architecture. For example, a retailer needs additional resources
 during the holiday season, but does not want to add private cloud
 resources to meet the peak demand.
 The user can accommodate the increased load by bursting to
 a public cloud for these peak load periods. These bursts could be
 for long or short cycles ranging from hourly to yearly.


Consistency of images and templates across different sites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is essential that the deployment of instances is consistent across
different sites and built into the infrastructure. If OpenStack
Object Storage is used as a back end for the Image service, it is
possible to create repositories of consistent images across multiple
sites. Having central endpoints with multiple storage nodes allows
consistent centralized storage for every site.

Not using a centralized object store increases the operational overhead
of maintaining a consistent image library. This could include
development of a replication mechanism to handle the transport of images
and the changes to the images across multiple sites.


Migration, availability, site loss and recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Outages can cause partial or full loss of site functionality. Strategies
should be implemented to understand and plan for recovery scenarios.

*  The deployed applications need to continue to function and, more
   importantly, you must consider the impact on the performance and
   reliability of the application when a site is unavailable.

*  It is important to understand what happens to the replication of
   objects and data between the sites when a site goes down. If this
   causes queues to start building up, consider how long these queues
   can safely exist until an error occurs.

*  After an outage, ensure the method for resuming proper operations of
   a site is implemented when it comes back online. We recommend you
   architect the recovery to avoid race conditions.

Disaster recovery and business continuity
 Cheaper storage makes the public cloud suitable for maintaining
 backup applications.

Migration scenarios
 Hybrid cloud architecture enables the migration of
 applications between different clouds.

Provider availability or implementation details
 Business changes can affect provider availability.
 Likewise, changes in a provider's service can disrupt
 a hybrid cloud environment or increase costs.

Provider API changes
 Consumers of external clouds rarely have control over provider
 changes to APIs, and changes can break compatibility.
 Using only the most common and basic APIs can minimize potential conflicts.

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

Business or technical diversity
 Organizations leveraging cloud-based services can embrace business
 diversity and utilize a hybrid cloud design to spread their
 workloads across multiple cloud providers. This ensures that
 no single cloud provider is the sole host for an application.
