
.. _storage-ha-backend:

================
Storage back end
================

An OpenStack environment includes multiple data pools for the VMs:

- Ephemeral storage is allocated for an instance and is deleted when the
  instance is deleted. The Compute service manages ephemeral storage and
  by default, Compute stores ephemeral drives as files on local disks on the
  compute node. As an alternative, you can use Ceph RBD as the storage back
  end for ephemeral storage.

- Persistent storage exists outside all instances. Two types of persistent
  storage are provided:

  - The Block Storage service (cinder) that can use LVM or Ceph RBD as the
    storage back end.
  - The Image service (glance) that can use the Object Storage service (swift)
    or Ceph RBD as the storage back end.

For more information about configuring storage back ends for
the different storage options, see `Manage volumes
<https://docs.openstack.org/admin-guide/blockstorage-manage-volumes.html>`_
in the OpenStack Administrator Guide.

This section discusses ways to protect against data loss in your OpenStack
environment.

RAID drives
-----------

Configuring RAID on the hard drives that implement storage protects your data
against a hard drive failure. If the node itself fails, data may be lost.
In particular, all volumes stored on an LVM node can be lost.

Ceph
----

`Ceph RBD <https://ceph.com/>`_ is an innately high availability storage back
end. It creates a storage cluster with multiple nodes that communicate with
each other to replicate and redistribute data dynamically.
A Ceph RBD storage cluster provides a single shared set of storage nodes that
can handle all classes of persistent and ephemeral data (glance, cinder, and
nova) that are required for OpenStack instances.

Ceph RBD provides object replication capabilities by storing Block Storage
volumes as Ceph RBD objects. Ceph RBD ensures that each replica of an object
is stored on a different node. This means that your volumes are protected
against hard drive and node failures, or even the failure of the data center
itself.

When Ceph RBD is used for ephemeral volumes as well as block and image storage,
it supports `live migration
<https://docs.openstack.org/admin-guide/compute-live-migration-usage.html>`_
of VMs with ephemeral drives. LVM only supports live migration of
volume-backed VMs.
