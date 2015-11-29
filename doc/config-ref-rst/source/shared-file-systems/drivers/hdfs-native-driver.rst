==================
HDFS native driver
==================

HDFS native driver is a plug-in based on the Shared File Systems
service, which uses Hadoop distributed file system (HDFS), a distributed
file system designed to hold very large amounts of data, and provide
high-throughput access to the data.

A Shared File Systems service share in this driver is a subdirectory in
hdfs root directory. Instances talk directly to the HDFS storage back
end with ``hdfs`` protocol. And access to each share is allowed by user
based access type, which is aligned with HDFS ACLs to support access
control of multiple users and groups.

Network configuration
~~~~~~~~~~~~~~~~~~~~~

The storage back end and Shared File Systems service hosts should be in
a flat network, otherwise, the L3 connectivity between them should
exist.

Supported shared filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  HDFS (authentication by user)

Supported operations
~~~~~~~~~~~~~~~~~~~~

- Create HDFS share.

- Delete HDFS share.

- Allow HDFS share access.

   - Only support user access type.

   - Support level of access (ro/rw).

- Deny HDFS share access.

- Create snapshot.

- Delete snapshot.

- Create share from snapshot.

Requirements
~~~~~~~~~~~~

- Install HDFS package, version >= 2.4.x, on the storage back end.

- To enable access control, the HDFS file system must have ACLs
  enabled.

- Establish network connection between the Shared File Systems service
  host and storage back end.

Shared File Systems service driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- share_driver = manila.share.drivers.hdfs.hdfs_native.HDFSNativeShareDriver

- hdfs_namenode_ip = the IP address of the HDFS namenode, and only
  single namenode is supported now

- hdfs_namenode_port = the port of the HDFS namenode service

- hdfs_ssh_port = HDFS namenode SSH port

- hdfs_ssh_name = HDFS namenode SSH login name

- hdfs_ssh_pw = HDFS namenode SSH login password, this parameter is
  not necessary, if the following hdfs_ssh_private_key is configured

- hdfs_ssh_private_key = Path to the HDFS namenode private key to
  ssh login

Known restrictions
~~~~~~~~~~~~~~~~~~

- This driver does not support network segmented multi-tenancy model.
  Instead multi-tenancy is supported by the tenant specific user
  authentication.

- Only support for single HDFS namenode in Kilo release.

Driver configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration options specific to this driver are documented here:

.. include:: ../../tables/manila-hdfs.rst
