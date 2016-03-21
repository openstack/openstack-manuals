=====================
ZFS (on Linux) driver
=====================

Manila ZFSonLinux share driver uses ZFS file system for exporting NFS shares.
Written and tested using Linux version of ZFS.

Requirements
~~~~~~~~~~~~

- NFS daemon that can be handled through ``exportfs`` app.

- ZFS file system packages, either Kernel or FUSE versions.

- ZFS zpools that are going to be used by Manila should exist and be
  configured as desired. Manila will not change zpool configuration.

- For remote ZFS hosts according to manila-share service host SSH should be
  installed.

- For ZFS hosts that support replication:

  - SSH access for each other should be passwordless.

  - Service IP addresses should be available by ZFS hosts for each other.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  - Only IP access type is supported.

  - Both access levels are supported - ``RW`` and ``RO``.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from snapshot.

- Extend a share.

- Shrink a share.

- Share replication (experimental):

  - Create, update, delete, and promote replica operations are supported.

Possibilities
~~~~~~~~~~~~~

- Any amount of ZFS zpools can be used by share driver.

- Allowed to configure default options for ZFS datasets that are used
  for share creation.

- Any amount of nested datasets is allowed to be used.

- All share replicas are read-only, only active one is read-write.

- All share replicas are synchronized periodically, not continuously.
  Status ``in_sync`` means latest sync was successful.
  Time range between syncs equals to the value
  of the ``replica_state_update_interval`` configuration global option.

- Driver can use qualified extra spec ``zfsonlinux:compression``.
  It can contain any value that ZFS app supports.
  But if it is disabled through the configuration option
  with the value ``compression=off``, then it will not be used.

Restrictions
~~~~~~~~~~~~

The ZFSonLinux share driver has the following restrictions:

- Only IP access type is supported for NFS.

- Only FLAT network is supported.

- ``Promote share replica`` operation will switch roles of
  current ``secondary`` replica and ``active``. It does not make more than
  one active replica available.

- The below items are not yet implemented:

  - ``Manage share`` operation.

  - ``Manage snapshot`` operation.

  - ``SaMBa`` based sharing.

  - ``Thick provisioning`` capability.

Known problems
~~~~~~~~~~~~~~

- ``Promote share replica`` operation will make ZFS file system that became
  secondary as RO only on NFS level. On ZFS level system will
  stay mounted as was - RW.

Back-end configuration
~~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the manila configuration file
for back-ends that use the ZFSonLinux driver:

- ``share_driver``
  = manila.share.drivers.zfsonlinux.driver.ZFSonLinuxShareDriver

- ``driver_handles_share_servers`` = False

- ``replication_domain`` = custom_str_value_as_domain_name

  - If empty, then replication will be disabled.

  - If set, then will be able to be used as replication peer for other
    back ends with the same value.

- ``zfs_share_export_ip`` = <user_facing IP address of ZFS host>

- ``zfs_service_ip`` = <IP address of service network interface of ZFS host>

- ``zfs_zpool_list`` = zpoolname1,zpoolname2/nested_dataset_for_zpool2

  - Can be one or more zpools.

  - Can contain nested datasets.

- ``zfs_dataset_creation_options`` = <list of ZFS dataset options>

  - readonly, quota, sharenfs and sharesmb options will be ignored.

- ``zfs_dataset_name_prefix`` = <prefix>

  - Prefix to be used in each dataset name.

- ``zfs_dataset_snapshot_name_prefix`` = <prefix>

  - Prefix to be used in each dataset snapshot name.

- ``zfs_use_ssh`` = <boolean_value>

  - Set ``False`` if ZFS located on the same host as `manila-share` service.

  - Set ``True`` if `manila-share` service should use SSH
    for ZFS configuration.

- ``zfs_ssh_username`` = <ssh_username>

  - Required for replication operations.

  - Required for SSH``ing to ZFS host if ``zfs_use_ssh`` is set to ``True``.

- ``zfs_ssh_user_password`` = <ssh_user_password>

  - Password for ``zfs_ssh_username`` of ZFS host.

  - Used only if ``zfs_use_ssh`` is set to ``True``.

- ``zfs_ssh_private_key_path`` = <path_to_private_ssh_key>

  - Used only if ``zfs_use_ssh`` is set to ``True``.

- ``zfs_share_helpers``
  = NFS=manila.share.drivers.zfsonlinux.utils.NFSviaZFSHelper

  - Approach for setting up helpers is similar to various other share drivers.

  - At least one helper should be used.

- ``zfs_replica_snapshot_prefix`` = <prefix>

  - Prefix to be used in dataset snapshot names that are created
    by ``update replica`` operation.

Driver options
~~~~~~~~~~~~~~

.. include:: ../../tables/manila-zfs.rst
