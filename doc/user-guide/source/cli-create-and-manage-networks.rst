==========================
Create and manage networks
==========================

Before you run commands, `set environment variables using the OpenStack RC file
<https://docs.openstack.org/user-guide/common/cli-set-environment-variables-using-openstack-rc.html>`_.

Create networks
~~~~~~~~~~~~~~~

#. List the extensions of the system:

   .. code-block:: console

      $ openstack extension list -c Alias -c Name --network
      +------------------------------------------+---------------------------+
      | Name                                     | Alias                     |
      +------------------------------------------+---------------------------+
      | Default Subnetpools                      | default-subnetpools       |
      | Network IP Availability                  | network-ip-availability   |
      | Auto Allocated Topology Services         | auto-allocated-topology   |
      | Neutron L3 Configurable external gateway | ext-gw-mode               |
      | Address scope                            | address-scope             |
      | Neutron Extra Route                      | extraroute                |
      +------------------------------------------+---------------------------+

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

Create subnets
~~~~~~~~~~~~~~

Create a subnet:

.. code-block:: console

   $ openstack subnet create subnet1 --network net1
     --subnet-range 192.0.2.0/24
   +-------------------+--------------------------------------+
   | Field             | Value                                |
   +-------------------+--------------------------------------+
   | allocation_pools  | 192.0.2.2-192.0.2.254                |
   | cidr              | 192.0.2.0/24                         |
   | created_at        | 2016-12-22T18:47:52Z                 |
   | description       |                                      |
   | dns_nameservers   |                                      |
   | enable_dhcp       | True                                 |
   | gateway_ip        | 192.0.2.1                            |
   | headers           |                                      |
   | host_routes       |                                      |
   | id                | a394689c-f547-4834-9778-3e0bb22130dc |
   | ip_version        | 4                                    |
   | ipv6_address_mode | None                                 |
   | ipv6_ra_mode      | None                                 |
   | name              | subnet1                              |
   | network_id        | 9db55b7f-e803-4e1b-9bba-6262f60b96cb |
   | project_id        | e17431afc0524e0690484889a04b7fa0     |
   | revision_number   | 2                                    |
   | service_types     |                                      |
   | subnetpool_id     | None                                 |
   | updated_at        | 2016-12-22T18:47:52Z                 |
   +-------------------+--------------------------------------+


The ``subnet-create`` command has the following positional and optional
parameters:

-  The name or ID of the network to which the subnet belongs.

   In this example, ``net1`` is a positional argument that specifies the
   network name.

-  The CIDR of the subnet.

   In this example, ``192.0.2.0/24`` is a positional argument that
   specifies the CIDR.

-  The subnet name, which is optional.

   In this example, ``--name subnet1`` specifies the name of the
   subnet.

For information and examples on more advanced use of neutron's
``subnet`` subcommand, see the `OpenStack Administrator
Guide <https://docs.openstack.org/admin-guide/networking-use.html#advanced-networking-operations>`__.

Create routers
~~~~~~~~~~~~~~

#. Create a router:

   .. code-block:: console

      $ openstack router create router1
      +-------------------------+--------------------------------------+
      | Field                   | Value                                |
      +-------------------------+--------------------------------------+
      | admin_state_up          | UP                                   |
      | availability_zone_hints |                                      |
      | availability_zones      |                                      |
      | created_at              | 2016-12-22T18:48:57Z                 |
      | description             |                                      |
      | distributed             | True                                 |
      | external_gateway_info   | null                                 |
      | flavor_id               | None                                 |
      | ha                      | False                                |
      | headers                 |                                      |
      | id                      | e25a24ee-3458-45c7-b16e-edf49092aab7 |
      | name                    | router1                              |
      | project_id              | e17431afc0524e0690484889a04b7fa0     |
      | revision_number         | 1                                    |
      | routes                  |                                      |
      | status                  | ACTIVE                               |
      | updated_at              | 2016-12-22T18:48:57Z                 |
      +-------------------------+--------------------------------------+


   Take note of the unique router identifier returned, this will be
   required in subsequent steps.

#. Link the router to the external provider network:

   .. code-block:: console

      $ openstack router set ROUTER --external-gateway NETWORK

   Replace ROUTER with the unique identifier of the router, replace NETWORK
   with the unique identifier of the external provider network.

#. Link the router to the subnet:

   .. code-block:: console

      $ openstack router add subnet ROUTER SUBNET

   Replace ROUTER with the unique identifier of the router, replace SUBNET
   with the unique identifier of the subnet.

Create ports
~~~~~~~~~~~~

#. Create a port with specified IP address:

   .. code-block:: console

      $ openstack port create --network net1 --fixed-ip subnet=subnet1,ip-address=192.0.2.40 port1
      +-----------------------+-----------------------------------------+
      | Field                 | Value                                   |
      +-----------------------+-----------------------------------------+
      | admin_state_up        | UP                                      |
      | allowed_address_pairs |                                         |
      | binding_host_id       |                                         |
      | binding_profile       |                                         |
      | binding_vif_details   |                                         |
      | binding_vif_type      | unbound                                 |
      | binding_vnic_type     | normal                                  |
      | created_at            | 2016-12-22T18:54:43Z                    |
      | description           |                                         |
      | device_id             |                                         |
      | device_owner          |                                         |
      | extra_dhcp_opts       |                                         |
      | fixed_ips             | ip_address='192.0.2.40', subnet_id='a   |
      |                       | 394689c-f547-4834-9778-3e0bb22130dc'    |
      | headers               |                                         |
      | id                    | 031ddba8-3e3f-4c3c-ae26-7776905eb24f    |
      | mac_address           | fa:16:3e:df:3d:c7                       |
      | name                  | port1                                   |
      | network_id            | 9db55b7f-e803-4e1b-9bba-6262f60b96cb    |
      | port_security_enabled | True                                    |
      | project_id            | e17431afc0524e0690484889a04b7fa0        |
      | revision_number       | 5                                       |
      | security_groups       | 84abb9eb-dc59-40c1-802c-4e173c345b6a    |
      | status                | DOWN                                    |
      | updated_at            | 2016-12-22T18:54:44Z                    |
      +-----------------------+-----------------------------------------+

   In the previous command, ``net1`` is the network name, which is a
   positional argument. ``--fixed-ip subnet<subnet>,ip-address=192.0.2.40`` is
   an option which specifies the port's fixed IP address we wanted.

   .. note::

      When creating a port, you can specify any unallocated IP in the
      subnet even if the address is not in a pre-defined pool of allocated
      IP addresses (set by your cloud provider).

#. Create a port without specified IP address:

   .. code-block:: console

      $ openstack port create port2 --network net1
      +-----------------------+-----------------------------------------+
      | Field                 | Value                                   |
      +-----------------------+-----------------------------------------+
      | admin_state_up        | UP                                      |
      | allowed_address_pairs |                                         |
      | binding_host_id       |                                         |
      | binding_profile       |                                         |
      | binding_vif_details   |                                         |
      | binding_vif_type      | unbound                                 |
      | binding_vnic_type     | normal                                  |
      | created_at            | 2016-12-22T18:56:06Z                    |
      | description           |                                         |
      | device_id             |                                         |
      | device_owner          |                                         |
      | extra_dhcp_opts       |                                         |
      | fixed_ips             | ip_address='192.0.2.10', subnet_id='a   |
      |                       | 394689c-f547-4834-9778-3e0bb22130dc'    |
      | headers               |                                         |
      | id                    | eac47fcd-07ac-42dd-9993-5b36ac1f201b    |
      | mac_address           | fa:16:3e:96:ae:6e                       |
      | name                  | port2                                   |
      | network_id            | 9db55b7f-e803-4e1b-9bba-6262f60b96cb    |
      | port_security_enabled | True                                    |
      | project_id            | e17431afc0524e0690484889a04b7fa0        |
      | revision_number       | 5                                       |
      | security_groups       | 84abb9eb-dc59-40c1-802c-4e173c345b6a    |
      | status                | DOWN                                    |
      | updated_at            | 2016-12-22T18:56:06Z                    |
      +-----------------------+-----------------------------------------+

   .. note::

      Note that the system allocates one IP address if you do not specify
      an IP address in the :command:`openstack port create` command.

   .. note::

      You can specify a MAC address with ``--mac-address MAC_ADDRESS``.
      If you specify an invalid MAC address, including ``00:00:00:00:00:00``
      or ``ff:ff:ff:ff:ff:ff``, you will get an error.

#. Query ports with specified fixed IP addresses:

   .. code-block:: console

      $ neutron port-list --fixed-ips ip_address=192.0.2.2 \
        ip_address=192.0.2.40
      +----------------+------+-------------------+-------------------------------------------------+
      | id             | name | mac_address       | fixed_ips                                       |
      +----------------+------+-------------------+-------------------------------------------------+
      | baf13412-26... |      | fa:16:3e:f6:ec:c7 | {"subnet_id"... ..."ip_address": "192.0.2.2"}   |
      | f7a08fe4-e7... |      | fa:16:3e:97:e0:fc | {"subnet_id"... ..."ip_address": "192.0.2.40"}  |
      +----------------+------+-------------------+-------------------------------------------------+
