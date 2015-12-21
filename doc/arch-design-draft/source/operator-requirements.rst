=====================
Operator requirements
=====================

.. toctree::
   :maxdepth: 2


Introduction
~~~~~~~~~~~~

Several operational factors affect the design choices for a general
purpose cloud. Operations staff receive tasks regarding the maintenance
of cloud environments, including:

Maintenance tasks
    Operating system patching, hardware/firmware upgrades, and datacenter
    related changes, as well as minor and release upgrades to OpenStack
    components are all ongoing operational tasks. In particular, the six
    monthly release cycle of the OpenStack projects needs to be considered as
    part of the cost of ongoing maintenance. The solution should take into
    account storage and network maintenance and the impact on underlying
    workloads.

Reliability and availability
    Reliability and availability depend on the many supporting components'
    availability and on the level of precautions taken by the service provider.
    This includes network, storage systems, datacenter, and operating systems.

In order to run efficiently, automate as many of the operational processes as
possible. Automation includes the configuration of provisioning, monitoring and
alerting systems. Part of the automation process includes the capability to
determine when human intervention is required and who should act.  The
objective is to increase the ratio of operational staff to running systems as
much as possible in order to reduce maintenance costs. In a massively scaled
environment, it is very difficult for staff to give each system individual
care.

Configuration management tools such as Ansible, Puppet, and Chef enable
operations staff to categorize systems into groups based on their roles and
thus create configurations and system states that the provisioning system
enforces.  Systems that fall out of the defined state due to errors or failures
are quickly removed from the pool of active nodes and replaced.

At large scale, the resource cost of diagnosing failed individual systems is
far greater than the cost of replacement. It is more economical to replace the
failed system with a new system, provisioning and configuring it automatically
and adding it to the pool of active nodes. By automating tasks that are
labor-intensive, repetitive, and critical to operations, cloud operations
teams can work more efficiently because fewer resources are required for these
common tasks. Administrators are then free to tackle tasks that are not easy
to automate and that have longer-term impacts on the business, for example,
capacity planning.


SLA Considerations
~~~~~~~~~~~~~~~~~~

Service-level agreements (SLAs) are contractual obligations that ensure the
availability of a service. When designing an OpenStack cloud, factoring in
promises of availability implies a certain level of redundancy and resiliency.

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

In any environment larger than just a few hosts, it is important to note that
there are two separate areas that might be subject to an SLA. Firstly, the
services that provide actual virtualization, networking and storage, are
subject to an SLA that customers of the environment are most likely to want to
be continuously available.  This is often referred to as the 'Data Plane'.

Secondly, there are the ancillary services such as API endpoints, and the
various services that control CRUD operations. These are often referred to as
the 'Control Plane'. The services in this category are usually subject to a
different SLA expectation and therefore may be better suited on separate
hardware or at least containers from the Data Plane services.

To effectively run cloud installations, initial downtime planning
includes creating processes and architectures that support the
following:

* Planned (maintenance)
* Unplanned (system faults)

It is important to determine as part of the SLA negotiation which party is
responsible for monitoring and starting up Compute service Instances should an
outage occur which shuts them down.

Resiliency of overall system and individual components are going to be
dictated by the requirements of the SLA, meaning designing for
:term:`high availability (HA)` can have cost ramifications.

When upgrading, patching and changing configuration items this may require
downtime for some services.  In these cases, stopping services that form the
Control Plane may leave the Data Plane unaffected, while actions such as
live-migration of Compute instances may be required in order to perform any
actions that require downtime to Data Plane components whilst still meeting SLA
expectations.

Note that there are many services that are outside the realms of pure OpenStack
code which affects the ability of any given design to meet SLA, including:

* Database services, such as ``MySQL`` or ``PostgreSQL``.
* Services providing RPC, such as ``RabbitMQ``.
* External network attachments.
* Physical constraints such as power, rack space, network cabling, etc.
* Shared storage including SAN based arrays, storage clusters such as ``Ceph``,
  and/or NFS services.

Depending on the design, some Network service functions may fall into both the
Control and Data Plane categories.  E.g. the neutron L3 Agent service may be
considered a Control Plane component, but the routers themselves would be Data
Plane.

It may be that a given set of requirements could dictate an SLA that suggests
some services need HA, and some do not.

In a design with multiple regions, the SLA would also need to take into
consideration the use of shared services such as the Identity service,
Dashboard, and so on.

Any SLA negotiation must also take into account the reliance on 3rd parties for
critical aspects of the design - for example, if there is an existing SLA on a
component such as a storage system, the cloud SLA must take into account this
limitation.  If the required SLA for the cloud exceeds the agreed uptime levels
of the components comprising that cloud, additional redundancy would be
required.  This consideration is critical to review in a hybrid cloud design,
where there are multiple 3rd parties involved.

Logging and Monitoring
~~~~~~~~~~~~~~~~~~~~~~

OpenStack clouds require appropriate monitoring platforms to catch and
manage errors.

.. note::

   We recommend leveraging existing monitoring systems to see if they
   are able to effectively monitor an OpenStack environment.

Specific meters that are critically important to capture include:

* Image disk utilization

* Response time to the Compute API

Logging and monitoring does not significantly differ for a multi-site OpenStack
cloud. The tools described in the `Logging and monitoring chapter
<http://docs.openstack.org/openstack-ops/content/logging_monitoring.html>`__ of
the Operations Guide remain applicable. Logging and monitoring can be provided
on a per-site basis, and in a common centralized location.

When attempting to deploy logging and monitoring facilities to a centralized
location, care must be taken with the load placed on the inter-site networking
links.



Network
~~~~~~~

The network design for an OpenStack cluster includes decisions regarding
the interconnect needs within the cluster, plus the need to allow clients to
access their resources, and for operators to access the cluster for
maintenance.  The bandwidth, latency, and reliability of these networks needs
consideration.

Make additional design decisions about monitoring and alarming. This can
be an internal responsibility or the responsibility of the external
provider. In the case of using an external provider, service level
agreements (SLAs) likely apply. In addition, other operational
considerations such as bandwidth, latency, and jitter can be part of an
SLA.

Consider the ability to upgrade the infrastructure. As demand for
network resources increase, operators add additional IP address blocks
and add additional bandwidth capacity. In addition, consider managing
hardware and software life cycle events, for example upgrades,
decommissioning, and outages, while avoiding service interruptions for
tenants.

Factor maintainability into the overall network design. This includes
the ability to manage and maintain IP addresses as well as the use of
overlay identifiers including VLAN tag IDs, GRE tunnel IDs, and MPLS
tags. As an example, if you may need to change all of the IP addresses
on a network, a process known as renumbering, then the design must
support this function.

Address network-focused applications when considering certain
operational realities. For example, consider the impending exhaustion of
IPv4 addresses, the migration to IPv6, and the use of private networks
to segregate different types of traffic that an application receives or
generates. In the case of IPv4 to IPv6 migrations, applications should
follow best practices for storing IP addresses. We recommend you avoid
relying on IPv4 features that did not carry over to the IPv6 protocol or
have differences in implementation.

To segregate traffic, allow applications to create a private tenant
network for database and storage network traffic. Use a public network
for services that require direct client access from the internet. Upon
segregating the traffic, consider quality of service (QoS) and security
to ensure each network has the required level of service.

Finally, consider the routing of network traffic. For some applications,
develop a complex policy framework for routing. To create a routing
policy that satisfies business requirements, consider the economic cost
of transmitting traffic over expensive links versus cheaper links, in
addition to bandwidth, latency, and jitter requirements.

Additionally, consider how to respond to network events. As an example,
how load transfers from one link to another during a failure scenario
could be a factor in the design. If you do not plan network capacity
correctly, failover traffic could overwhelm other ports or network links
and create a cascading failure scenario. In this case, traffic that
fails over to one link overwhelms that link and then moves to the
subsequent links until all network traffic stops.


Licensing
~~~~~~~~~

The many different forms of license agreements for software are often written
with the use of dedicated hardware in mind.  This model is relevant for the
cloud platform itself, including the hypervisor operating system, supporting
software for items such as database, RPC, backup, and so on.  Consideration
must be made when offering Compute service instances and applications to end
users of the cloud, since the license terms for that software may need some
adjustment to be able to operate economically in the cloud.

Multi-site OpenStack deployments present additional licensing
considerations over and above regular OpenStack clouds, particularly
where site licenses are in use to provide cost efficient access to
software licenses. The licensing for host operating systems, guest
operating systems, OpenStack distributions (if applicable),
software-defined infrastructure including network controllers and
storage systems, and even individual applications need to be evaluated.

Topics to consider include:

* The definition of what constitutes a site in the relevant licenses,
  as the term does not necessarily denote a geographic or otherwise
  physically isolated location.

* Differentiations between "hot" (active) and "cold" (inactive) sites,
  where significant savings may be made in situations where one site is
  a cold standby for disaster recovery purposes only.

* Certain locations might require local vendors to provide support and
  services for each site which may vary with the licensing agreement in
  place.

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

Operator access to systems
~~~~~~~~~~~~~~~~~~~~~~~~~~

As more and more applications are migrated into a Cloud based environment, we
get to a position where systems that are critical for Cloud operations are
hosted within the cloud that is being operated.  Consideration must be given to
the ability for operators to be able to access the systems and tools required
in order to resolve a major incident.

If a significant portion of the cloud is on externally managed systems,
prepare for situations where it may not be possible to make changes.
Additionally, providers may differ on how infrastructure must be managed and
exposed. This can lead to delays in root cause analysis where each insists the
blame lies with the other provider.

Ensure that the network structure connects all clouds to form an integrated
system, keeping in mind the state of handoffs. These handoffs must both be as
reliable as possible and include as little latency as possible to ensure the
best performance of the overall system.

Capacity planning
~~~~~~~~~~~~~~~~~

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

Quota management
~~~~~~~~~~~~~~~~

Quotas are used to set operational limits to prevent system capacities
from being exhausted without notification. They are currently enforced
at the tenant (or project) level rather than at the user level.

Quotas are defined on a per-region basis. Operators can define identical
quotas for tenants in each region of the cloud to provide a consistent
experience, or even create a process for synchronizing allocated quotas
across regions. It is important to note that only the operational limits
imposed by the quotas will be aligned consumption of quotas by users
will not be reflected between regions.

For example, given a cloud with two regions, if the operator grants a
user a quota of 25 instances in each region then that user may launch a
total of 50 instances spread across both regions. They may not, however,
launch more than 25 instances in any single region.

For more information on managing quotas refer to the `Managing projects
and users
chapter <http://docs.openstack.org/openstack-ops/content/projects_users.html>`__
of the OpenStack Operators Guide.

Policy management
~~~~~~~~~~~~~~~~~

OpenStack provides a default set of Role Based Access Control (RBAC)
policies, defined in a ``policy.json`` file, for each service. Operators
edit these files to customize the policies for their OpenStack
installation. If the application of consistent RBAC policies across
sites is a requirement, then it is necessary to ensure proper
synchronization of the ``policy.json`` files to all installations.

This must be done using system administration tools such as rsync as
functionality for synchronizing policies across regions is not currently
provided within OpenStack.

Selecting Hardware
~~~~~~~~~~~~~~~~~~


Integration with external IDP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Upgrades
~~~~~~~~

Running OpenStack with a focus on availability requires striking a balance
between stability and features. For example, it might be tempting to run an
older stable release branch of OpenStack to make deployments easier. However
known issues that may be of some concern or only have minimal impact in smaller
deployments could become pain points as scale increases. Recent releases may
address well known issues. The OpenStack community can help resolve reported
issues by applying the collective expertise of the OpenStack developers.

In multi-site OpenStack clouds deployed using regions, sites are
independent OpenStack installations which are linked together using
shared centralized services such as OpenStack Identity. At a high level
the recommended order of operations to upgrade an individual OpenStack
environment is (see the `Upgrades
chapter <http://docs.openstack.org/openstack-ops/content/ops_upgrades-general-steps.html>`__
of the Operations Guide for details):

#. Upgrade the OpenStack Identity service (keystone).

#. Upgrade the OpenStack Image service (glance).

#. Upgrade OpenStack Compute (nova), including networking components.

#. Upgrade OpenStack Block Storage (cinder).

#. Upgrade the OpenStack dashboard (horizon).

The process for upgrading a multi-site environment is not significantly
different:

#. Upgrade the shared OpenStack Identity service (keystone) deployment.

#. Upgrade the OpenStack Image service (glance) at each site.

#. Upgrade OpenStack Compute (nova), including networking components, at
   each site.

#. Upgrade OpenStack Block Storage (cinder) at each site.

#. Upgrade the OpenStack dashboard (horizon), at each site or in the
   single central location if it is shared.

Compute upgrades within each site can also be performed in a rolling
fashion. Compute controller services (API, Scheduler, and Conductor) can
be upgraded prior to upgrading of individual compute nodes. This allows
operations staff to keep a site operational for users of Compute
services while performing an upgrade.


The bleeding edge
-----------------

The number of organizations running at massive scales is a small proportion of
the OpenStack community, therefore it is important to share related issues
with the community and be a vocal advocate for resolving them. Some issues
only manifest when operating at large scale, and the number of organizations
able to duplicate and validate an issue is small, so it is important to
document and dedicate resources to their resolution.

In some cases, the resolution to the problem is ultimately to deploy a more
recent version of OpenStack. Alternatively, when you must resolve an issue in
a production environment where rebuilding the entire environment is not an
option, it is sometimes possible to deploy updates to specific underlying
components in order to resolve issues or gain significant performance
improvements. Although this may appear to expose the deployment to increased
risk and instability, in many cases it could be an undiscovered issue.

We recommend building a development and operations organization that is
responsible for creating desired features, diagnosing and resolving issues,
and building the infrastructure for large scale continuous integration tests
and continuous deployment. This helps catch bugs early and makes deployments
faster and easier. In addition to development resources, we also recommend the
recruitment of experts in the fields of message queues, databases, distributed
systems, networking, cloud, and storage.


Skills and training
~~~~~~~~~~~~~~~~~~~

Projecting growth for storage, networking, and compute is only one aspect of a
growth plan for running OpenStack at massive scale. Growing and nurturing
development and operational staff is an additional consideration. Sending team
members to OpenStack conferences, meetup events, and encouraging active
participation in the mailing lists and committees is a very important way to
maintain skills and forge relationships in the community. For a list of
OpenStack training providers in the marketplace, see:
http://www.openstack.org/marketplace/training/.

