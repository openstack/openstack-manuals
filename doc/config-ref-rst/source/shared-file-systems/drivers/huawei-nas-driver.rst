=============
Huawei driver
=============

Huawei NAS driver is a plug-in based on the Shared File Systems service.
The Huawei NAS driver can be used to provide functions such as the share
and snapshot for virtual machines, or instances, in OpenStack. Huawei
NAS driver enables the OceanStor V3 series V300R002 storage system to
provide only network filesystems for OpenStack.

Requirements
~~~~~~~~~~~~

-  The OceanStor V3 series V300R002 storage system.

-  The following licenses should be activated on V3 for File: CIFS, NFS,
   HyperSnap License (for snapshot)

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported for NFS.

  - Only user access is supported for CIFS.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

- Support pools in one backend.

- Extend a share.

- Shrink a share.


Pre-configurations on Huawei
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Create a driver configuration file. The driver configuration file
name must be the same as the manila_huawei_conf_file item in the
manila_conf configuration file.

2. Configure Product. Product indicates the storage system type. For the
OceanStor V3 series V300R002 storage systems, the driver configuration
file is as follows:

.. code-block:: xml

    <?xml version='1.0' encoding='UTF-8'?>
    <Config>
        <Storage>
            <Product>V3</Product>
            <LogicalPortIP>x.x.x.x</LogicalPortIP>
            <RestURL>https://x.x.x.x:8088/deviceManager/rest/</RestURL>
            <UserName>xxxxxxxxx</UserName>
            <UserPassword>xxxxxxxxx</UserPassword>
        </Storage>
        <Filesystem>
            <Thin_StoragePool>xxxxxxxxx</Thin_StoragePool>
            <Thick_StoragePool>xxxxxxxxx</Thick_StoragePool>
            <WaitInterval>3</WaitInterval>
            <Timeout>60</Timeout>
        </Filesystem>
    </Config>

-  Product is a type of storage product. Set it to V3.

-  LogicalPortIP is an IP address of the logical port.

-  RestURL is an access address of the REST interface. Multi RestURLs
   can be configured in <RestURL> (separated by ";"). When one of the
   RestURL fails to connect, the driver will retry another
   automatically.

-  UserName is a user name of an administrator.

-  UserPassword is a password of an administrator.

-  Thin_StoragePool is a name of a thin storage pool to be used.

-  Thick_StoragePool is a name of a thick storage pool to be used.

-  WaitInterval is the interval time of querying the file system status.

-  Timeout is the timeout period for waiting command execution of a
   device to complete.

Backend configuration
~~~~~~~~~~~~~~~~~~~~~

Modify the manila.conf Shared File Systems service configuration file
and add share_driver and manila_huawei_conf_file items. Example for
configuring a storage system:

-  share_driver =
   manila.share.drivers.huawei.huawei_nas.HuaweiNasDriver

-  manila_huawei_conf_file = /etc/manila/manila_huawei_conf.xml

-  driver_handles_share_servers = False

   .. note::

      As far as the Shared File Systems service requires share type
      for creation of shares, make sure that used share type has extra
      spec ``driver_handles_share_servers`` set to ``False`` otherwise
      Huawei back end will be filtered by ``manila-scheduler``. If you
      do not provide share type with share creation request then
      default share type and its extra specs will be used.

Restart of ``manila-share`` service is needed for the configuration
changes to take effect.

Share types
~~~~~~~~~~~

When creating a share, a share type can be specified to determine where
and how the share will be created. If a share type is not specified, the
default_share_type set in the Manila configuration file is used.

The Shared File Systems service requires that the share type includes
the driver_handles_share_servers extra-spec. This ensures that the
share will be created on a backend that supports the requested
driver_handles_share_servers (share networks) capability. For the
Huawei driver, this must be set to False.

Another common extra-spec used to determine where a share is created is
share_backend_name. When this extra-spec is defined in the share type,
the share will be created on a backend with a matching
share_backend_name.

The Shared File Systems service "share types" may contain qualified
extra-specs, extra-specs that have significance for the backend driver
and the CapabilityFilter. This commit makes the Huawei driver report the
following boolean capabilities:

-  capabilities:dedupe

-  capabilities:compression

-  capabilities:thin_provisioning

-  capabilities:huawei_smartcache

   -  huawei_smartcache:cachename

-  capabilities:huawei_smartpartition

   -  huawei_smartpartition:partitionname

The scheduler will choose a host that supports the needed capability
when the CapabilityFilter is used and a share type uses one or more of
the following extra-specs:

-  capabilities:dedupe='<is> True' or '<is> False'

-  capabilities:compression='<is> True' or '<is> False'

-  capabilities:thin_provisioning='<is> True' or '<is> False'

-  capabilities:huawei_smartcache='<is> True' or '<is> False'

   -  huawei_smartcache:cachename=test_cache_name

-  capabilities:huawei_smartpartition='<is> True' or '<is> False'

   -  huawei_smartpartition:partitionname=test_partition_name

``thin_provisioning`` will be reported as True for backends that use
thin provisioned pool. Backends that use thin provisioning also support
Manila's over-subscription feature. 'thin_provisioning' will be
reported as False for backends that use thick provisioned pool.

``dedupe`` will be reported as True for backends that use deduplication
technology.

``compression`` will be reported as True for backends that use
compression technology.

``huawei_smartcache`` will be reported as True for backends that use
smartcache technology. Adds SSDs into a high-speed cache pool and
divides the pool into multiple cache partitions to cache hotspot data in
random and small read I/Os.

``huawei_smartpartition`` will be reported as True for backends that use
smartpartition technology. Add share to the smartpartition named
'test_partition_name'. Allocates cache resources based on service
characteristics, ensuring the quality of critical services.

.. note::
        snapshot_support will be reported as True for backends that
        support all snapshot functionalities, including
        create_snapshot, delete_snapshot, and
        create_share_from_snapshot. Huawei Driver does not support
        create_share_from_snapshot API now, so make sure that used
        share type has extra spec snapshot_support set to False.

Restrictions
~~~~~~~~~~~~

The Huawei driver has the following restrictions:

-  Only IP access type is supported for NFS.

-  Only USER access type is supported for CIFS.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-huawei.rst
