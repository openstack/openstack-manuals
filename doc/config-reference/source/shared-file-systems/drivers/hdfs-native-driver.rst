==================
HDFS native driver
==================

The HDFS native driver is a plug-in for the Shared File Systems
service. It uses Hadoop distributed file system (HDFS), a distributed
file system designed to hold very large amounts of data, and provide
high-throughput access to the data.

A Shared File Systems service share in this driver is a subdirectory
in the hdfs root directory. Instances talk directly to the HDFS
storage back end using the ``hdfs`` protocol. Access to each share
is allowed by user based access type, which is aligned with HDFS ACLs
to support access control of multiple users and groups.

Network configuration
~~~~~~~~~~~~~~~~~~~~~

The storage back end and Shared File Systems service hosts should be
in a flat network, otherwise L3 connectivity between them should
exist.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports HDFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only user access type is supported.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.


Requirements
~~~~~~~~~~~~

- Install HDFS package, version >= 2.4.x, on the storage back end.

- To enable access control, the HDFS file system must have ACLs
  enabled.

- Establish network connection between the Shared File Systems service
  host and storage back end.

Shared File Systems service driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To enable the driver, set the ``share_driver`` option in file
``manila.conf`` and add other options as appropriate.

.. code-block:: ini

   share_driver = manila.share.drivers.hdfs.hdfs_native.HDFSNativeShareDriver

Known restrictions
~~~~~~~~~~~~~~~~~~

- This driver does not support network segmented multi-tenancy model.
  Instead multi-tenancy is supported by the tenant specific user
  authentication.

- Only support for single HDFS namenode in Kilo release.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-hdfs.rst
