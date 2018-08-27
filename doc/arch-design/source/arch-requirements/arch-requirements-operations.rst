========================
Operational requirements
========================

This section describes operational factors affecting the design of an
OpenStack cloud.

Network design
~~~~~~~~~~~~~~

The network design for an OpenStack cluster includes decisions regarding
the interconnect needs within the cluster, the need to allow clients to
access their resources, and the access requirements for operators to
administrate the cluster. You should consider the bandwidth, latency,
and reliability of these networks.

Consider additional design decisions about monitoring and alarming.
If you are using an external provider, service level agreements (SLAs)
are typically defined in your contract. Operational considerations such
as bandwidth, latency, and jitter can be part of the SLA.

As demand for network resources increase, make sure your network design
accommodates expansion and upgrades. Operators add additional IP address
blocks and add additional bandwidth capacity. In addition, consider
managing hardware and software lifecycle events, for example upgrades,
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
for services that require direct client access from the Internet. Upon
segregating the traffic, consider :term:`quality of service (QoS)` and
security to ensure each network has the required level of service.

Also consider the routing of network traffic. For some applications,
develop a complex policy framework for routing. To create a routing
policy that satisfies business requirements, consider the economic cost
of transmitting traffic over expensive links versus cheaper links, in
addition to bandwidth, latency, and jitter requirements.

Finally, consider how to respond to network events. How load
transfers from one link to another during a failure scenario could be
a factor in the design. If you do not plan network capacity
correctly, failover traffic could overwhelm other ports or network
links and create a cascading failure scenario. In this case,
traffic that fails over to one link overwhelms that link and then
moves to the subsequent links until all network traffic stops.

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

An operations staff supports, manages, and maintains an OpenStack environment.
Their skills may be specialized or varied depending on the size and purpose of
the installation.

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
`OpenStack Operations Guide <https://docs.openstack.org/operations-guide/>`_.

Logging and monitoring
----------------------

OpenStack clouds require appropriate monitoring platforms to identify and
manage errors.

.. note::

   We recommend leveraging existing monitoring systems to see if they
   are able to effectively monitor an OpenStack environment.

Specific meters that are critically important to capture include:

* Image disk utilization

* Response time to the Compute API

Logging and monitoring does not significantly differ for a multi-site OpenStack
cloud. The tools described in the `Logging and monitoring
<https://docs.openstack.org/operations-guide/ops-logging-monitoring.html>`__ in
the Operations Guide remain applicable. Logging and monitoring can be provided
on a per-site basis, and in a common centralized location.

When attempting to deploy logging and monitoring facilities to a centralized
location, care must be taken with the load placed on the inter-site networking
links

Management software
-------------------

Management software providing clustering, logging, monitoring, and alerting
details for a cloud environment is often used.  This impacts and affects the
overall OpenStack cloud design, and must account for the additional resource
consumption such as CPU, RAM, storage, and network
bandwidth.

The inclusion of clustering software, such as Corosync or Pacemaker, is
primarily determined by the availability of the cloud infrastructure and
the complexity of supporting the configuration after it is deployed. The
`OpenStack High Availability Guide <https://docs.openstack.org/ha-guide/>`_
provides more details on the installation and configuration of Corosync
and Pacemaker, should these packages need to be included in the design.

Some other potential design impacts include:

* OS-hypervisor combination
   Ensure that the selected logging, monitoring, or alerting tools support
   the proposed OS-hypervisor combination.

* Network hardware
   The network hardware selection needs to be supported by the logging,
   monitoring, and alerting software.

Database software
-----------------

Most OpenStack components require access to back-end database services
to store state and configuration information. Choose an appropriate
back-end database which satisfies the availability and fault tolerance
requirements of the OpenStack services.

MySQL is the default database for OpenStack, but other compatible
databases are available.

.. note::

   Telemetry uses MongoDB.

The chosen high availability database solution changes according to the
selected database. MySQL, for example, provides several options. Use a
replication technology such as Galera for active-active clustering. For
active-passive use some form of shared storage. Each of these potential
solutions has an impact on the design:

* Solutions that employ Galera/MariaDB require at least three MySQL
  nodes.

* MongoDB has its own design considerations for high availability.

* OpenStack design, generally, does not include shared storage.
  However, for some high availability designs, certain components might
  require it depending on the specific implementation.

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
