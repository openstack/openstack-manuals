.. _config-service-subnets:

===============
Service subnets
===============

Service subnets enable operators to define valid port types for each
subnet on a network without limiting networks to one subnet or manually
creating ports with a specific subnet ID. Using this feature, operators
can ensure that ports for instances and router interfaces, for example,
always use different subnets.

Operation
~~~~~~~~~

Define one or more service types for one or more subnets on a particular
network. Each service type must correspond to a valid device owner within
the port model in order for it to be used.

During IP allocation, the :ref:`IPAM <config-ipam>` driver returns an
address from a subnet with a service type matching the port device
owner. If no subnets match, or all matching subnets lack available IP
addresses, the IPAM driver attempts to use a subnet without any service
types to preserve compatibility. If all subnets on a network have a
service type, the IPAM driver cannot preserve compatibility. However, this
feature enables strict IP allocation from subnets with a matching device
owner. If multiple subnets contain the same service type, or a subnet
without a service type exists, the IPAM driver selects the first subnet
with a matching service type. For example, a floating IP agent gateway port
uses the following selection process:

* ``network:floatingip_agent_gateway``
* ``None``

Creating or updating a port with a specific a subnet skips this selection
process and explicitly uses the given subnet.

Usage
~~~~~

.. note::

   Creating a subnet with a service type requires administrative
   privileges.

#. Create a network.

   .. code-block:: console

      $ openstack network create demo-net1
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | admin_state_up    | True                                 |
      | id                | b5b729d8-31cc-4d2c-8284-72b3291fec02 |
      | name              | demo-net1                            |
      | router:external   | False                                |
      | shared            | False                                |
      | status            | ACTIVE                               |
      | subnets           |                                      |
      | tenant_id         | a8b3054cc1214f18b1186b291525650f     |
      +-------------------+--------------------------------------+

#. Create a subnet on the network with one or more service types. For
   example, the ``compute:nova`` service type enables instances to use
   this subnet.

   .. code-block:: console

      $ openstack subnet create demo-subnet1 --subnet-range 10.0.0.0/24 \
        --service-type 'compute:nova' --network demo-net1
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | id                | 6e38b23f-0b27-4e3c-8e69-fd23a3df1935 |
      | ip_version        | 4                                    |
      | cidr              | 10.0.0.0/24                          |
      | name              | demo-subnet1                         |
      | network_id        | b5b729d8-31cc-4d2c-8284-72b3291fec02 |
      | service_types     | ['compute:nova']                     |
      | tenant_id         | a8b3054cc1214f18b1186b291525650f     |
      +-------------------+--------------------------------------+

#. Optionally, create another subnet on the network with a different service
   type. For example, the ``compute:foo`` arbitrary service type.

   .. code-block:: console

      $ openstack subnet create demo-subnet2 --subnet-range 10.0.10.0/24 \
        --service-type 'compute:foo' --network demo-net1
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | id                | ea139dcd-17a3-4f0a-8cca-dff8b4e03f8a |
      | ip_version        | 4                                    |
      | cidr              | 10.0.10.0/24                         |
      | name              | demo-subnet2                         |
      | network_id        | b5b729d8-31cc-4d2c-8284-72b3291fec02 |
      | service_types     | ['compute:foo']                      |
      | tenant_id         | a8b3054cc1214f18b1186b291525650f     |
      +-------------------+--------------------------------------+

#. Launch an instance using the network. For example, using the ``cirros``
   image and ``m1.tiny`` flavor.

   .. code-block:: console

      $ openstack server create demo-instance1 --flavor m1.tiny \
        --image cirros --nic net-id=b5b729d8-31cc-4d2c-8284-72b3291fec02
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | id                | 05682b91-81a1-464c-8f40-8b3da7ee92c5 |
      | name              | demo-instance1                       |
      +-------------------+--------------------------------------+

#. Check the instance status. The ``Networks`` field contains an IP address
   from the subnet having the ``compute:nova`` service type.

   .. code-block:: console

      $ openstack server list
      +----------------+--------+-------------------------+
      | Name           | Status | Networks                |
      +----------------+--------+-------------------------+
      | demo-instance1 | ACTIVE | demo-net1=10.0.0.3      |
      +----------------+--------+-------------------------+
