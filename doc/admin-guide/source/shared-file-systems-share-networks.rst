.. _shared_file_systems_share_networks:

==============
Share networks
==============

Share network is an entity that encapsulates interaction with the OpenStack
Networking service. If the share driver that you selected runs in a mode
requiring Networking service interaction, specify the share network when
creating a new share network.

How to create share network
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To list networks in a project, run:

.. code-block:: console

   $ openstack network list
   +--------------+---------+--------------------+
   | ID           | Name    | Subnets            |
   +--------------+---------+--------------------+
   | bee7411d-... | public  | 884a6564-0f11-...  |
   |              |         | e6da81fa-5d5f-...  |
   | 5ed5a854-... | private | 74dcfb5a-b4d7-...  |
   |              |         | cc297be2-5213-...  |
   +--------------+---------+--------------------+

A share network stores network information that share servers can use where
shares are hosted. You can associate a share with a single share network.
When you create or update a share, you can optionally specify the ID of a share
network through which instances can access the share.

When you create a share network, you can specify only one type of network:

- OpenStack Networking (neutron). Specify a network ID and subnet ID.
  In this case ``manila.network.nova_network_plugin.NeutronNetworkPlugin``
  will be used.

- Legacy networking (nova-network). Specify a network ID.
  In this case ``manila.network.nova_network_plugin.NoveNetworkPlugin``
  will be used.

For more information about supported plug-ins for share networks, see
:ref:`shared_file_systems_network_plugins`.

A share network has these attributes:

- The IP block in Classless Inter-Domain Routing (CIDR) notation from which to
  allocate the network.

- The IP version of the network.

- The network type, which is `vlan`, `vxlan`, `gre`, or `flat`.

If the network uses segmentation, a segmentation identifier. For example, VLAN,
VXLAN, and GRE networks use segmentation.

To create a share network with private network and subnetwork, run:

.. code-block:: console

   $ manila share-network-create --neutron-net-id 5ed5a854-21dc-4ed3-870a-117b7064eb21 \
   --neutron-subnet-id 74dcfb5a-b4d7-4855-86f5-a669729428dc --name my_share_net --description "My first share network"
   +-------------------+--------------------------------------+
   | Property          | Value                                |
   +-------------------+--------------------------------------+
   | name              | my_share_net                         |
   | segmentation_id   | None                                 |
   | created_at        | 2015-09-24T12:06:32.602174           |
   | neutron_subnet_id | 74dcfb5a-b4d7-4855-86f5-a669729428dc |
   | updated_at        | None                                 |
   | network_type      | None                                 |
   | neutron_net_id    | 5ed5a854-21dc-4ed3-870a-117b7064eb21 |
   | ip_version        | None                                 |
   | nova_net_id       | None                                 |
   | cidr              | None                                 |
   | project_id        | 20787a7ba11946adad976463b57d8a2f     |
   | id                | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a |
   | description       | My first share network               |
   +-------------------+--------------------------------------+

The ``segmentation_id``, ``cidr``, ``ip_version``, and ``network_type``
share network attributes are automatically set to the values determined by the
network provider.

To check the network list, run:

.. code-block:: console

   $ manila share-network-list
   +--------------------------------------+--------------+
   | id                                   | name         |
   +--------------------------------------+--------------+
   | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a | my_share_net |
   +--------------------------------------+--------------+

If you configured the generic driver with ``driver_handles_share_servers =
True`` (with the share servers) and already had previous operations in the Shared
File Systems service, you can see ``manila_service_network`` in the neutron
list of networks. This network was created by the generic driver for internal
use.

.. code-block:: console

   $ openstack network list
   +--------------+------------------------+--------------------+
   | ID           | Name                   | Subnets            |
   +--------------+------------------------+--------------------+
   | 3b5a629a-e...| manila_service_network | 4f366100-50...     |
   | bee7411d-... | public                 | 884a6564-0f11-...  |
   |              |                        | e6da81fa-5d5f-...  |
   | 5ed5a854-... | private                | 74dcfb5a-b4d7-...  |
   |              |                        | cc297be2-5213-...  |
   +--------------+------------------------+--------------------+

You also can see detailed information about the share network including
``network_type``, and ``segmentation_id`` fields:

.. code-block:: console

   $ openstack network show manila_service_network
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | UP                                   |
   | availability_zone_hints   |                                      |
   | availability_zones        | nova                                 |
   | created_at                | 2016-12-13T09:31:30Z                 |
   | description               |                                      |
   | id                        | 3b5a629a-e7a1-46a3-afb2-ab666fb884bc |
   | ipv4_address_scope        | None                                 |
   | ipv6_address_scope        | None                                 |
   | mtu                       | 1450                                 |
   | name                      | manila_service_network               |
   | port_security_enabled     | True                                 |
   | project_id                | f6ac448a469b45e888050cf837b6e628     |
   | provider:network_type     | vxlan                                |
   | provider:physical_network | None                                 |
   | provider:segmentation_id  | 73                                   |
   | revision_number           | 7                                    |
   | router:external           | Internal                             |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   | 682e3329-60b0-440f-8749-83ef53dd8544 |
   | tags                      | []                                   |
   | updated_at                | 2016-12-13T09:31:36Z                 |
   +---------------------------+--------------------------------------+

You also can add and remove the security services from the share network.
For more detail, see :ref:`shared_file_systems_security_services`.
