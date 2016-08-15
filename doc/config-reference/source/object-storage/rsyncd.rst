====================
Rsyncd configuration
====================

Find an example rsyncd configuration at ``etc/rsyncd.conf-sample`` in
the source code repository.

The available configuration options are:

.. include:: ../tables/swift-rsyncd.rst

If ``rsync_module`` includes the device, you can tune rsyncd to permit 4
connections per device instead of simply allowing 8 connections for all
devices:

.. code-block:: ini

   rsync_module = {replication_ip}::object_{device}

If devices in your object ring are named sda, sdb, and sdc:

.. code-block:: ini

   [object_sda]
   max connections = 4
   path = /srv/node
   read only = false
   lock file = /var/lock/object_sda.lock

   [object_sdb]
   max connections = 4
   path = /srv/node
   read only = false
   lock file = /var/lock/object_sdb.lock

   [object_sdc]
   max connections = 4
   path = /srv/node
   read only = false
   lock file = /var/lock/object_sdc.lock

To emulate the deprecated ``vm_test_mode = yes`` option, set:

.. code-block:: ini

   rsync_module = {replication_ip}::object{replication_port}

Therefore, on your SAIO, you have to set the following rsyncd configuration:

.. code-block:: ini

   [object6010]
   max connections = 25
   path = /srv/1/node/
   read only = false
   lock file = /var/lock/object6010.lock

   [object6020]
   max connections = 25
   path = /srv/2/node/
   read only = false
   lock file = /var/lock/object6020.lock

   [object6030]
   max connections = 25
   path = /srv/3/node/
   read only = false
   lock file = /var/lock/object6030.lock

   [object6040]
   max connections = 25
   path = /srv/4/node/
   read only = false
   lock file = /var/lock/object6040.lock
