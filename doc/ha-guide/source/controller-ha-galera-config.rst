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

Galera Cluster requires that you open four ports to network traffic:

- On ``3306``, Galera Cluster uses TCP for database client connections
  and State Snapshot Transfers methods that require the client,
  (that is, ``mysqldump``).
- On ``4567`` Galera Cluster uses TCP for replication traffic. Multicast
  replication uses both TCP and UDP on this port.
- On ``4568`` Galera Cluster uses TCP for Incremental State Transfers.
- On ``4444`` Galera Cluster uses TCP for all other State Snapshot Transfer
  methods.

.. seealso:: For more information on firewalls, see `Firewalls and default ports
   <http://docs.openstack.org/liberty/config-reference/content/firewalls-default-ports.html>`_, in the Configuration Reference.



``iptables``
^^^^^^^^^^^^^

For many Linux distributions, you can configure the firewall using
the ``iptables`` utility. To do so, complete the following steps:

#. For each cluster node, run the following commands, replacing
   ``NODE-IP-ADDRESS`` with the IP address of the cluster node
   you want to open the firewall to:

   .. code-block:: console

      # iptables --append INPUT --in-interface eth0 \
         --protocol --match tcp --dport 3306 \
         --source NODE-IP-ADDRESS --jump ACCEPT
      # iptables --append INPUT --in-interface eth0 \
         --protocol --match tcp --dport 4567 \
         --source NODE-IP-ADDRESS --jump ACCEPT
      # iptables --append INPUT --in-interface eth0 \
         --protocol --match tcp --dport 4568 \
         --source NODE-IP-ADDRESS --jump ACCEPT
      # iptables --append INPUT --in-interface eth0 \
         --protocol --match tcp --dport 4444 \
         --source NODE-IP-ADDRESS --jump ACCEPT

   In the event that you also want to configure multicast replication,
   run this command as well:

   .. code-block:: console

      # iptables --append INPUT --in-interface eth0 \
          --protocol udp --match udp --dport 4567 \
        --source NODE-IP-ADDRESS --jump ACCEPT


#. Make the changes persistent. For servers that use ``init``, use
   the :command:`save` command:

   .. code-block:: console

      # service save iptables

   For servers that use ``systemd``, you need to save the current packet
   filtering to the path of the file that ``iptables`` reads when it starts.
   This path can vary by distribution, but common locations are in the
   ``/etc`` directory, such as:

   - ``/etc/sysconfig/iptables``
   - ``/etc/iptables/iptables.rules``

   When you find the correct path, run the :command:`iptables-save` command:

   .. code-block:: console

      # iptables-save > /etc/sysconfig/iptables

With the firewall configuration saved, whenever your OpenStack
database starts.

``firewall-cmd``
^^^^^^^^^^^^^^^^^

For many Linux distributions, you can configure the firewall using the
``firewall-cmd`` utility for FirewallD. To do so, complete the following
steps on each cluster node:

#. Add the Galera Cluster service:

   .. code-block:: console

      # firewall-cmd --add-service=mysql

#. For each instance of OpenStack database in your cluster, run the
   following commands, replacing ``NODE-IP-ADDRESS`` with the IP address
   of the cluster node you want to open the firewall to:

   .. code-block:: console

      # firewall-cmd --add-port=3306/tcp
      # firewall-cmd --add-port=4567/tcp
      # firewall-cmd --add-port=4568/tcp
      # firewall-cmd --add-port=4444/tcp

   In the event that you also want to configure mutlicast replication,
   run this command as well:

   .. code-block:: console

      # firewall-cmd --add-port=4567/udp

#. To make this configuration persistent, repeat the above commands
   with the :option:`--permanent` option.

   .. code-block:: console

      # firewall-cmd --add-service=mysql --permanent
      # firewall-cmd --add-port=3306/tcp --permanent
      # firewall-cmd --add-port=4567/tcp --permanent
      # firewall-cmd --add-port=4568/tcp --permanent
      # firewall-cmd --add-port=4444/tcp --permanent
      # firewall-cmd --add-port=4567/udp --permanent


With the firewall configuration saved, whenever your OpenStack
database starts.

SELinux
--------

Security-Enhanced Linux is a kernel module for improving security on Linux
operating systems. It is commonly enabled and configured by default on
Red Hat-based distributions. In the context of Galera Cluster, systems with
SELinux may block the database service, keep it from starting or prevent it
from establishing network connections with the cluster.

To configure SELinux to permit Galera Cluster to operate, complete
the following steps on each cluster node:

#. Using the ``semanage`` utility, open the relevant ports:

   .. code-block:: console

      # semanage port -a -t mysqld_port_t -p tcp 3306
      # semanage port -a -t mysqld_port_t -p tcp 4567
      # semanage port -a -t mysqld_port_t -p tcp 4568
      # semanage port -a -t mysqld_port_t -p tcp 4444

   In the event that you use multicast replication, you also need to
   open ``4567`` to UDP traffic:

   .. code-block:: console

      # semanage port -a -t mysqld_port_t -p udp 4567

#. Set SELinux to allow the database server to run:

   .. code-block:: console

      # semanage permissive -a mysqld_t

With these options set, SELinux now permits Galera Cluster to operate.

.. note:: Bear in mind, leaving SELinux in permissive mode is not a good
        security practice. Over the longer term, you need to develop a
        security policy for Galera Cluster and then switch SELinux back
        into enforcing mode.

        For more information on configuring SELinux to work with
        Galera Cluster, see the `Documentation
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

   For servers that use ``systemd``, instead run this command:

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
   bind-address=0.0.0.0

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



Configuring ``mysqld``
-----------------------

While all of the configuration parameters available to the standard MySQL,
MariaDB or Percona XtraDB database server are available in Galera Cluster,
there are some that you must define an outset to avoid conflict or
unexpected behavior.

- Ensure that the database server is not bound only to to the localhost,
  ``127.0.0.1``. Instead, bind it to ``0.0.0.0`` to ensure it listens on
  all available interfaces.

  .. code-block:: ini

     bind-address=0.0.0.0

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
  is set to ``2``, which is the interleaved locking mode.

  .. code-block:: ini

     innodb_autoinc_lock_mode=2

  Do not change this value. Other modes may cause ``INSERT`` statements
  on tables with auto-increment columns to fail as well as unresolved
  deadlocks that leave the system unresponsive.

- Ensure that the InnoDB log buffer is written to file once per second,
  rather than on each commit, to improve performance:

  .. code-block:: ini

     innodb_flush_log_at_trx_commit=0

  Bear in mind, while setting this parameter to ``1`` or ``2`` can improve
  performance, it introduces certain dangers. Operating system failures can
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
There are five that you must define for each cluster node in your
OpenStack database.

- **wsrep Provider** The Galera Replication Plugin serves as the wsrep
  Provider for Galera Cluster. It is installed on your system as the
  ``libgalera_smm.so`` file. You must define the path to this file in
  your ``my.cnf``.

  .. code-block:: ini

     wsrep_provider="/usr/lib/libgalera_smm.so"

- **Cluster Name** Define an arbitrary name for your cluster.

  .. code-block:: ini

     wsrep_cluster_name="my_example_cluster"

  You must use the same name on every cluster node. The connection fails
  when this value does not match.

- **Cluster Address** List the IP addresses for each cluster node.

  .. code-block:: ini

     wsrep_cluster_address="gcomm://192.168.1.1,192.168.1.2,192.168.1.3"

  Replace the IP addresses given here with comma-separated list of each
  OpenStack database in your cluster.

- **Node Name** Define the logical name of the cluster node.

  .. code-block:: ini

     wsrep_node_name="Galera1"

- **Node Address** Define the IP address of the cluster node.

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

For the documentation of these parameters, wsrep Provider option and status
variables available in Galera Cluster, see `Reference
<http://galeracluster.com/documentation-webpages/reference.html>`_.
