==================================
NetApp Clustered Data ONTAP driver
==================================

The Shared File Systems service can be configured to use NetApp
clustered Data ONTAP version 8.

Network approach
~~~~~~~~~~~~~~~~

L3 connectivity between the storage cluster and Shared File Systems
service host should exist, and VLAN segmentation should be configured.

The clustered Data ONTAP driver creates storage virtual machines (SVM,
previously known as vServers) as representations of the Shared File
Systems service share server interface, configures logical interfaces
(LIFs) and stores shares there.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported for NFS.

  - Only user access type is supported for CIFS.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Extend a share.

- Shrink a share.

- Create a consistency group.

- Delete a consistency group.

- Create a consistency group snapshot.

- Delete a consistency group snapshot.

Required licenses
~~~~~~~~~~~~~~~~~

-  NFS

-  CIFS

-  FlexClone

Known restrictions
~~~~~~~~~~~~~~~~~~

-  For CIFS shares an external active directory service is required. Its
   data should be provided via security-service that is attached to used
   share-network.

-  Share access rule by user for CIFS shares can be created only for
   existing user in active directory.

-  To be able to configure clients to security services, the time on
   these external security services and storage should be synchronized.
   The maximum allowed clock skew is 5 minutes.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-netapp.rst
