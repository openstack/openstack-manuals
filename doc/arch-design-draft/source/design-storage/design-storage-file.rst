===========================
Shared File Systems service
===========================

The Shared File Systems service (manila) provides a set of services for
management of shared file systems in a multi-tenant cloud environment.
Users interact with the Shared File Systems service by mounting remote File
Systems on their instances with the following usage of those systems for
file storing and exchange. The Shared File Systems service provides you with
shares which is a remote, mountable file system. You can mount a
share to and access a share from several hosts by several users at a
time. With shares, user can also:

* Create a share specifying its size, shared file system protocol,
  visibility level.
* Create a share on either a share server or standalone, depending on
  the selected back-end mode, with or without using a share network.
* Specify access rules and security services for existing shares.
* Combine several shares in groups to keep data consistency inside the
  groups for the following safe group operations.
* Create a snapshot of a selected share or a share group for storing
  the existing shares consistently or creating new shares from that
  snapshot in a consistent way.
* Create a share from a snapshot.
* Set rate limits and quotas for specific shares and snapshots.
* View usage of share resources.
* Remove shares.

Like Block Storage, the Shared File Systems service is persistent. It
can be:

* Mounted to any number of client machines.
* Detached from one instance and attached to another without data loss.
  During this process the data are safe unless the Shared File Systems
  service itself is changed or removed.

Shares are provided by the Shared File Systems service. In OpenStack,
Shared File Systems service is implemented by Shared File System
(manila) project, which supports multiple back-ends in the form of
drivers. The Shared File Systems service can be configured to provision
shares from one or more back-ends. Share servers are, mostly, virtual
machines that export file shares using different protocols such as NFS,
CIFS, GlusterFS, or HDFS.

