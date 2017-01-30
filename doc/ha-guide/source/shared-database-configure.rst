==============
Configuration
==============

Before you launch Galera Cluster, you need to configure the server
and the database to operate as part of the cluster.

Configuring the server
~~~~~~~~~~~~~~~~~~~~~~~

Certain services running on the underlying operating system of your
OpenStack database may block Galera Cluster from normal operation
or prevent ``mysqld`` from achieving network connectivity with the cluster.

Firewall
---------

Galera Cluster requires that you open the following ports to network traffic:

- On ``3306``, Galera Cluster uses TCP for database client connections
  and State Snapshot Transfers methods that require the client,
  (that is, ``mysqldump``).
- On ``4567``, Galera Cluster uses TCP for replication traffic. Multicast
  replication uses both TCP and UDP on this port.
- On ``4568``, Galera Cluster uses TCP for Incremental State Transfers.
- On ``4444``, Galera Cluster uses TCP for all other State Snapshot Transfer
  methods.

.. seealso::

   For more information on firewalls, see `firewalls and default ports
   <https://docs.openstack.org/admin-guide/firewalls-default-ports.html>`_
   in OpenStack Administrator Guide.

This can be achieved using the :command:`iptables` command:

.. code-block:: console

   # iptables --append INPUT --in-interface eth0 \
     --protocol tcp --match tcp --dport ${PORT} \
     --source ${NODE-IP-ADDRESS} --jump ACCEPT

Make sure to save the changes once you are done. This will vary
depending on your distribution:

- For `Ubuntu <http://askubuntu.com/questions/66890/how-can-i-make-a-specific-set-of-iptables-rules-permanent#66905>`_
- For `Fedora <https://fedoraproject.org/wiki/How_to_edit_iptables_rules>`_

Alternatively, make modifications using the ``firewall-cmd`` utility for
FirewallD that is available on many Linux distributions:

.. code-block:: console

   # firewall-cmd --add-service=mysql --permanent
   # firewall-cmd --add-port=3306/tcp --permanent

SELinux
--------

Security-Enhanced Linux is a kernel module for improving security on Linux
operating systems. It is commonly enabled and configured by default on
Red Hat-based distributions. In the context of Galera Cluster, systems with
SELinux may block the database service, keep it from starting, or prevent it
from establishing network connections with the cluster.

To configure SELinux to permit Galera Cluster to operate, you may need
to use the ``semanage`` utility to open the ports it uses. For
example:

.. code-block:: console

   # semanage port -a -t mysqld_port_t -p tcp 3306

Older versions of some distributions, which do not have an up-to-date
policy for securing Galera, may also require SELinux to be more
relaxed about database access and actions:

.. code-block:: console

   # semanage permissive -a mysqld_t

.. note::

   Bear in mind, leaving SELinux in permissive mode is not a good
   security practice. Over the longer term, you need to develop a
   security policy for Galera Cluster and then switch SELinux back
   into enforcing mode.

    For more information on configuring SELinux to work with
    Galera Cluster, see the `SELinux Documentation
    <http://galeracluster.com/documentation-webpages/selinux.html>`_

AppArmor
---------

Application Armor is a kernel module for improving security on Linux
operating systems. It is developed by Canonical and commonly used on
Ubuntu-based distributions. In the context of Galera Cluster, systems
with AppArmor may block the database service from operating normally.

To configure AppArmor to work with Galera Cluster, complete the
following steps on each cluster node:

#. Create a symbolic link for the database server in the ``disable`` directory:

   .. code-block:: console

      # ln -s /etc/apparmor.d/usr /etc/apparmor.d/disable/.sbin.mysqld

#. Restart AppArmor. For servers that use ``init``, run the following command:

   .. code-block:: console

      # service apparmor restart

   For servers that use ``systemd``, run the following command:

   .. code-block:: console

      # systemctl restart apparmor

AppArmor now permits Galera Cluster to operate.

Database configuration
~~~~~~~~~~~~~~~~~~~~~~~

MySQL databases, including MariaDB and Percona XtraDB, manage their
configurations using a ``my.cnf`` file, which is typically located in the
``/etc`` directory. Configuration options available in these databases are
also available in Galera Cluster, with some restrictions and several
additions.

.. code-block:: ini

   [mysqld]
   datadir=/var/lib/mysql
   socket=/var/lib/mysql/mysql.sock
   user=mysql
   binlog_format=ROW
   bind-address=10.0.0.12

   # InnoDB Configuration
   default_storage_engine=innodb
   innodb_autoinc_lock_mode=2
   innodb_flush_log_at_trx_commit=0
   innodb_buffer_pool_size=122M

   # Galera Cluster Configuration
   wsrep_provider=/usr/lib/libgalera_smm.so
   wsrep_provider_options="pc.recovery=TRUE;gcache.size=300M"
   wsrep_cluster_name="my_example_cluster"
   wsrep_cluster_address="gcomm://GALERA1-IP,GALERA2-IP,GALERA3-IP"
   wsrep_sst_method=rsync


Configuring mysqld
-------------------

While all of the configuration parameters available to the standard MySQL,
MariaDB, or Percona XtraDB database servers are available in Galera Cluster,
there are some that you must define an outset to avoid conflict or
unexpected behavior.

- Ensure that the database server is not bound only to the localhost:
  ``127.0.0.1``. Also, do not bind it to ``0.0.0.0``. Binding to the localhost
  or ``0.0.0.0`` makes ``mySQL`` bind to all IP addresses on the machine,
  including the virtual IP address causing ``HAProxy`` not to start. Instead,
  bind to the management IP address of the controller node to enable access by
  other nodes through the management network:

  .. code-block:: ini

     bind-address=10.0.0.12

- Ensure that the binary log format is set to use row-level replication,
  as opposed to statement-level replication:

  .. code-block:: ini

     binlog_format=ROW


Configuring InnoDB
-------------------

Galera Cluster does not support non-transactional storage engines and
requires that you use InnoDB by default. There are some additional
parameters that you must define to avoid conflicts.

- Ensure that the default storage engine is set to InnoDB:

  .. code-block:: ini

     default_storage_engine=InnoDB

- Ensure that the InnoDB locking mode for generating auto-increment values
  is set to ``2``, which is the interleaved locking mode:

  .. code-block:: ini

     innodb_autoinc_lock_mode=2

  Do not change this value. Other modes may cause ``INSERT`` statements
  on tables with auto-increment columns to fail as well as unresolved
  deadlocks that leave the system unresponsive.

- Ensure that the InnoDB log buffer is written to file once per second,
  rather than on each commit, to improve performance:

  .. code-block:: ini

     innodb_flush_log_at_trx_commit=0

  Setting this parameter to ``1`` or ``2`` can improve
  performance, but it introduces certain dangers. Operating system failures can
  erase the last second of transactions. While you can recover this data
  from another node, if the cluster goes down at the same time
  (in the event of a data center power outage), you lose this data permanently.

- Define the InnoDB memory buffer pool size. The default value is 128 MB,
  but to compensate for Galera Cluster's additional memory usage, scale
  your usual value back by 5%:

  .. code-block:: ini

     innodb_buffer_pool_size=122M


Configuring wsrep replication
------------------------------

Galera Cluster configuration parameters all have the ``wsrep_`` prefix.
You must define the following parameters for each cluster node in your
OpenStack database.

- **wsrep Provider**: The Galera Replication Plugin serves as the ``wsrep``
  provider for Galera Cluster. It is installed on your system as the
  ``libgalera_smm.so`` file. Define the path to this file in
  your ``my.cnf``:

  .. code-block:: ini

     wsrep_provider="/usr/lib/libgalera_smm.so"

- **Cluster Name**: Define an arbitrary name for your cluster.

  .. code-block:: ini

     wsrep_cluster_name="my_example_cluster"

  You must use the same name on every cluster node. The connection fails
  when this value does not match.

- **Cluster Address**: List the IP addresses for each cluster node.

  .. code-block:: ini

     wsrep_cluster_address="gcomm://192.168.1.1,192.168.1.2,192.168.1.3"

  Replace the IP addresses given here with comma-separated list of each
  OpenStack database in your cluster.

- **Node Name**: Define the logical name of the cluster node.

  .. code-block:: ini

     wsrep_node_name="Galera1"

- **Node Address**: Define the IP address of the cluster node.

  .. code-block:: ini

     wsrep_node_address="192.168.1.1"

Additional parameters
^^^^^^^^^^^^^^^^^^^^^^

For a complete list of the available parameters, run the
``SHOW VARIABLES`` command from within the database client:

.. code-block:: mysql

   SHOW VARIABLES LIKE 'wsrep_%';

   +------------------------------+-------+
   | Variable_name                | Value |
   +------------------------------+-------+
   | wsrep_auto_increment_control | ON    |
   +------------------------------+-------+
   | wsrep_causal_reads           | OFF   |
   +------------------------------+-------+
   | wsrep_certify_nonPK          | ON    |
   +------------------------------+-------+
   | ...                          | ...   |
   +------------------------------+-------+
   | wsrep_sync_wait              | 0     |
   +------------------------------+-------+

For documentation about these parameters, ``wsrep`` provider option, and status
variables available in Galera Cluster, see the Galera cluster `Reference
<http://galeracluster.com/documentation-webpages/reference.html>`_.
