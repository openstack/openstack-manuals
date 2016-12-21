==========================
Create and manage networks
==========================

Before you run commands, `set environment variables using the OpenStack RC file
<http://docs.openstack.org/user-guide/common/cli-set-environment-variables-using-openstack-rc.html>`_.

Create networks
~~~~~~~~~~~~~~~

#. List the extensions of the system:

   .. code-block:: console

      $ neutron ext-list -c alias -c name
      +-----------------+--------------------------+
      | alias           | name                     |
      +-----------------+--------------------------+
      | agent_scheduler | Agent Schedulers         |
      | binding         | Port Binding             |
      | quotas          | Quota management support |
      | agent           | agent                    |
      | provider        | Provider Network         |
      | router          | Neutron L3 Router        |
      | lbaas           | LoadBalancing service    |
      | extraroute      | Neutron Extra Route      |
      +-----------------+--------------------------+

#. Create a network:

   .. code-block:: console

      $ openstack network create net1
      Created a new network:
      +---------------------------+--------------------------------------+
      | Field                     | Value                                |
      +---------------------------+--------------------------------------+
      | admin_state_up            | UP                                   |
      | availability_zone_hints   |                                      |
      | availability_zones        |                                      |
      | created_at                | 2016-12-21T08:32:54Z                 |
      | description               |                                      |
      | headers                   |                                      |
      | id                        | 180620e3-9eae-4ba7-9739-c5847966e1f0 |
      | ipv4_address_scope        | None                                 |
      | ipv6_address_scope        | None                                 |
      | mtu                       | 1450                                 |
      | name                      | net1                                 |
      | port_security_enabled     | True                                 |
      | project_id                | c961a8f6d3654657885226378ade8220     |
      | provider:network_type     | vxlan                                |
      | provider:physical_network | None                                 |
      | provider:segmentation_id  | 14                                   |
      | revision_number           | 3                                    |
      | router:external           | Internal                             |
      | shared                    | False                                |
      | status                    | ACTIVE                               |
      | subnets                   |                                      |
      | tags                      | []                                   |
      | updated_at                | 2016-12-21T08:32:54Z                 |
      +---------------------------+--------------------------------------+

   .. note::

      Some fields of the created network are invisible to non-admin users.

#. Create a network with specified provider network type.

   .. code-block:: console

      $ openstack network create net2 --provider-network-type vxlan
      Created a new network:
      +---------------------------+--------------------------------------+
      | Field                     | Value                                |
      +---------------------------+--------------------------------------+
      | admin_state_up            | UP                                   |
      | availability_zone_hints   |                                      |
      | availability_zones        |                                      |
      | created_at                | 2016-12-21T08:33:34Z                 |
      | description               |                                      |
      | headers                   |                                      |
      | id                        | c0a563d5-ef7d-46b3-b30d-6b9d4138b6cf |
      | ipv4_address_scope        | None                                 |
      | ipv6_address_scope        | None                                 |
      | mtu                       | 1450                                 |
      | name                      | net2                                 |
      | port_security_enabled     | True                                 |
      | project_id                | c961a8f6d3654657885226378ade8220     |
      | provider:network_type     | vxlan                                |
      | provider:physical_network | None                                 |
      | provider:segmentation_id  | 87                                   |
      | revision_number           | 3                                    |
      | router:external           | Internal                             |
      | shared                    | False                                |
      | status                    | ACTIVE                               |
      | subnets                   |                                      |
      | tags                      | []                                   |
      | updated_at                | 2016-12-21T08:33:34Z                 |
      +---------------------------+--------------------------------------+

   Just as shown previously, the unknown option ``--provider-network-type``
   is used to create a ``vxlan`` provider network.

Create subnets
~~~~~~~~~~~~~~

Create a subnet:

.. code-block:: console

   $ neutron subnet-create net1 192.168.2.0/24 --name subnet1
   Created a new subnet:
   +------------------+--------------------------------------------------+
   | Field            | Value                                            |
   +------------------+--------------------------------------------------+
   | allocation_pools | {"start": "192.168.2.2", "end": "192.168.2.254"} |
   | cidr             | 192.168.2.0/24                                   |
   | dns_nameservers  |                                                  |
   | enable_dhcp      | True                                             |
   | gateway_ip       | 192.168.2.1                                      |
   | host_routes      |                                                  |
   | id               | 15a09f6c-87a5-4d14-b2cf-03d97cd4b456             |
   | ip_version       | 4                                                |
   | name             | subnet1                                          |
   | network_id       | 2d627131-c841-4e3a-ace6-f2dd75773b6d             |
   | tenant_id        | 3671f46ec35e4bbca6ef92ab7975e463                 |
   +------------------+--------------------------------------------------+

The ``subnet-create`` command has the following positional and optional
parameters:

-  The name or ID of the network to which the subnet belongs.

   In this example, ``net1`` is a positional argument that specifies the
   network name.

-  The CIDR of the subnet.

   In this example, ``192.168.2.0/24`` is a positional argument that
   specifies the CIDR.

-  The subnet name, which is optional.

   In this example, ``--name subnet1`` specifies the name of the
   subnet.

For information and examples on more advanced use of neutron's
``subnet`` subcommand, see the `OpenStack Administrator
Guide <http://docs.openstack.org/admin-guide/networking-use.html#advanced-networking-operations>`__.

Create routers
~~~~~~~~~~~~~~

#. Create a router:

   .. code-block:: console

      $ neutron router-create router1
      Created a new router:
      +-----------------------+--------------------------------------+
      | Field                 | Value                                |
      +-----------------------+--------------------------------------+
      | admin_state_up        | True                                 |
      | external_gateway_info |                                      |
      | id                    | 6e1f11ed-014b-4c16-8664-f4f615a3137a |
      | name                  | router1                              |
      | status                | ACTIVE                               |
      | tenant_id             | 7b5970fbe7724bf9b74c245e66b92abf     |
      +-----------------------+--------------------------------------+

   Take note of the unique router identifier returned, this will be
   required in subsequent steps.

#. Link the router to the external provider network:

   .. code-block:: console

      $ neutron router-gateway-set ROUTER NETWORK

   Replace ROUTER with the unique identifier of the router, replace NETWORK
   with the unique identifier of the external provider network.

#. Link the router to the subnet:

   .. code-block:: console

      $ neutron router-interface-add ROUTER SUBNET

   Replace ROUTER with the unique identifier of the router, replace SUBNET
   with the unique identifier of the subnet.

Create ports
~~~~~~~~~~~~

#. Create a port with specified IP address:

   .. code-block:: console

      $ neutron port-create net1 --fixed-ip ip_address=192.168.2.40
      Created a new port:
      +----------------------+----------------------------------------------------------------------+
      | Field                | Value                                                                |
      +----------------------+----------------------------------------------------------------------+
      | admin_state_up       | True                                                                 |
      | binding:capabilities | {"port_filter": false}                                               |
      | binding:vif_type     | ovs                                                                  |
      | device_id            |                                                                      |
      | device_owner         |                                                                      |
      | fixed_ips            | {"subnet_id": "15a09f6c-87a5-4d14-b2cf-03d97cd4b456", "ip_address... |
      | id                   | f7a08fe4-e79e-4b67-bbb8-a5002455a493                                 |
      | mac_address          | fa:16:3e:97:e0:fc                                                    |
      | name                 |                                                                      |
      | network_id           | 2d627131-c841-4e3a-ace6-f2dd75773b6d                                 |
      | status               | DOWN                                                                 |
      | tenant_id            | 3671f46ec35e4bbca6ef92ab7975e463                                     |
      +----------------------+----------------------------------------------------------------------+

   In the previous command, ``net1`` is the network name, which is a
   positional argument. :option:`--fixed-ip ip_address=192.168.2.40` is
   an option which specifies the port's fixed IP address we wanted.

   .. note::

      When creating a port, you can specify any unallocated IP in the
      subnet even if the address is not in a pre-defined pool of allocated
      IP addresses (set by your cloud provider).

#. Create a port without specified IP address:

   .. code-block:: console

      $ neutron port-create net1
      Created a new port:
      +----------------------+----------------------------------------------------------------------+
      | Field                | Value                                                                |
      +----------------------+----------------------------------------------------------------------+
      | admin_state_up       | True                                                                 |
      | binding:capabilities | {"port_filter": false}                                               |
      | binding:vif_type     | ovs                                                                  |
      | device_id            |                                                                      |
      | device_owner         |                                                                      |
      | fixed_ips            | {"subnet_id": "15a09f6c-87a5-4d14-b2cf-03d97cd4b456", "ip_address... |
      | id                   | baf13412-2641-4183-9533-de8f5b91444c                                 |
      | mac_address          | fa:16:3e:f6:ec:c7                                                    |
      | name                 |                                                                      |
      | network_id           | 2d627131-c841-4e3a-ace6-f2dd75773b6d                                 |
      | status               | DOWN                                                                 |
      | tenant_id            | 3671f46ec35e4bbca6ef92ab7975e463                                     |
      +----------------------+----------------------------------------------------------------------+

   .. note::

      Note that the system allocates one IP address if you do not specify
      an IP address in the :command:`neutron port-create` command.

   .. note::

      You can specify a MAC address with :option:`--mac-address MAC_ADDRESS`.
      If you specify an invalid MAC address, including ``00:00:00:00:00:00``
      or ``ff:ff:ff:ff:ff:ff``, you will get an error.

#. Query ports with specified fixed IP addresses:

   .. code-block:: console

      $ neutron port-list --fixed-ips ip_address=192.168.2.2 \
        ip_address=192.168.2.40
      +----------------+------+-------------------+-------------------------------------------------+
      | id             | name | mac_address       | fixed_ips                                       |
      +----------------+------+-------------------+-------------------------------------------------+
      | baf13412-26... |      | fa:16:3e:f6:ec:c7 | {"subnet_id"... ..."ip_address": "192.168.2.2"} |
      | f7a08fe4-e7... |      | fa:16:3e:97:e0:fc | {"subnet_id"... ..."ip_address": "192.168.2.40"}|
      +----------------+------+-------------------+-------------------------------------------------+

   :option:`--fixed-ips ip_address=192.168.2.2 ip_address=192.168.2.40` is one
   unknown option.

How to find unknown options
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The unknown options can be easily found by watching the output of
:command:`create_xxx` or :command:`show_xxx` command. For example,
in the port creation command, we see the fixed\_ips fields, which
can be used as an unknown option.
