===============================================
Database (Galera Cluster) for high availability
===============================================

.. toctree::
  :maxdepth: 2

  shared-database-configure.rst
  shared-database-manage.rst

The first step is to install the database that sits at the heart of the
cluster. To implement high availability, run an instance of the database on
each controller node and use Galera Cluster to provide replication between
them. Galera Cluster is a synchronous multi-master database cluster, based
on MySQL and the InnoDB storage engine. It is a high-availability service
that provides high system uptime, no data loss, and scalability for growth.

You can achieve high availability for the OpenStack database in many
different ways, depending on the type of database that you want to use.
There are three implementations of Galera Cluster available to you:

- `Galera Cluster for MySQL <http://galeracluster.com>`_: The MySQL
  reference implementation from Codership, Oy.
- `MariaDB Galera Cluster <https://mariadb.org>`_: The MariaDB
  implementation of Galera Cluster, which is commonly supported in
  environments based on Red Hat distributions.
- `Percona XtraDB Cluster <https://www.percona.com>`_: The XtraDB
  implementation of Galera Cluster from Percona.

In addition to Galera Cluster, you can also achieve high availability
through other database options, such as PostgreSQL, which has its own
replication system.
