=======================================
Generic approach for share provisioning
=======================================

The Shared File Systems service can be configured to use nova VMs and
cinder volumes. There are two modules that handle them in the Shared
File Systems service:

-  ``service_instance`` module creates VMs in nova with predefined image
   called service image. This module can be used by any driver for
   provisioning of service VMs to be able to separate share resources
   among tenants.

-  'generic' module operates with cinder volumes and VMs created by
   ``service_instance`` module, then creates shared filesystems based on
   volumes attached to VMs.

Network configurations
~~~~~~~~~~~~~~~~~~~~~~

Each driver can handle networking in its own way, see:
https://wiki.openstack.org/wiki/manila/Networking.

One of two possible configurations can be chosen for share provisioning
    using ``service_instance`` module:

- Service VM has one net interface from net that is connected to public router.
  For successful creation of share, user network should be connected to public
  router too.

- Service VM has two net interfaces, first one connected to service network,
  second one connected directly to user's network.

Requirements for service image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Linux based distro

-  NFS server

-  Samba server >=3.2.0, that can be configured by data stored in
   registry

-  SSH server

-  Two net interfaces configured to DHCP (see network approaches)

-  ``exportfs`` and ``net conf`` libraries used for share actions

-  Following files will be used, so if their paths differ one needs to
   create at least symlinks for them:

   -  ``/etc/exports`` (permanent file with NFS exports)

   -  ``/var/lib/nfs/etab`` (temporary file with NFS exports used by
      ``exportfs``)

   -  ``/etc/fstab`` (permanent file with mounted filesystems)

   -  ``/etc/mtab`` (temporary file with mounted filesystems used by
      ``mount``)

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
   needs and other 26 are used for attaching block devices that are used
   for shares.

-  Juno version works only with neutron. Each share should be created
   with neutron-net and neutron-subnet IDs provided via share-network
   entity.

-  Juno version handles security group, flavor, image, keypair for nova
   VM and also creates service networks, but does not use availability
   zones for nova VMs and volume types for cinder block devices.

-  Juno version does not use security services data provided with
   share-network. These data will be just ignored.

-  Liberty version adds a share extend capability. Share access will be
   briefly interrupted during an extend operation.

-  Liberty version adds a share shrink capability, but this capability
   is not effective because generic driver shrinks only filesystem size
   and doesn't shrink the size of cinder volume.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to this
driver.

.. include:: ../../tables/manila-generic.rst
