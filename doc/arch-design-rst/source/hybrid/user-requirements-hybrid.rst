=================
User requirements
=================

Hybrid cloud architectures are complex, especially those
that use heterogeneous cloud platforms.
Ensure that design choices match requirements so that the
benefits outweigh the inherent additional complexity and risks.

Business considerations
~~~~~~~~~~~~~~~~~~~~~~~

Business considerations when designing a hybrid cloud deployment
----------------------------------------------------------------

Cost
 A hybrid cloud architecture involves multiple vendors and
 technical architectures.
 These architectures may be more expensive to deploy and maintain.
 Operational costs can be higher because of the need for more
 sophisticated orchestration and brokerage tools than in other architectures.
 In contrast, overall operational costs might be lower by
 virtue of using a cloud brokerage tool to deploy the
 workloads to the most cost effective platform.

Revenue opportunity
 Revenue opportunities vary based on the intent and use case of the cloud.
 As a commercial, customer-facing product, you must consider whether building
 over multiple platforms makes the design more attractive to customers.

Time-to-market
 One common reason to use cloud platforms is to improve the
 time-to-market of a new product or application.
 For example, using multiple cloud platforms is viable because
 there is an existing investment in several applications.
 It is faster to tie the investments together rather than migrate
 the components and refactoring them to a single platform.

Business or technical diversity
 Organizations leveraging cloud-based services can embrace business
 diversity and utilize a hybrid cloud design to spread their
 workloads across multiple cloud providers.  This ensures that
 no single cloud provider is the sole host for an application.

Application momentum
 Businesses with existing applications may find that it is
 more cost effective to integrate applications on multiple
 cloud platforms than migrating them to a single platform.

Workload considerations
~~~~~~~~~~~~~~~~~~~~~~~

A workload can be a single application or a suite of applications
that work together. It can also be a duplicate set of applications that
need to run on multiple cloud environments.
In a hybrid cloud deployment, the same workload often needs to function
equally well on radically different public and private cloud environments.
The architecture needs to address these potential conflicts,
complexity, and platform incompatibilities.

Use cases for a hybrid cloud architecture
-----------------------------------------

Dynamic resource expansion or bursting
 An application that requires additional resources may suit a multiple
 cloud architecture. For example, a retailer needs additional resources
 during the holiday season, but does not want to add private cloud
 resources to meet the peak demand.
 The user can accommodate the increased load by bursting to
 a public cloud for these peak load periods. These bursts could be
 for long or short cycles ranging from hourly to yearly.

Disaster recovery and business continuity
 Cheaper storage makes the public cloud suitable for maintaining
 backup applications.

Federated hypervisor and instance management
 Adding self-service, charge back, and transparent delivery of
 the resources from a federated pool can be cost effective.
 In a hybrid cloud environment, this is a particularly important
 consideration. Look for a cloud that provides cross-platform
 hypervisor support and robust instance management tools.

Application portfolio integration
 An enterprise cloud delivers efficient application portfolio
 management and deployments by leveraging self-service features
 and rules according to use.
 Integrating existing cloud environments is a common driver
 when building hybrid cloud architectures.

Migration scenarios
 Hybrid cloud architecture enables the migration of
 applications between different clouds.

High availability
 A combination of locations and platforms enables a level of
 availability that is not possible with a single platform.
 This approach increases design complexity.

As running a workload on multiple cloud platforms increases design
complexity, we recommend first exploring options such as transferring
workloads across clouds at the application, instance, cloud platform,
hypervisor, and network levels.

Tools considerations
~~~~~~~~~~~~~~~~~~~~

Hybrid cloud designs must incorporate tools to facilitate working
across multiple clouds.

Tool functions
--------------

Broker between clouds
 Brokering software evaluates relative costs between different
 cloud platforms. Cloud Management Platforms (CMP)
 allow the designer to determine the right location for the
 workload based on predetermined criteria.

Facilitate orchestration across the clouds
 CMPs simplify the migration of application workloads between
 public, private, and hybrid cloud platforms.
 We recommend using cloud orchestration tools for managing a diverse
 portfolio of systems and applications across multiple cloud platforms.

Network considerations
~~~~~~~~~~~~~~~~~~~~~~

It is important to consider the functionality, security, scalability,
availability, and testability of network when choosing a CMP and cloud
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

Risk mitigation and management considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hybrid cloud architectures introduce additional risk because
they are more complex than a single cloud design and may involve
incompatible components or tools. However, they also reduce
risk by spreading workloads over multiple providers.

Hybrid cloud risks
------------------

Provider availability or implementation details
 Business changes can affect provider availability.
 Likewise, changes in a provider's service can disrupt
 a hybrid cloud environment or increase costs.

Differing SLAs
 Hybrid cloud designs must accommodate differences in SLAs
 between providers, and consider their enforceability.

Security levels
 Securing multiple cloud environments is more complex than
 securing single cloud environments.  We recommend addressing
 concerns at the application, network, and cloud platform levels.
 Be aware that each cloud platform approaches security differently,
 and a hybrid cloud design must address and compensate for these differences.

Provider API changes
 Consumers of external clouds rarely have control over provider
 changes to APIs, and changes can break compatibility.
 Using only the most common and basic APIs can minimize potential conflicts.
