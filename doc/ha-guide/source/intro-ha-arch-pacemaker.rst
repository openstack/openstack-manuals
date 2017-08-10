==========================
The Pacemaker architecture
==========================

What is a cluster manager?
~~~~~~~~~~~~~~~~~~~~~~~~~~

At its core, a cluster is a distributed finite state machine capable
of co-ordinating the startup and recovery of inter-related services
across a set of machines.

Even a distributed or replicated application that is able to survive failures
on one or more machines can benefit from a cluster manager because a cluster
manager has the following capabilities:

#. Awareness of other applications in the stack

   While SYS-V init replacements like systemd can provide
   deterministic recovery of a complex stack of services, the
   recovery is limited to one machine and lacks the context of what
   is happening on other machines. This context is crucial to
   determine the difference between a local failure, and clean startup
   and recovery after a total site failure.

#. Awareness of instances on other machines

   Services like RabbitMQ and Galera have complicated boot-up
   sequences that require co-ordination, and often serialization, of
   startup operations across all machines in the cluster. This is
   especially true after a site-wide failure or shutdown where you must
   first determine the last machine to be active.

#. A shared implementation and calculation of `quorum
   <https://en.wikipedia.org/wiki/Quorum_(Distributed_Systems)>`_

   It is very important that all members of the system share the same
   view of who their peers are and whether or not they are in the
   majority. Failure to do this leads very quickly to an internal
   `split-brain <https://en.wikipedia.org/wiki/Split-brain_(computing)>`_
   state. This is where different parts of the system are pulling in
   different and incompatible directions.

#. Data integrity through fencing (a non-responsive process does not
   imply it is not doing anything)

   A single application does not have sufficient context to know the
   difference between failure of a machine and failure of the
   application on a machine. The usual practice is to assume the
   machine is dead and continue working, however this is highly risky. A
   rogue process or machine could still be responding to requests and
   generally causing havoc. The safer approach is to make use of
   remotely accessible power switches and/or network switches and SAN
   controllers to fence (isolate) the machine before continuing.

#. Automated recovery of failed instances

   While the application can still run after the failure of several
   instances, it may not have sufficient capacity to serve the
   required volume of requests. A cluster can automatically recover
   failed instances to prevent additional load induced failures.

For these reasons, we highly recommend the use of a cluster manager like
`Pacemaker <http://clusterlabs.org>`_.

Deployment flavors
~~~~~~~~~~~~~~~~~~

It is possible to deploy three different flavors of the Pacemaker
architecture. The two extremes are ``Collapsed`` (where every
component runs on every node) and ``Segregated`` (where every
component runs in its own 3+ node cluster).

Regardless of which flavor you choose, we recommend that
clusters contain at least three nodes so that you can take advantage of
`quorum <quorum_>`_.

Quorum becomes important when a failure causes the cluster to split in
two or more partitions. In this situation, you want the majority members of
the system to ensure the minority are truly dead (through fencing) and continue
to host resources. For a two-node cluster, no side has the majority and
you can end up in a situation where both sides fence each other, or
both sides are running the same services. This can lead to data corruption.

Clusters with an even number of hosts suffer from similar issues. A
single network failure could easily cause a N:N split where neither
side retains a majority. For this reason, we recommend an odd number
of cluster members when scaling up.

You can have up to 16 cluster members (this is currently limited by
the ability of corosync to scale higher). In extreme cases, 32 and
even up to 64 nodes could be possible. However, this is not well tested.

Collapsed
---------

In a collapsed configuration, there is a single cluster of 3 or more
nodes on which every component is running.

This scenario has the advantage of requiring far fewer, if more
powerful, machines. Additionally, being part of a single cluster
allows you to accurately model the ordering dependencies between
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
Using a proxy server provides the following capabilities:

#. Load distribution

   Many services can act in an active/active capacity, however, they
   usually require an external mechanism for distributing requests to
   one of the available instances. The proxy server can serve this
   role.

#. API isolation

   By sending all API access through the proxy, you can clearly
   identify service interdependencies. You can also move them to
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
   a degraded state (such as being too far behind in the
   replication) and take them out of circulation.

The following components are currently unable to benefit from the use
of a proxy server:

* RabbitMQ
* Memcached
* MongoDB

We recommend HAProxy as the load balancer, however, there are many alternative
load balancing solutions in the marketplace.

Generally, we use round-robin to distribute load amongst instances of
active/active services. Alternatively, Galera uses ``stick-table`` options
to ensure that incoming connection to virtual IP (VIP) are directed to only one
of the available back ends. This helps avoid lock contention and prevent
deadlocks, although Galera can run active/active. Used in combination with
the ``httpchk`` option, this ensure only nodes that are in sync with their
peers are allowed to handle requests.
