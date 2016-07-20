.. _config-address-scopes:

==============
Address scopes
==============

Address scopes build from subnet pools. While subnet pools provide a mechanism
for controlling the allocation of addresses to subnets, address scopes show
where addresses can be routed between networks, preventing the use of
overlapping addresses in any two subnets. Because all addresses allocated in
the address scope do not overlap, neutron routers do not NAT between your
tenants' network and your external network. As long as the addresses within
an address scope match, the Networking service performs simple routing
between networks.

Accessing address scopes
~~~~~~~~~~~~~~~~~~~~~~~~

Anyone with access to the Networking service can create their own address
scopes. However, network administrators can create shared address scopes,
allowing other projects to create networks within that address scope.

Access to addresses in a scope are managed through subnet pools.
Subnet pools can either be created in an address scope, or updated to belong
to an address scope.

With subnet pools, all addresses in use within the address
scope are unique from the point of view of the address scope owner. Therefore,
add more than one subnet pool to an address scope if the
pools have different owners, allowing for delegation of parts of the
address scope. Delegation prevents address overlap across the
whole scope. Otherwise, you receive an error if two pools have the same
address ranges.

Each router interface is associated with an address scope by looking at
subnets connected to the network. When a router connects
to an external network with matching address scopes, network traffic routes
between without Network address translation (NAT).
The router marks all traffic connections originating from each interface
with its corresponding address scope. If traffic leaves an interface in the
wrong scope, the router blocks the traffic.

Backwards compatibility
~~~~~~~~~~~~~~~~~~~~~~~

Networks created before the Mitaka release do not
contain explicitly named address scopes, unless the network contains
subnets from a subnet pool that belongs to a created or updated
address scope. The Networking service preserves backwards compatibility with
pre-Mitaka networks through special address scope properties so that
these networks can perform advanced routing:

#. Unlimited address overlap is allowed.
#. Neutron routers, by default, will NAT traffic from internal networks
   to external networks.
#. Pre-Mitaka address scopes are not visible through the API. You cannot
   list address scopes or show details. Scopes exist
   implicitly as a catch-all for addresses that are not explicitly scoped.

Create shared address scopes as an administrative user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section shows how to set up shared address scopes to
allow simple routing for project networks with the same subnet pools.

.. note:: Irrelevant fields have been trimmed from the output of
    these commands for brevity.

#. Create IPv6 and IPv4 address scopes:

   .. code-block:: console

      $ neutron address-scope-create --shared address-scope-ip6 6
      Created a new address_scope:
      +------------+--------------------------------------+
      | Field      | Value                                |
      +------------+--------------------------------------+
      | id         | 13b83fb2-beb4-4533-9e12-4bf9a5721ef5 |
      | ip_version | 6                                    |
      | name       | address-scope-ip6                    |
      | shared     | True                                 |
      +------------+--------------------------------------+

   .. code-block:: console

      $ neutron address-scope-create --shared address-scope-ip4 4
      Created a new address_scope:
      +------------+--------------------------------------+
      | Field      | Value                                |
      +------------+--------------------------------------+
      | id         | 97702525-e145-40c8-8c8f-d415930d12ce |
      | ip_version | 4                                    |
      | name       | address-scope-ip4                    |
      | shared     | True                                 |
      +------------+--------------------------------------+

#. Create subnet pools specifying the name (or UUID) of the address
   scope that the subnet pool belongs to. If you have existing
   subnet pools, use the ``subnetpool-update`` command to put them in
   a new address scope:

   .. code-block:: console

      $ neutron subnetpool-create --address-scope address-scope-ip6 \
        --shared --pool-prefix 2001:db8:a583::/48 --default-prefixlen 64 \
        subnet-pool-ip6
      Created a new subnetpool:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | address_scope_id  | 13b83fb2-beb4-4533-9e12-4bf9a5721ef5 |
      | default_prefixlen | 64                                   |
      | id                | 14813344-d11a-4896-906c-e4c378291058 |
      | ip_version        | 6                                    |
      | name              | subnet-pool-ip6                      |
      | prefixes          | 2001:db8:a583::/48                   |
      | shared            | True                                 |
      +-------------------+--------------------------------------+

   .. code-block:: console

      $ neutron subnetpool-create --address-scope address-scope-ip4 \
        --shared --pool-prefix 203.0.113.0/21 --default-prefixlen 26 \
        subnet-pool-ip4
      Created a new subnetpool:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | address_scope_id  | 97702525-e145-40c8-8c8f-d415930d12ce |
      | default_prefixlen | 26                                   |
      | id                | e2c4f12d-307f-4616-a4df-203a45e6cb7f |
      | ip_version        | 4                                    |
      | name              | subnet-pool-ip4                      |
      | prefixes          | 203.0.112.0/21                       |
      | shared            | True                                 |
      +-------------------+--------------------------------------+

#. Make sure that subnets on an external network are created
   from the subnet pools created above:

   .. code-block:: console

      $ neutron subnet-show ipv6-public-subnet
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 2001:db8::/64                        |
      | enable_dhcp       | False                                |
      | gateway_ip        | 2001:db8::2                          |
      | id                | 8e9299bf-5c48-4143-b081-010ba26636a2 |
      | ip_version        | 6                                    |
      | name              | ipv6-public-subnet                   |
      | network_id        | d2ac8578-7e86-4646-849a-afdf5a05fff0 |
      | subnetpool_id     | 14813344-d11a-4896-906c-e4c378291058 |
      +-------------------+--------------------------------------+

   .. code-block:: console

      $ neutron subnet-show public-subnet
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 172.24.4.0/24                        |
      | enable_dhcp       | False                                |
      | gateway_ip        | 172.24.4.1                           |
      | id                | 3c3029d2-8081-4e56-9842-6007ce742860 |
      | ip_version        | 4                                    |
      | name              | public-subnet                        |
      | network_id        | d2ac8578-7e86-4646-849a-afdf5a05fff0 |
      | subnetpool_id     | e2c4f12d-307f-4616-a4df-203a45e6cb7f |
      +-------------------+--------------------------------------+

Routing with address scopes for non-privileged users
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section shows how non-privileged users can use address scopes to
route straight to an external network without NAT.

#. Create a couple of networks to host subnets:

   .. code-block:: console

    $ neutron net-create network1
    Created a new network:
    +-------------------------+--------------------------------------+
    | Field                   | Value                                |
    +-------------------------+--------------------------------------+
    | id                      | f5a980d9-5521-438e-b831-0ebacba2b372 |
    | name                    | network1                             |
    | subnets                 |                                      |
    +-------------------------+--------------------------------------+

   .. code-block:: console

      $ neutron net-create network2
      Created a new network:
      +-------------------------+--------------------------------------+
      | Field                   | Value                                |
      +-------------------------+--------------------------------------+
      | id                      | 438e4f26-0e45-4b26-9797-57d0bd817953 |
      | name                    | network2                             |
      | subnets                 |                                      |
      +-------------------------+--------------------------------------+

#. Create a subnet not associated with a subnet pool or
   an address scope:

   .. code-block:: console

      $ neutron subnet-create --name subnet-ip4-1 network1 198.51.100.0/26
      Created a new subnet:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 198.51.100.0/26                      |
      | id                | 48ed5c71-2a1d-4f73-b29e-371deec04d44 |
      | name              | subnet-ip4-1                         |
      | network_id        | f5a980d9-5521-438e-b831-0ebacba2b372 |
      | subnetpool_id     |                                      |
      +-------------------+--------------------------------------+

   .. code-block:: console

      $ neutron subnet-create --name subnet-ip6-1 network1 \
        --ipv6-ra-mode slaac --ipv6-address-mode slaac \
        --ip_version 6 2001:db8:80d2:c4d3::/64
      Created a new subnet:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 2001:db8:80d2:c4d3::/64              |
      | id                | c9f0bb79-1d7b-435f-b362-05a9a7259aa6 |
      | name              | subnet-ip6-1                         |
      | network_id        | f5a980d9-5521-438e-b831-0ebacba2b372 |
      | subnetpool_id     |                                      |
      +-------------------+--------------------------------------+

#. Create a subnet using a subnet pool associated with a address scope
   from an external network:

   .. code-block:: console

      $ neutron subnet-create --name subnet-ip4-2 \
        --subnetpool subnet-pool-ip4 network2
      Created a new subnet:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 203.0.112.0/26                       |
      | id                | deb36645-8d46-4c13-a489-1135174d8a8c |
      | name              | subnet-ip4-2                         |
      | network_id        | 438e4f26-0e45-4b26-9797-57d0bd817953 |
      | subnetpool_id     | e2c4f12d-307f-4616-a4df-203a45e6cb7f |
      +-------------------+--------------------------------------+

   .. code-block:: console

      $ neutron subnet-create --name subnet-ip6-2 --ip_version 6 \
        --ipv6-ra-mode slaac --ipv6-address-mode slaac \
        --subnetpool subnet-pool-ip6 network2
      Created a new subnet:
      +-------------------+--------------------------------------+
      | Field             | Value                                |
      +-------------------+--------------------------------------+
      | cidr              | 2001:db8:a583::/64                   |
      | id                | b157e288-748e-4c4b-9b2e-8b8e65241036 |
      | name              | subnet-ip6-2                         |
      | network_id        | 438e4f26-0e45-4b26-9797-57d0bd817953 |
      | subnetpool_id     | 14813344-d11a-4896-906c-e4c378291058 |
      +-------------------+--------------------------------------+

   By creating subnets from scoped subnet pools, the network is
   associated with the address scope.

   .. code-block:: console

      $ neutron net-show network2
      +-------------------------+--------------------------------------+
      | Field                   | Value                                |
      +-------------------------+--------------------------------------+
      | id                      | 4f677ab6-32a1-452c-8feb-b0b6b7ed1a0f |
      | ipv4_address_scope      | 97702525-e145-40c8-8c8f-d415930d12ce |
      | ipv6_address_scope      | 13b83fb2-beb4-4533-9e12-4bf9a5721ef5 |
      | name                    | network2                             |
      | subnets                 | d5d68ac3-3eaa-439e-b75b-0e0b2c1d221a |
      |                         | 917f9360-a840-45c1-83a1-2a093bd7b376 |
      +-------------------------+--------------------------------------+

#. Connect a router to each of the tenant subnets that have been created, for
   example, using a router called ``router1``:

   .. code-block:: console

      $ neutron router-interface-add router1 subnet-ip4-1
      Added interface 73d832e1-e4a7-4029-9a66-f4e0f4ba0e76 to router router1.
      $ neutron router-interface-add router1 subnet-ip4-2
      Added interface 94b4cdb2-875d-4ab3-9a6e-803c3626c4d9 to router router1.
      $ neutron router-interface-add router1 subnet-ip6-1
      Added interface f35c4541-d529-4bd8-af4e-1b069269c263 to router router1.
      $ neutron router-interface-add router1 subnet-ip6-2
      Added interface f5904a4b-9547-4c08-bc7e-bc5fc71a8db9 to router router1.

Checking connectivity
---------------------

This example shows how to check the connectivity between networks
with address scopes.

#. Launch two instances, ``instance1`` on ``network1`` and
   ``instance2`` on ``network2``. Associate a floating IP address to both
   instances.

#. Adjust security groups to allow pings and SSH (both IPv4 and IPv6):

   .. code-block:: console

      $ nova list
      +--------------+-----------+---------------------------------------------------------------------------+
      | ID           | Name      | Networks                                                                  |
      +--------------+-----------+---------------------------------------------------------------------------+
      | 97e49c8e-... | instance1 | network1=2001:db8:80d2:c4d3:f816:3eff:fe52:b69f, 198.51.100.3, 172.24.4.3 |
      | ceba9638-... | instance2 | network2=203.0.112.3, 2001:db8:a583:0:f816:3eff:fe42:1eeb, 172.24.4.4     |
      +--------------+-----------+---------------------------------------------------------------------------+

Regardless of address scopes, the floating IPs can be pinged from the
external network:

.. code-block:: console

    $ ping -c 1 172.24.4.3
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    $ ping -c 1 172.24.4.4
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

You can now ping ``instance2`` directly because ``instance2`` shares the
same address scope as the external network:

.. note:: BGP routing can be used to automatically set up a static
   route for your instances.

.. code-block:: console

    # ip route add 203.0.112.0/26 via 172.24.4.2
    $ ping -c 1 203.0.112.3
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

.. code-block:: console

    # ip route add 2001:db8:a583::/64 via 2001:db8::1
    $ ping6 -c 1 2001:db8:a583:0:f816:3eff:fe42:1eeb
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

You cannot ping ``instance1`` directly because the address scopes do not
match:

.. code-block:: console

    # ip route add 198.51.100.0/26 via 172.24.4.2
    $ ping -c 1 198.51.100.3
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

.. code-block:: console

    # ip route add 2001:db8:80d2:c4d3::/64 via 2001:db8::1
    $ ping6 -c 1 2001:db8:80d2:c4d3:f816:3eff:fe52:b69f
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

If the address scopes match between
networks then pings and other traffic route directly through. If the
scopes do not match between networks, the router either drops the
traffic or applies NAT to cross scope boundaries.
