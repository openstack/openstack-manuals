==============
Address scopes
==============

Address scopes have been made available since the Mitaka release. They build
from subnet pools added in Kilo. While subnet pools provide a mechanism for
controlling the allocation of addresses to subnets, address scopes provide a
way to know where addresses are viable. Like subnet pools, they also prevent
using overlapping addresses in any two subnets.

Why you need them
~~~~~~~~~~~~~~~~~

With address scopes, OpenStack Networking knows where addresses can be routed
essentially because all of the allocated addresses within the scope are
non-overlapping and they are under the control of the address scope owner.

You can set up the address scopes for tenants to pull addresses from. Then,
since neutron routers understand address scopes, they will not NAT between
these networks and your external network as long as the scopes match. They will
just do simple routing.

How it works
~~~~~~~~~~~~

Anyone can create an address scope. Admins can create shared address
scopes seen by all tenants.

Access to addresses in a scope is managed through subnet pools. You can
create a subnet pool in an address scope or you can update existing
subnet pools to belong to a scope.

It may be useful to add more than one subnet pool to an address scope if
the pools have different owners. This allows delegation of parts of the
address scope. Address overlap is prevented across the whole scope so
you will get an error if two pools have some of the same address ranges
in them.

A Neutron router connects at least a couple of networks. Each router
interface is associated with an address scope by looking at the subnets
on the network its connected to. The router internally marks all
traffic connections originating from each interface with the
corresponding address scope to track it. If traffic tries to leave an
interface in the wrong scope, it is blocked.

When a router connects to two networks with the same address scope, it
knows that these networks can be routed without any kind of address
translation. Also, since subnet pools are part of the foundation of
address scopes, Neutron knows that all of the addresses in use within an
address scope are unique and legitimate from the address scope owner's
point of view.

No scope
~~~~~~~~

OpenStack Networking preserves backwards compatibility with pre-Mitaka
Networking. You will not notice any difference until you decide to begin using
hem so you will not be forced to change your behavior.

When subnets are not explicitly part of an explicit address scope.  They can be
considered part of a catch all implicit scope which is different in a few ways
to preserve backwards compatibility.

#. Unlimited address overlap is allowed.
#. Neutron routers, by default, will NAT traffic from internal networks
   to external networks even if they are all in this scope (unless snat
   is disabled for the router.)
#. This scope is not visible through the API. It will not show up when you
   list address scopes and you cannot show details. It exists only
   implicitly to catch all addresses which are not explicitly scoped.

Demo
----

Give it a try. Starting with devstack is recommended.

.. note:: Some irrelevant fields have been trimmed from the output of
    these commands just for brevity and to avoid distracting with too
    many details.

Admin commands
______________

First, as admin, create a couple of shared address scopes, subnet pools to
manage the addresses inside them, and an external network with subnets from
these pools so that tenant networks from the same pools will be routed straight
through.  The following examples show how to accomplish this.

.. code-block:: console

    admin> neutron address-scope-create --shared address-scope-ip6 6
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

    admin> neutron address-scope-create --shared address-scope-ip4 4
    Created a new address_scope:
    +------------+--------------------------------------+
    | Field      | Value                                |
    +------------+--------------------------------------+
    | id         | 97702525-e145-40c8-8c8f-d415930d12ce |
    | ip_version | 4                                    |
    | name       | address-scope-ip4                    |
    | shared     | True                                 |
    +------------+--------------------------------------+

Next, create subnet pools specifying the name (or UUID) of the address
scope that the subnet pool should belong to. If you have existing
subnet pools, you can use the subnet-pool-update command to put them in
to a new address scope.

.. code-block:: console

    admin> neutron subnetpool-create --address-scope address-scope-ip6 \
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

    admin> neutron subnetpool-create --address-scope address-scope-ip4 \
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

Now that these are created, create subnets on an external network.

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

.. note:: In the interest of full disclosure, I didn't explain here how to go
   about creating an external subnets with this subnet pool.  How should we
   handle this in the final docs?  It is pretty much covered in the subnet
   pools doc but it isn't all shown here which could make this little tutorial
   a tiny bit frustrating.

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

This completes the portion of the demo that requires admin privileges.  The
address scope has been created with subnet pools to manage addresses.  Finally,
the external network has been created with subnets from the address scope.

Non-admin tenant commands
_________________________

As a tenant, create networks that will be routed straight to the external
network without NAT.  Also, create a network the old way to demonstrate how
routing between address scopes is not allowed between tenant networks.  Start
by creating a couple of networks to host the subnets.

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

First, create a subnet the old way, it will not be associated with a
subnetpool nor an address scope.

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

Next, create a subnet using an subnet pool.  These subnets come from the
address scope as the external network.

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

Note that by creating subnets from scoped subnet pools, the network is
now associated with the address scope.

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

Connect a router to each of the tenant subnets that have been created.  This
example uses a pre-existing router called router1.

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
_____________________

Boot two vms, instance1 on network1 and instance2 on network2 and give
them floating ip addresses. Adjust security groups to allow pings and
ssh (both IPv4 and IPv6).

.. code-block:: console

    $ nova list
    +--------------+-----------+---------------------------------------------------------------------------+
    | ID           | Name      | Networks                                                                  |
    +--------------+-----------+---------------------------------------------------------------------------+
    | 97e49c8e-... | instance1 | network1=2001:db8:80d2:c4d3:f816:3eff:fe52:b69f, 198.51.100.3, 172.24.4.3 |
    | ceba9638-... | instance2 | network2=203.0.112.3, 2001:db8:a583:0:f816:3eff:fe42:1eeb, 172.24.4.4     |
    +--------------+-----------+---------------------------------------------------------------------------+

Regardless of address scopes, the floating IPs are pingable from the
external network.

.. code-block:: console

    $ ping -c 1 172.24.4.3
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    $ ping -c 1 172.24.4.4
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

With just a little bit of routing help, the internal network2 is
pingable directly because it is in the the same address scope as the
external network.

.. note:: When I wrote this, I didn't have
   the BGP routing work available in Neutron.  So, I added a static route
   manually.  However, now BGP is available which could fill the gap but at the
   cost of going through all of that setup.  How should we handle this in the
   docs?

.. code-block:: console

    # ip route add 203.0.112.0/26 via 172.24.4.2
    $ ping -c 1 203.0.112.3
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

.. code-block:: console

    # ip route add 2001:db8:a583::/64 via 2001:db8::1
    $ ping6 -c 1 2001:db8:a583:0:f816:3eff:fe42:1eeb
    1 packets transmitted, 1 received, 0% packet loss, time 0ms

The other network is not pingable directly because the scopes do not
match.

.. code-block:: console

    # ip route add 198.51.100.0/26 via 172.24.4.2
    $ ping -c 1 198.51.100.3
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

.. code-block:: console

    # ip route add 2001:db8:80d2:c4d3::/64 via 2001:db8::1
    $ ping6 -c 1 2001:db8:80d2:c4d3:f816:3eff:fe52:b69f
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

In general, if address scopes are used and the scope matches between
networks then pings (and other traffic) route directly through. If the
scopes do not match between networks then the router either drops the
traffic or it applies NAT to cross scope boundaries.
