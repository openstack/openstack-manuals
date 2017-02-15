.. _shared_file_systems_share_migration:

===============
Share migration
===============

Share migration is the feature that migrates a share between different storage
pools.

Use cases
~~~~~~~~~

As an administrator, you may want to migrate your share from one storage pool
to another for several reasons. Examples include:

* Maintenance or evacuation

  * Evacuate a back end for hardware or software upgrades
  * Evacuate a back end experiencing failures
  * Evacuate a back end which is tagged end-of-life

* Optimization

  * Defragment back ends to empty and be taken offline to conserve power
  * Rebalance back ends to maximize available performance
  * Move data and compute closer together to reduce network utilization and
    decrease latency or increase bandwidth

* Moving shares

  * Migrate from old hardware generation to a newer generation
  * Migrate from one vendor to another

Migration workflows
~~~~~~~~~~~~~~~~~~~

Moving shares across different storage pools is generally expected to be a
disruptive operation that disconnects existing clients when the source ceases
to exist. For this reason, share migration is implemented in a 2-phase approach
that allows the administrator to control the timing of the disruption. The
first phase performs data copy while users retain access to the share. When
copying is complete, the second phase may be triggered to perform a switchover
that may include a last sync and deleting the source, generally requiring users
to reconnect to continue accessing the share.

In order to migrate a share, one of two possible mechanisms may be employed,
which provide different capabilities and affect how the disruption occurs with
regards to user access during data copy phase and disconnection during
switchover phase. Those two mechanisms are:

* Driver-assisted migration: This mechanism is intended to make use of driver
  optimizations to migrate shares between pools of the same storage vendor.
  This mechanism allows migrating shares nondisruptively while the source
  remains writable, preserving all filesystem metadata and snapshots. The
  migration workload is performed in the storage back end.

* Host-assisted migration: This mechanism is intended to migrate shares in an
  agnostic manner between two different pools, regardless of storage vendor.
  The implementation for this mechanism does not offer the same properties
  found in driver-assisted migration. In host-assisted migration, the source
  remains readable, snapshots must be deleted prior to starting the migration,
  filesystem metadata may be lost, and the clients will get disconnected by the
  end of migration. The migration workload is performed by the Data Service,
  which is a dedicated manila service for intensive data operations.

When starting a migration, driver-assisted migration is attempted first. If
the shared file system service detects it is not possible to perform the
driver-assisted migration, it proceeds to attempt host-assisted migration.

Using the migration APIs
~~~~~~~~~~~~~~~~~~~~~~~~

The commands to interact with the share migration API are:

* ``migration_start``: starts a migration while retaining access to the share.
  Migration is paused and waits for ``migration_complete`` invocation when it
  has copied all data and is ready to take down the source share.

  .. code-block:: console

     $ manila migration-start share_1 ubuntu@generic2#GENERIC2 --writable False --preserve-snapshots False --preserve-metadata False --nondisruptive False

  .. note::
     This command has no output.

* ``migration_complete``: completes a migration, removing the source share and
  setting the destination share instance to ``available``.

  .. code-block:: console

     $ manila migration-complete share_1

  .. note::
     This command has no output.

* ``migration_get_progress``: obtains migration progress information of a
  share.

  .. code-block:: console

     $ manila migration-get-progress share_1

     +----------------+--------------------------+
     | Property       | Value                    |
     +----------------+--------------------------+
     | task_state     | data_copying_in_progress |
     | total_progress | 37                       |
     +----------------+--------------------------+

* ``migration_cancel``: cancels an in-progress migration of a share.

  .. code-block:: console

     $ manila migration-cancel share_1

  .. note::
     This command has no output.

The parameters
--------------

To start a migration, an administrator should specify several parameters. Among
those, two of them are key for the migration.

* ``share``: The share that will be migrated.

* ``destination_pool``: The destination pool to which the share should be
  migrated to, in format host@backend#pool.

Several other parameters, referred to here as ``driver-assisted parameters``,
*must* be specified in the ``migration_start`` API. They are:

* ``preserve_metadata``: whether preservation of filesystem metadata should be
  enforced for this migration.

* ``preserve_snapshots``: whether preservation of snapshots should be enforced
  for this migration.

* ``writable``: whether the source share remaining writable should be enforced
  for this migration.

* ``nondisruptive``: whether it should be enforced to keep clients connected
  throughout the migration.

Specifying any of the boolean parameters above as ``True`` will disallow a
host-assisted migration.

In order to appropriately move a share to a different storage pool, it may be
required to change one or more share properties, such as the share type, share
network, or availability zone. To accomplish this, use the optional parameters:

* ``new_share_type_id``: Specify the ID of the share type that should be set in
  the migrated share.

* ``new_share_network_id``: Specify the ID of the share network that should be
  set in the migrated share.

If driver-assisted migration should not be attempted, you may provide the
optional parameter:

* ``force_host_assisted_migration``: whether driver-assisted migration attempt
  should be skipped. If this option is set to ``True``, all driver-assisted
  options must be set to ``False``.

Configuration
~~~~~~~~~~~~~

For share migration to work in the cloud, there are several configuration
requirements that need to be met:

For driver-assisted migration: it is necessary that the configuration of all
back end stanzas is present in the file manila.conf of all manila-share nodes.
Also, network connectivity between the nodes running manila-share service and
their respective storage back ends is required.

For host-assisted migration: it is necessary that the Data Service
(manila-data) is installed and configured in a node connected to the cloud's
administrator network. The drivers pertaining to the source back end and
destination back end involved in the migration should be able to provide shares
that can be accessed from the administrator network. This can easily be
accomplished if the driver supports ``admin_only`` export locations, else it is
up to the administrator to set up means of connectivity.

In order for the Data Service to mount the source and destination instances, it
must use manila share access APIs to grant access to mount the instances.
The access rule type varies according to the share protocol, so there are a few
config options to set the access value for each type:

* ``data_node_access_ip``: For IP-based access type, provide the value of the
  IP of the Data Service node in the administrator network. For NFS shares,
  drivers should always add rules with the "no_root_squash" property.

* ``data_node_access_cert``: For certificate-based access type, provide the
  value of the certificate name that grants access to the Data Service.

* ``data_node_access_admin_user``: For user-based access type, provide the
  value of a username that grants access and administrator privileges to the
  files in the share.

* ``data_node_mount_options``: Provide the value of a mapping of protocol name
  to respective mount options. The Data Service makes use of mount command
  templates that by default have a dedicated field to inserting mount options
  parameter. The default value for this config option already includes the
  username and password parameters for CIFS shares and NFS v3 enforcing
  parameter for NFS shares.

* ``mount_tmp_location``: Provide the value of a string representing the path
  where the share instances used in migration should be temporarily mounted.
  The default value is ``/tmp/``.

* ``check_hash``: This boolean config option value determines whether the hash
  of all files copied in migration should be validated. Setting this option
  increases the time it takes to migrate files, and is recommended for
  ultra-dependable systems. It defaults to disabled.

The configuration options above are respective to the Data Service only and
should be defined the ``DEFAULT`` group of the ``manila.conf`` configuration
file. Also, the Data Service node must have all the protocol-related libraries
pre-installed to be able to run the mount commands for each protocol.

You may need to change some driver-specific configuration options from their
default value to work with specific drivers. If so, they must be set under the
driver configuration stanza in ``manila.conf``. See a detailed description for
each one below:

* ``migration_ignore_files``: Provide value as a list containing the names of
  files or folders to be ignored during migration for a specific driver. The
  default value is a list containing only ``lost+found`` folder.

* ``share_mount_template``: Provide a string that defines the template for the
  mount command for a specific driver. The template should contain the
  following entries to be formatted by the code:

  * proto: The share protocol. Automatically formatted by the Data Service.
  * options: The mount options to be formatted by the Data Service according to
    the data_node_mount_options config option.
  * export: The export path of the share. Automatically formatted by the Data
    Service with the share's ``admin_only`` export location.
  * path: The path to mount the share. Automatically formatted by the Data
    Serivce according to the mount_tmp_location config option.

  The default value for this config option is::

      mount -vt %(proto)s %(options)s %(export)s %(path)s.


* ``share_unmount_template``: Provide the value of a string that defines the
  template for the unmount command for a specific driver. The template should
  contain the path of where the shares are mounted, according to the
  ``mount_tmp_location`` config option, to be formatted automatically by the
  Data Service. The default value for this config option is::

      umount -v %(path)s


* ``protocol_access_mapping``: Provide the value of a mapping of access rule
  type to protocols supported. The default value specifies IP and user based
  access types mapped to NFS and CIFS respectively, which are the combinations
  supported by manila. If a certain driver uses a different protocol for IP or
  user access types, or is not included in the default mapping, it should be
  specified in this configuration option.

Other remarks
~~~~~~~~~~~~~

* There is no need to manually add any of the previously existing access rules
  after a migration is complete, they will be persisted on the destination
  after the migration.

* Once migration of a share has started, the user will see the status
  ``migrating`` and it will block other share actions, such as adding or
  removing access rules, creating or deleting snapshots, resizing, among
  others.

* The destination share instance export locations, although it may exist from
  the beginning of a host-assisted migration, are not visible nor accessible as
  access rules cannot be added.

* During a host-assisted migration, an access rule granting access to the Data
  Service will be added and displayed by querying the ``access-list`` API. This
  access rule should not be tampered with, it will otherwise cause migration to
  fail.

* Resources allocated are cleaned up automatically when a migration fails,
  except if this failure occurs during the 2nd phase of a driver-assisted
  migration. Each step in migration is saved to the field ``task_state``
  present in the Share model. If for any reason the state is not set to
  ``migration_error`` during a failure, it will need to be reset using the
  ``reset-task-state`` API.

* It is advised that the node running the Data Service is well secured, since
  it will be mounting shares with highest privileges, temporarily exposing user
  data to whoever has access to this node.

* The two mechanisms of migration are affected differently by service restarts:

  * If performing a host-assisted migration, all services may be restarted
    except for the manila-data service when performing the copy (the
    ``task_state`` field value starts with ``data_copying_``). In other steps
    of the host-assisted migration, both the source and destination
    manila-share services should not be restarted.
  * If performing a driver-assisted migration, the migration is affected
    minimally by driver restarts if the ``task_state`` is
    ``migration_driver_in_progress``, while the copy is being done in the
    back end. Otherwise, the source and destination manila-share services
    should not be restarted.
