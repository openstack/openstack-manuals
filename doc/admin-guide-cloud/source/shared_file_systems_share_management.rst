.. _shared_file_systems_share_management:

================
Share management
================

The default configuration of the Shared File Systems service uses the OpenStack
Block Storage based back end. In that case, the Shared File Systems service
cares about everything (VMs, networking, keypairs, security groups) by itself.
It is not production solution, but can help you to understand how the Shared
File Systems service works.

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

.. note::

   The Shared File Systems service provides set of drivers that enable you to
   use various network file storage devices, instead of the base
   implementation. That is the real purpose of the Shared File Systems service
   service in production.

.. toctree::
    shared_file_systems_crud_share.rst
    shared_file_systems_manage_and_unmanage_share.rst
    shared_file_systems_share_resize.rst
    shared_file_systems_quotas.rst
