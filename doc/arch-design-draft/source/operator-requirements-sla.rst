==================
SLA considerations
==================

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
