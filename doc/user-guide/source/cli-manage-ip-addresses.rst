===================
Manage IP addresses
===================

Each instance has a private, fixed IP address and can also have a
public, or floating IP address. Private IP addresses are used for
communication between instances, and public addresses are used for
communication with networks outside the cloud, including the Internet.

When you launch an instance, it is automatically assigned a private IP
address that stays the same until you explicitly terminate the instance.
Rebooting an instance has no effect on the private IP address.

A pool of floating IP addresses, configured by the cloud administrator,
is available in OpenStack Compute. The project quota defines the maximum
number of floating IP addresses that you can allocate to the project.
After you allocate a floating IP address to a project, you can:

- Associate the floating IP address with an instance of the project. Only one
  floating IP address can be allocated to an instance at any given time.

- Disassociate a floating IP address from an instance in the project.

- Delete a floating IP from the project which automatically deletes that IP's
  associations.

Use the :command:`openstack` commands to manage floating IP addresses.

Create an external network
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create an external network named ``public``:

.. code-block:: console

   $ openstack network create public --external

   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | UP                                   |
   | availability_zone_hints   |                                      |
   | availability_zones        |                                      |
   | created_at                | 2017-05-18T05:06:06Z                 |
   | description               |                                      |
   | dns_domain                | None                                 |
   | id                        | 5a6c74b9-5659-4b9e-951e-85ffca212139 |
   | ipv4_address_scope        | None                                 |
   | ipv6_address_scope        | None                                 |
   | is_default                | False                                |
   | mtu                       | 1450                                 |
   | name                      | public                               |
   | port_security_enabled     | False                                |
   | project_id                | b3abf186ac64462e85741315376e9ca7     |
   | provider:network_type     | vxlan                                |
   | provider:physical_network | None                                 |
   | provider:segmentation_id  | 9                                    |
   | qos_policy_id             | None                                 |
   | revision_number           | 3                                    |
   | router:external           | External                             |
   | segments                  | None                                 |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | updated_at                | 2017-05-18T05:06:06Z                 |
   +---------------------------+--------------------------------------+

#. Create a subnet of the ``public`` external network:

.. code-block:: console

   $ openstack subnet create --network public --subnet-range 172.24.4.0/24 public_subnet

   +-------------------------+--------------------------------------+
   | Field                   | Value                                |
   +-------------------------+--------------------------------------+
   | allocation_pools        | 172.24.4.2-172.24.4.254              |
   | cidr                    | 172.24.4.0/24                        |
   | created_at              | 2017-05-18T05:16:46Z                 |
   | description             |                                      |
   | dns_nameservers         |                                      |
   | enable_dhcp             | True                                 |
   | gateway_ip              | 172.24.4.1                           |
   | host_routes             |                                      |
   | id                      | f61a73b3-6097-48ff-b7ef-98da203e6b18 |
   | ip_version              | 4                                    |
   | ipv6_address_mode       | None                                 |
   | ipv6_ra_mode            | None                                 |
   | name                    | public_subnet                        |
   | network_id              | 5a6c74b9-5659-4b9e-951e-85ffca212139 |
   | project_id              | b3abf186ac64462e85741315376e9ca7     |
   | revision_number         | 2                                    |
   | segment_id              | None                                 |
   | service_types           |                                      |
   | subnetpool_id           | None                                 |
   | updated_at              | 2017-05-18T05:16:46Z                 |
   | use_default_subnet_pool | None                                 |
   +-------------------------+--------------------------------------+

List floating IP address information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To list all pools that provide floating IP addresses, run:

.. code-block:: console

   $ openstack floating ip pool list
   +--------+
   | name   |
   +--------+
   | public |
   | test   |
   +--------+

.. note::

   If this list is empty, the cloud administrator must configure a pool
   of floating IP addresses.
   This command is only available in ``nova-network``. If you use the OpenStack
   Networking service, run the following command to list external networks:

   .. code-block:: console

      $ openstack network list --external

      +--------------------------------------+-------------+--------------------------------------+
      | ID                                   | Name        | Subnets                              |
      +--------------------------------------+-------------+--------------------------------------+
      | 5a6c74b9-5659-4b9e-951e-85ffca212139 | public      | f61a73b3-6097-48ff-b7ef-98da203e6b18 |
      | 9839a22d-33b7-4173-9708-985f091bb892 | public1     | 19f1fbb4-f411-4465-8ed9-b641c7fc73d0 |
      +--------------------------------------+-------------+--------------------------------------+


To list all floating IP addresses that are allocated to the current project,
run:

.. code-block:: console

   $ openstack floating ip list
   +--------------------------------------+---------------------+------------------+------+
   | ID                                   | Floating IP Address | Fixed IP Address | Port |
   +--------------------------------------+---------------------+------------------+------+
   | 760963b2-779c-4a49-a50d-f073c1ca5b9e | 172.24.4.228        | None             | None |
   | 89532684-13e1-4af3-bd79-f434c9920cc3 | 172.24.4.235        | None             | None |
   | ea3ebc6d-a146-47cd-aaa8-35f06e1e8c3d | 172.24.4.229        | None             | None |
   +--------------------------------------+---------------------+------------------+------+

For each floating IP address that is allocated to the current project,
the command outputs the floating IP address, the ID for the instance
to which the floating IP address is assigned, the associated fixed IP
address, and the pool from which the floating IP address was
allocated.

Associate floating IP addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can assign a floating IP address to a project and to an instance.

#. Run the following command to allocate a floating IP address to the
   current project. By default, the floating IP address is allocated from
   the public pool. The command outputs the allocated IP address:

   .. code-block:: console

      $ openstack floating ip create public
      +---------------------+--------------------------------------+
      | Field               | Value                                |
      +---------------------+--------------------------------------+
      | created_at          | 2017-03-30T12:35:25Z                 |
      | description         |                                      |
      | fixed_ip_address    | None                                 |
      | floating_ip_address | 172.24.4.230                        |
      | floating_network_id | c213f520-aade-42eb-8bf1-6826505d74bb |
      | id                  | 1e777f9e-4fc8-4df8-be6f-89f5caba3c0f |
      | name                | None                                 |
      | port_id             | None                                 |
      | project_id          | b3abf186ac64462e85741315376e9ca7     |
      | revision_number     | 1                                    |
      | router_id           | None                                 |
      | status              | DOWN                                 |
      | updated_at          | 2017-03-30T12:35:25Z                 |
      +---------------------+--------------------------------------+

#. List all project instances with which a floating IP address could be
   associated.

   .. code-block:: console

      $ openstack server list
      +---------------------+------+---------+------------+-------------+------------------+------------+
      | ID                  | Name | Status  | Task State | Power State | Networks         | Image Name |
      +---------------------+------+---------+------------+-------------+------------------+------------+
      | d5c854f9-d3e5-4f... | VM1  | ACTIVE  | -          | Running     | private=10.0.0.3 | cirros     |
      | 42290b01-0968-43... | VM2  | SHUTOFF | -          | Shutdown    | private=10.0.0.4 | centos     |
      +---------------------+------+---------+------------+-------------+------------------+------------+

#. Associate an IP address with an instance in the project, as follows:

   .. code-block:: console

      $ openstack server add floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS

   For example:

   .. code-block:: console

      $ openstack server add floating ip VM1 172.24.4.225

   The instance is now associated with two IP addresses:

   .. code-block:: console

      $ openstack server list
      +------------------+------+--------+------------+-------------+-------------------------------+------------+
      | ID               | Name | Status | Task State | Power State | Networks                      | Image Name |
      +------------------+------+--------+------------+-------------+-------------------------------+------------+
      | d5c854f9-d3e5... | VM1  | ACTIVE | -          | Running     | private=10.0.0.3, 172.24.4.225| cirros     |
      | 42290b01-0968... | VM2  | SHUTOFF| -          | Shutdown    | private=10.0.0.4              | centos     |
      +------------------+------+--------+------------+-------------+-------------------------------+------------+

   After you associate the IP address and configure security group rules
   for the instance, the instance is publicly available at the floating IP
   address.

   .. note::

      The :command:`openstack server` command does not allow users to associate a
      floating IP address with a specific fixed IP address using the optional
      ``--fixed-address`` parameter, which legacy commands required as an
      argument.

Disassociate floating IP addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To disassociate a floating IP address from an instance:

.. code-block:: console

   $ openstack server remove floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS

To remove the floating IP address from a project:

.. code-block:: console

   $ openstack floating ip delete FLOATING_IP_ADDRESS

The IP address is returned to the pool of IP addresses that is available
for all projects. If the IP address is still associated with a running
instance, it is automatically disassociated from that instance.
