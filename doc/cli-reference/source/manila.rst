.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

========================================================
Shared File Systems service (manila) command-line client
========================================================

The manila client is the command-line interface (CLI) for
the Shared File Systems service (manila) API and its extensions.

This chapter documents :command:`manila` version ``1.14.0``.

For help on a specific :command:`manila` command, enter:

.. code-block:: console

   $ manila help COMMAND

.. _manila_command_usage:

manila usage
~~~~~~~~~~~~

.. code-block:: console

   usage: manila [--version] [-d] [--os-cache] [--os-reset-cache]
                 [--os-user-id <auth-user-id>] [--os-username <auth-user-name>]
                 [--os-password <auth-password>]
                 [--os-tenant-name <auth-tenant-name>]
                 [--os-project-name <auth-project-name>]
                 [--os-tenant-id <auth-tenant-id>]
                 [--os-project-id <auth-project-id>]
                 [--os-user-domain-id <auth-user-domain-id>]
                 [--os-user-domain-name <auth-user-domain-name>]
                 [--os-project-domain-id <auth-project-domain-id>]
                 [--os-project-domain-name <auth-project-domain-name>]
                 [--os-auth-url <auth-url>] [--os-region-name <region-name>]
                 [--os-token <token>] [--bypass-url <bypass-url>]
                 [--service-type <service-type>] [--service-name <service-name>]
                 [--share-service-name <share-service-name>]
                 [--endpoint-type <endpoint-type>]
                 [--os-share-api-version <share-api-ver>]
                 [--os-cacert <ca-certificate>] [--retries <retries>]
                 [--os-cert <certificate>]
                 <subcommand> ...

**Subcommands:**

``absolute-limits``
  Print a list of absolute limits for a user.

``access-allow``
  Allow access to the share.

``access-deny``
  Deny access to a share.

``access-list``
  Show access list for share.

``api-version``
  Display the API version information.

``availability-zone-list``
  List all availability zones.

``create``
  Creates a new share (NFS, CIFS, CephFS, GlusterFS or
  HDFS).

``credentials``
  Show user credentials returned from auth.

``delete``
  Remove one or more shares.

``endpoints``
  Discover endpoints that get returned from the
  authenticate services.

``extend``
  Increases the size of an existing share.

``extra-specs-list``
  Print a list of current 'share types and extra specs'
  (Admin Only).

``force-delete``
  Attempt force-delete of share, regardless of state
  (Admin only).

``list``
  List NAS shares with filters.

``manage``
  Manage share not handled by Manila (Admin only).

``metadata``
  Set or delete metadata on a share.

``metadata-show``
  Show metadata of given share.

``metadata-update-all``
  Update all metadata of a share.

``migration-cancel``
  Cancels migration of a given share when copying (Admin
  only, Experimental).

``migration-complete``
  Completes migration for a given share (Admin only,
  Experimental).

``migration-get-progress``
  Gets migration progress of a given share when copying
  (Admin only, Experimental).

``migration-start``
  Migrates share to a new host (Admin only,
  Experimental).

``pool-list``
  List all backend storage pools known to the scheduler
  (Admin only).

``quota-class-show``
  List the quotas for a quota class.

``quota-class-update``
  Update the quotas for a quota class (Admin only).

``quota-defaults``
  List the default quotas for a tenant.

``quota-delete``
  Delete quota for a tenant/user. The quota will revert
  back to default (Admin only).

``quota-show``
  List the quotas for a tenant/user.

``quota-update``
  Update the quotas for a tenant/user (Admin only).

``rate-limits``
  Print a list of rate limits for a user.

``reset-state``
  Explicitly update the state of a share (Admin only).

``reset-task-state``
  Explicitly update the task state of a share (Admin
  only, Experimental).

``revert-to-snapshot``
  Revert a share to the specified snapshot.

``security-service-create``
  Create security service used by tenant.

``security-service-delete``
  Delete one or more security services.

``security-service-list``
  Get a list of security services.

``security-service-show``
  Show security service.

``security-service-update``
  Update security service.

``service-disable``
  Disables 'manila-share' or 'manila-scheduler' services
  (Admin only).

``service-enable``
  Enables 'manila-share' or 'manila-scheduler' services
  (Admin only).

``service-list``
  List all services (Admin only).

``share-export-location-list``
  List export locations of a given share.

``share-export-location-show``
  Show export location of the share.

``share-group-create``
  Creates a new share group (Experimental).

``share-group-delete``
  Remove one or more share groups (Experimental).

``share-group-list``
  List share groups with filters (Experimental).

``share-group-reset-state``
  Explicitly update the state of a share group (Admin
  only, Experimental).

``share-group-show``
  Show details about a share group (Experimental).

``share-group-snapshot-create``
  Creates a new share group snapshot (Experimental).

``share-group-snapshot-delete``
  Remove one or more share group snapshots
  (Experimental).

``share-group-snapshot-list``
  List share group snapshots with filters
  (Experimental).

``share-group-snapshot-list-members``
  List members of a share group snapshot (Experimental).

``share-group-snapshot-reset-state``
  Explicitly update the state of a share group snapshot
  (Admin only, Experimental).

``share-group-snapshot-show``
  Show details about a share group snapshot
  (Experimental).

``share-group-snapshot-update``
  Update a share group snapshot (Experimental).

``share-group-type-access-add``
  Adds share group type access for the given project
  (Admin only).

``share-group-type-access-list``
  Print access information about a share group type
  (Admin only).

``share-group-type-access-remove``
  Removes share group type access for the given project
  (Admin only).

``share-group-type-create``
  Create a new share group type (Admin only).

``share-group-type-delete``
  Delete a specific share group type (Admin only).

``share-group-type-key``
  Set or unset group_spec for a share group type (Admin
  only).

``share-group-type-list``
  Print a list of available 'share group types'.

``share-group-type-specs-list``
  Print a list of 'share group types specs' (Admin
  Only).

``share-group-update``
  Update a share group (Experimental).

``share-instance-export-location-list``
  List export locations of a given share instance.

``share-instance-export-location-show``
  Show export location for the share instance.

``share-instance-force-delete``
  Force-delete the share instance, regardless of state
  (Admin only).

``share-instance-list``
  List share instances (Admin only).

``share-instance-reset-state``
  Explicitly update the state of a share instance (Admin
  only).

``share-instance-show``
  Show details about a share instance (Admin only).

``share-network-create``
  Create description for network used by the tenant.

``share-network-delete``
  Delete one or more share networks.

``share-network-list``
  Get a list of network info.

``share-network-security-service-add``
  Associate security service with share network.

``share-network-security-service-list``
  Get list of security services associated with a given
  share network.

``share-network-security-service-remove``
  Dissociate security service from share network.

``share-network-show``
  Get a description for network used by the tenant.

``share-network-update``
  Update share network data.

``share-replica-create``
  Create a share replica (Experimental).

``share-replica-delete``
  Remove one or more share replicas (Experimental).

``share-replica-list``
  List share replicas (Experimental).

``share-replica-promote``
  Promote specified replica to 'active' replica_state
  (Experimental).

``share-replica-reset-replica-state``
  Explicitly update the 'replica_state' of a share
  replica (Experimental).

``share-replica-reset-state``
  Explicitly update the 'status' of a share replica
  (Experimental).

``share-replica-resync``
  Attempt to update the share replica with its 'active'
  mirror (Experimental).

``share-replica-show``
  Show details about a replica (Experimental).

``share-server-delete``
  Delete one or more share servers (Admin only).

``share-server-details``
  Show share server details (Admin only).

``share-server-list``
  List all share servers (Admin only).

``share-server-show``
  Show share server info (Admin only).

``show``
  Show details about a NAS share.

``shrink``
  Decreases the size of an existing share.

``snapshot-access-allow``
  Allow read only access to a snapshot.

``snapshot-access-deny``
  Deny access to a snapshot.

``snapshot-access-list``
  Show access list for a snapshot.

``snapshot-create``
  Add a new snapshot.

``snapshot-delete``
  Remove one or more snapshots.

``snapshot-export-location-list``
  List export locations of a given snapshot.

``snapshot-export-location-show``
  Show export location of the share snapshot.

``snapshot-force-delete``
  Attempt force-deletion of one or more snapshots.
  Regardless of the state (Admin only).

``snapshot-instance-export-location-list``
  List export locations of a given snapshot instance.

``snapshot-instance-export-location-show``
  Show export location of the share instance snapshot.

``snapshot-instance-list``
  List share snapshot instances.

``snapshot-instance-reset-state``
  Explicitly update the state of a share snapshot
  instance.

``snapshot-instance-show``
  Show details about a share snapshot instance.

``snapshot-list``
  List all the snapshots.

``snapshot-manage``
  Manage share snapshot not handled by Manila (Admin
  only).

``snapshot-rename``
  Rename a snapshot.

``snapshot-reset-state``
  Explicitly update the state of a snapshot (Admin
  only).

``snapshot-show``
  Show details about a snapshot.

``snapshot-unmanage``
  Unmanage one or more share snapshots (Admin only).

``type-access-add``
  Adds share type access for the given project (Admin
  only).

``type-access-list``
  Print access information about the given share type
  (Admin only).

``type-access-remove``
  Removes share type access for the given project (Admin
  only).

``type-create``
  Create a new share type (Admin only).

``type-delete``
  Delete one or more specific share types (Admin only).

``type-key``
  Set or unset extra_spec for a share type (Admin only).

``type-list``
  Print a list of available 'share types'.

``unmanage``
  Unmanage share (Admin only).

``update``
  Rename a share.

``bash-completion``
  Print arguments for bash_completion. Prints all of the
  commands and options to stdout so that the
  manila.bash_completion script doesn't have to hard
  code them.

``help``
  Display help about this program or one of its
  subcommands.

``list-extensions``
  List all the os-api extensions that are available.

.. _manila_command_options:

manila optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-d, --debug``
  Print debugging output.

``--os-cache``
  Use the auth token cache. Defaults to ``env[OS_CACHE]``.

``--os-reset-cache``
  Delete cached password and auth token.

``--os-user-id <auth-user-id>``
  Defaults to env [OS_USER_ID].

``--os-username <auth-user-name>``
  Defaults to ``env[OS_USERNAME]``.

``--os-password <auth-password>``
  Defaults to ``env[OS_PASSWORD]``.

``--os-tenant-name <auth-tenant-name>``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-project-name <auth-project-name>``
  Another way to specify tenant name. This option is
  mutually exclusive with --os-tenant-name. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-tenant-id <auth-tenant-id>``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-project-id <auth-project-id>``
  Another way to specify tenant ID. This option is
  mutually exclusive with --os-tenant-id. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-user-domain-id <auth-user-domain-id>``
  OpenStack user domain ID. Defaults to
  ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  OpenStack user domain name. Defaults to
  ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-domain-id <auth-project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <auth-project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-auth-url <auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-region-name <region-name>``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-token <token>``
  Defaults to ``env[OS_TOKEN]``.

``--bypass-url <bypass-url>``
  Use this API endpoint instead of the Service Catalog.
  Defaults to ``env[OS_MANILA_BYPASS_URL]``.

``--service-type <service-type>``
  Defaults to compute for most actions.

``--service-name <service-name>``
  Defaults to ``env[OS_MANILA_SERVICE_NAME]``.

``--share-service-name <share-service-name>``
  Defaults to ``env[OS_MANILA_SHARE_SERVICE_NAME]``.

``--endpoint-type <endpoint-type>``
  Defaults to ``env[OS_MANILA_ENDPOINT_TYPE]`` or publicURL.

``--os-share-api-version <share-api-ver>``
  Accepts 1.x to override default to
  ``env[OS_SHARE_API_VERSION]``.

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS
  (https) server certificate. Defaults to
  ``env[OS_CACERT]``.

``--retries <retries>``
  Number of retries.

``--os-cert <certificate>``
  Defaults to ``env[OS_CERT]``.

.. _manila_absolute-limits:

manila absolute-limits
----------------------

.. code-block:: console

   usage: manila absolute-limits

Print a list of absolute limits for a user.

.. _manila_access-allow:

manila access-allow
-------------------

.. code-block:: console

   usage: manila access-allow [--access-level <access_level>]
                              <share> <access_type> <access_to>

Allow access to the share.

**Positional arguments:**

``<share>``
  Name or ID of the NAS share to modify.

``<access_type>``
  Access rule type (only "ip", "user"(user or group),
  "cert" or "cephx" are supported).

``<access_to>``
  Value that defines access.

**Optional arguments:**

``--access-level <access_level>, --access_level <access_level>``
  Share access level ("rw" and "ro" access levels are
  supported). Defaults to rw.

.. _manila_access-deny:

manila access-deny
------------------

.. code-block:: console

   usage: manila access-deny <share> <id>

Deny access to a share.

**Positional arguments:**

``<share>``
  Name or ID of the NAS share to modify.

``<id>``
  ID of the access rule to be deleted.

.. _manila_access-list:

manila access-list
------------------

.. code-block:: console

   usage: manila access-list [--columns <columns>] <share>

Show access list for share.

**Positional arguments:**

``<share>``
  Name or ID of the share.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "access_type,access_to"

.. _manila_api-version:

manila api-version
------------------

.. code-block:: console

   usage: manila api-version

Display the API version information.

.. _manila_availability-zone-list:

manila availability-zone-list
-----------------------------

.. code-block:: console

   usage: manila availability-zone-list [--columns <columns>]

List all availability zones.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_create:

manila create
-------------

.. code-block:: console

   usage: manila create [--snapshot-id <snapshot-id>] [--name <name>]
                        [--metadata [<key=value> [<key=value> ...]]]
                        [--share-network <network-info>]
                        [--description <description>] [--share-type <share-type>]
                        [--public] [--availability-zone <availability-zone>]
                        [--share-group <share-group>]
                        <share_protocol> <size>

Creates a new share (NFS, CIFS, CephFS, GlusterFS or HDFS).

**Positional arguments:**

``<share_protocol>``
  Share protocol (NFS, CIFS, CephFS, GlusterFS or HDFS).

``<size>``
  Share size in GiB.

**Optional arguments:**

``--snapshot-id <snapshot-id>, --snapshot_id <snapshot-id>``
  Optional snapshot ID to create the share from.
  (Default=None)

``--name <name>``
  Optional share name. (Default=None)

``--metadata [<key=value> [<key=value> ...]]``
  Metadata key=value pairs (Optional, Default=None).

``--share-network <network-info>, --share_network <network-info>``
  Optional network info ID or name.

``--description <description>``
  Optional share description. (Default=None)

``--share-type <share-type>, --share_type <share-type>, --volume-type <share-type>, --volume_type <share-type>``
  Optional share type. Use of optional volume type is
  deprecated(Default=None)

``--public``
  Level of visibility for share. Defines whether other
  tenants are able to see it or not.

``--availability-zone <availability-zone>, --availability_zone <availability-zone>, --az <availability-zone>``
  Availability zone in which share should be created.

``--share-group <share-group>, --share_group <share-group>, --group <share-group>``
  Optional share group name or ID in which to create the
  share (Experimental, Default=None).

.. _manila_credentials:

manila credentials
------------------

.. code-block:: console

   usage: manila credentials

Show user credentials returned from auth.

.. _manila_delete:

manila delete
-------------

.. code-block:: console

   usage: manila delete [--share-group <share-group>] <share> [<share> ...]

Remove one or more shares.

**Positional arguments:**

``<share>``
  Name or ID of the share(s).

**Optional arguments:**

``--share-group <share-group>, --share_group <share-group>, --group <share-group>``
  Optional share group name or ID which contains the
  share (Experimental, Default=None).

.. _manila_endpoints:

manila endpoints
----------------

.. code-block:: console

   usage: manila endpoints

Discover endpoints that get returned from the authenticate services.

.. _manila_extend:

manila extend
-------------

.. code-block:: console

   usage: manila extend <share> <new_size>

Increases the size of an existing share.

**Positional arguments:**

``<share>``
  Name or ID of share to extend.

``<new_size>``
  New size of share, in GiBs.

.. _manila_extra-specs-list:

manila extra-specs-list
-----------------------

.. code-block:: console

   usage: manila extra-specs-list [--columns <columns>]

Print a list of current 'share types and extra specs' (Admin Only).

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_force-delete:

manila force-delete
-------------------

.. code-block:: console

   usage: manila force-delete <share> [<share> ...]

Attempt force-delete of share, regardless of state (Admin only).

**Positional arguments:**

``<share>``
  Name or ID of the share(s) to force delete.

.. _manila_list:

manila list
-----------

.. code-block:: console

   usage: manila list [--all-tenants [<0|1>]] [--name <name>] [--status <status>]
                      [--share-server-id <share_server_id>]
                      [--metadata [<key=value> [<key=value> ...]]]
                      [--extra-specs [<key=value> [<key=value> ...]]]
                      [--share-type <share_type>] [--limit <limit>]
                      [--offset <offset>] [--sort-key <sort_key>]
                      [--sort-dir <sort_dir>] [--snapshot <snapshot>]
                      [--host <host>] [--share-network <share_network>]
                      [--project-id <project_id>] [--public]
                      [--share-group <share_group>] [--columns <columns>]

List NAS shares with filters.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--name <name>``
  Filter results by name.

``--status <status>``
  Filter results by status.

``--share-server-id <share_server_id>, --share-server_id <share_server_id>, --share_server-id <share_server_id>, --share_server_id <share_server_id>``
  Filter results by share server ID (Admin only).

``--metadata [<key=value> [<key=value> ...]]``
  Filters results by a metadata key and value. OPTIONAL:
  Default=None

``--extra-specs [<key=value> [<key=value> ...]], --extra_specs [<key=value> [<key=value> ...]]``
  Filters results by a extra specs key and value of
  share type that was used for share creation. OPTIONAL:
  Default=None

``--share-type <share_type>, --volume-type <share_type>, --share_type <share_type>, --share-type-id <share_type>, --volume-type-id <share_type>, --share-type_id <share_type>, --share_type-id <share_type>, --share_type_id <share_type>, --volume_type <share_type>, --volume_type_id <share_type>``
  Filter results by a share type id or name that was
  used for share creation.

``--limit <limit>``
  Maximum number of shares to return. OPTIONAL:
  Default=None.

``--offset <offset>``
  Set offset to define start point of share listing.
  OPTIONAL: Default=None.

``--sort-key <sort_key>, --sort_key <sort_key>``
  Key to be sorted, available keys are ('id', 'status',
  'size', 'host', 'share_proto', 'export_location',
  'availability_zone', 'user_id', 'project_id',
  'created_at', 'updated_at', 'display_name', 'name',
  'share_type_id', 'share_type', 'share_network_id',
  'share_network', 'snapshot_id', 'snapshot'). OPTIONAL:
  Default=None.

``--sort-dir <sort_dir>, --sort_dir <sort_dir>``
  Sort direction, available values are ('asc', 'desc').
  OPTIONAL: Default=None.

``--snapshot <snapshot>``
  Filer results by snapshot name or id, that was used
  for share.

``--host <host>``
  Filter results by host.

``--share-network <share_network>, --share_network <share_network>``
  Filter results by share-network name or id.

``--project-id <project_id>, --project_id <project_id>``
  Filter results by project id. Useful with set key
  '--all-tenants'.

``--public``
  Add public shares from all tenants to result.

``--share-group <share_group>, --share_group <share_group>, --group <share_group>``
  Filter results by share group name or ID
  (Experimental, Default=None).

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "export_location,is public"

.. _manila_list-extensions:

manila list-extensions
----------------------

.. code-block:: console

   usage: manila list-extensions

List all the os-api extensions that are available.

.. _manila_manage:

manila manage
-------------

.. code-block:: console

   usage: manila manage [--name <name>] [--description <description>]
                        [--share_type <share-type>]
                        [--driver_options [<key=value> [<key=value> ...]]]
                        [--public]
                        <service_host> <protocol> <export_path>

Manage share not handled by Manila (Admin only).

**Positional arguments:**

``<service_host>``
  manage-share service host: some.host@driver#pool

``<protocol>``
  Protocol of the share to manage, such as NFS or CIFS.

``<export_path>``
  Share export path, NFS share such as:
  10.0.0.1:/example_path, CIFS share such as:
  \\\\10.0.0.1\\example_cifs_share

**Optional arguments:**

``--name <name>``
  Optional share name. (Default=None)

``--description <description>``
  Optional share description. (Default=None)

``--share_type <share-type>, --share-type <share-type>``
  Optional share type assigned to share. (Default=None)

``--driver_options [<key=value> [<key=value> ...]], --driver-options [<key=value> [<key=value> ...]]``
  Driver option key=value pairs (Optional,
  Default=None).

``--public``
  Level of visibility for share. Defines whether other
  tenants are able to see it or not. Available only for
  microversion >= 2.8

.. _manila_metadata:

manila metadata
---------------

.. code-block:: console

   usage: manila metadata <share> <action> <key=value> [<key=value> ...]

Set or delete metadata on a share.

**Positional arguments:**

``<share>``
  Name or ID of the share to update metadata on.

``<action>``
  Actions: 'set' or 'unset'.

``<key=value>``
  Metadata to set or unset (key is only necessary on unset).

.. _manila_metadata-show:

manila metadata-show
--------------------

.. code-block:: console

   usage: manila metadata-show <share>

Show metadata of given share.

**Positional arguments:**

``<share>``
  Name or ID of the share.

.. _manila_metadata-update-all:

manila metadata-update-all
--------------------------

.. code-block:: console

   usage: manila metadata-update-all <share> <key=value> [<key=value> ...]

Update all metadata of a share.

**Positional arguments:**

``<share>``
  Name or ID of the share to update metadata on.

``<key=value>``
  Metadata entry or entries to update.

.. _manila_migration-cancel:

manila migration-cancel
-----------------------

.. code-block:: console

   usage: manila migration-cancel <share>

Cancels migration of a given share when copying (Admin only, Experimental).

**Positional arguments:**

``<share>``
  Name or ID of share to cancel migration.

.. _manila_migration-complete:

manila migration-complete
-------------------------

.. code-block:: console

   usage: manila migration-complete <share>

Completes migration for a given share (Admin only, Experimental).

**Positional arguments:**

``<share>``
  Name or ID of share to complete migration.

.. _manila_migration-get-progress:

manila migration-get-progress
-----------------------------

.. code-block:: console

   usage: manila migration-get-progress <share>

Gets migration progress of a given share when copying (Admin only,
Experimental).

**Positional arguments:**

``<share>``
  Name or ID of the share to get share migration progress
  information.

.. _manila_migration-start:

manila migration-start
----------------------

.. code-block:: console

   usage: manila migration-start [--force_host_assisted_migration <True|False>]
                                 --preserve-metadata <True|False>
                                 --preserve-snapshots <True|False> --writable
                                 <True|False> --nondisruptive <True|False>
                                 [--new_share_network <new_share_network>]
                                 [--new_share_type <new_share_type>]
                                 <share> <host@backend#pool>

Migrates share to a new host (Admin only, Experimental).

**Positional arguments:**

``<share>``
  Name or ID of share to migrate.

``<host@backend#pool>``
  Destination host where share will be migrated to. Use
  the format 'host@backend#pool'.

**Optional arguments:**

``--force_host_assisted_migration <True|False>, --force-host-assisted-migration <True|False>``
  Enforces the use of the host-assisted migration
  approach, which bypasses driver optimizations.
  Default=False.

``--preserve-metadata <True|False>, --preserve_metadata <True|False>``
  Enforces migration to preserve all file metadata when
  moving its contents. If set to True, host-assisted
  migration will not be attempted.

``--preserve-snapshots <True|False>, --preserve_snapshots <True|False>``
  Enforces migration of the share snapshots to the
  destination. If set to True, host-assisted migration
  will not be attempted.

``--writable <True|False>``
  Enforces migration to keep the share writable while
  contents
  are
  being
  moved.
  If
  set
  to
  True,
  host-assisted
  migration
  will
  not
  be
  attempted.

``--nondisruptive <True|False>``
  Enforces migration to be nondisruptive. If set to
  True, host-assisted migration will not be attempted.

``--new_share_network <new_share_network>, --new-share-network <new_share_network>``
  Specify the new share network for the share. Do not
  specify this parameter if the migrating share has to
  be retained within its current share network.

``--new_share_type <new_share_type>, --new-share-type <new_share_type>``
  Specify the new share type for the share. Do not
  specify this parameter if the migrating share has to
  be retained with its current share type.

.. _manila_pool-list:

manila pool-list
----------------

.. code-block:: console

   usage: manila pool-list [--host <host>] [--backend <backend>] [--pool <pool>]
                           [--columns <columns>] [--detail]
                           [--share-type <share_type>]

List all backend storage pools known to the scheduler (Admin only).

**Optional arguments:**

``--host <host>``
  Filter results by host name. Regular expressions are
  supported.

``--backend <backend>``
  Filter results by backend name. Regular expressions
  are supported.

``--pool <pool>``
  Filter results by pool name. Regular expressions are
  supported.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "name,host"

``--detail, --detailed``
  Show detailed information about pools. (Default=False)

``--share-type <share_type>, --share_type <share_type>, --share-type-id <share_type>, --share_type_id <share_type>``
  Filter results by share type name or ID.
  (Default=None)Available only for microversion >= 2.23

.. _manila_quota-class-show:

manila quota-class-show
-----------------------

.. code-block:: console

   usage: manila quota-class-show <class>

List the quotas for a quota class.

**Positional arguments:**

``<class>``
  Name of quota class to list the quotas for.

.. _manila_quota-class-update:

manila quota-class-update
-------------------------

.. code-block:: console

   usage: manila quota-class-update [--shares <shares>] [--snapshots <snapshots>]
                                    [--gigabytes <gigabytes>]
                                    [--snapshot-gigabytes <snapshot_gigabytes>]
                                    [--share-networks <share-networks>]
                                    <class-name>

Update the quotas for a quota class (Admin only).

**Positional arguments:**

``<class-name>``
  Name of quota class to set the quotas for.

**Optional arguments:**

``--shares <shares>``
  New value for the "shares" quota.

``--snapshots <snapshots>``
  New value for the "snapshots" quota.

``--gigabytes <gigabytes>``
  New value for the "gigabytes" quota.

``--snapshot-gigabytes <snapshot_gigabytes>, --snapshot_gigabytes <snapshot_gigabytes>``
  New value for the "snapshot_gigabytes" quota.

``--share-networks <share-networks>, --share_networks <share-networks>``
  New value for the "share_networks" quota.

.. _manila_quota-defaults:

manila quota-defaults
---------------------

.. code-block:: console

   usage: manila quota-defaults [--tenant <tenant-id>]

List the default quotas for a tenant.

**Optional arguments:**

``--tenant <tenant-id>``
  ID of tenant to list the default quotas for.

.. _manila_quota-delete:

manila quota-delete
-------------------

.. code-block:: console

   usage: manila quota-delete [--tenant <tenant-id>] [--user <user-id>]

Delete quota for a tenant/user. The quota will revert back to default (Admin
only).

**Optional arguments:**

``--tenant <tenant-id>``
  ID of tenant to delete quota for.

``--user <user-id>``
  ID of user to delete quota for.

.. _manila_quota-show:

manila quota-show
-----------------

.. code-block:: console

   usage: manila quota-show [--tenant <tenant-id>] [--user <user-id>] [--detail]

List the quotas for a tenant/user.

**Optional arguments:**

``--tenant <tenant-id>``
  ID of tenant to list the quotas for.

``--user <user-id>``
  ID of user to list the quotas for.

``--detail``
  Optional flag to indicate whether to show quota in
  detail. Default false, available only for microversion
  >= 2.25.

.. _manila_quota-update:

manila quota-update
-------------------

.. code-block:: console

   usage: manila quota-update [--user <user-id>] [--shares <shares>]
                              [--snapshots <snapshots>] [--gigabytes <gigabytes>]
                              [--snapshot-gigabytes <snapshot_gigabytes>]
                              [--share-networks <share-networks>] [--force]
                              <tenant_id>

Update the quotas for a tenant/user (Admin only).

**Positional arguments:**

``<tenant_id>``
  UUID of tenant to set the quotas for.

**Optional arguments:**

``--user <user-id>``
  ID of user to set the quotas for.

``--shares <shares>``
  New value for the "shares" quota.

``--snapshots <snapshots>``
  New value for the "snapshots" quota.

``--gigabytes <gigabytes>``
  New value for the "gigabytes" quota.

``--snapshot-gigabytes <snapshot_gigabytes>, --snapshot_gigabytes <snapshot_gigabytes>``
  New value for the "snapshot_gigabytes" quota.

``--share-networks <share-networks>, --share_networks <share-networks>``
  New value for the "share_networks" quota.

``--force``
  Whether force update the quota even if the already
  used and reserved exceeds the new quota.

.. _manila_rate-limits:

manila rate-limits
------------------

.. code-block:: console

   usage: manila rate-limits [--columns <columns>]

Print a list of rate limits for a user.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "verb,uri,value"

.. _manila_reset-state:

manila reset-state
------------------

.. code-block:: console

   usage: manila reset-state [--state <state>] <share>

Explicitly update the state of a share (Admin only).

**Positional arguments:**

``<share>``
  Name or ID of the share to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the share. Options include
  available, error, creating, deleting, error_deleting. If no
  state is provided, available will be used.

.. _manila_reset-task-state:

manila reset-task-state
-----------------------

.. code-block:: console

   usage: manila reset-task-state [--task-state <task_state>] <share>

Explicitly update the task state of a share (Admin only, Experimental).

**Positional arguments:**

``<share>``
  Name or ID of the share to modify.

**Optional arguments:**

``--task-state <task_state>, --task_state <task_state>, --state <task_state>``
  Indicate which task state to assign the share. Options
  include migration_starting, migration_in_progress,
  migration_completing, migration_success,
  migration_error, migration_cancelled,
  migration_driver_in_progress,
  migration_driver_phase1_done, data_copying_starting,
  data_copying_in_progress, data_copying_completing,
  data_copying_completed, data_copying_cancelled,
  data_copying_error. If no value is provided, None will
  be used.

.. _manila_revert-to-snapshot:

manila revert-to-snapshot
-------------------------

.. code-block:: console

   usage: manila revert-to-snapshot <snapshot>

Revert a share to the specified snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot to restore. The snapshot must be the
  most recent one known to manila.

.. _manila_security-service-create:

manila security-service-create
------------------------------

.. code-block:: console

   usage: manila security-service-create [--dns-ip <dns_ip>] [--server <server>]
                                         [--domain <domain>] [--user <user>]
                                         [--password <password>] [--name <name>]
                                         [--description <description>]
                                         <type>

Create security service used by tenant.

**Positional arguments:**

``<type>``
  Security service type: 'ldap', 'kerberos' or
  'active_directory'.

**Optional arguments:**

``--dns-ip <dns_ip>``
  DNS IP address used inside tenant's network.

``--server <server>``
  Security service IP address or hostname.

``--domain <domain>``
  Security service domain.

``--user <user>``
  Security service user or group used by tenant.

``--password <password>``
  Password used by user.

``--name <name>``
  Security service name.

``--description <description>``
  Security service description.

.. _manila_security-service-delete:

manila security-service-delete
------------------------------

.. code-block:: console

   usage: manila security-service-delete <security-service>
                                         [<security-service> ...]

Delete one or more security services.

**Positional arguments:**

``<security-service>``
  Name or ID of the security service(s) to delete

.. _manila_security-service-list:

manila security-service-list
----------------------------

.. code-block:: console

   usage: manila security-service-list [--all-tenants [<0|1>]]
                                       [--share-network <share_network>]
                                       [--status <status>] [--name <name>]
                                       [--type <type>] [--user <user>]
                                       [--dns-ip <dns_ip>] [--server <server>]
                                       [--domain <domain>] [--detailed [<0|1>]]
                                       [--offset <offset>] [--limit <limit>]
                                       [--columns <columns>]

Get a list of security services.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--share-network <share_network>, --share_network <share_network>``
  Filter results by share network id or name.

``--status <status>``
  Filter results by status.

``--name <name>``
  Filter results by name.

``--type <type>``
  Filter results by type.

``--user <user>``
  Filter results by user or group used by tenant.

``--dns-ip <dns_ip>, --dns_ip <dns_ip>``
  Filter results by DNS IP address used inside tenant's
  network.

``--server <server>``
  Filter results by security service IP address or
  hostname.

``--domain <domain>``
  Filter results by domain.

``--detailed [<0|1>]``
  Show detailed information about filtered security
  services.

``--offset <offset>``
  Start position of security services listing.

``--limit <limit>``
  Number of security services to return per request.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "name,type"

.. _manila_security-service-show:

manila security-service-show
----------------------------

.. code-block:: console

   usage: manila security-service-show <security-service>

Show security service.

**Positional arguments:**

``<security-service>``
  Security service name or ID to show.

.. _manila_security-service-update:

manila security-service-update
------------------------------

.. code-block:: console

   usage: manila security-service-update [--dns-ip <dns-ip>] [--server <server>]
                                         [--domain <domain>] [--user <user>]
                                         [--password <password>] [--name <name>]
                                         [--description <description>]
                                         <security-service>

Update security service.

**Positional arguments:**

``<security-service>``
  Security service name or ID to update.

**Optional arguments:**

``--dns-ip <dns-ip>``
  DNS IP address used inside tenant's network.

``--server <server>``
  Security service IP address or hostname.

``--domain <domain>``
  Security service domain.

``--user <user>``
  Security service user or group used by tenant.

``--password <password>``
  Password used by user.

``--name <name>``
  Security service name.

``--description <description>``
  Security service description.

.. _manila_service-disable:

manila service-disable
----------------------

.. code-block:: console

   usage: manila service-disable <hostname> <binary>

Disables 'manila-share' or 'manila-scheduler' services (Admin only).

**Positional arguments:**

``<hostname>``
  Host name as 'example_host@example_backend'.

``<binary>``
  Service binary, could be 'manila-share' or 'manila-scheduler'.

.. _manila_service-enable:

manila service-enable
---------------------

.. code-block:: console

   usage: manila service-enable <hostname> <binary>

Enables 'manila-share' or 'manila-scheduler' services (Admin only).

**Positional arguments:**

``<hostname>``
  Host name as 'example_host@example_backend'.

``<binary>``
  Service binary, could be 'manila-share' or 'manila-scheduler'.

.. _manila_service-list:

manila service-list
-------------------

.. code-block:: console

   usage: manila service-list [--host <hostname>] [--binary <binary>]
                              [--status <status>] [--state <state>]
                              [--zone <zone>] [--columns <columns>]

List all services (Admin only).

**Optional arguments:**

``--host <hostname>``
  Name of host.

``--binary <binary>``
  Service binary.

``--status <status>``
  Filter results by status.

``--state <state>``
  Filter results by state.

``--zone <zone>``
  Availability zone.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,host"

.. _manila_share-export-location-list:

manila share-export-location-list
---------------------------------

.. code-block:: console

   usage: manila share-export-location-list [--columns <columns>] <share>

List export locations of a given share.

**Positional arguments:**

``<share>``
  Name or ID of the share.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,host,status"

.. _manila_share-export-location-show:

manila share-export-location-show
---------------------------------

.. code-block:: console

   usage: manila share-export-location-show <share> <export_location>

Show export location of the share.

**Positional arguments:**

``<share>``
  Name or ID of the share.

``<export_location>``
  ID of the share export location.

.. _manila_share-group-create:

manila share-group-create
-------------------------

.. code-block:: console

   usage: manila share-group-create [--name <name>] [--description <description>]
                                    [--share-types <share_types>]
                                    [--share-group-type <share_group_type>]
                                    [--share-network <share_network>]
                                    [--source-share-group-snapshot <source_share_group_snapshot>]
                                    [--availability-zone <availability-zone>]

Creates a new share group (Experimental).

**Optional arguments:**

``--name <name>``
  Optional share group name. (Default=None)

``--description <description>``
  Optional share group description. (Default=None)

``--share-types <share_types>, --share_types <share_types>``
  Comma-separated list of share types. (Default=None)

``--share-group-type <share_group_type>, --share_group_type <share_group_type>, --type <share_group_type>``
  Share group type name or ID of the share group to be
  created. (Default=None)

``--share-network <share_network>, --share_network <share_network>``
  Specify share network name or id.

``--source-share-group-snapshot <source_share_group_snapshot>, --source_share_group_snapshot <source_share_group_snapshot>``
  Optional share group snapshot name or ID to create the
  share group from. (Default=None)

``--availability-zone <availability-zone>, --availability_zone <availability-zone>, --az <availability-zone>``
  Optional availability zone in which group should be
  created. (Default=None

.. _manila_share-group-delete:

manila share-group-delete
-------------------------

.. code-block:: console

   usage: manila share-group-delete [--force] <share_group> [<share_group> ...]

Remove one or more share groups (Experimental).

**Positional arguments:**

``<share_group>``
  Name or ID of the share_group(s).

**Optional arguments:**

``--force``
  Attempt to force delete the share group (Default=False)
  (Admin only).

.. _manila_share-group-list:

manila share-group-list
-----------------------

.. code-block:: console

   usage: manila share-group-list [--all-tenants [<0|1>]] [--name <name>]
                                  [--status <status>]
                                  [--share-server-id <share_server_id>]
                                  [--share-group-type <share_group_type>]
                                  [--snapshot <snapshot>] [--host <host>]
                                  [--share-network <share_network>]
                                  [--project-id <project_id>] [--limit <limit>]
                                  [--offset <offset>] [--sort-key <sort_key>]
                                  [--sort-dir <sort_dir>] [--columns <columns>]

List share groups with filters (Experimental).

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--name <name>``
  Filter results by name.

``--status <status>``
  Filter results by status.

``--share-server-id <share_server_id>, --share-server_id <share_server_id>, --share_server-id <share_server_id>, --share_server_id <share_server_id>``
  Filter results by share server ID (Admin only).

``--share-group-type <share_group_type>, --share-group-type-id <share_group_type>, --share_group_type <share_group_type>, --share_group_type_id <share_group_type>``
  Filter results by a share group type ID or name that
  was used for share group creation.

``--snapshot <snapshot>``
  Filter results by share group snapshot name or ID that
  was used to create the share group.

``--host <host>``
  Filter results by host.

``--share-network <share_network>, --share_network <share_network>``
  Filter results by share-network name or ID.

``--project-id <project_id>, --project_id <project_id>``
  Filter results by project ID. Useful with set key
  '--all-tenants'.

``--limit <limit>``
  Maximum number of share groups to return.
  (Default=None)

``--offset <offset>``
  Start position of share group listing.

``--sort-key <sort_key>, --sort_key <sort_key>``
  Key to be sorted, available keys are ('id', 'name',
  'status', 'host', 'user_id', 'project_id',
  'created_at', 'availability_zone', 'share_network',
  'share_network_id', 'share_group_type',
  'share_group_type_id',
  'source_share_group_snapshot_id'). Default=None.

``--sort-dir <sort_dir>, --sort_dir <sort_dir>``
  Sort direction, available values are ('asc', 'desc').
  OPTIONAL: Default=None.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-group-reset-state:

manila share-group-reset-state
------------------------------

.. code-block:: console

   usage: manila share-group-reset-state [--state <state>] <share_group>

Explicitly update the state of a share group (Admin only, Experimental).

**Positional arguments:**

``<share_group>``
  Name or ID of the share group to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the share group. Options
  include available, error, creating, deleting,
  error_deleting. If no state is provided, available will be
  used.

.. _manila_share-group-show:

manila share-group-show
-----------------------

.. code-block:: console

   usage: manila share-group-show <share_group>

Show details about a share group (Experimental).

**Positional arguments:**

``<share_group>``
  Name or ID of the share group.

.. _manila_share-group-snapshot-create:

manila share-group-snapshot-create
----------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-create [--name <name>]
                                             [--description <description>]
                                             <share_group>

Creates a new share group snapshot (Experimental).

**Positional arguments:**

``<share_group>``
  Name or ID of the share group.

**Optional arguments:**

``--name <name>``
  Optional share group snapshot name. (Default=None)

``--description <description>``
  Optional share group snapshot description.
  (Default=None)

.. _manila_share-group-snapshot-delete:

manila share-group-snapshot-delete
----------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-delete [--force]
                                             <share_group_snapshot>
                                             [<share_group_snapshot> ...]

Remove one or more share group snapshots (Experimental).

**Positional arguments:**

``<share_group_snapshot>``
  Name or ID of the share group snapshot(s) to delete.

**Optional arguments:**

``--force``
  Attempt to force delete the share group snapshot(s)
  (Default=False) (Admin only).

.. _manila_share-group-snapshot-list:

manila share-group-snapshot-list
--------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-list [--all-tenants [<0|1>]]
                                           [--name <name>] [--status <status>]
                                           [--share-group-id <share_group_id>]
                                           [--limit <limit>] [--offset <offset>]
                                           [--sort-key <sort_key>]
                                           [--sort-dir <sort_dir>]
                                           [--detailed DETAILED]
                                           [--columns <columns>]

List share group snapshots with filters (Experimental).

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--name <name>``
  Filter results by name.

``--status <status>``
  Filter results by status.

``--share-group-id <share_group_id>, --share_group_id <share_group_id>``
  Filter results by share group ID.

``--limit <limit>``
  Maximum number of share group snapshots to
  return.(Default=None)

``--offset <offset>``
  Start position of share group snapshot listing.

``--sort-key <sort_key>, --sort_key <sort_key>``
  Key to be sorted, available keys are ('id', 'name',
  'status', 'host', 'user_id', 'project_id',
  'created_at', 'share_group_id'). Default=None.

``--sort-dir <sort_dir>, --sort_dir <sort_dir>``
  Sort direction, available values are ('asc', 'desc').
  OPTIONAL: Default=None.

``--detailed DETAILED``
  Show detailed information about share group snapshots.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-group-snapshot-list-members:

manila share-group-snapshot-list-members
----------------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-list-members [--columns <columns>]
                                                   <share_group_snapshot>

List members of a share group snapshot (Experimental).

**Positional arguments:**

``<share_group_snapshot>``
  Name or ID of the share group snapshot.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-group-snapshot-reset-state:

manila share-group-snapshot-reset-state
---------------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-reset-state [--state <state>]
                                                  <share_group_snapshot>

Explicitly update the state of a share group snapshot (Admin only,
Experimental).

**Positional arguments:**

``<share_group_snapshot>``
  Name or ID of the share group snapshot.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the share group
  snapshot. Options include available, error, creating,
  deleting, error_deleting. If no state is provided,
  available will be used.

.. _manila_share-group-snapshot-show:

manila share-group-snapshot-show
--------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-show <share_group_snapshot>

Show details about a share group snapshot (Experimental).

**Positional arguments:**

``<share_group_snapshot>``
  Name or ID of the share group snapshot.

.. _manila_share-group-snapshot-update:

manila share-group-snapshot-update
----------------------------------

.. code-block:: console

   usage: manila share-group-snapshot-update [--name <name>]
                                             [--description <description>]
                                             <share_group_snapshot>

Update a share group snapshot (Experimental).

**Positional arguments:**

``<share_group_snapshot>``
  Name or ID of the share group snapshot to update.

**Optional arguments:**

``--name <name>``
  Optional new name for the share group snapshot.
  (Default=None

``--description <description>``
  Optional share group snapshot description.
  (Default=None)

.. _manila_share-group-type-access-add:

manila share-group-type-access-add
----------------------------------

.. code-block:: console

   usage: manila share-group-type-access-add <share_group_type> <project_id>

Adds share group type access for the given project (Admin only).

**Positional arguments:**

``<share_group_type>``
  Share group type name or ID to add access for the given
  project.

``<project_id>``
  Project ID to add share group type access for.

.. _manila_share-group-type-access-list:

manila share-group-type-access-list
-----------------------------------

.. code-block:: console

   usage: manila share-group-type-access-list <share_group_type>

Print access information about a share group type (Admin only).

**Positional arguments:**

``<share_group_type>``
  Filter results by share group type name or ID.

.. _manila_share-group-type-access-remove:

manila share-group-type-access-remove
-------------------------------------

.. code-block:: console

   usage: manila share-group-type-access-remove <share_group_type> <project_id>

Removes share group type access for the given project (Admin only).

**Positional arguments:**

``<share_group_type>``
  Share group type name or ID to remove access for the
  given project.

``<project_id>``
  Project ID to remove share group type access for.

.. _manila_share-group-type-create:

manila share-group-type-create
------------------------------

.. code-block:: console

   usage: manila share-group-type-create [--is_public <is_public>]
                                         <name> <share_types>

Create a new share group type (Admin only).

**Positional arguments:**

``<name>``
  Name of the new share group type.

``<share_types>``
  Comma-separated list of share type names or IDs.

**Optional arguments:**

``--is_public <is_public>, --is-public <is_public>``
  Make type accessible to the public (default true).

.. _manila_share-group-type-delete:

manila share-group-type-delete
------------------------------

.. code-block:: console

   usage: manila share-group-type-delete <id>

Delete a specific share group type (Admin only).

**Positional arguments:**

``<id>``
  Name or ID of the share group type to delete.

.. _manila_share-group-type-key:

manila share-group-type-key
---------------------------

.. code-block:: console

   usage: manila share-group-type-key <share_group_type> <action>
                                      [<key=value> [<key=value> ...]]

Set or unset group_spec for a share group type (Admin only).

**Positional arguments:**

``<share_group_type>``
  Name or ID of the share group type.

``<action>``
  Actions: 'set' or 'unset'.

``<key=value>``
  Group specs to set or unset (key is only necessary on
  unset).

.. _manila_share-group-type-list:

manila share-group-type-list
----------------------------

.. code-block:: console

   usage: manila share-group-type-list [--all] [--columns <columns>]

Print a list of available 'share group types'.

**Optional arguments:**

``--all``
  Display all share group types (Admin only).

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-group-type-specs-list:

manila share-group-type-specs-list
----------------------------------

.. code-block:: console

   usage: manila share-group-type-specs-list [--columns <columns>]

Print a list of 'share group types specs' (Admin Only).

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-group-update:

manila share-group-update
-------------------------

.. code-block:: console

   usage: manila share-group-update [--name <name>] [--description <description>]
                                    <share_group>

Update a share group (Experimental).

**Positional arguments:**

``<share_group>``
  Name or ID of the share group to update.

**Optional arguments:**

``--name <name>``
  Optional new name for the share group. (Default=None)

``--description <description>``
  Optional share group description. (Default=None)

.. _manila_share-instance-export-location-list:

manila share-instance-export-location-list
------------------------------------------

.. code-block:: console

   usage: manila share-instance-export-location-list [--columns <columns>]
                                                     <instance>

List export locations of a given share instance.

**Positional arguments:**

``<instance>``
  Name or ID of the share instance.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,host,status"

.. _manila_share-instance-export-location-show:

manila share-instance-export-location-show
------------------------------------------

.. code-block:: console

   usage: manila share-instance-export-location-show <instance> <export_location>

Show export location for the share instance.

**Positional arguments:**

``<instance>``
  Name or ID of the share instance.

``<export_location>``
  ID of the share instance export location.

.. _manila_share-instance-force-delete:

manila share-instance-force-delete
----------------------------------

.. code-block:: console

   usage: manila share-instance-force-delete <instance> [<instance> ...]

Force-delete the share instance, regardless of state (Admin only).

**Positional arguments:**

``<instance>``
  Name or ID of the instance(s) to force delete.

.. _manila_share-instance-list:

manila share-instance-list
--------------------------

.. code-block:: console

   usage: manila share-instance-list [--share-id <share_id>]
                                     [--columns <columns>]

List share instances (Admin only).

**Optional arguments:**

``--share-id <share_id>, --share_id <share_id>``
  Filter results by share ID.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,host,status"

.. _manila_share-instance-reset-state:

manila share-instance-reset-state
---------------------------------

.. code-block:: console

   usage: manila share-instance-reset-state [--state <state>] <instance>

Explicitly update the state of a share instance (Admin only).

**Positional arguments:**

``<instance>``
  Name or ID of the share instance to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the instance. Options
  include available, error, creating, deleting,
  error_deleting, migrating,migrating_to. If no state is
  provided, available will be used.

.. _manila_share-instance-show:

manila share-instance-show
--------------------------

.. code-block:: console

   usage: manila share-instance-show <instance>

Show details about a share instance (Admin only).

**Positional arguments:**

``<instance>``
  Name or ID of the share instance.

.. _manila_share-network-create:

manila share-network-create
---------------------------

.. code-block:: console

   usage: manila share-network-create [--neutron-net-id <neutron-net-id>]
                                      [--neutron-subnet-id <neutron-subnet-id>]
                                      [--name <name>]
                                      [--description <description>]

Create description for network used by the tenant.

**Optional arguments:**

``--neutron-net-id <neutron-net-id>, --neutron-net_id <neutron-net-id>, --neutron_net_id <neutron-net-id>, --neutron_net-id <neutron-net-id>``
  Neutron network ID. Used to set up network for share
  servers.

``--neutron-subnet-id <neutron-subnet-id>, --neutron-subnet_id <neutron-subnet-id>, --neutron_subnet_id <neutron-subnet-id>, --neutron_subnet-id <neutron-subnet-id>``
  Neutron subnet ID. Used to set up network for share
  servers. This subnet should belong to specified
  neutron network.

``--name <name>``
  Share network name.

``--description <description>``
  Share network description.

.. _manila_share-network-delete:

manila share-network-delete
---------------------------

.. code-block:: console

   usage: manila share-network-delete <share-network> [<share-network> ...]

Delete one or more share networks.

**Positional arguments:**

``<share-network>``
  Name or ID of share network(s) to be deleted.

.. _manila_share-network-list:

manila share-network-list
-------------------------

.. code-block:: console

   usage: manila share-network-list [--all-tenants [<0|1>]]
                                    [--project-id <project_id>] [--name <name>]
                                    [--created-since <created_since>]
                                    [--created-before <created_before>]
                                    [--security-service <security_service>]
                                    [--neutron-net-id <neutron_net_id>]
                                    [--neutron-subnet-id <neutron_subnet_id>]
                                    [--network-type <network_type>]
                                    [--segmentation-id <segmentation_id>]
                                    [--cidr <cidr>] [--ip-version <ip_version>]
                                    [--offset <offset>] [--limit <limit>]
                                    [--columns <columns>]

Get a list of network info.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--project-id <project_id>, --project_id <project_id>``
  Filter results by project ID.

``--name <name>``
  Filter results by name.

``--created-since <created_since>, --created_since <created_since>``
  Return only share networks created since given date.
  The date is in the format 'yyyy-mm-dd'.

``--created-before <created_before>, --created_before <created_before>``
  Return only share networks created until given date.
  The date is in the format 'yyyy-mm-dd'.

``--security-service <security_service>, --security_service <security_service>``
  Filter results by attached security service.

``--neutron-net-id <neutron_net_id>, --neutron_net_id <neutron_net_id>, --neutron_net-id <neutron_net_id>, --neutron-net_id <neutron_net_id>``
  Filter results by neutron net ID.

``--neutron-subnet-id <neutron_subnet_id>, --neutron_subnet_id <neutron_subnet_id>, --neutron-subnet_id <neutron_subnet_id>, --neutron_subnet-id <neutron_subnet_id>``
  Filter results by neutron subnet ID.

``--network-type <network_type>, --network_type <network_type>``
  Filter results by network type.

``--segmentation-id <segmentation_id>, --segmentation_id <segmentation_id>``
  Filter results by segmentation ID.

``--cidr <cidr>``
  Filter results by CIDR.

``--ip-version <ip_version>, --ip_version <ip_version>``
  Filter results by IP version.

``--offset <offset>``
  Start position of share networks listing.

``--limit <limit>``
  Number of share networks to return per request.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id"

.. _manila_share-network-security-service-add:

manila share-network-security-service-add
-----------------------------------------

.. code-block:: console

   usage: manila share-network-security-service-add <share-network>
                                                    <security-service>

Associate security service with share network.

**Positional arguments:**

``<share-network>``
  Share network name or ID.

``<security-service>``
  Security service name or ID to associate with.

.. _manila_share-network-security-service-list:

manila share-network-security-service-list
------------------------------------------

.. code-block:: console

   usage: manila share-network-security-service-list [--columns <columns>]
                                                     <share-network>

Get list of security services associated with a given share network.

**Positional arguments:**

``<share-network>``
  Share network name or ID.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_share-network-security-service-remove:

manila share-network-security-service-remove
--------------------------------------------

.. code-block:: console

   usage: manila share-network-security-service-remove <share-network>
                                                       <security-service>

Dissociate security service from share network.

**Positional arguments:**

``<share-network>``
  Share network name or ID.

``<security-service>``
  Security service name or ID to dissociate.

.. _manila_share-network-show:

manila share-network-show
-------------------------

.. code-block:: console

   usage: manila share-network-show <share-network>

Get a description for network used by the tenant.

**Positional arguments:**

``<share-network>``
  Name or ID of the share network to show.

.. _manila_share-network-update:

manila share-network-update
---------------------------

.. code-block:: console

   usage: manila share-network-update [--neutron-net-id <neutron-net-id>]
                                      [--neutron-subnet-id <neutron-subnet-id>]
                                      [--name <name>]
                                      [--description <description>]
                                      <share-network>

Update share network data.

**Positional arguments:**

``<share-network>``
  Name or ID of share network to update.

**Optional arguments:**

``--neutron-net-id <neutron-net-id>, --neutron-net_id <neutron-net-id>, --neutron_net_id <neutron-net-id>, --neutron_net-id <neutron-net-id>``
  Neutron network ID. Used to set up network for share
  servers. This option is deprecated and will be
  rejected in newer releases of OpenStack Manila.

``--neutron-subnet-id <neutron-subnet-id>, --neutron-subnet_id <neutron-subnet-id>, --neutron_subnet_id <neutron-subnet-id>, --neutron_subnet-id <neutron-subnet-id>``
  Neutron subnet ID. Used to set up network for share
  servers. This subnet should belong to specified
  neutron network.

``--name <name>``
  Share network name.

``--description <description>``
  Share network description.

.. _manila_share-replica-create:

manila share-replica-create
---------------------------

.. code-block:: console

   usage: manila share-replica-create [--availability-zone <availability-zone>]
                                      [--share-network <network-info>]
                                      <share>

Create a share replica (Experimental).

**Positional arguments:**

``<share>``
  Name or ID of the share to replicate.

**Optional arguments:**

``--availability-zone <availability-zone>, --availability_zone <availability-zone>, --az <availability-zone>``
  Optional Availability zone in which replica should be
  created.

``--share-network <network-info>, --share_network <network-info>``
  Optional network info ID or name.

.. _manila_share-replica-delete:

manila share-replica-delete
---------------------------

.. code-block:: console

   usage: manila share-replica-delete [--force] <replica> [<replica> ...]

Remove one or more share replicas (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica.

**Optional arguments:**

``--force``
  Attempt to force deletion of a replica on its backend. Using this
  option will purge the replica from Manila even if it is not
  cleaned up on the backend. Defaults to False.

.. _manila_share-replica-list:

manila share-replica-list
-------------------------

.. code-block:: console

   usage: manila share-replica-list [--share-id <share_id>] [--columns <columns>]

List share replicas (Experimental).

**Optional arguments:**

``--share-id <share_id>, --share_id <share_id>, --si <share_id>``
  List replicas belonging to share.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "replica_state,id"

.. _manila_share-replica-promote:

manila share-replica-promote
----------------------------

.. code-block:: console

   usage: manila share-replica-promote <replica>

Promote specified replica to 'active' replica_state (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica.

.. _manila_share-replica-reset-replica-state:

manila share-replica-reset-replica-state
----------------------------------------

.. code-block:: console

   usage: manila share-replica-reset-replica-state
                                                   [--replica-state <replica_state>]
                                                   <replica>

Explicitly update the 'replica_state' of a share replica (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica to modify.

**Optional arguments:**

``--replica-state <replica_state>, --replica_state <replica_state>, --state <replica_state>``
  Indicate which replica_state to assign the replica.
  Options include in_sync, out_of_sync, active, error.
  If no state is provided, out_of_sync will be used.

.. _manila_share-replica-reset-state:

manila share-replica-reset-state
--------------------------------

.. code-block:: console

   usage: manila share-replica-reset-state [--state <state>] <replica>

Explicitly update the 'status' of a share replica (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the replica. Options include
  available, error, creating, deleting, error_deleting. If no
  state is provided, available will be used.

.. _manila_share-replica-resync:

manila share-replica-resync
---------------------------

.. code-block:: console

   usage: manila share-replica-resync <replica>

Attempt to update the share replica with its 'active' mirror (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica to resync.

.. _manila_share-replica-show:

manila share-replica-show
-------------------------

.. code-block:: console

   usage: manila share-replica-show <replica>

Show details about a replica (Experimental).

**Positional arguments:**

``<replica>``
  ID of the share replica.

.. _manila_share-server-delete:

manila share-server-delete
--------------------------

.. code-block:: console

   usage: manila share-server-delete <id> [<id> ...]

Delete one or more share servers (Admin only).

**Positional arguments:**

``<id>``
  ID of the share server(s) to delete.

.. _manila_share-server-details:

manila share-server-details
---------------------------

.. code-block:: console

   usage: manila share-server-details <id>

Show share server details (Admin only).

**Positional arguments:**

``<id>``
  ID of share server.

.. _manila_share-server-list:

manila share-server-list
------------------------

.. code-block:: console

   usage: manila share-server-list [--host <hostname>] [--status <status>]
                                   [--share-network <share_network>]
                                   [--project-id <project_id>]
                                   [--columns <columns>]

List all share servers (Admin only).

**Optional arguments:**

``--host <hostname>``
  Filter results by name of host.

``--status <status>``
  Filter results by status.

``--share-network <share_network>``
  Filter results by share network.

``--project-id <project_id>``
  Filter results by project ID.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,host,status"

.. _manila_share-server-show:

manila share-server-show
------------------------

.. code-block:: console

   usage: manila share-server-show <id>

Show share server info (Admin only).

**Positional arguments:**

``<id>``
  ID of share server.

.. _manila_show:

manila show
-----------

.. code-block:: console

   usage: manila show <share>

Show details about a NAS share.

**Positional arguments:**

``<share>``
  Name or ID of the NAS share.

.. _manila_shrink:

manila shrink
-------------

.. code-block:: console

   usage: manila shrink <share> <new_size>

Decreases the size of an existing share.

**Positional arguments:**

``<share>``
  Name or ID of share to shrink.

``<new_size>``
  New size of share, in GiBs.

.. _manila_snapshot-access-allow:

manila snapshot-access-allow
----------------------------

.. code-block:: console

   usage: manila snapshot-access-allow <snapshot> <access_type> <access_to>

Allow read only access to a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the share snapshot to allow access to.

``<access_type>``
  Access rule type (only "ip", "user"(user or group), "cert" or
  "cephx" are supported).

``<access_to>``
  Value that defines access.

.. _manila_snapshot-access-deny:

manila snapshot-access-deny
---------------------------

.. code-block:: console

   usage: manila snapshot-access-deny <snapshot> <id> [<id> ...]

Deny access to a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the share snapshot to deny access to.

``<id>``
  ID(s) of the access rule(s) to be deleted.

.. _manila_snapshot-access-list:

manila snapshot-access-list
---------------------------

.. code-block:: console

   usage: manila snapshot-access-list [--columns <columns>] <snapshot>

Show access list for a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the share snapshot to list access of.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "access_type,access_to"

.. _manila_snapshot-create:

manila snapshot-create
----------------------

.. code-block:: console

   usage: manila snapshot-create [--force <True|False>] [--name <name>]
                                 [--description <description>]
                                 <share>

Add a new snapshot.

**Positional arguments:**

``<share>``
  Name or ID of the share to snapshot.

**Optional arguments:**

``--force <True|False>``
  Optional flag to indicate whether to snapshot a share
  even if it's busy. (Default=False)

``--name <name>``
  Optional snapshot name. (Default=None)

``--description <description>``
  Optional snapshot description. (Default=None)

.. _manila_snapshot-delete:

manila snapshot-delete
----------------------

.. code-block:: console

   usage: manila snapshot-delete <snapshot> [<snapshot> ...]

Remove one or more snapshots.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot(s) to delete.

.. _manila_snapshot-export-location-list:

manila snapshot-export-location-list
------------------------------------

.. code-block:: console

   usage: manila snapshot-export-location-list [--columns <columns>] <snapshot>

List export locations of a given snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,path"

.. _manila_snapshot-export-location-show:

manila snapshot-export-location-show
------------------------------------

.. code-block:: console

   usage: manila snapshot-export-location-show <snapshot> <export_location>

Show export location of the share snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot.

``<export_location>``
  ID of the share snapshot export location.

.. _manila_snapshot-force-delete:

manila snapshot-force-delete
----------------------------

.. code-block:: console

   usage: manila snapshot-force-delete <snapshot> [<snapshot> ...]

Attempt force-deletion of one or more snapshots. Regardless of the state
(Admin only).

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot(s) to force delete.

.. _manila_snapshot-instance-export-location-list:

manila snapshot-instance-export-location-list
---------------------------------------------

.. code-block:: console

   usage: manila snapshot-instance-export-location-list [--columns <columns>]
                                                        <instance>

List export locations of a given snapshot instance.

**Positional arguments:**

``<instance>``
  Name or ID of the snapshot instance.

**Optional arguments:**

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,path,is_admin_only"

.. _manila_snapshot-instance-export-location-show:

manila snapshot-instance-export-location-show
---------------------------------------------

.. code-block:: console

   usage: manila snapshot-instance-export-location-show <snapshot_instance>
                                                        <export_location>

Show export location of the share instance snapshot.

**Positional arguments:**

``<snapshot_instance>``
  ID of the share snapshot instance.

``<export_location>``
  ID of the share snapshot instance export location.

.. _manila_snapshot-instance-list:

manila snapshot-instance-list
-----------------------------

.. code-block:: console

   usage: manila snapshot-instance-list [--snapshot <snapshot>]
                                        [--columns <columns>]
                                        [--detailed <detailed>]

List share snapshot instances.

**Optional arguments:**

``--snapshot <snapshot>``
  Filter results by share snapshot ID.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id"

``--detailed <detailed>``
  Show detailed information about snapshot instances.
  (Default=False)

.. _manila_snapshot-instance-reset-state:

manila snapshot-instance-reset-state
------------------------------------

.. code-block:: console

   usage: manila snapshot-instance-reset-state [--state <state>]
                                               <snapshot_instance>

Explicitly update the state of a share snapshot instance.

**Positional arguments:**

``<snapshot_instance>``
  ID of the snapshot instance to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the snapshot instance.
  Options include available, error, creating, deleting,
  error_deleting. If no state is provided, available will
  be used.

.. _manila_snapshot-instance-show:

manila snapshot-instance-show
-----------------------------

.. code-block:: console

   usage: manila snapshot-instance-show <snapshot_instance>

Show details about a share snapshot instance.

**Positional arguments:**

``<snapshot_instance>``
  ID of the share snapshot instance.

.. _manila_snapshot-list:

manila snapshot-list
--------------------

.. code-block:: console

   usage: manila snapshot-list [--all-tenants [<0|1>]] [--name <name>]
                               [--status <status>] [--share-id <share_id>]
                               [--usage [any|used|unused]] [--limit <limit>]
                               [--offset <offset>] [--sort-key <sort_key>]
                               [--sort-dir <sort_dir>] [--columns <columns>]

List all the snapshots.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Display information from all tenants (Admin only).

``--name <name>``
  Filter results by name.

``--status <status>``
  Filter results by status.

``--share-id <share_id>, --share_id <share_id>``
  Filter results by source share ID.

``--usage [any|used|unused]``
  Either filter or not snapshots by its usage. OPTIONAL:
  Default=any.

``--limit <limit>``
  Maximum number of share snapshots to return. OPTIONAL:
  Default=None.

``--offset <offset>``
  Set offset to define start point of share snapshots
  listing. OPTIONAL: Default=None.

``--sort-key <sort_key>, --sort_key <sort_key>``
  Key to be sorted, available keys are ('id', 'status',
  'size', 'share_id', 'user_id', 'project_id',
  'progress', 'name', 'display_name'). Default=None.

``--sort-dir <sort_dir>, --sort_dir <sort_dir>``
  Sort direction, available values are ('asc', 'desc').
  OPTIONAL: Default=None.

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_snapshot-manage:

manila snapshot-manage
----------------------

.. code-block:: console

   usage: manila snapshot-manage [--name <name>] [--description <description>]
                                 [--driver_options [<key=value> [<key=value> ...]]]
                                 <share> <provider_location>

Manage share snapshot not handled by Manila (Admin only).

**Positional arguments:**

``<share>``
  Name or ID of the share.

``<provider_location>``
  Provider location of the snapshot on the backend.

**Optional arguments:**

``--name <name>``
  Optional snapshot name (Default=None).

``--description <description>``
  Optional snapshot description (Default=None).

``--driver_options [<key=value> [<key=value> ...]], --driver-options [<key=value> [<key=value> ...]]``
  Optional driver options as key=value pairs
  (Default=None).

.. _manila_snapshot-rename:

manila snapshot-rename
----------------------

.. code-block:: console

   usage: manila snapshot-rename [--description <description>]
                                 <snapshot> [<name>]

Rename a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot to rename.

``<name>``
  New name for the snapshot.

**Optional arguments:**

``--description <description>``
  Optional snapshot description. (Default=None)

.. _manila_snapshot-reset-state:

manila snapshot-reset-state
---------------------------

.. code-block:: console

   usage: manila snapshot-reset-state [--state <state>] <snapshot>

Explicitly update the state of a snapshot (Admin only).

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot to modify.

**Optional arguments:**

``--state <state>``
  Indicate which state to assign the snapshot. Options
  include available, error, creating, deleting,
  error_deleting. If no state is provided, available will be
  used.

.. _manila_snapshot-show:

manila snapshot-show
--------------------

.. code-block:: console

   usage: manila snapshot-show <snapshot>

Show details about a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot.

.. _manila_snapshot-unmanage:

manila snapshot-unmanage
------------------------

.. code-block:: console

   usage: manila snapshot-unmanage <snapshot> [<snapshot> ...]

Unmanage one or more share snapshots (Admin only).

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot(s).

.. _manila_type-access-add:

manila type-access-add
----------------------

.. code-block:: console

   usage: manila type-access-add <share_type> <project_id>

Adds share type access for the given project (Admin only).

**Positional arguments:**

``<share_type>``
  Share type name or ID to add access for the given project.

``<project_id>``
  Project ID to add share type access for.

.. _manila_type-access-list:

manila type-access-list
-----------------------

.. code-block:: console

   usage: manila type-access-list <share_type>

Print access information about the given share type (Admin only).

**Positional arguments:**

``<share_type>``
  Filter results by share type name or ID.

.. _manila_type-access-remove:

manila type-access-remove
-------------------------

.. code-block:: console

   usage: manila type-access-remove <share_type> <project_id>

Removes share type access for the given project (Admin only).

**Positional arguments:**

``<share_type>``
  Share type name or ID to remove access for the given project.

``<project_id>``
  Project ID to remove share type access for.

.. _manila_type-create:

manila type-create
------------------

.. code-block:: console

   usage: manila type-create [--snapshot_support <snapshot_support>]
                             [--create_share_from_snapshot_support <create_share_from_snapshot_support>]
                             [--revert_to_snapshot_support <revert_to_snapshot_support>]
                             [--mount_snapshot_support <mount_snapshot_support>]
                             [--extra-specs [<key=value> [<key=value> ...]]]
                             [--is_public <is_public>]
                             <name> <spec_driver_handles_share_servers>

Create a new share type (Admin only).

**Positional arguments:**

``<name>``
  Name of the new share type.

``<spec_driver_handles_share_servers>``
  Required extra specification. Valid values are
  'true'/'1' and 'false'/'0'

**Optional arguments:**

``--snapshot_support <snapshot_support>, --snapshot-support <snapshot_support>``
  Boolean extra spec used for filtering of back ends by
  their capability to create share snapshots.

``--create_share_from_snapshot_support <create_share_from_snapshot_support>, --create-share-from-snapshot-support <create_share_from_snapshot_support>``
  Boolean extra spec used for filtering of back ends by
  their capability to create shares from snapshots.

``--revert_to_snapshot_support <revert_to_snapshot_support>, --revert-to-snapshot-support <revert_to_snapshot_support>``
  Boolean extra spec used for filtering of back ends by
  their capability to revert shares to snapshots.
  (Default is False).

``--mount_snapshot_support <mount_snapshot_support>, --mount-snapshot-support <mount_snapshot_support>``
  Boolean extra spec used for filtering of back ends by
  their capability to mount share snapshots. (Default is
  False).

``--extra-specs [<key=value> [<key=value> ...]], --extra_specs [<key=value> [<key=value> ...]]``
  Extra specs key and value of share type that will be
  used for share type creation. OPTIONAL: Default=None.
  e.g --extra-specs thin_provisioning='<is> True',
  replication_type=readable.

``--is_public <is_public>, --is-public <is_public>``
  Make type accessible to the public (default true).

.. _manila_type-delete:

manila type-delete
------------------

.. code-block:: console

   usage: manila type-delete <id> [<id> ...]

Delete one or more specific share types (Admin only).

**Positional arguments:**

``<id>``
  Name or ID of the share type(s) to delete.

.. _manila_type-key:

manila type-key
---------------

.. code-block:: console

   usage: manila type-key <stype> <action> [<key=value> [<key=value> ...]]

Set or unset extra_spec for a share type (Admin only).

**Positional arguments:**

``<stype>``
  Name or ID of the share type.

``<action>``
  Actions: 'set' or 'unset'.

``<key=value>``
  Extra_specs to set or unset (key is only necessary on unset).

.. _manila_type-list:

manila type-list
----------------

.. code-block:: console

   usage: manila type-list [--all] [--columns <columns>]

Print a list of available 'share types'.

**Optional arguments:**

``--all``
  Display all share types (Admin only).

``--columns <columns>``
  Comma separated list of columns to be displayed e.g.
  --columns "id,name"

.. _manila_unmanage:

manila unmanage
---------------

.. code-block:: console

   usage: manila unmanage <share>

Unmanage share (Admin only).

**Positional arguments:**

``<share>``
  Name or ID of the share(s).

.. _manila_update:

manila update
-------------

.. code-block:: console

   usage: manila update [--name <name>] [--description <description>]
                        [--is-public <is_public>]
                        <share>

Rename a share.

**Positional arguments:**

``<share>``
  Name or ID of the share to rename.

**Optional arguments:**

``--name <name>``
  New name for the share.

``--description <description>``
  Optional share description. (Default=None)

``--is-public <is_public>, --is_public <is_public>``
  Public share is visible for all tenants.

