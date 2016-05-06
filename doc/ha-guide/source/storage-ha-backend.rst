
.. _storage-ha-backend:

================
Storage back end
================

Most of this guide concerns the control plane of high availability:
ensuring that services continue to run even if a component fails.
Ensuring that data is not lost
is the data plane component of high availability;
this is discussed here.

An OpenStack environment includes multiple data pools for the VMs:

- Ephemeral storage is allocated for an instance
  and is deleted when the instance is deleted.
  The Compute service manages ephemeral storage.
  By default, Compute stores ephemeral drives as files
  on local disks on the Compute node
  but Ceph RBD can instead be used
  as the storage back end for ephemeral storage.

- Persistent storage exists outside all instances.
  Two types of persistent storage are provided:

  - Block Storage service (cinder)
    can use LVM or Ceph RBD as the storage back end.
  - Image service (glance)
    can use the Object Storage service (swift)
    or Ceph RBD as the storage back end.

For more information about configuring storage back ends for
the different storage options, see the `Administrator Guide
<http://docs.openstack.org/admin-guide/>`_.

This section discusses ways to protect against
data loss in your OpenStack environment.

RAID drives
-----------

Configuring RAID on the hard drives that implement storage
protects your data against a hard drive failure.
If, however, the node itself fails, data may be lost.
In particular, all volumes stored on an LVM node can be lost.

Ceph
----

`Ceph RBD <http://ceph.com/>`_
is an innately high availability storage back end.
It creates a storage cluster with multiple nodes
that communicate with each other
to replicate and redistribute data dynamically.
A Ceph RBD storage cluster provides
a single shared set of storage nodes
that can handle all classes of persistent and ephemeral data
-- glance, cinder, and nova --
that are required for OpenStack instances.

Ceph RBD provides object replication capabilities
by storing Block Storage volumes as Ceph RBD objects;
Ceph RBD ensures that each replica of an object
is stored on a different node.
This means that your volumes are protected against
hard drive and node failures
or even the failure of the data center itself.

When Ceph RBD is used for ephemeral volumes
as well as block and image storage, it supports
`live migration
<http://docs.openstack.org/admin-guide/compute-live-migration-usage.html>`_
of VMs with ephemeral drives;
LVM only supports live migration of volume-backed VMs.

Remote backup facilities
------------------------

[TODO: Add discussion of remote backup facilities
as an alternate way to secure ones data.
Include brief mention of key third-party technologies
with links to their documentation]


