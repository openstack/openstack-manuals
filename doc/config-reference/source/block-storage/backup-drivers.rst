==============
Backup drivers
==============

.. toctree::

   backup/ceph-backup-driver.rst
   backup/tsm-backup-driver.rst
   backup/swift-backup-driver.rst
   backup/nfs-backup-driver.rst

This section describes how to configure the cinder-backup service and
its drivers.

The volume drivers are included with the `Block Storage repository
<https://git.openstack.org/cgit/openstack/cinder/>`_. To set a backup
driver, use the ``backup_driver`` flag. By default there is no backup
driver enabled.
