================
LVM share driver
================

The Shared File Systems service can be configured to use LVM share
driver. LVM share driver relies solely on LVM running on the same host with
manila-share service. It does not require any services not
related to the Shared File Systems service to be present to work.

Prerequisites
~~~~~~~~~~~~~

The following packages must be installed on the same host with manila-share
service:

-  NFS server

-  Samba server >= 3.2.0

-  LVM2 >= 2.02.66

Services must be up and running, ports used by the services must not be
blocked. A node with manila-share service should be accessible to share
service users.

LVM should be preconfigured. By default, LVM driver expects to find a volume
group named ``lvm-shares``. This volume group will be used by the driver for
share provisioning. It should be managed by node administrator separately.

Shared File Systems service driver configuration setting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To use the driver, one should set up a corresponding back end. A driver
must be explicitly specified as well as export IP address. A
minimal back-end specification that will enable LVM share driver is presented
below:

.. code-block:: ini

   [LVM_sample_backend]
   driver_handles_share_servers = False
   share_driver = manila.share.drivers.lvm.LVMShareDriver
   lvm_share_export_ip = 1.2.3.4

In the example above, ``lvm_share_export_ip`` is the address to be used by
clients for accessing shares. In the simplest case, it should be the same
as host's address.

Supported shared file systems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported for NFS.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Extend a share.

Known restrictions
~~~~~~~~~~~~~~~~~~

-  LVM driver should not be used on a host running Neutron agents, simultaneous
   usage might cause issues with share deletion (shares will not get deleted
   from volume groups).

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to this
driver.

.. include:: ../../tables/manila-lvm.rst
