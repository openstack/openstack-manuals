.. _configuring-compute-service-groups:

================================
Configure Compute service groups
================================

The Compute service must know the status of each compute node to
effectively manage and use them. This can include events like a user
launching a new VM, the scheduler sending a request to a live node, or a
query to the ServiceGroup API to determine if a node is live.

When a compute worker running the nova-compute daemon starts, it calls
the join API to join the compute group. Any service (such as the
scheduler) can query the group's membership and the status of its nodes.
Internally, the ServiceGroup client driver automatically updates the
compute worker status.

.. _database-servicegroup-driver:

Database ServiceGroup driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, Compute uses the database driver to track if a node is live.
In a compute worker, this driver periodically sends a ``db update``
command to the database, saying “I'm OK” with a timestamp. Compute uses
a pre-defined timeout (``service_down_time``) to determine if a node is
dead.

The driver has limitations, which can be problematic depending on your
environment. If a lot of compute worker nodes need to be checked, the
database can be put under heavy load, which can cause the timeout to
trigger, and a live node could incorrectly be considered dead. By
default, the timeout is 60 seconds. Reducing the timeout value can help
in this situation, but you must also make the database update more
frequently, which again increases the database workload.

The database contains data that is both transient (such as whether the
node is alive) and persistent (such as entries for VM owners). With the
ServiceGroup abstraction, Compute can treat each type separately.

.. _zookeeper-servicegroup-driver:

ZooKeeper ServiceGroup driver
-----------------------------

The ZooKeeper ServiceGroup driver works by using ZooKeeper ephemeral
nodes. ZooKeeper, unlike databases, is a distributed system, with its
load divided among several servers. On a compute worker node, the driver
can establish a ZooKeeper session, then create an ephemeral znode in the
group directory. Ephemeral znodes have the same lifespan as the session.
If the worker node or the nova-compute daemon crashes, or a network
partition is in place between the worker and the ZooKeeper server
quorums, the ephemeral znodes are removed automatically. The driver
can be given group membership by running the :command:`ls` command in the
group directory.

The ZooKeeper driver requires the ZooKeeper servers and client
libraries. Setting up ZooKeeper servers is outside the scope of this
guide (for more information, see `Apache Zookeeper <http://zookeeper.apache.org/>`_). These client-side
Python libraries must be installed on every compute node:

**python-zookeeper**
  The official Zookeeper Python binding

**evzookeeper**
  This library makes the binding work with the eventlet threading model.

This example assumes the ZooKeeper server addresses and ports are
``192.168.2.1:2181``, ``192.168.2.2:2181``, and ``192.168.2.3:2181``.

These values in the ``/etc/nova/nova.conf`` file are required on every
node for the ZooKeeper driver:

.. code-block:: ini

   # Driver for the ServiceGroup service
   servicegroup_driver="zk"

   [zookeeper]
   address="192.168.2.1:2181,192.168.2.2:2181,192.168.2.3:2181"

.. _memcache-servicegroup-driver:

Memcache ServiceGroup driver
----------------------------

The memcache ServiceGroup driver uses memcached, a distributed memory
object caching system that is used to increase site performance. For
more details, see `memcached.org <http://memcached.org/>`_.

To use the memcache driver, you must install memcached. You might
already have it installed, as the same driver is also used for the
OpenStack Object Storage and OpenStack dashboard. To install
memcached, see the *Environment -> Memcached* section in the
`Installation Tutorials and Guides <https://docs.openstack.org/project-install-guide/ocata>`_
depending on your distribution.

These values in the ``/etc/nova/nova.conf`` file are required on every
node for the memcache driver:

.. code-block:: ini

   # Driver for the ServiceGroup service
   servicegroup_driver = "mc"

   # Memcached servers. Use either a list of memcached servers to use for caching (list value),
   # or "<None>" for in-process caching (default).
   memcached_servers = <None>

   # Timeout; maximum time since last check-in for up service (integer value).
   # Helps to define whether a node is dead
   service_down_time = 60
