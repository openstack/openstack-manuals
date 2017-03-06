.. _capacity-planning-scaling:

=============================
Capacity planning and scaling
=============================

Whereas traditional applications required larger hardware to scale
(vertical scaling), cloud-based applications typically request more,
discrete hardware (horizontal scaling).

OpenStack is designed to be horizontally scalable. Rather than switching
to larger servers, you procure more servers and simply install identically
configured services. Ideally, you scale out and load balance among groups of
functionally identical services (for example, compute nodes or ``nova-api``
nodes), that communicate on a message bus.

The Starting Point
~~~~~~~~~~~~~~~~~~

Determining the scalability of your cloud and how to improve it requires
balancing many variables. No one solution meets everyone's scalability goals.
However, it is helpful to track a number of metrics. Since you can define
virtual hardware templates, called "flavors" in OpenStack, you can start to
make scaling decisions based on the flavors you'll provide. These templates
define sizes for memory in RAM, root disk size, amount of ephemeral data disk
space available, and number of cores for starters.

The default OpenStack flavors are shown in :ref:`table_default_flavors`.

.. _table_default_flavors:

.. list-table:: Table. OpenStack default flavors
   :widths: 20 20 20 20 20
   :header-rows: 1

   * - Name
     - Virtual cores
     - Memory
     - Disk
     - Ephemeral
   * - m1.tiny
     - 1
     - 512 MB
     - 1 GB
     - 0 GB
   * - m1.small
     - 1
     - 2 GB
     - 10 GB
     - 20 GB
   * - m1.medium
     - 2
     - 4 GB
     - 10 GB
     - 40 GB
   * - m1.large
     - 4
     - 8 GB
     - 10 GB
     - 80 GB
   * - m1.xlarge
     - 8
     - 16 GB
     - 10 GB
     - 160 GB

The starting point is the core count of your cloud. By applying
some ratios, you can gather information about:

-  The number of virtual machines (VMs) you expect to run,
   ``((overcommit fraction × cores) / virtual cores per instance)``

-  How much storage is required ``(flavor disk size × number of instances)``

You can use these ratios to determine how much additional infrastructure
you need to support your cloud.

Here is an example using the ratios for gathering scalability
information for the number of VMs expected as well as the storage
needed. The following numbers support (200 / 2) × 16 = 1600 VM instances
and require 80 TB of storage for ``/var/lib/nova/instances``:

-  200 physical cores.

-  Most instances are size m1.medium (two virtual cores, 50 GB of
   storage).

-  Default CPU overcommit ratio (``cpu_allocation_ratio`` in nova.conf)
   of 16:1.

.. note::
   Regardless of the overcommit ratio, an instance can not be placed
   on any physical node with fewer raw (pre-overcommit) resources than
   instance flavor requires.

However, you need more than the core count alone to estimate the load
that the API services, database servers, and queue servers are likely to
encounter. You must also consider the usage patterns of your cloud.

As a specific example, compare a cloud that supports a managed
web-hosting platform with one running integration tests for a
development project that creates one VM per code commit. In the former,
the heavy work of creating a VM happens only every few months, whereas
the latter puts constant heavy load on the cloud controller. You must
consider your average VM lifetime, as a larger number generally means
less load on the cloud controller.

.. TODO Perhaps relocate the above paragraph under the web scale use case?

Aside from the creation and termination of VMs, you must consider the
impact of users accessing the service particularly on ``nova-api`` and
its associated database. Listing instances garners a great deal of
information and, given the frequency with which users run this
operation, a cloud with a large number of users can increase the load
significantly. This can occur even without their knowledge. For example,
leaving the OpenStack dashboard instances tab open in the browser
refreshes the list of VMs every 30 seconds.

After you consider these factors, you can determine how many cloud
controller cores you require. A typical eight core, 8 GB of RAM server
is sufficient for up to a rack of compute nodes — given the above
caveats.

You must also consider key hardware specifications for the performance
of user VMs, as well as budget and performance needs, including storage
performance (spindles/core), memory availability (RAM/core), network
bandwidth hardware specifications and (Gbps/core), and overall
CPU performance (CPU/core).

.. tip::

   For a discussion of metric tracking, including how to extract
   metrics from your cloud, see the .`OpenStack Operations Guide
   <https://docs.openstack.org/ops-guide/ops-logging-monitoring.html>`_.

Adding Cloud Controller Nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can facilitate the horizontal expansion of your cloud by adding
nodes. Adding compute nodes is straightforward since they are easily picked up
by the existing installation. However, you must consider some important
points when you design your cluster to be highly available.

A cloud controller node runs several different services. You
can install services that communicate only using the message queue
internally— ``nova-scheduler`` and ``nova-console`` on a new server for
expansion. However, other integral parts require more care.

You should load balance user-facing services such as dashboard,
``nova-api``, or the Object Storage proxy. Use any standard HTTP
load-balancing method (DNS round robin, hardware load balancer, or
software such as Pound or HAProxy). One caveat with dashboard is the VNC
proxy, which uses the WebSocket protocol— something that an L7 load
balancer might struggle with. See also `Horizon session storage
<https://docs.openstack.org/developer/horizon/topics/deployment.html#session-storage>`_.

You can configure some services, such as ``nova-api`` and
``glance-api``, to use multiple processes by changing a flag in their
configuration file allowing them to share work between multiple cores on
the one machine.

.. tip::

   Several options are available for MySQL load balancing, and the
   supported AMQP brokers have built-in clustering support. Information
   on how to configure these and many of the other services can be
   found in the `operations chapter
   <https://docs.openstack.org/ops-guide/operations.html>`_ in the Operations
   Guide.

Segregating Your Cloud
~~~~~~~~~~~~~~~~~~~~~~

When you want to offer users different regions to provide legal
considerations for data storage, redundancy across earthquake fault
lines, or for low-latency API calls, you segregate your cloud. Use one
of the following OpenStack methods to segregate your cloud: *cells*,
*regions*, *availability zones*, or *host aggregates*.

Each method provides different functionality and can be best divided
into two groups:

-  Cells and regions, which segregate an entire cloud and result in
   running separate Compute deployments.

-  :term:`Availability zones <availability zone>` and host aggregates,
   which merely divide a single Compute deployment.

:ref:`table_segregation_methods` provides a comparison view of each
segregation method currently provided by OpenStack Compute.

.. _table_segregation_methods:

.. list-table:: Table. OpenStack segregation methods
   :widths: 20 20 20 20 20
   :header-rows: 1

   * -
     - Cells
     - Regions
     - Availability zones
     - Host aggregates
   * - **Use**
     - A single :term:`API endpoint` for compute, or you require a second
       level of scheduling.
     - Discrete regions with separate API endpoints and no coordination
       between regions.
     - Logical separation within your nova deployment for physical isolation
       or redundancy.
     - To schedule a group of hosts with common features.
   * - **Example**
     - A cloud with multiple sites where you can schedule VMs "anywhere" or on
       a particular site.
     - A cloud with multiple sites, where you schedule VMs to a particular
       site and you want a shared infrastructure.
     - A single-site cloud with equipment fed by separate power supplies.
     - Scheduling to hosts with trusted hardware support.
   * - **Overhead**
     - Considered experimental. A new service, nova-cells. Each cell has a full
       nova installation except nova-api.
     - A different API endpoint for every region. Each region has a full nova
       installation.
     - Configuration changes to ``nova.conf``.
     - Configuration changes to ``nova.conf``.
   * - **Shared services**
     - Keystone, ``nova-api``
     - Keystone
     - Keystone, All nova services
     - Keystone, All nova services

Cells and Regions
-----------------

OpenStack Compute cells are designed to allow running the cloud in a
distributed fashion without having to use more complicated technologies,
or be invasive to existing nova installations. Hosts in a cloud are
partitioned into groups called *cells*. Cells are configured in a tree.
The top-level cell ("API cell") has a host that runs the ``nova-api``
service, but no ``nova-compute`` services. Each child cell runs all of
the other typical ``nova-*`` services found in a regular installation,
except for the ``nova-api`` service. Each cell has its own message queue
and database service and also runs ``nova-cells``, which manages the
communication between the API cell and child cells.

This allows for a single API server being used to control access to
multiple cloud installations. Introducing a second level of scheduling
(the cell selection), in addition to the regular ``nova-scheduler``
selection of hosts, provides greater flexibility to control where
virtual machines are run.

Unlike having a single API endpoint, regions have a separate API
endpoint per installation, allowing for a more discrete separation.
Users wanting to run instances across sites have to explicitly select a
region. However, the additional complexity of a running a new service is
not required.

The OpenStack dashboard (horizon) can be configured to use multiple
regions. This can be configured through the ``AVAILABLE_REGIONS``
parameter.

Availability Zones and Host Aggregates
--------------------------------------

You can use availability zones, host aggregates, or both to partition a
nova deployment.

Availability zones are implemented through and configured in a similar
way to host aggregates.

However, you can use them for different reasons.

Availability zone
^^^^^^^^^^^^^^^^^

This enables you to arrange OpenStack compute hosts into logical groups
and provides a form of physical isolation and redundancy from other
availability zones, such as by using a separate power supply or network
equipment.

You define the availability zone in which a specified compute host
resides locally on each server. An availability zone is commonly used to
identify a set of servers that have a common attribute. For instance, if
some of the racks in your data center are on a separate power source,
you can put servers in those racks in their own availability zone.
Availability zones can also help separate different classes of hardware.

When users provision resources, they can specify from which availability
zone they want their instance to be built. This allows cloud consumers
to ensure that their application resources are spread across disparate
machines to achieve high availability in the event of hardware failure.

Host aggregates zone
^^^^^^^^^^^^^^^^^^^^

This enables you to partition OpenStack Compute deployments into logical
groups for load balancing and instance distribution. You can use host
aggregates to further partition an availability zone. For example, you
might use host aggregates to partition an availability zone into groups
of hosts that either share common resources, such as storage and
network, or have a special property, such as trusted computing
hardware.

A common use of host aggregates is to provide information for use with
the ``nova-scheduler``. For example, you might use a host aggregate to
group a set of hosts that share specific flavors or images.

The general case for this is setting key-value pairs in the aggregate
metadata and matching key-value pairs in flavor's ``extra_specs``
metadata. The ``AggregateInstanceExtraSpecsFilter`` in the filter
scheduler will enforce that instances be scheduled only on hosts in
aggregates that define the same key to the same value.

An advanced use of this general concept allows different flavor types to
run with different CPU and RAM allocation ratios so that high-intensity
computing loads and low-intensity development and testing systems can
share the same cloud without either starving the high-use systems or
wasting resources on low-utilization systems. This works by setting
``metadata`` in your host aggregates and matching ``extra_specs`` in
your flavor types.

The first step is setting the aggregate metadata keys
``cpu_allocation_ratio`` and ``ram_allocation_ratio`` to a
floating-point value. The filter schedulers ``AggregateCoreFilter`` and
``AggregateRamFilter`` will use those values rather than the global
defaults in ``nova.conf`` when scheduling to hosts in the aggregate. Be
cautious when using this feature, since each host can be in multiple
aggregates, but should have only one allocation ratio for
each resources. It is up to you to avoid putting a host in multiple
aggregates that define different values for the same resource.

This is the first half of the equation. To get flavor types that are
guaranteed a particular ratio, you must set the ``extra_specs`` in the
flavor type to the key-value pair you want to match in the aggregate.
For example, if you define ``extra_specs`` ``cpu_allocation_ratio`` to
"1.0", then instances of that type will run in aggregates only where the
metadata key ``cpu_allocation_ratio`` is also defined as "1.0." In
practice, it is better to define an additional key-value pair in the
aggregate metadata to match on rather than match directly on
``cpu_allocation_ratio`` or ``core_allocation_ratio``. This allows
better abstraction. For example, by defining a key ``overcommit`` and
setting a value of "high," "medium," or "low," you could then tune the
numeric allocation ratios in the aggregates without also needing to
change all flavor types relating to them.

.. note::

    Previously, all services had an availability zone. Currently, only
    the ``nova-compute`` service has its own availability zone. Services
    such as ``nova-scheduler``, ``nova-network``, and ``nova-conductor``
    have always spanned all availability zones.

    When you run any of the following operations, the services appear in
    their own internal availability zone
    (CONF.internal_service_availability_zone):

    -  :command:`openstack host list` (os-hosts)

    -  :command:`euca-describe-availability-zones verbose`

    -  :command:`openstack compute service list`

    The internal availability zone is hidden in
    euca-describe-availability_zones (nonverbose).

    CONF.node_availability_zone has been renamed to
    CONF.default_availability_zone and is used only by the
    ``nova-api`` and ``nova-scheduler`` services.

    CONF.node_availability_zone still works but is deprecated.

Scalable Hardware
~~~~~~~~~~~~~~~~~

While several resources already exist to help with deploying and
installing OpenStack, it's very important to make sure that you have
your deployment planned out ahead of time. This guide presumes that you
have set aside a rack for the OpenStack cloud but also offers
suggestions for when and what to scale.

Hardware Procurement
--------------------

“The Cloud” has been described as a volatile environment where servers
can be created and terminated at will. While this may be true, it does
not mean that your servers must be volatile. Ensuring that your cloud's
hardware is stable and configured correctly means that your cloud
environment remains up and running.

OpenStack can be deployed on any hardware supported by an
OpenStack compatible Linux distribution.

Hardware does not have to be consistent, but it should at least have the
same type of CPU to support instance migration.

The typical hardware recommended for use with OpenStack is the standard
value-for-money offerings that most hardware vendors stock. It should be
straightforward to divide your procurement into building blocks such as
"compute," "object storage," and "cloud controller," and request as many
of these as you need. Alternatively, any existing servers you have that meet
performance requirements and virtualization technology are likely to support
OpenStack.

Capacity Planning
-----------------

OpenStack is designed to increase in size in a straightforward manner.
Taking into account the considerations previous mentioned, particularly on the
sizing of the cloud controller, it should be possible to procure additional
compute or object storage nodes as needed. New nodes do not need to be the same
specification or vendor as existing nodes.

For compute nodes, ``nova-scheduler`` will manage differences in
sizing with core count and RAM. However, you should consider that the user
experience changes with differing CPU speeds. When adding object storage
nodes, a :term:`weight` should be specified that reflects the
:term:`capability` of the node.

Monitoring the resource usage and user growth will enable you to know
when to procure. The `Logging and Monitoring
<https://docs.openstack.org/ops-guide/ops-logging-monitoring.html>`_
chapte in the Operations Guide details some useful metrics.

Burn-in Testing
---------------

The chances of failure for the server's hardware are high at the start
and the end of its life. As a result, dealing with hardware failures
while in production can be avoided by appropriate burn-in testing to
attempt to trigger the early-stage failures. The general principle is to
stress the hardware to its limits. Examples of burn-in tests include
running a CPU or disk benchmark for several days.

