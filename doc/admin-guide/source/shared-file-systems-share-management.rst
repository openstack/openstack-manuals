.. _shared_file_systems_share_management:

================
Share management
================

A share is a remote, mountable file system. You can mount a share to and access
a share from several hosts by several users at a time.

You can create a share and associate it with a network, list shares, and show
information for, update, and delete a specified share.
You can also create snapshots of shares. To create a snapshot, you specify the
ID of the share that you want to snapshot.

The shares are based on of the supported Shared File Systems protocols:

* *NFS*. Network File System (NFS).
* *CIFS*. Common Internet File System (CIFS).
* *GLUSTERFS*. Gluster file system (GlusterFS).
* *HDFS*. Hadoop Distributed File System (HDFS).
* *CEPHFS*. Ceph File System (CephFS).

The Shared File Systems service provides set of drivers that enable you to use
various network file storage devices, instead of the base implementation. That
is the real purpose of the Shared File Systems service in production.

.. toctree::

   shared-file-systems-crud-share.rst
   shared-file-systems-manage-and-unmanage-share.rst
   shared-file-systems-manage-and-unmanage-snapshot.rst
   shared-file-systems-share-resize.rst
   shared-file-systems-quotas.rst
