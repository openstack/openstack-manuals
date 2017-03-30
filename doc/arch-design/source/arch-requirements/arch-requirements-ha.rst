.. _high-availability:

=================
High availability
=================

Data plane and control plane
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When designing an OpenStack cloud, it is important to consider the needs
dictated by the :term:`Service Level Agreement (SLA)`. This includes the core
services required to maintain availability of running Compute service
instances, networks, storage, and additional services running on top of those
resources. These services are often referred to as the Data Plane services,
and are generally expected to be available all the time.

The remaining services, responsible for create, read, update and delete (CRUD)
operations, metering, monitoring, and so on, are often referred to as the
Control Plane. The SLA is likely to dictate a lower uptime requirement for
these services.

The services comprising an OpenStack cloud have a number of requirements that
you need to understand in order to be able to meet SLA terms. For example, in
order to provide the Compute service a minimum of storage, message queueing and
database services are necessary as well as the networking between
them.

Ongoing maintenance operations are made much simpler if there is logical and
physical separation of Data Plane and Control Plane systems. It then becomes
possible to, for example, reboot a controller without affecting customers.
If one service failure affects the operation of an entire server (``noisy
neighbor``), the separation between Control and Data Planes enables rapid
maintenance with a limited effect on customer operations.

Eliminating single points of failure within each site
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack lends itself to deployment in a highly available manner where it is
expected that at least 2 servers be utilized. These can run all the services
involved from the message queuing service, for example ``RabbitMQ`` or
``QPID``, and an appropriately deployed database service such as ``MySQL`` or
``MariaDB``. As services in the cloud are scaled out, back-end services will
need to scale too. Monitoring and reporting on server utilization and response
times, as well as load testing your systems, will help determine scale out
decisions.

The OpenStack services themselves should be deployed across multiple servers
that do not represent a single point of failure. Ensuring availability can
be achieved by placing these services behind highly available load balancers
that have multiple OpenStack servers as members.

There are a small number of OpenStack services which are intended to only run
in one place at a time (for example, the ``ceilometer-agent-central`` service)
. In order to prevent these services from becoming a single point of failure,
they can be controlled by clustering software such as ``Pacemaker``.

In OpenStack, the infrastructure is integral to providing services and should
always be available, especially when operating with SLAs. Ensuring network
availability is accomplished by designing the network architecture so that no
single point of failure exists. A consideration of the number of switches,
routes and redundancies of power should be factored into core infrastructure,
as well as the associated bonding of networks to provide diverse routes to your
highly available switch infrastructure.

Care must be taken when deciding network functionality. Currently, OpenStack
supports both the legacy networking (nova-network) system and the newer,
extensible OpenStack Networking (neutron). OpenStack Networking and legacy
networking both have their advantages and disadvantages. They are both valid
and supported options that fit different network deployment models described in
the `OpenStack Operations Guide
<https://docs.openstack.org/ops-guide/arch_network_design.html#network-topology>`_.

When using the Networking service, the OpenStack controller servers or separate
Networking hosts handle routing unless the dynamic virtual routers pattern for
routing is selected. Running routing directly on the controller servers mixes
the Data and Control Planes and can cause complex issues with performance and
troubleshooting. It is possible to use third party software and external
appliances that help maintain highly available layer three routes. Doing so
allows for common application endpoints to control network hardware, or to
provide complex multi-tier web applications in a secure manner. It is also
possible to completely remove routing from Networking, and instead rely on
hardware routing capabilities. In this case, the switching infrastructure must
support layer three routing.

Application design must also be factored into the capabilities of the
underlying cloud infrastructure. If the compute hosts do not provide a seamless
live migration capability, then it must be expected that if a compute host
fails, that instance and any data local to that instance will be deleted.
However, when providing an expectation to users that instances have a
high-level of uptime guaranteed, the infrastructure must be deployed in a way
that eliminates any single point of failure if a compute host disappears.
This may include utilizing shared file systems on enterprise storage or
OpenStack Block storage to provide a level of guarantee to match service
features.

If using a storage design that includes shared access to centralized storage,
ensure that this is also designed without single points of failure and the SLA
for the solution matches or exceeds the expected SLA for the Data Plane.

Eliminating single points of failure in a multi-region design
-------------------------------------------------------------

Some services are commonly shared between multiple regions, including the
Identity service and the Dashboard. In this case, it is necessary to ensure
that the databases backing the services are replicated, and that access to
multiple workers across each site can be maintained in the event of losing a
single region.

Multiple network links should be deployed between sites to provide redundancy
for all components. This includes storage replication, which should be isolated
to a dedicated network or VLAN with the ability to assign QoS to control the
replication traffic or provide priority for this traffic.

.. note::

   If the data store is highly changeable, the network requirements could have
   a significant effect on the operational cost of maintaining the sites.

If the design incorporates more than one site, the ability to maintain object
availability in both sites has significant implications on the Object Storage
design and implementation. It also has a significant impact on the WAN network
design between the sites.

If applications running in a cloud are not cloud-aware, there should be clear
measures and expectations to define what the infrastructure can and cannot
support. An example would be shared storage between sites. It is possible,
however such a solution is not native to OpenStack and requires a third-party
hardware vendor to fulfill such a requirement. Another example can be seen in
applications that are able to consume resources in object storage directly.

Connecting more than two sites increases the challenges and adds more
complexity to the design considerations. Multi-site implementations require
planning to address the additional topology used for internal and external
connectivity. Some options include full mesh topology, hub spoke, spine leaf,
and 3D Torus.

For more information on high availability in OpenStack, see the `OpenStack High
Availability Guide <https://docs.openstack.org/ha-guide/>`_.

Site loss and recovery
~~~~~~~~~~~~~~~~~~~~~~

Outages can cause partial or full loss of site functionality. Strategies
should be implemented to understand and plan for recovery scenarios.

*  The deployed applications need to continue to function and, more
   importantly, you must consider the impact on the performance and
   reliability of the application if a site is unavailable.

*  It is important to understand what happens to the replication of
   objects and data between the sites when a site goes down. If this
   causes queues to start building up, consider how long these queues
   can safely exist until an error occurs.

*  After an outage, ensure that operations of a site are resumed when it
   comes back online. We recommend that you architect the recovery to
   avoid race conditions.


Replicating inter-site data
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Traditionally, replication has been the best method of protecting object store
implementations. A variety of replication methods exist in storage
architectures, for example synchronous and asynchronous mirroring. Most object
stores and back-end storage systems implement methods for replication at the
storage subsystem layer. Object stores also tailor replication techniques to
fit a cloud's requirements.

Organizations must find the right balance between data integrity and data
availability. Replication strategy may also influence disaster recovery
methods.

Replication across different racks, data centers, and geographical regions
increases focus on determining and ensuring data locality. The ability to
guarantee data is accessed from the nearest or fastest storage can be necessary
for applications to perform well.

.. note::

   When running embedded object store methods, ensure that you do not
   instigate extra data replication as this may cause performance issues.
