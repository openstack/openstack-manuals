=====================
Operator requirements
=====================

This section describes operational factors affecting the design of an
OpenStack cloud.

SLA considerations
~~~~~~~~~~~~~~~~~~

Service-level agreements (SLAs) define the levels of availability that will
impact the design of an OpenStack cloud to provide redundancy and high
availability.

SLA terms that affect the design include:

* API availability guarantees implying multiple infrastructure services
  and highly available load balancers.

* Network uptime guarantees affecting switch design, which might
  require redundant switching and power.

* Networking security policy requirements.

In any environment larger than just a few hosts, there are two areas
that might be subject to a SLA:

* Data Plane - services that provide virtualization, networking, and
  storage. Customers usually require these services to be continuously
  available.

* Control Plane - ancillary services such as API endpoints, and services that
  control CRUD operations. The services in this category are usually subject to
  a different SLA expectation and may be better suited on separate
  hardware or containers from the Data Plane services.

To effectively run cloud installations, initial downtime planning includes
creating processes and architectures that support planned maintenance
and unplanned system faults.

It is important to determine as part of the SLA negotiation which party is
responsible for monitoring and starting up the Compute service instances if an
outage occurs.

Upgrading, patching, and changing configuration items may require
downtime for some services. Stopping services that form the Control Plane may
not impact the Data Plane. Live-migration of Compute instances may be required
to perform any actions that require downtime to Data Plane components.

There are many services outside the realms of pure OpenStack
code which affects the ability of a cloud design to meet SLAs, including:

* Database services, such as ``MySQL`` or ``PostgreSQL``.
* Services providing RPC, such as ``RabbitMQ``.
* External network attachments.
* Physical constraints such as power, rack space, network cabling, etc.
* Shared storage including SAN based arrays, storage clusters such as ``Ceph``,
  and/or NFS services.

Depending on the design, some network service functions may fall into both the
Control and Data Plane categories. For example, the neutron L3 Agent service
may be considered a Control Plane component, but the routers themselves would
be a Data Plane component.

In a design with multiple regions, the SLA would also need to take into
consideration the use of shared services such as the Identity service
and Dashboard.

Any SLA negotiation must also take into account the reliance on third parties
for critical aspects of the design. For example, if there is an existing SLA
on a component such as a storage system, the SLA must take into account this
limitation. If the required SLA for the cloud exceeds the agreed uptime levels
of the cloud components, additional redundancy would be required. This
consideration is critical in a hybrid cloud design, where there are multiple
third parties involved.

Support and maintenance
~~~~~~~~~~~~~~~~~~~~~~~

An operations staff supports, manages, and maintains an OpenStack
environment. Their skills may be specialised or varied depending
on the size and purpose of the installation.

The maintenance function of an operator should be taken into consideration:

Maintenance tasks
 Operating system patching, hardware/firmware upgrades, and datacenter
 related changes, as well as minor and release upgrades to OpenStack
 components are all ongoing operational tasks. The six monthly release
 cycle of the OpenStack projects needs to be considered as part of the
 cost of ongoing maintenance. The solution should take into account
 storage and network maintenance and the impact on underlying
 workloads.

Reliability and availability
 Reliability and availability depend on the many supporting components'
 availability and on the level of precautions taken by the service provider.
 This includes network, storage systems, datacenter, and operating systems.

For more information on
managing and maintaining your OpenStack environment, see the
`Operations chapter <http://docs.openstack.org/ops-guide/operations.html>`_
in the OpenStack Operations Guide.

Operator access to systems
~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a trend for cloud operations systems being hosted within the cloud
environment. Operators require access to these systems to resolve a major
incident.

Ensure that the network structure connects all clouds to form an integrated
system. Also consider the state of handoffs which must be reliable and have
minimal latency for optimal performance of the system.

If a significant portion of the cloud is on externally managed systems,
prepare for situations where it may not be possible to make changes.
Additionally, cloud providers may differ on how infrastructure must be managed
and exposed. This can lead to delays in root cause analysis where a provider
insists the blame lies with the other provider.

Quota management
~~~~~~~~~~~~~~~~

Quotas are used to set operational limits to prevent system capacities
from being exhausted without notification. For more
information on managing quotas refer to the `Managing projects and users
chapter <http://docs.openstack.org/ops-guide/ops-projects-users.html>`__
of the OpenStack Operations Guide.

Policy management
~~~~~~~~~~~~~~~~~

OpenStack provides a default set of Role Based Access Control (RBAC)
policies, defined in a ``policy.json`` file, for each service. If consistent
RBAC policies across sites is a requirement, ensure proper synchronization of
the ``policy.json`` files to all installations using system administration
tools such as rsync.

