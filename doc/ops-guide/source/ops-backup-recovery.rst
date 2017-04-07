===================
Backup and Recovery
===================

Standard backup best practices apply when creating your OpenStack backup
policy. For example, how often to back up your data is closely related
to how quickly you need to recover from data loss.

.. note::

   If you cannot have any data loss at all, you should also focus on a
   highly available deployment. The `OpenStack High Availability
   Guide <https://docs.openstack.org/ha-guide/index.html>`_ offers
   suggestions for elimination of a single point of failure that could
   cause system downtime. While it is not a completely prescriptive
   document, it offers methods and techniques for avoiding downtime and
   data loss.

Other backup considerations include:

* How many backups to keep?
* Should backups be kept off-site?
* How often should backups be tested?

Just as important as a backup policy is a recovery policy (or at least
recovery testing).

What to Back Up
~~~~~~~~~~~~~~~

While OpenStack is composed of many components and moving parts, backing
up the critical data is quite simple.

This chapter describes only how to back up configuration files and
databases that the various OpenStack components need to run. This
chapter does not describe how to back up objects inside Object Storage
or data contained inside Block Storage. Generally these areas are left
for users to back up on their own.

Database Backups
~~~~~~~~~~~~~~~~

The example OpenStack architecture designates the cloud controller as
the MySQL server. This MySQL server hosts the databases for nova,
glance, cinder, and keystone. With all of these databases in one place,
it's very easy to create a database backup:

.. code-block:: console

   # mysqldump --opt --all-databases > openstack.sql

If you only want to backup a single database, you can instead run:

.. code-block:: console

   # mysqldump --opt nova > nova.sql

where ``nova`` is the database you want to back up.

You can easily automate this process by creating a cron job that runs
the following script once per day:

.. code-block:: bash

   #!/bin/bash
   backup_dir="/var/lib/backups/mysql"
   filename="${backup_dir}/mysql-`hostname`-`eval date +%Y%m%d`.sql.gz"
   # Dump the entire MySQL database
   /usr/bin/mysqldump --opt --all-databases | gzip > $filename
   # Delete backups older than 7 days
   find $backup_dir -ctime +7 -type f -delete

This script dumps the entire MySQL database and deletes any backups
older than seven days.

File System Backups
~~~~~~~~~~~~~~~~~~~

This section discusses which files and directories should be backed up
regularly, organized by service.

Compute
-------

The ``/etc/nova`` directory on both the cloud controller and compute
nodes should be regularly backed up.

``/var/log/nova`` does not need to be backed up if you have all logs
going to a central area. It is highly recommended to use a central
logging server or back up the log directory.

``/var/lib/nova`` is another important directory to back up. The
exception to this is the ``/var/lib/nova/instances`` subdirectory on
compute nodes. This subdirectory contains the KVM images of running
instances. You would want to back up this directory only if you need to
maintain backup copies of all instances. Under most circumstances, you
do not need to do this, but this can vary from cloud to cloud and your
service levels. Also be aware that making a backup of a live KVM
instance can cause that instance to not boot properly if it is ever
restored from a backup.

Image Catalog and Delivery
--------------------------

``/etc/glance`` and ``/var/log/glance`` follow the same rules as their
nova counterparts.

``/var/lib/glance`` should also be backed up. Take special notice of
``/var/lib/glance/images``. If you are using a file-based back end of
glance, ``/var/lib/glance/images`` is where the images are stored and
care should be taken.

There are two ways to ensure stability with this directory. The first is
to make sure this directory is run on a RAID array. If a disk fails, the
directory is available. The second way is to use a tool such as rsync to
replicate the images to another server:

.. code-block:: console

   # rsync -az --progress /var/lib/glance/images backup-server:/var/lib/glance/images/

Identity
--------

``/etc/keystone`` and ``/var/log/keystone`` follow the same rules as
other components.

``/var/lib/keystone``, although it should not contain any data being
used, can also be backed up just in case.

Block Storage
-------------

``/etc/cinder`` and ``/var/log/cinder`` follow the same rules as other
components.

``/var/lib/cinder`` should also be backed up.

Networking
----------

``/etc/neutron`` and ``/var/log/neutron`` follow the same rules as other
components.

``/var/lib/neutron`` should also be backed up.

Object Storage
--------------

``/etc/swift`` is very important to have backed up. This directory
contains the swift configuration files as well as the ring files and
ring :term:`builder files <builder file>`, which if lost, render the data
on your cluster inaccessible. A best practice is to copy the builder files
to all storage nodes along with the ring files. Multiple backup copies are
spread throughout your storage cluster.

Telemetry
---------

Back up the ``/etc/ceilometer`` directory containing Telemetry configuration
files.

Orchestration
-------------

Back up HOT template ``yaml`` files, and the ``/etc/heat/`` directory
containing Orchestration configuration files.

Recovering Backups
~~~~~~~~~~~~~~~~~~

Recovering backups is a fairly simple process. To begin, first ensure
that the service you are recovering is not running. For example, to do a
full recovery of ``nova`` on the cloud controller, first stop all
``nova`` services:

.. code-block:: console

   # stop nova-api
   # stop nova-consoleauth
   # stop nova-novncproxy
   # stop nova-objectstore
   # stop nova-scheduler

Now you can import a previously backed-up database:

.. code-block:: console

   # mysql nova < nova.sql

You can also restore backed-up nova directories:

.. code-block:: console

   # mv /etc/nova{,.orig}
   # cp -a /path/to/backup/nova /etc/

Once the files are restored, start everything back up:

.. code-block:: console

   # start mysql
   # for i in nova-api nova-consoleauth nova-novncproxy \
     nova-objectstore nova-scheduler
   > do
   > start $i
   > done

Other services follow the same process, with their respective
directories and databases.

Summary
~~~~~~~

Backup and subsequent recovery is one of the first tasks system
administrators learn. However, each system has different items that need
attention. By taking care of your database, image service, and
appropriate file system locations, you can be assured that you can
handle any event requiring recovery.
