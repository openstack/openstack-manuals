=======================
Create initial networks
=======================

Before launching your first instance, you must create the necessary
virtual network infrastructure to which the instances connect, including
the :ref:`external-network` and :ref:`tenant-network`. After creating this
infrastructure, we recommend that you :ref:`verify-connectivity` and resolve
any issues before proceeding further. :ref:`Initial networks <initialnetworks>`
provides a basic architectural overview of the components that Networking
implements for the initial networks and shows how network traffic flows from
the instance to the external network or Internet.

.. _initialnetworks:

.. figure:: /figures/installguide-neutron-initialnetworks.png
   :alt: OpenStack networking (neutron) initial networks

.. _external-network:

External network
~~~~~~~~~~~~~~~~
The external network typically provides Internet access for your
instances. By default, this network only allows Internet access *from*
instances using :term:`Network Address Translation (NAT)`. You can enable
Internet access *to* individual instances using a :term:`floating IP address`
and suitable :term:`security group` rules. The ``admin`` tenant owns this
network because it provides external network access for multiple
tenants.

**To create the external network**

#. On the controller node, source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the network:

   .. code-block:: console

      $ neutron net-create ext-net --router:external \
        --provider:physical_network external --provider:network_type flat
      Created a new network:
      +---------------------------+--------------------------------------+
      | Field                     | Value                                |
      +---------------------------+--------------------------------------+
      | admin_state_up            | True                                 |
      | id                        | 893aebb9-1c1e-48be-8908-6b947f3237b3 |
      | name                      | ext-net                              |
      | provider:network_type     | flat                                 |
      | provider:physical_network | external                             |
      | provider:segmentation_id  |                                      |
      | router:external           | True                                 |
      | shared                    | False                                |
      | status                    | ACTIVE                               |
      | subnets                   |                                      |
      | tenant_id                 | 54cd044c64d5408b83f843d63624e0d8     |
      +---------------------------+--------------------------------------+

Like a physical network, a virtual network requires a :term:`subnet` assigned
to it. The external network shares the same subnet and :term:`gateway`
associated with the physical network connected to the external interface on the
network node. You should specify an exclusive slice of this subnet for
:term:`router` and floating IP addresses to prevent interference with other
devices on the external network.

**To create a subnet on the external network**

Create the subnet:

.. code-block:: console

   $ neutron subnet-create ext-net EXTERNAL_NETWORK_CIDR --name ext-subnet \
     --allocation-pool start=FLOATING_IP_START,end=FLOATING_IP_END \
     --disable-dhcp --gateway EXTERNAL_NETWORK_GATEWAY

- Replace ``FLOATING_IP_START`` and ``FLOATING_IP_END`` with
  the first and last IP addresses of the range that you want to allocate for
  floating IP addresses.

- Replace ``EXTERNAL_NETWORK_CIDR`` with the subnet associated with the
  physical network.

- Replace ``EXTERNAL_NETWORK_GATEWAY`` with the gateway associated with the
  physical network, typically the ".1" IP address.

- You should disable :term:`DHCP` on this subnet because instances do not
  connect directly to the external network and floating IP addresses
  require manual assignment.

For example, using ``203.0.113.0/24`` with floating IP address range
``203.0.113.101`` to ``203.0.113.200``:

.. code-block:: console

   $ neutron subnet-create ext-net 203.0.113.0/24 --name ext-subnet \
     --allocation-pool start=203.0.113.101,end=203.0.113.200 \
     --disable-dhcp --gateway 203.0.113.1
   Created a new subnet:
   +-------------------+------------------------------------------------------+
   | Field             | Value                                                |
   +-------------------+------------------------------------------------------+
   | allocation_pools  | {"start": "203.0.113.101", "end": "203.0.113.200"}   |
   | cidr              | 203.0.113.0/24                                       |
   | dns_nameservers   |                                                      |
   | enable_dhcp       | False                                                |
   | gateway_ip        | 203.0.113.1                                          |
   | host_routes       |                                                      |
   | id                | 9159f0dc-2b63-41cf-bd7a-289309da1391                 |
   | ip_version        | 4                                                    |
   | ipv6_address_mode |                                                      |
   | ipv6_ra_mode      |                                                      |
   | name              | ext-subnet                                           |
   | network_id        | 893aebb9-1c1e-48be-8908-6b947f3237b3                 |
   | tenant_id         | 54cd044c64d5408b83f843d63624e0d8                     |
   +-------------------+------------------------------------------------------+

.. _tenant-network:

Tenant network
~~~~~~~~~~~~~~
The tenant network provides internal network access for instances. The
architecture isolates this type of network from other tenants. The
``demo`` tenant owns this network because it only provides network
access for instances within it.

**To create the tenant network**

#. On the controller node, source the ``demo`` credentials to gain access to
   user-only CLI commands:

   .. code-block:: console

      $ source demo-openrc.sh

#. Create the network:

   .. code-block:: console

      $ neutron net-create demo-net
      Created a new network:
      +-----------------+--------------------------------------+
      | Field           | Value                                |
      +-----------------+--------------------------------------+
      | admin_state_up  | True                                 |
      | id              | ac108952-6096-4243-adf4-bb6615b3de28 |
      | name            | demo-net                             |
      | router:external | False                                |
      | shared          | False                                |
      | status          | ACTIVE                               |
      | subnets         |                                      |
      | tenant_id       | cdef0071a0194d19ac6bb63802dc9bae     |
      +-----------------+--------------------------------------+

Like the external network, your tenant network also requires a subnet
attached to it. You can specify any valid subnet because the
architecture isolates tenant networks. By default, this subnet uses DHCP
so your instances can obtain IP addresses.

**To create a subnet on the tenant network**

Create the subnet:

.. code-block:: console

    $ neutron subnet-create demo-net TENANT_NETWORK_CIDR \
      --name demo-subnet --gateway TENANT_NETWORK_GATEWAY

- Replace ``TENANT_NETWORK_CIDR`` with the subnet you want to associate with
  the tenant network.

- Replace ``TENANT_NETWORK_GATEWAY`` with the gateway you want to associate
  with it, typically the ".1" IP address.

Example using ``192.168.1.0/24``:

.. code-block:: console

   $ neutron subnet-create demo-net 192.168.1.0/24 \
     --name demo-subnet --gateway 192.168.1.1
   Created a new subnet:
   +-------------------+------------------------------------------------------+
   | Field             | Value                                                |
   +-------------------+------------------------------------------------------+
   | allocation_pools  | {"start": "192.168.1.2", "end": "192.168.1.254"}     |
   | cidr              | 192.168.1.0/24                                       |
   | dns_nameservers   |                                                      |
   | enable_dhcp       | True                                                 |
   | gateway_ip        | 192.168.1.1                                          |
   | host_routes       |                                                      |
   | id                | 69d38773-794a-4e49-b887-6de6734e792d                 |
   | ip_version        | 4                                                    |
   | ipv6_address_mode |                                                      |
   | ipv6_ra_mode      |                                                      |
   | name              | demo-subnet                                          |
   | network_id        | ac108952-6096-4243-adf4-bb6615b3de28                 |
   | tenant_id         | cdef0071a0194d19ac6bb63802dc9bae                     |
   +-------------------+------------------------------------------------------+

A virtual router passes network traffic between two or more virtual
networks. Each router requires one or more :term:`interfaces <interface>`
and/or gateways that provide access to specific networks. In this case, you
create a router and attach your tenant and external networks to it.

**To create a router on the tenant network and attach the external and tenant
networks to it**

#. Create the router:

   .. code-block:: console

      $ neutron router-create demo-router
      Created a new router:
      +-----------------------+--------------------------------------+
      | Field                 | Value                                |
      +-----------------------+--------------------------------------+
      | admin_state_up        | True                                 |
      | external_gateway_info |                                      |
      | id                    | 635660ae-a254-4feb-8993-295aa9ec6418 |
      | name                  | demo-router                          |
      | routes                |                                      |
      | status                | ACTIVE                               |
      | tenant_id             | cdef0071a0194d19ac6bb63802dc9bae     |
      +-----------------------+--------------------------------------+

#. Attach the router to the ``demo`` tenant subnet:

   .. code-block:: console

      $ neutron router-interface-add demo-router demo-subnet
      Added interface b1a894fd-aee8-475c-9262-4342afdc1b58 to router demo-router.

#. Attach the router to the external network by setting it as the gateway:

   .. code-block:: console

      $ neutron router-gateway-set demo-router ext-net
      Set gateway for router demo-router

.. _verify-connectivity:

Verify connectivity
~~~~~~~~~~~~~~~~~~~
We recommend that you verify network connectivity and resolve any issues
before proceeding further. Following the external network subnet example
using ``203.0.113.0/24``, the tenant router gateway should occupy the
lowest IP address in the floating IP address range, ``203.0.113.101``.
If you configured your external physical network and virtual networks
correctly, you should be able to ``ping`` this IP address from any host
on your external physical network.

.. note::

   If you are building your OpenStack nodes as virtual machines, you
   must configure the hypervisor to permit promiscuous mode on the
   external network.

**To verify network connectivity**

From a host on the external network, ping the tenant router gateway:

.. code-block:: console

   $ ping -c 4 203.0.113.101
   PING 203.0.113.101 (203.0.113.101) 56(84) bytes of data.
   64 bytes from 203.0.113.101: icmp_req=1 ttl=64 time=0.619 ms
   64 bytes from 203.0.113.101: icmp_req=2 ttl=64 time=0.189 ms
   64 bytes from 203.0.113.101: icmp_req=3 ttl=64 time=0.165 ms
   64 bytes from 203.0.113.101: icmp_req=4 ttl=64 time=0.216 ms

   --- 203.0.113.101 ping statistics ---
   4 packets transmitted, 4 received, 0% packet loss, time 2999ms
   rtt min/avg/max/mdev = 0.165/0.297/0.619/0.187 ms
