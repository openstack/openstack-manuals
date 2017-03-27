=======================
Enterprise requirements
=======================

The following sections describe business, usage, and performance
considerations for customers which will impact cloud architecture design.

Cost
~~~~

Financial factors are a primary concern for any organization. Cost
considerations may influence the type of cloud that you build.
For example, a general purpose cloud is unlikely to be the most
cost-effective environment for specialized applications.
Unless business needs dictate that cost is a critical factor,
cost should not be the sole consideration when choosing or designing a cloud.

As a general guideline, increasing the complexity of a cloud architecture
increases the cost of building and maintaining it. For example, a hybrid or
multi-site cloud architecture involving multiple vendors and technical
architectures may require higher setup and operational costs because of the
need for more sophisticated orchestration and brokerage tools than in other
architectures. However, overall operational costs might be lower by virtue of
using a cloud brokerage tool to deploy the workloads to the most cost effective
platform.

.. TODO Replace examples with the proposed example use cases in this guide.

Consider the following costs categories when designing a cloud:

*  Compute resources

*  Networking resources

*  Replication

*  Storage

*  Management

*  Operational costs

It is also important to consider how costs will increase as your cloud scales.
Choices that have a negligible impact in small systems may considerably
increase costs in large systems. In these cases, it is important to minimize
capital expenditure (CapEx) at all layers of the stack. Operators of massively
scalable OpenStack clouds require the use of dependable commodity hardware and
freely available open source software components to reduce deployment costs and
operational expenses. Initiatives like Open Compute (more information available
in the `Open Compute Project <http://www.opencompute.org>`_) provide additional
information.

Time-to-market
~~~~~~~~~~~~~~

The ability to deliver services or products within a flexible time
frame is a common business factor when building a cloud. Allowing users to
self-provision and gain access to compute, network, and
storage resources on-demand may decrease time-to-market for new products
and applications.

You must balance the time required to build a new cloud platform against the
time saved by migrating users away from legacy platforms. In some cases,
existing infrastructure may influence your architecture choices. For example,
using multiple cloud platforms may be a good option when there is an existing
investment in several applications, as it could be faster to tie the
investments together rather than migrating the components and refactoring them
to a single platform.

Revenue opportunity
~~~~~~~~~~~~~~~~~~~

Revenue opportunities vary based on the intent and use case of the cloud.
The requirements of a commercial, customer-facing product are often very
different from an internal, private cloud. You must consider what features
make your design most attractive to your users.

Capacity planning and scalability
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Capacity and the placement of workloads are key design considerations
for clouds. A long-term capacity plan for these designs must
incorporate growth over time to prevent permanent consumption of more
expensive external clouds. To avoid this scenario, account for future
applications' capacity requirements and plan growth appropriately.

It is difficult to predict the amount of load a particular
application might incur if the number of users fluctuates, or the
application experiences an unexpected increase in use.
It is possible to define application requirements in terms of
vCPU, RAM, bandwidth, or other resources and plan appropriately.
However, other clouds might not use the same meter or even the same
oversubscription rates.

Oversubscription is a method to emulate more capacity than
may physically be present. For example, a physical hypervisor node with 32 GB
RAM may host 24 instances, each provisioned with 2 GB RAM.
As long as all 24 instances do not concurrently use 2 full
gigabytes, this arrangement works well.
However, some hosts take oversubscription to extremes and,
as a result, performance can be inconsistent.
If at all possible, determine what the oversubscription rates
of each host are and plan capacity accordingly.

.. TODO Considerations when building your cloud, racks, CPUs, compute node
   density. For ongoing capacity planning refer to the Ops Guide.


Performance
~~~~~~~~~~~

Performance is a critical consideration when designing any cloud, and becomes
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
 :term:`IOPS <Input/output Operations Per Second (IOPS)>`, capacity,
 bandwidth, and future needs. Planning capacity based on projected needs
 over the course of a budget cycle is important for a design. The
 architecture should balance cost and capacity, while also allowing
 flexibility to implement new technologies and methods as they become
 available.

Network
~~~~~~~

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

Compliance and geo-location
~~~~~~~~~~~~~~~~~~~~~~~~~~~

An organization may have certain legal obligations and regulatory
compliance measures which could require certain workloads or data to not
be located in certain regions.

Compliance considerations are particularly important for multi-site clouds.
Considerations include:

- federal legal requirements
- local jurisdictional legal and compliance requirements
- image consistency and availability
- storage replication and availability (both block and file/object storage)
- authentication, authorization, and auditing (AAA)

Geographical considerations may also impact the cost of building or leasing
data centers. Considerations include:

- floor space
- floor weight
- rack height and type
- environmental considerations
- power usage and power usage efficiency (PUE)
- physical security

Auditing
~~~~~~~~

A well-considered auditing plan is essential for quickly finding issues.
Keeping track of changes made to security groups and tenant changes can be
useful in rolling back the changes if they affect production. For example,
if all security group rules for a tenant disappeared, the ability to quickly
track down the issue would be important for operational and legal reasons.
For more details on auditing, see the `Compliance chapter
<https://docs.openstack.org/security-guide/compliance.html>`_ in the OpenStack
Security Guide.

Security
~~~~~~~~

The importance of security varies based on the type of organization using
a cloud. For example, government and financial institutions often have
very high security requirements. Security should be implemented according to
asset, threat, and vulnerability risk assessment matrices.
See `security-requirements`.

Service level agreements
~~~~~~~~~~~~~~~~~~~~~~~~

Service level agreements (SLA) must be developed in conjunction with business,
technical, and legal input. Small, private clouds may operate under an informal
SLA, but hybrid or public clouds generally require more formal agreements with
their users.

For a user of a massively scalable OpenStack public cloud, there are no
expectations for control over security, performance, or availability. Users
expect only SLAs related to uptime of API services, and very basic SLAs for
services offered. It is the user's responsibility to address these issues on
their own. The exception to this expectation is the rare case of a massively
scalable cloud infrastructure built for a private or government organization
that has specific requirements.

High performance systems have SLA requirements for a minimum quality of service
with regard to guaranteed uptime, latency, and bandwidth. The level of the
SLA can have a significant impact on the network architecture and
requirements for redundancy in the systems.

Hybrid cloud designs must accommodate differences in SLAs between providers,
and consider their enforceability.

Application readiness
~~~~~~~~~~~~~~~~~~~~~

Some applications are tolerant of a lack of synchronized object
storage, while others may need those objects to be replicated and
available across regions. Understanding how the cloud implementation
impacts new and existing applications is important for risk mitigation,
and the overall success of a cloud project. Applications may have to be
written or rewritten for an infrastructure with little to no redundancy,
or with the cloud in mind.

Application momentum
 Businesses with existing applications may find that it is
 more cost effective to integrate applications on multiple
 cloud platforms than migrating them to a single platform.

No predefined usage model
 The lack of a pre-defined usage model enables the user to run a wide
 variety of applications without having to know the application
 requirements in advance. This provides a degree of independence and
 flexibility that no other cloud scenarios are able to provide.

On-demand and self-service application
 By definition, a cloud provides end users with the ability to
 self-provision computing power, storage, networks, and software in a
 simple and flexible way. The user must be able to scale their
 resources up to a substantial level without disrupting the
 underlying host operations. One of the benefits of using a general
 purpose cloud architecture is the ability to start with limited
 resources and increase them over time as the user demand grows.

Authentication
~~~~~~~~~~~~~~

It is recommended to have a single authentication domain rather than a
separate implementation for each and every site. This requires an
authentication mechanism that is highly available and distributed to
ensure continuous operation. Authentication server locality might be
required and should be planned for.

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
