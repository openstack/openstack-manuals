=============
Block Storage
=============

Block storage also known as volume storage in OpenStack provides users
with access to block storage devices. Users interact with block storage
by attaching volumes to their running VM instances.

These volumes are persistent, they can be detached from one instance and
re-attached to another and the data remains intact. Block storage is
implemented in OpenStack by the OpenStack Block Storage (cinder), which
supports multiple back ends in the form of drivers. Your
choice of a storage back end must be supported by a Block Storage
driver.

Most block storage drivers allow the instance to have direct access to
the underlying storage hardware's block device. This helps increase the
overall read/write IO. However, support for utilizing files as volumes
is also well established, with full support for NFS, GlusterFS and
others.

These drivers work a little differently than a traditional block
storage driver. On an NFS or GlusterFS file system, a single file is
created and then mapped as a virtual volume into the instance. This
mapping/translation is similar to how OpenStack utilizes QEMU's
file-based virtual machines stored in ``/var/lib/nova/instances``.
