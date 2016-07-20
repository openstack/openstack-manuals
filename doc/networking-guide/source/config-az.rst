.. _config-az:

==================
Availability zones
==================

An availability zone groups network nodes that run services like DHCP, L3, FW,
and others. It is defined as an agent's attribute on the network node. This
allows users to associate an availability zone with their resources so that the
resources get high availability.


Use case
--------

An availability zone is used to make network resources highly available. The
operators group the nodes that are attached to different power sources under
separate availability zones and configure scheduling for resources with high
availability so that they are scheduled on different availability zones.


Required extensions
-------------------

The core plug-in must support the ``availability_zone`` extension. The core
plug-in also must support the ``network_availability_zone`` extension to
schedule a network according to availability zones. The ``Ml2Plugin`` supports
it. The router service plug-in must support the ``router_availability_zone``
extension to schedule a router according to the availability zones. The
``L3RouterPlugin`` supports it.

.. code-block:: console

    $ neutron ext-list
    +---------------------------+-----------------------------------------------+
    | alias                     | name                                          |
    +---------------------------+-----------------------------------------------+
    ...
    | network_availability_zone | Network Availability Zone                     |
    ...
    | availability_zone         | Availability Zone                             |
    ...
    | router_availability_zone  | Router Availability Zone                      |
    ...
    +---------------------------+-----------------------------------------------+


Availability zone of agents
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``availability_zone`` attribute can be defined in ``dhcp-agent`` and
``l3-agent``. To define an availability zone for each agent, set the
value into ``[AGENT]`` section of ``/etc/neutron/dhcp_agent.ini`` or
``/etc/neutron/l3_agent.ini``:

.. code-block:: ini

    [AGENT]
    availability_zone = zone-1

To confirm the agent's availability zone:

.. code-block:: console

    $ neutron agent-show ca203db1-9f7f-40a7-91aa-4b184886e65d
    +---------------------+----------------------------------------------------------+
    | Field               | Value                                                    |
    +---------------------+----------------------------------------------------------+
    | admin_state_up      | True                                                     |
    | agent_type          | DHCP agent                                               |
    | alive               | True                                                     |
    | availability_zone   | zone-1                                                   |
    | binary              | neutron-dhcp-agent                                       |
    | configurations      | {                                                        |
    |                     |      "subnets": 0,                                       |
    |                     |      "dhcp_lease_duration": 86400,                       |
    |                     |      "dhcp_driver": "neutron.agent.linux.dhcp.Dnsmasq",  |
    |                     |      "networks": 0,                                      |
    |                     |      "log_agent_heartbeats": false,                      |
    |                     |      "ports": 0                                          |
    |                     | }                                                        |
    | created_at          | 2015-12-10 00:30:19                                      |
    | description         |                                                          |
    | heartbeat_timestamp | 2015-12-10 00:54:09                                      |
    | host                | mitaka                                                   |
    | id                  | ca203db1-9f7f-40a7-91aa-4b184886e65d                     |
    | started_at          | 2015-12-10 00:45:09                                      |
    | topic               | dhcp_agent                                               |
    +---------------------+----------------------------------------------------------+

    $ neutron agent-show 4d8aa289-21eb-4997-86f2-49a884f78d0b
    +---------------------+---------------------------------------------+
    | Field               | Value                                       |
    +---------------------+---------------------------------------------+
    | admin_state_up      | True                                        |
    | agent_type          | L3 agent                                    |
    | alive               | True                                        |
    | availability_zone   | zone-1                                      |
    | binary              | neutron-l3-agent                            |
    | configurations      | {                                           |
    |                     |      "router_id": "",                       |
    |                     |      "agent_mode": "legacy",                |
    |                     |      "gateway_external_network_id": "",     |
    |                     |      "handle_internal_only_routers": true,  |
    |                     |      "routers": 0,                          |
    |                     |      "interfaces": 0,                       |
    |                     |      "floating_ips": 0,                     |
    |                     |      "interface_driver": "openvswitch",     |
    |                     |      "log_agent_heartbeats": false,         |
    |                     |      "external_network_bridge": "br-ex",    |
    |                     |      "ex_gw_ports": 0                       |
    |                     | }                                           |
    | created_at          | 2015-12-10 00:30:22                         |
    | description         |                                             |
    | heartbeat_timestamp | 2015-12-10 00:54:48                         |
    | host                | mitaka                                      |
    | id                  | 4d8aa289-21eb-4997-86f2-49a884f78d0b        |
    | started_at          | 2015-12-10 00:45:18                         |
    | topic               | l3_agent                                    |
    +---------------------+---------------------------------------------+


Availability zone related attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following attributes are added into network and router:

.. list-table::
   :header-rows: 1
   :widths: 25 10 10 10 50

   * - Attribute name
     - Access
     - Required
     - Input type
     - Description

   * - availability_zone_hints
     - RW(POST only)
     - No
     - list of string
     - availability zone candidates for the resource

   * - availability_zones
     - RO
     - N/A
     - list of string
     - availability zones for the resource

Use ``availability_zone_hints`` to specify the zone in which the resource is
hosted:

.. code-block:: console

    $ neutron net-create --availability-zone-hint zone-1 \
    --availability-zone-hint zone-2 net1
    Created a new network:
    +---------------------------+--------------------------------------+
    | Field                     | Value                                |
    +---------------------------+--------------------------------------+
    | admin_state_up            | True                                 |
    | availability_zone_hints   | zone-1                               |
    |                           | zone-2                               |
    | id                        | 0ef0597c-4aab-4235-8513-bf5d8304fe64 |
    | mtu                       | 1450                                 |
    | name                      | net1                                 |
    | port_security_enabled     | True                                 |
    | provider:network_type     | vxlan                                |
    | provider:physical_network |                                      |
    | provider:segmentation_id  | 1054                                 |
    | router:external           | False                                |
    | shared                    | False                                |
    | status                    | ACTIVE                               |
    | subnets                   |                                      |
    | tenant_id                 | 32f5512c7b3f47fb8924588ff9ad603b     |
    +---------------------------+--------------------------------------+


.. code-block:: console

    $ neutron router-create --ha True --availability-zone-hint zone-1 \
    --availability-zone-hint zone-2 router1
    Created a new router:
    +-------------------------+--------------------------------------+
    | Field                   | Value                                |
    +-------------------------+--------------------------------------+
    | admin_state_up          | True                                 |
    | availability_zone_hints | zone-1                               |
    |                         | zone-2                               |
    | availability_zones      |                                      |
    | distributed             | False                                |
    | external_gateway_info   |                                      |
    | ha                      | True                                 |
    | id                      | 272f9be2-e352-4138-92a7-f022449b83a0 |
    | name                    | router1                              |
    | routes                  |                                      |
    | status                  | ACTIVE                               |
    | tenant_id               | 32f5512c7b3f47fb8924588ff9ad603b     |
    +-------------------------+--------------------------------------+


Availability zone is selected from ``default_availability_zones`` in
``/etc/neutron/neutron.conf`` if a resource is created without
``availability_zone_hints``:

.. code-block:: ini

    default_availability_zones = zone-1,zone-2

To confirm the availability zone defined by the system:

.. code-block:: console

    $ neutron availability-zone-list
    +--------+----------+-----------+
    | name   | resource | state     |
    +--------+----------+-----------+
    | zone-2 | router   | available |
    | zone-1 | router   | available |
    | zone-2 | network  | available |
    | zone-1 | network  | available |
    +--------+----------+-----------+

Look at the ``availability_zones`` attribute of each resource to confirm in
which zone the resource is hosted:

.. code-block:: console

    $ neutron net-show net1
    +---------------------------+--------------------------------------+
    | Field                     | Value                                |
    +---------------------------+--------------------------------------+
    | admin_state_up            | True                                 |
    | availability_zone_hints   | zone-1                               |
    |                           | zone-2                               |
    | availability_zones        | zone-1                               |
    |                           | zone-2                               |
    | id                        | 0ef0597c-4aab-4235-8513-bf5d8304fe64 |
    | mtu                       | 1450                                 |
    | name                      | net1                                 |
    | port_security_enabled     | True                                 |
    | provider:network_type     | vxlan                                |
    | provider:physical_network |                                      |
    | provider:segmentation_id  | 1054                                 |
    | router:external           | False                                |
    | shared                    | False                                |
    | status                    | ACTIVE                               |
    | subnets                   | b24490b9-a3dd-4103-895f-a28aaf2c9bff |
    | tenant_id                 | 32f5512c7b3f47fb8924588ff9ad603b     |
    +---------------------------+--------------------------------------+

.. code-block:: console

    $ neutron router-show router1
    +-------------------------+--------------------------------------+
    | Field                   | Value                                |
    +-------------------------+--------------------------------------+
    | admin_state_up          | True                                 |
    | availability_zone_hints | zone-1                               |
    |                         | zone-2                               |
    | availability_zones      | zone-1                               |
    |                         | zone-2                               |
    | distributed             | False                                |
    | external_gateway_info   |                                      |
    | ha                      | True                                 |
    | id                      | 272f9be2-e352-4138-92a7-f022449b83a0 |
    | name                    | router1                              |
    | routes                  |                                      |
    | status                  | ACTIVE                               |
    | tenant_id               | 32f5512c7b3f47fb8924588ff9ad603b     |
    +-------------------------+--------------------------------------+

.. note::

    The ``availability_zones`` attribute does not have a value until the
    resource is scheduled. Once the Networking service schedules the resource
    to zones according to ``availability_zone_hints``, ``availability_zones``
    shows in which zone the resource is hosted practically. The
    ``availability_zones`` may not match ``availability_zone_hints``. For
    example, even if you specify a zone with ``availability_zone_hints``, all
    agents of the zone may be dead before the resource is scheduled. In
    general, they should match, unless there are failures or there is no
    capacity left in the zone requested.


Availability zone aware scheduler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Network scheduler
-----------------

Set ``AZAwareWeightScheduler`` to ``network_scheduler_driver`` in
``/etc/neutron/neutron.conf`` so that the Networking service schedules a
network according to the availability zone:

.. code-block:: ini

    network_scheduler_driver = neutron.scheduler.dhcp_agent_scheduler.AZAwareWeightScheduler
    dhcp_load_type = networks

The Networking service schedules a network to one of the agents within the
selected zone as with ``WeightScheduler``. In this case, scheduler refers to
``dhcp_load_type`` as well.


Router scheduler
----------------

Set ``AZLeastRoutersScheduler`` to ``router_scheduler_driver`` in file
``/etc/neutron/neutron.conf`` so that the Networking service schedules a router
according to the availability zone:

.. code-block:: ini

    router_scheduler_driver = neutron.scheduler.l3_agent_scheduler.AZLeastRoutersScheduler

The Networking service schedules a router to one of the agents within the
selected zone as with ``LeastRouterScheduler``.


Achieving high availability with availability zone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although, the Networking service provides high availability for routers and
high availability and fault tolerance for networks' DHCP services, availability
zones provide an extra layer of protection by segmenting a Networking service
deployment in isolated failure domains. By deploying HA nodes across different
availability zones, it is guaranteed that network services remain available in
face of zone-wide failures that affect the deployment.

This section explains how to get high availability with the availability zone
for L3 and DHCP. You should naturally set above configuration options for the
availability zone.

L3 high availability
--------------------

Set the following configuration options in file ``/etc/neutron/neutron.conf``
so that you get L3 high availability.

.. code-block:: ini

    l3_ha = True
    max_l3_agents_per_router = 3
    min_l3_agents_per_router = 2

HA routers are created on availability zones you selected when creating the
router.

DHCP high availability
----------------------

Set the following configuration options in file ``/etc/neutron/neutron.conf``
so that you get DHCP high availability.

.. code-block:: ini

    dhcp_agents_per_network = 2

DHCP services are created on availability zones you selected when creating the
network.
