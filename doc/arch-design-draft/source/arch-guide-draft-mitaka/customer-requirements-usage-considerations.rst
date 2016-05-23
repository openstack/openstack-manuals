====================
Usage considerations
====================

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


Cloud type
~~~~~~~~~~

Public cloud
 For a company interested in building a commercial public cloud
 offering based on OpenStack, the general purpose architecture model
 might be the best choice. Designers are not always going to know the
 purposes or workloads for which the end users will use the cloud.

Internal consumption (private) cloud
 Organizations need to determine if it is logical to create their own
 clouds internally. Using a private cloud, organizations are able to
 maintain complete control over architectural and cloud components.

Hybrid cloud
 Users may want to combine using the internal cloud with access
 to an external cloud. If that case is likely, it might be worth
 exploring the possibility of taking a multi-cloud approach with
 regard to at least some of the architectural elements.


Tools
~~~~~

Complex clouds, in particular hybrid clouds, may require tools to
facilitate working across multiple clouds.

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


Workload considerations
~~~~~~~~~~~~~~~~~~~~~~~

A workload can be a single application or a suite of applications
that work together. It can also be a duplicate set of applications that
need to run on multiple cloud environments.

In a hybrid cloud deployment, the same workload often needs to function
equally well on radically different public and private cloud environments.
The architecture needs to address these potential conflicts,
complexity, and platform incompatibilities.

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


Capacity planning
~~~~~~~~~~~~~~~~~

Capacity and the placement of workloads are key design considerations
for clouds. One of the primary reasons many organizations use a hybrid cloud
is to increase capacity without making large capital investments.
The long-term capacity plan for these designs must
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


Authentication
~~~~~~~~~~~~~~

It is recommended to have a single authentication domain rather than a
separate implementation for each and every site. This requires an
authentication mechanism that is highly available and distributed to
ensure continuous operation. Authentication server locality might be
required and should be planned for.


Storage
~~~~~~~

OpenStack compatibility
 Interoperability and integration with OpenStack can be paramount in
 deciding on a storage hardware and storage management platform.
 Interoperability and integration includes factors such as OpenStack
 Block Storage interoperability, OpenStack Object Storage
 compatibility, and hypervisor compatibility (which affects the
 ability to use storage for ephemeral instance storage).

Storage management
 You must address a range of storage management-related
 considerations in the design of a storage-focused OpenStack cloud.
 These considerations include, but are not limited to, backup
 strategy (and restore strategy, since a backup that cannot be
 restored is useless), data valuation-hierarchical storage
 management, retention strategy, data placement, and workflow
 automation.

Data grids
 Data grids are helpful when answering questions around data
 valuation. Data grids improve decision making through correlation of
 access patterns, ownership, and business-unit revenue with other
 metadata values to deliver actionable information about data.
