==========================
The Pacemaker architecture
==========================

What is a cluster manager
~~~~~~~~~~~~~~~~~~~~~~~~~

At its core, a cluster is a distributed finite state machine capable
of co-ordinating the startup and recovery of inter-related services
across a set of machines.

Even a distributed and/or replicated application that is able to
survive failures on one or more machines can benefit from a
cluster manager:

#. Awareness of other applications in the stack

   While SYS-V init replacements like systemd can provide
   deterministic recovery of a complex stack of services, the
   recovery is limited to one machine and lacks the context of what
   is happening on other machines - context that is crucial to
   determine the difference between a local failure, clean startup
   and recovery after a total site failure.

#. Awareness of instances on other machines

   Services like RabbitMQ and Galera have complicated boot-up
   sequences that require co-ordination, and often serialization, of
   startup operations across all machines in the cluster. This is
   especially true after site-wide failure or shutdown where we must
   first determine the last machine to be active.

#. A shared implementation and calculation of `quorum
   <http://en.wikipedia.org/wiki/Quorum_(Distributed_Systems)>`_.

   It is very important that all members of the system share the same
   view of who their peers are and whether or not they are in the
   majority. Failure to do this leads very quickly to an internal
   `split-brain <http://en.wikipedia.org/wiki/Split-brain_(computing)>`_
   state - where different parts of the system are pulling in
   different and incompatible directions.

#. Data integrity through fencing (a non-responsive process does not
   imply it is not doing anything)

   A single application does not have sufficient context to know the
   difference between failure of a machine and failure of the
   applcation on a machine. The usual practice is to assume the
   machine is dead and carry on, however this is highly risky - a
   rogue process or machine could still be responding to requests and
   generally causing havoc. The safer approach is to make use of
   remotely accessible power switches and/or network switches and SAN
   controllers to fence (isolate) the machine before continuing.

#. Automated recovery of failed instances

   While the application can still run after the failure of several
   instances, it may not have sufficient capacity to serve the
   required volume of requests. A cluster can automatically recover
   failed instances to prevent additional load induced failures.

For this reason, the use of a cluster manager like `Pacemaker
<http://clusterlabs.org>`_ is highly recommended.

Deployment flavors
~~~~~~~~~~~~~~~~~~

It is possible to deploy three different flavors of the Pacemaker
architecture. The two extremes are **Collapsed** (where every
component runs on every node) and **Segregated** (where every
component runs in its own 3+ node cluster).

Regardless of which flavor you choose, it is recommended that the
clusters contain at least three nodes so that we can take advantage of
`quorum <quorum_>`_.

Quorum becomes important when a failure causes the cluster to split in
two or more partitions. In this situation, you want the majority to
ensure the minority are truly dead (through fencing) and continue to
host resources. For a two-node cluster, no side has the majority and
you can end up in a situation where both sides fence each other, or
both sides are running the same services - leading to data corruption.

Clusters with an even number of hosts suffer from similar issues - a
single network failure could easily cause a N:N split where neither
side retains a majority. For this reason, we recommend an odd number
of cluster members when scaling up.

You can have up to 16 cluster members (this is currently limited by
the ability of corosync to scale higher). In extreme cases, 32 and
even up to 64 nodes could be possible, however, this is not well tested.

Collapsed
---------

In this configuration, there is a single cluster of 3 or more
nodes on which every component is running.

This scenario has the advantage of requiring far fewer, if more
powerful, machines. Additionally, being part of a single cluster
allows us to accurately model the ordering dependencies between
components.

This scenario can be visualized as below.

.. image:: /figures/Cluster-deployment-collapsed.png
   :width: 100%

You would choose this option if you prefer to have fewer but more
powerful boxes.

This is the most common option and the one we document here.

Segregated
----------

In this configuration, each service runs in a dedicated cluster of
3 or more nodes.

The benefits of this approach are the physical isolation between
components and the ability to add capacity to specific components.

You would choose this option if you prefer to have more but
less powerful boxes.

This scenario can be visualized as below, where each box below
represents a cluster of three or more guests.

.. image:: /figures/Cluster-deployment-segregated.png
   :width: 100%

Mixed
-----

It is also possible to follow a segregated approach for one or more
components that are expected to be a bottleneck and use a collapsed
approach for the remainder.


Proxy server
~~~~~~~~~~~~

Almost all services in this stack benefit from being proxied.
Using a proxy server provides:

#. Load distribution

   Many services can act in an active/active capacity, however, they
   usually require an external mechanism for distributing requests to
   one of the available instances. The proxy server can serve this
   role.

#. API isolation

   By sending all API access through the proxy, we can clearly
   identify service interdependencies. We can also move them to
   locations other than ``localhost`` to increase capacity if the
   need arises.

#. Simplified process for adding/removing of nodes

   Since all API access is directed to the proxy, adding or removing
   nodes has no impact on the configuration of other services. This
   can be very useful in upgrade scenarios where an entirely new set
   of machines can be configured and tested in isolation before
   telling the proxy to direct traffic there instead.

#. Enhanced failure detection

   The proxy can be configured as a secondary mechanism for detecting
   service failures. It can even be configured to look for nodes in
   a degraded state (such as being 'too far' behind in the
   replication) and take them out of circulation.

The following components are currently unable to benefit from the use
of a proxy server:

* RabbitMQ
* Memcached
* MongoDB

However, the reasons vary and are discussed under each component's
heading.

We recommend HAProxy as the load balancer, however, there are many
alternatives in the marketplace.

We use a check interval of 1 second, however, the timeouts vary by service.

Generally, we use round-robin to distribute load amongst instances of
active/active services, however, Galera uses the ``stick-table`` options
to ensure that incoming connections to the virtual IP (VIP) should be
directed to only one of the available back ends.

In Galera's case, although it can run active/active, this helps avoid
lock contention and prevent deadlocks. It is used in combination with
the ``httpchk`` option that ensures only nodes that are in sync with its
peers are allowed to handle requests.
