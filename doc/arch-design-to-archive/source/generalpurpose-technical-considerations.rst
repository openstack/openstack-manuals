========================
Technical considerations
========================

General purpose clouds are expected to include these base services:

* Compute

* Network

* Storage

Each of these services have different resource requirements. As a
result, you must make design decisions relating directly to the service,
as well as provide a balanced infrastructure for all services.

Take into consideration the unique aspects of each service, as
individual characteristics and service mass can impact the hardware
selection process. Hardware designs should be generated for each of the
services.

Hardware decisions are also made in relation to network architecture and
facilities planning. These factors play heavily into the overall
architecture of an OpenStack cloud.

Compute resource design
~~~~~~~~~~~~~~~~~~~~~~~

When designing compute resource pools, a number of factors can impact
your design decisions. Factors such as number of processors, amount of
memory, and the quantity of storage required for each hypervisor must be
taken into account.

You will also need to decide whether to provide compute resources in a
single pool or in multiple pools. In most cases, multiple pools of
resources can be allocated and addressed on demand. A compute design
that allocates multiple pools of resources makes best use of application
resources, and is commonly referred to as bin packing.

In a bin packing design, each independent resource pool provides service
for specific flavors. This helps to ensure that, as instances are
scheduled onto compute hypervisors, each independent node's resources
will be allocated in a way that makes the most efficient use of the
available hardware. Bin packing also requires a common hardware design,
with all hardware nodes within a compute resource pool sharing a common
processor, memory, and storage layout. This makes it easier to deploy,
support, and maintain nodes throughout their lifecycle.

An overcommit ratio is the ratio of available virtual resources to
available physical resources. This ratio is configurable for CPU and
memory. The default CPU overcommit ratio is 16:1, and the default memory
overcommit ratio is 1.5:1. Determining the tuning of the overcommit
ratios during the design phase is important as it has a direct impact on
the hardware layout of your compute nodes.

When selecting a processor, compare features and performance
characteristics. Some processors include features specific to
virtualized compute hosts, such as hardware-assisted virtualization, and
technology related to memory paging (also known as EPT shadowing). These
types of features can have a significant impact on the performance of
your virtual machine.

You will also need to consider the compute requirements of
non-hypervisor nodes (sometimes referred to as resource nodes). This
includes controller, object storage, and block storage nodes, and
networking services.

The number of processor cores and threads impacts the number of worker
threads which can be run on a resource node. Design decisions must
relate directly to the service being run on it, as well as provide a
balanced infrastructure for all services.

Workload can be unpredictable in a general purpose cloud, so consider
including the ability to add additional compute resource pools on
demand. In some cases, however, the demand for certain instance types or
flavors may not justify individual hardware design. In either case,
start by allocating hardware designs that are capable of servicing the
most common instance requests. If you want to add additional hardware to
the overall architecture, this can be done later.

Designing network resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack clouds generally have multiple network segments, with each
segment providing access to particular resources. The network services
themselves also require network communication paths which should be
separated from the other networks. When designing network services for a
general purpose cloud, plan for either a physical or logical separation
of network segments used by operators and projects. You can also create
an additional network segment for access to internal services such as
the message bus and database used by various services. Segregating these
services onto separate networks helps to protect sensitive data and
protects against unauthorized access to services.

Choose a networking service based on the requirements of your instances.
The architecture and design of your cloud will impact whether you choose
OpenStack Networking (neutron), or legacy networking (nova-network).

Legacy networking (nova-network)
 The legacy networking (nova-network) service is primarily a layer-2
 networking service that functions in two modes, which use VLANs in
 different ways. In a flat network mode, all network hardware nodes
 and devices throughout the cloud are connected to a single layer-2
 network segment that provides access to application data.

 When the network devices in the cloud support segmentation using
 VLANs, legacy networking can operate in the second mode. In this
 design model, each project within the cloud is assigned a network
 subnet which is mapped to a VLAN on the physical network. It is
 especially important to remember the maximum number of 4096 VLANs
 which can be used within a spanning tree domain. This places a hard
 limit on the amount of growth possible within the data center. When
 designing a general purpose cloud intended to support multiple
 projects, we recommend the use of legacy networking with VLANs, and
 not in flat network mode.

Another consideration regarding network is the fact that legacy
networking is entirely managed by the cloud operator; projects do not
have control over network resources. If projects require the ability to
manage and create network resources such as network segments and
subnets, it will be necessary to install the OpenStack Networking
service to provide network access to instances.

Networking (neutron)
 OpenStack Networking (neutron) is a first class networking service
 that gives full control over creation of virtual network resources
 to projects. This is often accomplished in the form of tunneling
 protocols which will establish encapsulated communication paths over
 existing network infrastructure in order to segment project traffic.
 These methods vary depending on the specific implementation, but
 some of the more common methods include tunneling over GRE,
 encapsulating with VXLAN, and VLAN tags.

We recommend you design at least three network segments:

* The first segment is a public network, used for access to REST APIs
  by projects and operators. The controller nodes and swift proxies are
  the only devices connecting to this network segment. In some cases,
  this network might also be serviced by hardware load balancers and
  other network devices.

* The second segment is used by administrators to manage hardware
  resources. Configuration management tools also use this for deploying
  software and services onto new hardware. In some cases, this network
  segment might also be used for internal services, including the
  message bus and database services. This network needs to communicate
  with every hardware node. Due to the highly sensitive nature of this
  network segment, you also need to secure this network from
  unauthorized access.

* The third network segment is used by applications and consumers to
  access the physical network, and for users to access applications.
  This network is segregated from the one used to access the cloud APIs
  and is not capable of communicating directly with the hardware
  resources in the cloud. Compute resource nodes and network gateway
  services which allow application data to access the physical network
  from outside of the cloud need to communicate on this network
  segment.

Designing Object Storage
~~~~~~~~~~~~~~~~~~~~~~~~

When designing hardware resources for OpenStack Object Storage, the
primary goal is to maximize the amount of storage in each resource node
while also ensuring that the cost per terabyte is kept to a minimum.
This often involves utilizing servers which can hold a large number of
spinning disks. Whether choosing to use 2U server form factors with
directly attached storage or an external chassis that holds a larger
number of drives, the main goal is to maximize the storage available in
each node.

.. note::

   We do not recommended investing in enterprise class drives for an
   OpenStack Object Storage cluster. The consistency and partition
   tolerance characteristics of OpenStack Object Storage ensures that
   data stays up to date and survives hardware faults without the use
   of any specialized data replication devices.

One of the benefits of OpenStack Object Storage is the ability to mix
and match drives by making use of weighting within the swift ring. When
designing your swift storage cluster, we recommend making use of the
most cost effective storage solution available at the time.

To achieve durability and availability of data stored as objects it is
important to design object storage resource pools to ensure they can
provide the suggested availability. Considering rack-level and
zone-level designs to accommodate the number of replicas configured to
be stored in the Object Storage service (the default number of replicas
is three) is important when designing beyond the hardware node level.
Each replica of data should exist in its own availability zone with its
own power, cooling, and network resources available to service that
specific zone.

Object storage nodes should be designed so that the number of requests
does not hinder the performance of the cluster. The object storage
service is a chatty protocol, therefore making use of multiple
processors that have higher core counts will ensure the IO requests do
not inundate the server.

Designing Block Storage
~~~~~~~~~~~~~~~~~~~~~~~

When designing OpenStack Block Storage resource nodes, it is helpful to
understand the workloads and requirements that will drive the use of
block storage in the cloud. We recommend designing block storage pools
so that projects can choose appropriate storage solutions for their
applications. By creating multiple storage pools of different types, in
conjunction with configuring an advanced storage scheduler for the block
storage service, it is possible to provide projects with a large catalog
of storage services with a variety of performance levels and redundancy
options.

Block storage also takes advantage of a number of enterprise storage
solutions. These are addressed via a plug-in driver developed by the
hardware vendor. A large number of enterprise storage plug-in drivers
ship out-of-the-box with OpenStack Block Storage (and many more
available via third party channels). General purpose clouds are more
likely to use directly attached storage in the majority of block storage
nodes, deeming it necessary to provide additional levels of service to
projects which can only be provided by enterprise class storage
solutions.

Redundancy and availability requirements impact the decision to use a
RAID controller card in block storage nodes. The input-output per second
(IOPS) demand of your application will influence whether or not you
should use a RAID controller, and which level of RAID is required.
Making use of higher performing RAID volumes is suggested when
considering performance. However, where redundancy of block storage
volumes is more important we recommend making use of a redundant RAID
configuration such as RAID 5 or RAID 6. Some specialized features, such
as automated replication of block storage volumes, may require the use
of third-party plug-ins and enterprise block storage solutions in order
to provide the high demand on storage. Furthermore, where extreme
performance is a requirement it may also be necessary to make use of
high speed SSD disk drives' high performing flash storage solutions.

Software selection
~~~~~~~~~~~~~~~~~~

The software selection process plays a large role in the architecture of
a general purpose cloud. The following have a large impact on the design
of the cloud:

* Choice of operating system

* Selection of OpenStack software components

* Choice of hypervisor

* Selection of supplemental software

Operating system (OS) selection plays a large role in the design and
architecture of a cloud. There are a number of OSes which have native
support for OpenStack including:

* Ubuntu

* Red Hat Enterprise Linux (RHEL)

* CentOS

* SUSE Linux Enterprise Server (SLES)

.. note::

   Native support is not a constraint on the choice of OS; users are
   free to choose just about any Linux distribution (or even Microsoft
   Windows) and install OpenStack directly from source (or compile
   their own packages). However, many organizations will prefer to
   install OpenStack from distribution-supplied packages or
   repositories (although using the distribution vendor's OpenStack
   packages might be a requirement for support).

OS selection also directly influences hypervisor selection. A cloud
architect who selects Ubuntu, RHEL, or SLES has some flexibility in
hypervisor; KVM, Xen, and LXC are supported virtualization methods
available under OpenStack Compute (nova) on these Linux distributions.
However, a cloud architect who selects Windows Server is limited to Hyper-V.
Similarly, a cloud architect who selects XenServer is limited to the
CentOS-based dom0 operating system provided with XenServer.

The primary factors that play into OS-hypervisor selection include:

User requirements
 The selection of OS-hypervisor combination first and foremost needs
 to support the user requirements.

Support
 The selected OS-hypervisor combination needs to be supported by
 OpenStack.

Interoperability
 The OS-hypervisor needs to be interoperable with other features and
 services in the OpenStack design in order to meet the user
 requirements.

Hypervisor
~~~~~~~~~~

OpenStack supports a wide variety of hypervisors, one or more of which
can be used in a single cloud. These hypervisors include:

* KVM (and QEMU)

* XCP/XenServer

* vSphere (vCenter and ESXi)

* Hyper-V

* LXC

* Docker

* Bare-metal

A complete list of supported hypervisors and their capabilities can be
found at `OpenStack Hypervisor Support
Matrix <https://wiki.openstack.org/wiki/HypervisorSupportMatrix>`_.

We recommend general purpose clouds use hypervisors that support the
most general purpose use cases, such as KVM and Xen. More specific
hypervisors should be chosen to account for specific functionality or a
supported feature requirement. In some cases, there may also be a
mandated requirement to run software on a certified hypervisor including
solutions from VMware, Microsoft, and Citrix.

The features offered through the OpenStack cloud platform determine the
best choice of a hypervisor. Each hypervisor has their own hardware
requirements which may affect the decisions around designing a general
purpose cloud.

In a mixed hypervisor environment, specific aggregates of compute
resources, each with defined capabilities, enable workloads to utilize
software and hardware specific to their particular requirements. This
functionality can be exposed explicitly to the end user, or accessed
through defined metadata within a particular flavor of an instance.

OpenStack components
~~~~~~~~~~~~~~~~~~~~

A general purpose OpenStack cloud design should incorporate the core
OpenStack services to provide a wide range of services to end-users. The
OpenStack core services recommended in a general purpose cloud are:

* :term:`Compute service (nova)`

* :term:`Networking service (neutron)`

* :term:`Image service (glance)`

* :term:`Identity service (keystone)`

* :term:`Dashboard (horizon)`

* :term:`Telemetry service (telemetry)`

A general purpose cloud may also include :term:`Object Storage service
(swift)`. :term:`Block Storage service (cinder)`.
These may be selected to provide storage to applications and instances.

Supplemental software
~~~~~~~~~~~~~~~~~~~~~

A general purpose OpenStack deployment consists of more than just
OpenStack-specific components. A typical deployment involves services
that provide supporting functionality, including databases and message
queues, and may also involve software to provide high availability of
the OpenStack environment. Design decisions around the underlying
message queue might affect the required number of controller services,
as well as the technology to provide highly resilient database
functionality, such as MariaDB with Galera. In such a scenario,
replication of services relies on quorum.

Where many general purpose deployments use hardware load balancers to
provide highly available API access and SSL termination, software
solutions, for example HAProxy, can also be considered. It is vital to
ensure that such software implementations are also made highly
available. High availability can be achieved by using software such as
Keepalived or Pacemaker with Corosync. Pacemaker and Corosync can
provide active-active or active-passive highly available configuration
depending on the specific service in the OpenStack environment. Using
this software can affect the design as it assumes at least a 2-node
controller infrastructure where one of those nodes may be running
certain services in standby mode.

Memcached is a distributed memory object caching system, and Redis is a
key-value store. Both are deployed on general purpose clouds to assist
in alleviating load to the Identity service. The memcached service
caches tokens, and due to its distributed nature it can help alleviate
some bottlenecks to the underlying authentication system. Using
memcached or Redis does not affect the overall design of your
architecture as they tend to be deployed onto the infrastructure nodes
providing the OpenStack services.

Controller infrastructure
~~~~~~~~~~~~~~~~~~~~~~~~~

The Controller infrastructure nodes provide management services to the
end-user as well as providing services internally for the operating of
the cloud. The Controllers run message queuing services that carry
system messages between each service. Performance issues related to the
message bus would lead to delays in sending that message to where it
needs to go. The result of this condition would be delays in operation
functions such as spinning up and deleting instances, provisioning new
storage volumes and managing network resources. Such delays could
adversely affect an application’s ability to react to certain
conditions, especially when using auto-scaling features. It is important
to properly design the hardware used to run the controller
infrastructure as outlined above in the Hardware Selection section.

Performance of the controller services is not limited to processing
power, but restrictions may emerge in serving concurrent users. Ensure
that the APIs and Horizon services are load tested to ensure that you
are able to serve your customers. Particular attention should be made to
the OpenStack Identity Service (Keystone), which provides the
authentication and authorization for all services, both internally to
OpenStack itself and to end-users. This service can lead to a
degradation of overall performance if this is not sized appropriately.

Network performance
~~~~~~~~~~~~~~~~~~~

In a general purpose OpenStack cloud, the requirements of the network
help determine performance capabilities. It is possible to design
OpenStack environments that run a mix of networking capabilities. By
utilizing the different interface speeds, the users of the OpenStack
environment can choose networks that are fit for their purpose.

Network performance can be boosted considerably by implementing hardware
load balancers to provide front-end service to the cloud APIs. The
hardware load balancers also perform SSL termination if that is a
requirement of your environment. When implementing SSL offloading, it is
important to understand the SSL offloading capabilities of the devices
selected.

Compute host
~~~~~~~~~~~~

The choice of hardware specifications used in compute nodes including
CPU, memory and disk type directly affects the performance of the
instances. Other factors which can directly affect performance include
tunable parameters within the OpenStack services, for example the
overcommit ratio applied to resources. The defaults in OpenStack Compute
set a 16:1 over-commit of the CPU and 1.5 over-commit of the memory.
Running at such high ratios leads to an increase in "noisy-neighbor"
activity. Care must be taken when sizing your Compute environment to
avoid this scenario. For running general purpose OpenStack environments
it is possible to keep to the defaults, but make sure to monitor your
environment as usage increases.

Storage performance
~~~~~~~~~~~~~~~~~~~

When considering performance of Block Storage, hardware and
architecture choice is important. Block Storage can use enterprise
back-end systems such as NetApp or EMC, scale out storage such as
GlusterFS and Ceph, or simply use the capabilities of directly attached
storage in the nodes themselves. Block Storage may be deployed so that
traffic traverses the host network, which could affect, and be adversely
affected by, the front-side API traffic performance. As such, consider
using a dedicated data storage network with dedicated interfaces on the
Controller and Compute hosts.

When considering performance of Object Storage, a number of design
choices will affect performance. A user’s access to the Object
Storage is through the proxy services, which sit behind hardware load
balancers. By the very nature of a highly resilient storage system,
replication of the data would affect performance of the overall system.
In this case, 10 GbE (or better) networking is recommended throughout
the storage network architecture.

High Availability
~~~~~~~~~~~~~~~~~

In OpenStack, the infrastructure is integral to providing services and
should always be available, especially when operating with SLAs.
Ensuring network availability is accomplished by designing the network
architecture so that no single point of failure exists. A consideration
of the number of switches, routes and redundancies of power should be
factored into core infrastructure, as well as the associated bonding of
networks to provide diverse routes to your highly available switch
infrastructure.

The OpenStack services themselves should be deployed across multiple
servers that do not represent a single point of failure. Ensuring API
availability can be achieved by placing these services behind highly
available load balancers that have multiple OpenStack servers as
members.

OpenStack lends itself to deployment in a highly available manner where
it is expected that at least 2 servers be utilized. These can run all
the services involved from the message queuing service, for example
RabbitMQ or QPID, and an appropriately deployed database service such as
MySQL or MariaDB. As services in the cloud are scaled out, back-end
services will need to scale too. Monitoring and reporting on server
utilization and response times, as well as load testing your systems,
will help determine scale out decisions.

Care must be taken when deciding network functionality. Currently,
OpenStack supports both the legacy networking (nova-network) system and
the newer, extensible OpenStack Networking (neutron). Both have their
pros and cons when it comes to providing highly available access. Legacy
networking, which provides networking access maintained in the OpenStack
Compute code, provides a feature that removes a single point of failure
when it comes to routing, and this feature is currently missing in
OpenStack Networking. The effect of legacy networking’s multi-host
functionality restricts failure domains to the host running that
instance.

When using Networking, the OpenStack controller servers or
separate Networking hosts handle routing. For a deployment that requires
features available in only Networking, it is possible to remove this
restriction by using third party software that helps maintain highly
available L3 routes. Doing so allows for common APIs to control network
hardware, or to provide complex multi-tier web applications in a secure
manner. It is also possible to completely remove routing from
Networking, and instead rely on hardware routing capabilities. In this
case, the switching infrastructure must support L3 routing.

OpenStack Networking and legacy networking both have their advantages
and disadvantages. They are both valid and supported options that fit
different network deployment models described in the
`Networking deployment options table <https://docs.openstack.org/ops-guide/arch-network-design.html#network-topology>`
of OpenStack Operations Guide.

Ensure your deployment has adequate back-up capabilities.

Application design must also be factored into the capabilities of the
underlying cloud infrastructure. If the compute hosts do not provide a
seamless live migration capability, then it must be expected that when a
compute host fails, that instance and any data local to that instance
will be deleted. However, when providing an expectation to users that
instances have a high-level of uptime guarantees, the infrastructure
must be deployed in a way that eliminates any single point of failure
when a compute host disappears. This may include utilizing shared file
systems on enterprise storage or OpenStack Block storage to provide a
level of guarantee to match service features.

For more information on high availability in OpenStack, see the
`OpenStack High Availability
Guide <https://docs.openstack.org/ha-guide/>`_.

Security
~~~~~~~~

A security domain comprises users, applications, servers or networks
that share common trust requirements and expectations within a system.
Typically they have the same authentication and authorization
requirements and users.

These security domains are:

* Public

* Guest

* Management

* Data

These security domains can be mapped to an OpenStack deployment
individually, or combined. In each case, the cloud operator should be
aware of the appropriate security concerns. Security domains should be
mapped out against your specific OpenStack deployment topology. The
domains and their trust requirements depend upon whether the cloud
instance is public, private, or hybrid.

* The public security domain is an entirely untrusted area of the cloud
  infrastructure. It can refer to the internet as a whole or simply to
  networks over which you have no authority. This domain should always
  be considered untrusted.

* The guest security domain handles compute data generated by instances
  on the cloud but not services that support the operation of the
  cloud, such as API calls. Public cloud providers and private cloud
  providers who do not have stringent controls on instance use or who
  allow unrestricted internet access to instances should consider this
  domain to be untrusted. Private cloud providers may want to consider
  this network as internal and therefore trusted only if they have
  controls in place to assert that they trust instances and all their
  projects.

* The management security domain is where services interact. Sometimes
  referred to as the control plane, the networks in this domain
  transport confidential data such as configuration parameters, user
  names, and passwords. In most deployments this domain is considered
  trusted.

* The data security domain is concerned primarily with information
  pertaining to the storage services within OpenStack. Much of the data
  that crosses this network has high integrity and confidentiality
  requirements and, depending on the type of deployment, may also have
  strong availability requirements. The trust level of this network is
  heavily dependent on other deployment decisions.

When deploying OpenStack in an enterprise as a private cloud it is
usually behind the firewall and within the trusted network alongside
existing systems. Users of the cloud are employees that are bound by the
security requirements set forth by the company. This tends to push most
of the security domains towards a more trusted model. However, when
deploying OpenStack in a public facing role, no assumptions can be made
and the attack vectors significantly increase.

Consideration must be taken when managing the users of the system for
both public and private clouds. The identity service allows for LDAP to
be part of the authentication process. Including such systems in an
OpenStack deployment may ease user management if integrating into
existing systems.

It is important to understand that user authentication requests include
sensitive information including user names, passwords, and
authentication tokens. For this reason, placing the API services behind
hardware that performs SSL termination is strongly recommended.

For more information OpenStack Security, see the `OpenStack Security
Guide <https://docs.openstack.org/security-guide/>`_.
