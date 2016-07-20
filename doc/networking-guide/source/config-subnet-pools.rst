.. _config-subnet-pools:

============
Subnet pools
============

Subnet pools have been made available since the Kilo release. It is a simple
feature that has the potential to improve your workflow considerably. It also
provides a building block from which other new features will be built in to
OpenStack Networking.

To see if your cloud has this feature available, you can check that it is
listed in the supported aliases. You can do this with the neutron client.

.. code-block:: console

    $ neutron ext-list | grep subnet_allocation
    | subnet_allocation | Subnet Allocation |

Why you need them
~~~~~~~~~~~~~~~~~

Before Kilo, Networking had no automation around the addresses used to create a
subnet. To create one, you had to come up with the addresses on your own
without any help from the system. There are valid use cases for this but if you
are interested in the following capabilities, then subnet pools might be for
you.

First, would not it be nice if you could turn your pool of addresses over to
Neutron to take care of?  When you need to create a subnet, you just ask for
addresses to be allocated from the pool. You do not have to worry about what
you have already used and what addresses are in your pool. Subnet pools can do
this.

Second, subnet pools can manage addresses across tenants. The addresses are
guaranteed not to overlap. If the addresses come from an externally routable
pool then you know that all of the tenants have addresses which are *routable*
and unique. This can be useful in the following scenarios.

#. IPv6 since OpenStack Networking has no IPv6 floating IPs.
#. Routing directly to a tenant network from an external network.

How they work
~~~~~~~~~~~~~

A subnet pool manages a pool of addresses from which subnets can be allocated.
It ensures that there is no overlap between any two subnets allocated from the
same pool.

As a regular tenant in an OpenStack cloud, you can create a subnet pool of your
own and use it to manage your own pool of addresses. This does not require any
admin privileges. Your pool will not be visible to any other tenant.

If you are an admin, you can create a pool which can be accessed by any regular
tenant. Being a shared resource, there is a quota mechanism to arbitrate
access.

Quotas
~~~~~~

Subnet pools have a quota system which is a little bit different than
other quotas in Neutron. Other quotas in Neutron count discrete
instances of an object against a quota. Each time you create something
like a router, network, or a port, it uses one from your total quota.

With subnets, the resource is the IP address space. Some subnets take
more of it than others. For example, 203.0.113.0/24 uses 256 addresses
in one subnet but 198.51.100.224/28 uses only 16. If address space is
limited, the quota system can encourage efficient use of the space.

With IPv4, the default_quota can be set to the number of absolute
addresses any given tenant is allowed to consume from the pool. For
example, with a quota of 128, I might get 203.0.113.128/26,
203.0.113.224/28, and still have room to allocate 48 more addresses in
the future.

With IPv6 it is a little different. It is not practical to count
individual addresses. To avoid ridiculously large numbers, the quota is
expressed in the number of /64 subnets which can be allocated. For
example, with a default_quota of 3, I might get 2001:db8:c18e:c05a::/64,
2001:db8:221c:8ef3::/64, and still have room to allocate one more prefix
in the future.

Default subnet pools
~~~~~~~~~~~~~~~~~~~~

Beginning with Mitaka, a subnet pool can be marked as the default. This
is handled with a new extension.

.. code-block:: console

    $ neutron ext-list | grep default-subnetpools
    | default-subnetpools | Default Subnetpools |

An administrator can mark a pool as default. Only one pool from each
address family can be marked default.

.. code-block:: console

    $ neutron subnetpool-update --is-default True 74348864-f8bf-4fc0-ab03-81229d189467
    Updated subnetpool: 74348864-f8bf-4fc0-ab03-81229d189467

If there is a default, it can be requested by passing
:option:`--use-default-subnetpool` instead of
:option:`--subnetpool SUBNETPOOL`.

Demo
----

If you have access to an OpenStack Kilo or later based neutron, you can play
with this feature now. Give it a try. All of the following commands work
equally as well with IPv6 addresses.

First, as admin, create a shared subnet pool:

.. code-block:: console

    admin> neutron subnetpool-create --shared --pool-prefix 203.0.113.0/24 \
               --default-prefixlen 26 demo-subnetpool4
    Created a new subnetpool:
    +-------------------+--------------------------------------+
    | Field             | Value                                |
    +-------------------+--------------------------------------+
    | default_prefixlen | 26                                   |
    | default_quota     |                                      |
    | id                | 670eb517-4fd3-4dfc-9bed-da2f99f85c7a |
    | ip_version        | 4                                    |
    | name              | demo-subnetpool4                     |
    | prefixes          | 203.0.113.0/24                       |
    | shared            | True                                 |
    | tenant_id         | c597484841ff4a8785804c62ba81449b     |
    +-------------------+--------------------------------------+

The ``default_prefixlen`` defines the subnet size you will get if you do not
specify :option:`--prefixlen` when creating a subnet.

Do essentially the same thing for IPv6 and there are now two subnet
pools. Regular tenants can see them. (the output is trimmed a bit
for display)

.. code-block:: console

    $ neutron subnetpool-list
    +---------+------------------+------------------------------------+-------------------+
    | id      | name             | prefixes                           | default_prefixlen |
    +---------+------------------+------------------------------------+-------------------+
    | 670e... | demo-subnetpool4 | [u'203.0.113.0/24']                | 26                |
    | 7b69... | demo-subnetpool  | [u'2001:db8:1:2', u'2001:db8:1:2'] | 64                |
    +---------+------------------+------------------------------------+-------------------+

Now, use them. It is easy to create a subnet from a pool:

.. code-block:: console

    $ neutron subnet-create --name demo-subnet1 --ip_version 4 \
          --subnetpool demo-subnetpool4 demo-network1
    +-------------------+--------------------------------------+
    | Field             | Value                                |
    +-------------------+--------------------------------------+
    | id                | 6e38b23f-0b27-4e3c-8e69-fd23a3df1935 |
    | ip_version        | 4                                    |
    | cidr              | 203.0.113.0/26                       |
    | name              | demo-subnet1                         |
    | network_id        | b5b729d8-31cc-4d2c-8284-72b3291fec02 |
    | subnetpool_id     | 670eb517-4fd3-4dfc-9bed-da2f99f85c7a |
    | tenant_id         | a8b3054cc1214f18b1186b291525650f     |
    +-------------------+--------------------------------------+

You can request a specific subnet from the pool. You need to specify a subnet
that falls within the pool's prefixes. If the subnet is not already allocated,
the request succeeds. You can leave off the IP version because it is deduced
from the subnet pool.

.. code-block:: console

    $ neutron subnet-create --name demo-subnet2 \
          --subnetpool demo-subnetpool4 demo-network1 203.0.113.128/26
    Created a new subnet:
    +-------------------+----------------------------------------------------+
    | Field             | Value                                              |
    +-------------------+----------------------------------------------------+
    | id                | b15db708-ce90-4ce3-8852-52e1779bae1f               |
    | ip_version        | 4                                                  |
    | cidr              | 203.0.113.128/26                                   |
    | name              | demo-subnet2                                       |
    | network_id        | 8d16c25d-690c-4414-a0c8-afbe698a1e73               |
    | subnetpool_id     | 499b768b-0f8f-4762-8748-792e7e00face               |
    | tenant_id         | a8b3054cc1214f18b1186b291525650f                   |
    +-------------------+----------------------------------------------------+

If the pool becomes exhausted, load some more prefixes:

.. code-block:: console

    admin> neutron subnetpool-update --pool-prefix 203.0.113.0/24 \
               --pool-prefix 198.51.100.0/24 demo-subnetpool4
    Updated subnetpool: demo-subnetpool4
    admin> neutron subnetpool-show demo-subnetpool4
    +-------------------+--------------------------------------+
    | Field             | Value                                |
    +-------------------+--------------------------------------+
    | default_prefixlen | 26                                   |
    | default_quota     |                                      |
    | id                | 670eb517-4fd3-4dfc-9bed-da2f99f85c7a |
    | ip_version        | 4                                    |
    | name              | demo-subnetpool4                     |
    | prefixes          | 198.51.100.0/24                      |
    |                   | 203.0.113.0/24                       |
    | shared            | True                                 |
    | tenant_id         | c597484841ff4a8785804c62ba81449b     |
    +-------------------+--------------------------------------+
