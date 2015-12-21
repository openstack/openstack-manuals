=======================================
Generic approach for share provisioning
=======================================

The Shared File Systems service can be configured to use Compute VMs
and Block Storage service volumes. There are two modules that handle
them in the Shared File Systems service:

-  The ``service_instance`` module creates VMs in Compute with a
   predefined image called ``service image``. This module can be used by
   any driver for provisioning of service VMs to be able to separate
   share resources among tenants.

-  The ``generic`` module operates with Block Storage service volumes
   and VMs created by the ``service_instance`` module, then creates
   shared filesystems based on volumes attached to VMs.

Network configurations
~~~~~~~~~~~~~~~~~~~~~~

Each driver can handle networking in its own way, see:
https://wiki.openstack.org/wiki/manila/Networking.

One of the two possible configurations can be chosen for share provisioning
using the ``service_instance`` module:

- Service VM has one network interface from a network that is
  connected to a public router. For successful creation of a share,
  the user network should be connected to a public router, too.

- Service VM has two network interfaces, the first one is connected to
  the service network, the second one is connected directly to the
  user's network.

Requirements for service image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Linux based distro

-  NFS server

-  Samba server >= 3.2.0, that can be configured by data stored in
   registry

-  SSH server

-  Two network interfaces configured to DHCP (see network approaches)

-  ``exportfs`` and ``net conf`` libraries used for share actions

-  The following files will be used, so if their paths differ one
   needs to create at least symlinks for them:

   -  ``/etc/exports``: permanent file with NFS exports.

   -  ``/var/lib/nfs/etab``: temporary file with NFS exports used by
      ``exportfs``.

   -  ``/etc/fstab``: permanent file with mounted filesystems.

   -  ``/etc/mtab``: temporary file with mounted filesystems used by
      ``mount``.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported for NFS and CIFS.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Extend a share.

- Shrink a share.


Known restrictions
~~~~~~~~~~~~~~~~~~

-  One of nova's configurations only allows 26 shares per server. This
   limit comes from the maximum number of virtual PCI interfaces that
   are used for block device attaching. There are 28 virtual PCI
   interfaces, in this configuration, two of them are used for server
   needs and the other 26 are used for attaching block devices that
   are used for shares.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to this
driver.

.. include:: ../../tables/manila-generic.rst
