==========
Management
==========

When you finish installing and configuring the OpenStack database,
you can initialize the Galera Cluster.

Prerequisites
~~~~~~~~~~~~~

- Database hosts with Galera Cluster installed
- A minimum of three hosts
- No firewalls between the hosts
- SELinux and AppArmor set to permit access to ``mysqld``
- The correct path to ``libgalera_smm.so`` given to the
  ``wsrep_provider`` parameter

Initializing the cluster
~~~~~~~~~~~~~~~~~~~~~~~~~

In the Galera Cluster, the Primary Component is the cluster of database
servers that replicate into each other. In the event that a
cluster node loses connectivity with the Primary Component, it
defaults into a non-operational state, to avoid creating or serving
inconsistent data.

By default, cluster nodes do not start as part of a Primary Component.
In the Primary Component, replication and state transfers bring all databases
to the same state.

To start the cluster, complete the following steps:

#. Initialize the Primary Component on one cluster node. For
   servers that use ``init``, run the following command:

   .. code-block:: console

      # service mysql start --wsrep-new-cluster

   For servers that use ``systemd``, run the following command:

   .. code-block:: console

      # systemctl start mariadb --wsrep-new-cluster

#. Once the database server starts, check the cluster status using
   the ``wsrep_cluster_size`` status variable. From the database
   client, run the following command:

   .. code-block:: mysql

      SHOW STATUS LIKE 'wsrep_cluster_size';

      +--------------------+-------+
      | Variable_name      | Value |
      +--------------------+-------+
      | wsrep_cluster_size | 1     |
      +--------------------+-------+

#. Start the database server on all other cluster nodes. For
   servers that use ``init``, run the following command:

   .. code-block:: console

      # service mysql start

   For servers that use ``systemd``, run the following command:

   .. code-block:: console

      # systemctl start mariadb

#. When you have all cluster nodes started, log into the database
   client of any cluster node and check the ``wsrep_cluster_size``
   status variable again:

   .. code-block:: mysql

      SHOW STATUS LIKE 'wsrep_cluster_size';

      +--------------------+-------+
      | Variable_name      | Value |
      +--------------------+-------+
      | wsrep_cluster_size | 3     |
      +--------------------+-------+

When each cluster node starts, it checks the IP addresses given to
the ``wsrep_cluster_address`` parameter. It then attempts to establish
network connectivity with a database server running there. Once it
establishes a connection, it attempts to join the Primary
Component, requesting a state transfer as needed to bring itself
into sync with the cluster.

.. note::

   In the event that you need to restart any cluster node, you can do
   so. When the database server comes back it, it establishes
   connectivity with the Primary Component and updates itself to any
   changes it may have missed while down.

Restarting the cluster
-----------------------

Individual cluster nodes can stop and be restarted without issue.
When a database loses its connection or restarts, the Galera Cluster
brings it back into sync once it reestablishes connection with the
Primary Component. In the event that you need to restart the
entire cluster, identify the most advanced cluster node and
initialize the Primary Component on that node.

To find the most advanced cluster node, you need to check the
sequence numbers, or the ``seqnos``, on the last committed transaction for
each. You can find this by viewing ``grastate.dat`` file in
database directory:

.. code-block:: console

   $ cat /path/to/datadir/grastate.dat

   # Galera saved state
   version: 3.8
   uuid:    5ee99582-bb8d-11e2-b8e3-23de375c1d30
   seqno:   8204503945773

Alternatively, if the database server is running, use the
``wsrep_last_committed`` status variable:

.. code-block:: mysql

   SHOW STATUS LIKE 'wsrep_last_committed';

   +----------------------+--------+
   | Variable_name        | Value  |
   +----------------------+--------+
   | wsrep_last_committed | 409745 |
   +----------------------+--------+

This value increments with each transaction, so the most advanced
node has the highest sequence number and therefore is the most up to date.

Configuration tips
~~~~~~~~~~~~~~~~~~~

Deployment strategies
----------------------

Galera can be configured using one of the following
strategies:

- Each instance has its own IP address:

  OpenStack services are configured with the list of these IP
  addresses so they can select one of the addresses from those
  available.

- Galera runs behind HAProxy:

  HAProxy load balances incoming requests and exposes just one IP
  address for all the clients.

  Galera synchronous replication guarantees a zero slave lag. The
  failover procedure completes once HAProxy detects that the active
  back end has gone down and switches to the backup one, which is
  then marked as ``UP``. If no back ends are ``UP``, the failover
  procedure finishes only when the Galera Cluster has been
  successfully reassembled. The SLA is normally no more than 5
  minutes.

- Use MySQL/Galera in active/passive mode to avoid deadlocks on
  ``SELECT ... FOR UPDATE`` type queries (used, for example, by nova
  and neutron). This issue is discussed in the following:

  - `IMPORTANT: MySQL Galera does *not* support SELECT ... FOR UPDATE
    <http://lists.openstack.org/pipermail/openstack-dev/2014-May/035264.html>`_
  - `Understanding reservations, concurrency, and locking in Nova
    <http://www.joinfu.com/2015/01/understanding-reservations-concurrency-locking-in-nova/>`_

Configuring HAProxy
--------------------

If you use HAProxy as a load-balancing client to provide access to the
Galera Cluster, as described in the :doc:`controller-ha-haproxy`, you can
use the ``clustercheck`` utility to improve health checks.

#. Create a configuration file for ``clustercheck`` at
   ``/etc/sysconfig/clustercheck``:

   .. code-block:: ini

      MYSQL_USERNAME="clustercheck_user"
      MYSQL_PASSWORD="my_clustercheck_password"
      MYSQL_HOST="localhost"
      MYSQL_PORT="3306"

.. note::
      For Ubuntu 16.04.1: Create a configuration file for ``clustercheck``
      at ``/etc/default/clustercheck``.

#. Log in to the database client and grant the ``clustercheck`` user
   ``PROCESS`` privileges:

   .. code-block:: mysql

      GRANT PROCESS ON *.* TO 'clustercheck_user'@'localhost'
      IDENTIFIED BY 'my_clustercheck_password';

      FLUSH PRIVILEGES;

   You only need to do this on one cluster node. Galera Cluster
   replicates the user to all the others.

#. Create a configuration file for the HAProxy monitor service, at
   ``/etc/xinetd.d/galera-monitor``:

   .. code-block:: none

      service galera-monitor
      {
         port = 9200
         disable = no
         socket_type = stream
         protocol = tcp
         wait = no
         user = root
         group = root
         groups = yes
         server = /usr/bin/clustercheck
         type = UNLISTED
         per_source = UNLIMITED
         log_on_success =
         log_on_failure = HOST
         flags = REUSE
      }

#. Start the ``xinetd`` daemon for ``clustercheck``. For servers
   that use ``init``, run the following commands:

   .. code-block:: console

      # service xinetd enable
      # service xinetd start

   For servers that use ``systemd``, run the following commands:

   .. code-block:: console

      # systemctl daemon-reload
      # systemctl enable xinetd
      # systemctl start xinetd
