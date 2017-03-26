=========
Databases
=========

Almost all OpenStack components have an underlying database to store
persistent information. Usually this database is MySQL. Normal MySQL
administration is applicable to these databases. OpenStack does not
configure the databases out of the ordinary. Basic administration
includes performance tweaking, high availability, backup, recovery, and
repairing. For more information, see a standard MySQL administration guide.

You can perform a couple of tricks with the database to either more
quickly retrieve information or fix a data inconsistency error—for
example, an instance was terminated, but the status was not updated in
the database. These tricks are discussed throughout this book.

Database Connectivity
~~~~~~~~~~~~~~~~~~~~~

Review the component's configuration file to see how each OpenStack component
accesses its corresponding database. Look for a ``connection`` option. The
following command uses ``grep`` to display the SQL connection string for nova,
glance, cinder, and keystone:

.. code-block:: console

   # grep -hE "connection ?=" \
     /etc/nova/nova.conf /etc/glance/glance-*.conf \
     /etc/cinder/cinder.conf /etc/keystone/keystone.conf \
     /etc/neutron/neutron.conf
   connection = mysql+pymysql://nova:password@cloud.example.com/nova
   connection = mysql+pymysql://glance:password@cloud.example.com/glance
   connection = mysql+pymysql://glance:password@cloud.example.com/glance
   connection = mysql+pymysql://cinder:password@cloud.example.com/cinder
   connection = mysql+pymysql://keystone:password@cloud.example.com/keystone
   connection = mysql+pymysql://neutron:password@cloud.example.com/neutron

The connection strings take this format:

.. code-block:: console

   mysql+pymysql:// <username> : <password> @ <hostname> / <database name>

Performance and Optimizing
~~~~~~~~~~~~~~~~~~~~~~~~~~

As your cloud grows, MySQL is utilized more and more. If you suspect
that MySQL might be becoming a bottleneck, you should start researching
MySQL optimization. The MySQL manual has an entire section dedicated to
this topic: `Optimization Overview
<http://dev.mysql.com/doc/refman/5.5/en/optimize-overview.html>`_.
