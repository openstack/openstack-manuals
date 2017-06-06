.. ###################################################
.. ##  WARNING  ######################################
.. ##############  WARNING  ##########################
.. ##########################  WARNING  ##############
.. ######################################  WARNING  ##
.. ###################################################
.. ###################################################
.. ##
.. This file is tool-generated. Do not edit manually.
.. http://docs.openstack.org/contributor-guide/
.. doc-tools/cli-reference.html
..                                                  ##
.. ##  WARNING  ######################################
.. ##############  WARNING  ##########################
.. ##########################  WARNING  ##############
.. ######################################  WARNING  ##
.. ###################################################

==================================================
Block Storage service (cinder) command-line client
==================================================

The cinder client is the command-line interface (CLI) for
the Block Storage service (cinder) API and its extensions.

This chapter documents :command:`cinder` version ``2.2.0``.

For help on a specific :command:`cinder` command, enter:

.. code-block:: console

   $ cinder help COMMAND

.. _cinder_command_usage:

cinder usage
~~~~~~~~~~~~

.. code-block:: console

   usage: cinder [--version] [-d] [--os-auth-system <os-auth-system>]
                 [--os-auth-type <os-auth-type>] [--service-type <service-type>]
                 [--service-name <service-name>]
                 [--volume-service-name <volume-service-name>]
                 [--os-endpoint-type <os-endpoint-type>]
                 [--endpoint-type <endpoint-type>]
                 [--os-volume-api-version <volume-api-ver>]
                 [--bypass-url <bypass-url>] [--os-endpoint <os-endpoint>]
                 [--retries <retries>] [--profile HMAC_KEY]
                 [--os-auth-strategy <auth-strategy>]
                 [--os-username <auth-user-name>] [--os-password <auth-password>]
                 [--os-tenant-name <auth-tenant-name>]
                 [--os-tenant-id <auth-tenant-id>] [--os-auth-url <auth-url>]
                 [--os-user-id <auth-user-id>]
                 [--os-user-domain-id <auth-user-domain-id>]
                 [--os-user-domain-name <auth-user-domain-name>]
                 [--os-project-id <auth-project-id>]
                 [--os-project-name <auth-project-name>]
                 [--os-project-domain-id <auth-project-domain-id>]
                 [--os-project-domain-name <auth-project-domain-name>]
                 [--os-region-name <region-name>] [--os-token <token>]
                 [--os-url <url>] [--insecure] [--os-cacert <ca-certificate>]
                 [--os-cert <certificate>] [--os-key <key>] [--timeout <seconds>]
                 <subcommand> ...

**Subcommands:**

``absolute-limits``
  Lists absolute limits for a user.

``api-version``
  Display the server API version information. (Supported
  by
  API
  versions
  3.0
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``attachment-create``
  Create an attachment for a cinder volume. (Supported
  by
  API
  versions
  3.27
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``attachment-delete``
  Delete an attachment for a cinder volume. (Supported
  by
  API
  versions
  3.27
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``attachment-list``
  Lists all attachments. (Supported by API versions 3.27
  - 3.latest) [hint: use '--os-volume-api-version' flag
  to show help message for proper version]

``attachment-show``
  Show detailed information for attachment. (Supported
  by
  API
  versions
  3.27
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``attachment-update``
  Update an attachment for a cinder volume. (Supported
  by
  API
  versions
  3.27
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``availability-zone-list``
  Lists all availability zones.

``backup-create``
  Creates a volume backup.

``backup-delete``
  Removes one or more backups.

``backup-export``
  Export backup metadata record.

``backup-import``
  Import backup metadata record.

``backup-list``
  Lists all backups.

``backup-reset-state``
  Explicitly updates the backup state.

``backup-restore``
  Restores a backup.

``backup-show``
  Shows backup details.

``backup-update``
  Renames
  a
  backup.
  (Supported
  by
  API
  versions
  3.9
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``cgsnapshot-create``
  Creates a cgsnapshot.

``cgsnapshot-delete``
  Removes one or more cgsnapshots.

``cgsnapshot-list``
  Lists all cgsnapshots.

``cgsnapshot-show``
  Shows cgsnapshot details.

``cluster-disable``
  Disables clustered services. (Supported by API
  versions
  3.7
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``cluster-enable``
  Enables clustered services. (Supported by API versions
  3.7 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``cluster-list``
  Lists clustered services with optional filtering.
  (Supported by API versions 3.7 - 3.latest) [hint: use
  '--os-volume-api-version' flag to show help message
  for proper version]

``cluster-show``
  Show detailed information on a clustered service.
  (Supported by API versions 3.7 - 3.latest) [hint: use
  '--os-volume-api-version' flag to show help message
  for proper version]

``consisgroup-create``
  Creates a consistency group.

``consisgroup-create-from-src``
  Creates a consistency group from a cgsnapshot or a
  source CG.

``consisgroup-delete``
  Removes one or more consistency groups.

``consisgroup-list``
  Lists all consistency groups.

``consisgroup-show``
  Shows details of a consistency group.

``consisgroup-update``
  Updates a consistency group.

``create``
  Creates a volume.

``credentials``
  Shows user credentials returned from auth.

``delete``
  Removes one or more volumes.

``encryption-type-create``
  Creates encryption type for a volume type. Admin only.

``encryption-type-delete``
  Deletes encryption type for a volume type. Admin only.

``encryption-type-list``
  Shows encryption type details for volume types. Admin
  only.

``encryption-type-show``
  Shows encryption type details for a volume type. Admin
  only.

``encryption-type-update``
  Update encryption type information for a volume type
  (Admin Only).

``endpoints``
  Discovers endpoints registered by authentication
  service.

``extend``
  Attempts to extend size of an existing volume.

``extra-specs-list``
  Lists current volume types and extra specs.

``failover-host``
  Failover a replicating cinder-volume host.

``force-delete``
  Attempts force-delete of volume, regardless of state.

``freeze-host``
  Freeze and disable the specified cinder-volume host.

``get-capabilities``
  Show backend volume stats and properties. Admin only.

``get-pools``
  Show pool information for backends. Admin only.

``group-create``
  Creates
  a
  group.
  (Supported
  by
  API
  versions
  3.13
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``group-create-from-src``
  Creates a group from a group snapshot or a source
  group. (Supported by API versions 3.14 - 3.latest)
  [hint: use '--os-volume-api-version' flag to show help
  message for proper version]

``group-delete``
  Removes one or more groups. (Supported by API versions
  3.13 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``group-list``
  Lists
  all
  groups.
  (Supported
  by
  API
  versions
  3.13
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``group-show``
  Shows details of a group. (Supported by API versions
  3.13 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``group-snapshot-create``
  Creates a group snapshot. (Supported by API versions
  3.14 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``group-snapshot-delete``
  Removes one or more group snapshots. (Supported by API
  versions
  3.14
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``group-snapshot-list``
  Lists all group snapshots. (Supported by API versions
  3.14 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``group-snapshot-show``
  Shows group snapshot details. (Supported by API
  versions
  3.14
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``group-specs-list``
  Lists current group types and specs. (Supported by API
  versions
  3.11
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``group-type-create``
  Creates a group type. (Supported by API versions 3.11
  - 3.latest) [hint: use '--os-volume-api-version' flag
  to show help message for proper version]

``group-type-default``
  List the default group type. (Supported by API
  versions
  3.11
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``group-type-delete``
  Deletes group type or types. (Supported by API
  versions
  3.11
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``group-type-key``
  Sets or unsets group_spec for a group type. (Supported
  by
  API
  versions
  3.11
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper version]

``group-type-list``
  Lists available 'group types'. (Admin only will see
  private
  types)
  (Supported
  by
  API
  versions
  3.11
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``group-type-show``
  Show group type details. (Supported by API versions
  3.11 - 3.latest) [hint: use '--os-volume-api-version'
  flag to show help message for proper version]

``group-type-update``
  Updates group type name, description, and/or
  is_public. (Supported by API versions 3.11 - 3.latest)
  [hint: use '--os-volume-api-version' flag to show help
  message for proper version]

``group-update``
  Updates
  a
  group.
  (Supported
  by
  API
  versions
  3.13
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``image-metadata``
  Sets or deletes volume image metadata.

``image-metadata-show``
  Shows volume image metadata.

``list``
  Lists all volumes.

``list-filters``
  (Supported by API versions 3.33 - 3.latest) [hint: use
  '--os-volume-api-version' flag to show help message
  for proper version]

``manage``
  Manage an existing volume.

``manageable-list``
  Lists all manageable volumes. (Supported by API
  versions
  3.8
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``message-delete``
  Removes one or more messages. (Supported by API
  versions
  3.3
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``message-list``
  Lists
  all
  messages.
  (Supported
  by
  API
  versions
  3.3
  -3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show help message for proper version]

``message-show``
  Shows message details. (Supported by API versions 3.3
  - 3.latest) [hint: use '--os-volume-api-version' flag
  to show help message for proper version]

``metadata``
  Sets or deletes volume metadata.

``metadata-show``
  Shows volume metadata.

``metadata-update-all``
  Updates volume metadata.

``migrate``
  Migrates volume to a new host.

``qos-associate``
  Associates qos specs with specified volume type.

``qos-create``
  Creates a qos specs.

``qos-delete``
  Deletes a specified qos specs.

``qos-disassociate``
  Disassociates qos specs from specified volume type.

``qos-disassociate-all``
  Disassociates qos specs from all its associations.

``qos-get-association``
  Lists all associations for specified qos specs.

``qos-key``
  Sets or unsets specifications for a qos spec.

``qos-list``
  Lists qos specs.

``qos-show``
  Shows qos specs details.

``quota-class-show``
  Lists quotas for a quota class.

``quota-class-update``
  Updates quotas for a quota class.

``quota-defaults``
  Lists default quotas for a tenant.

``quota-delete``
  Delete the quotas for a tenant.

``quota-show``
  Lists quotas for a tenant.

``quota-update``
  Updates quotas for a tenant.

``quota-usage``
  Lists quota usage for a tenant.

``rate-limits``
  Lists rate limits for a user.

``readonly-mode-update``
  Updates volume read-only access-mode flag.

``rename``
  Renames a volume.

``replication-promote``
  Promote a secondary volume to primary for a
  relationship.

``replication-reenable``
  Sync the secondary volume with primary for a
  relationship.

``reset-state``
  Explicitly updates the entity state in the Cinder
  database.

``retype``
  Changes the volume type for a volume.

``service-disable``
  Disables the service.

``service-enable``
  Enables the service.

``service-list``
  Lists all services. Filter by host and service binary.
  (Supported by API versions 3.0 - 3.latest) [hint: use
  '--os-volume-api-version' flag to show help message
  for proper version]

``set-bootable``
  Update bootable status of a volume.

``show``
  Shows volume details.

``snapshot-create``
  Creates a snapshot.

``snapshot-delete``
  Removes one or more snapshots.

``snapshot-list``
  Lists all snapshots.

``snapshot-manage``
  Manage an existing snapshot.

``snapshot-manageable-list``
  Lists all manageable snapshots. (Supported by API
  versions
  3.8
  -
  3.latest)
  [hint:
  use
  '--os-volume-api-version'
  flag
  to
  show
  help
  message
  for
  proper
  version]

``snapshot-metadata``
  Sets or deletes snapshot metadata.

``snapshot-metadata-show``
  Shows snapshot metadata.

``snapshot-metadata-update-all``
  Updates snapshot metadata.

``snapshot-rename``
  Renames a snapshot.

``snapshot-reset-state``
  Explicitly updates the snapshot state.

``snapshot-show``
  Shows snapshot details.

``snapshot-unmanage``
  Stop managing a snapshot.

``thaw-host``
  Thaw and enable the specified cinder-volume host.

``transfer-accept``
  Accepts a volume transfer.

``transfer-create``
  Creates a volume transfer.

``transfer-delete``
  Undoes a transfer.

``transfer-list``
  Lists all transfers.

``transfer-show``
  Shows transfer details.

``type-access-add``
  Adds volume type access for the given project.

``type-access-list``
  Print access information about the given volume type.

``type-access-remove``
  Removes volume type access for the given project.

``type-create``
  Creates a volume type.

``type-default``
  List the default volume type.

``type-delete``
  Deletes volume type or types.

``type-key``
  Sets or unsets extra_spec for a volume type.

``type-list``
  Lists available 'volume types'.

``type-show``
  Show volume type details.

``type-update``
  Updates volume type name, description, and/or
  is_public.

``unmanage``
  Stop managing a volume.

``upload-to-image``
  Uploads volume to Image Service as an image.

``version-list``
  List all API versions. (Supported by API versions 3.0
  - 3.latest) [hint: use '--os-volume-api-version' flag
  to show help message for proper version]

``bash-completion``
  Prints arguments for bash_completion.

``help``
  Shows help about this program or one of its
  subcommands.

``list-extensions``

.. _cinder_command_options:

cinder optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-d, --debug``
  Shows debugging output.

``--os-auth-system <os-auth-system>``
  **DEPRECATED!** Use --os-auth-type. Defaults to
  ``env[OS_AUTH_SYSTEM]``.

``--os-auth-type <os-auth-type>``
  Defaults to ``env[OS_AUTH_TYPE]``.

``--service-type <service-type>``
  Service type. For most actions, default is volume.

``--service-name <service-name>``
  Service name. Default= ``env[CINDER_SERVICE_NAME]``.

``--volume-service-name <volume-service-name>``
  Volume service name.
  Default= ``env[CINDER_VOLUME_SERVICE_NAME]``.

``--os-endpoint-type <os-endpoint-type>``
  Endpoint type, which is publicURL or internalURL.
  Default= ``env[OS_ENDPOINT_TYPE]`` or nova
  ``env[CINDER_ENDPOINT_TYPE]`` or publicURL.

``--endpoint-type <endpoint-type>``
  **DEPRECATED!** Use --os-endpoint-type.

``--os-volume-api-version <volume-api-ver>``
  Block Storage API version. Accepts X, X.Y (where X is
  major and Y is minor
  part).Default= ``env[OS_VOLUME_API_VERSION]``.

``--bypass-url <bypass-url>``
  **DEPRECATED!** Use os_endpoint. Use this API endpoint
  instead of the Service Catalog. Defaults to
  ``env[CINDERCLIENT_BYPASS_URL]``.

``--os-endpoint <os-endpoint>``
  Use this API endpoint instead of the Service Catalog.
  Defaults to ``env[CINDER_ENDPOINT]``.

``--retries <retries>``
  Number of retries.

``--profile HMAC_KEY``
  HMAC key to use for encrypting context data for
  performance profiling of operation. This key needs to
  match the one configured on the cinder api server.
  Without key the profiling will not be triggered even
  if osprofiler is enabled on server side.

``--os-auth-strategy <auth-strategy>``
  Authentication strategy (Env: OS_AUTH_STRATEGY,
  default keystone). For now, any other value will
  disable the authentication.

``--os-username <auth-user-name>``
  OpenStack user name. Default= ``env[OS_USERNAME]``.

``--os-password <auth-password>``
  Password for OpenStack user. Default= ``env[OS_PASSWORD]``.

``--os-tenant-name <auth-tenant-name>``
  Tenant name. Default= ``env[OS_TENANT_NAME]``.

``--os-tenant-id <auth-tenant-id>``
  ID for the tenant. Default= ``env[OS_TENANT_ID]``.

``--os-auth-url <auth-url>``
  URL for the authentication service.
  Default= ``env[OS_AUTH_URL]``.

``--os-user-id <auth-user-id>``
  Authentication user ID (Env: OS_USER_ID).

``--os-user-domain-id <auth-user-domain-id>``
  OpenStack user domain ID. Defaults to
  ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  OpenStack user domain name. Defaults to
  ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-id <auth-project-id>``
  Another way to specify tenant ID. This option is
  mutually exclusive with --os-tenant-id. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-project-name <auth-project-name>``
  Another way to specify tenant name. This option is
  mutually exclusive with --os-tenant-name. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-project-domain-id <auth-project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <auth-project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-region-name <region-name>``
  Region name. Default= ``env[OS_REGION_NAME]``.

``--os-token <token>``
  Defaults to ``env[OS_TOKEN]``.

``--os-url <url>``
  Defaults to ``env[OS_URL]``.

.. _cinder_absolute-limits:

cinder absolute-limits
----------------------

.. code-block:: console

   usage: cinder absolute-limits [<tenant_id>]

Lists absolute limits for a user.

**Positional arguments:**

``<tenant_id>``
  Display information for a single tenant (Admin only).

.. _cinder_api-version:

cinder api-version
------------------

.. code-block:: console

   usage: cinder api-version

Display the server API version information.

.. _cinder_attachment-create:

cinder attachment-create
------------------------

.. code-block:: console

   usage: cinder attachment-create [--connect <connect>]
                                   [--initiator <initiator>] [--ip <ip>]
                                   [--host <host>] [--platform <platform>]
                                   [--ostype <ostype>] [--multipath <multipath>]
                                   [--mountpoint <mountpoint>]
                                   <volume> <server_id>

Create an attachment for a cinder volume.

**Positional arguments:**

``<volume>``
  Name or ID of volume or volumes to attach.

``<server_id>``
  ID of server attaching to.

**Optional arguments:**

``--connect <connect>``
  Make an active connection using provided connector
  info (True or False).

``--initiator <initiator>``
  iqn of the initiator attaching to. Default=None.

``--ip <ip>``
  ip of the system attaching to. Default=None.

``--host <host>``
  Name of the host attaching to. Default=None.

``--platform <platform>``
  Platform type. Default=x86_64.

``--ostype <ostype>``
  OS type. Default=linux2.

``--multipath <multipath>``
  Use multipath. Default=False.

``--mountpoint <mountpoint>``
  Mountpoint volume will be attached at. Default=None.

.. _cinder_attachment-delete:

cinder attachment-delete
------------------------

.. code-block:: console

   usage: cinder attachment-delete <attachment> [<attachment> ...]

Delete an attachment for a cinder volume.

**Positional arguments:**

``<attachment>``
  ID of attachment or attachments to delete.

.. _cinder_attachment-list:

cinder attachment-list
----------------------

.. code-block:: console

   usage: cinder attachment-list [--all-tenants [<0|1>]]
                                 [--volume-id <volume-id>] [--status <status>]
                                 [--marker <marker>] [--limit <limit>]
                                 [--sort <key>[:<direction>]]
                                 [--tenant [<tenant>]]
                                 [--filters [<key=value> [<key=value> ...]]]

Lists all attachments.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--volume-id <volume-id>``
  Filters results by a volume ID. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--status <status>``
  Filters results by a status. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--marker <marker>``
  Begin returning attachments that appear later in
  attachment list than that represented by this id.
  Default=None.

``--limit <limit>``
  Maximum number of attachments to return. Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: id,
  status, size, availability_zone, name, bootable,
  created_at, reference. Default=None.

``--tenant [<tenant>]``
  Display information from single tenant (Admin only).

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_attachment-show:

cinder attachment-show
----------------------

.. code-block:: console

   usage: cinder attachment-show <attachment>

Show detailed information for attachment.

**Positional arguments:**

``<attachment>``
  ID of attachment.

.. _cinder_attachment-update:

cinder attachment-update
------------------------

.. code-block:: console

   usage: cinder attachment-update [--initiator <initiator>] [--ip <ip>]
                                   [--host <host>] [--platform <platform>]
                                   [--ostype <ostype>] [--multipath <multipath>]
                                   [--mountpoint <mountpoint>]
                                   <attachment>

Update an attachment for a cinder volume. This call is designed to be more of
an attachment completion than anything else. It expects the value of a
connector object to notify the driver that the volume is going to be connected
and where it's being connected to.

**Positional arguments:**

``<attachment>``
  ID of attachment.

**Optional arguments:**

``--initiator <initiator>``
  iqn of the initiator attaching to. Default=None.

``--ip <ip>``
  ip of the system attaching to. Default=None.

``--host <host>``
  Name of the host attaching to. Default=None.

``--platform <platform>``
  Platform type. Default=x86_64.

``--ostype <ostype>``
  OS type. Default=linux2.

``--multipath <multipath>``
  Use multipath. Default=False.

``--mountpoint <mountpoint>``
  Mountpoint volume will be attached at. Default=None.

.. _cinder_availability-zone-list:

cinder availability-zone-list
-----------------------------

.. code-block:: console

   usage: cinder availability-zone-list

Lists all availability zones.

.. _cinder_backup-create:

cinder backup-create
--------------------

.. code-block:: console

   usage: cinder backup-create [--container <container>] [--name <name>]
                               [--description <description>] [--incremental]
                               [--force] [--snapshot-id <snapshot-id>]
                               <volume>

Creates a volume backup.

**Positional arguments:**

``<volume>``
  Name or ID of volume to backup.

**Optional arguments:**

``--container <container>``
  Backup container name. Default=None.

``--name <name>``
  Backup name. Default=None.

``--description <description>``
  Backup description. Default=None.

``--incremental``
  Incremental backup. Default=False.

``--force``
  Allows or disallows backup of a volume when the volume
  is attached to an instance. If set to True, backs up
  the
  volume
  whether
  its
  status
  is
  "available"
  or
  "in-use".
  The
  backup
  of
  an
  "in-use"
  volume
  means
  your
  data
  is crash consistent. Default=False.

``--snapshot-id <snapshot-id>``
  ID of snapshot to backup. Default=None.

.. _cinder_backup-delete:

cinder backup-delete
--------------------

.. code-block:: console

   usage: cinder backup-delete [--force] <backup> [<backup> ...]

Removes one or more backups.

**Positional arguments:**

``<backup>``
  Name or ID of backup(s) to delete.

**Optional arguments:**

``--force``
  Allows deleting backup of a volume when its status is other than
  "available" or "error". Default=False.

.. _cinder_backup-export:

cinder backup-export
--------------------

.. code-block:: console

   usage: cinder backup-export <backup>

Export backup metadata record.

**Positional arguments:**

``<backup>``
  ID of the backup to export.

.. _cinder_backup-import:

cinder backup-import
--------------------

.. code-block:: console

   usage: cinder backup-import <backup_service> <backup_url>

Import backup metadata record.

**Positional arguments:**

``<backup_service>``
  Backup service to use for importing the backup.

``<backup_url>``
  Backup URL for importing the backup metadata.

.. _cinder_backup-list:

cinder backup-list
------------------

.. code-block:: console

   usage: cinder backup-list [--all-tenants [<all_tenants>]] [--name <name>]
                             [--status <status>] [--volume-id <volume-id>]
                             [--marker <marker>] [--limit <limit>]
                             [--sort <key>[:<direction>]]
                             [--filters [<key=value> [<key=value> ...]]]

Lists all backups.

**Optional arguments:**

``--all-tenants [<all_tenants>]``
  Shows details for all tenants. Admin only.

``--name <name>``
  Filters results by a name. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--status <status>``
  Filters results by a status. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--volume-id <volume-id>``
  Filters results by a volume ID. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--marker <marker>``
  Begin returning backups that appear later in the
  backup list than that represented by this id.
  Default=None.

``--limit <limit>``
  Maximum number of backups to return. Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: id,
  status, size, availability_zone, name, bootable,
  created_at, reference. Default=None.

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_backup-reset-state:

cinder backup-reset-state
-------------------------

.. code-block:: console

   usage: cinder backup-reset-state [--state <state>] <backup> [<backup> ...]

Explicitly updates the backup state.

**Positional arguments:**

``<backup>``
  Name or ID of the backup to modify.

**Optional arguments:**

``--state <state>``
  The state to assign to the backup. Valid values are
  "available", "error". Default=available.

.. _cinder_backup-restore:

cinder backup-restore
---------------------

.. code-block:: console

   usage: cinder backup-restore [--volume <volume>] [--name <name>] <backup>

Restores a backup.

**Positional arguments:**

``<backup>``
  Name or ID of backup to restore.

**Optional arguments:**

``--volume <volume>``
  Name or ID of existing volume to which to restore. This
  is mutually exclusive with --name and takes priority.
  Default=None.

``--name <name>``
  Use the name for new volume creation to restore. This is
  mutually exclusive with --volume (or the deprecated
  --volume-id) and --volume (or --volume-id) takes
  priority. Default=None.

.. _cinder_backup-show:

cinder backup-show
------------------

.. code-block:: console

   usage: cinder backup-show <backup>

Shows backup details.

**Positional arguments:**

``<backup>``
  Name or ID of backup.

.. _cinder_backup-update:

cinder backup-update
--------------------

.. code-block:: console

   usage: cinder backup-update [--name [<name>]] [--description <description>]
                               <backup>

Renames a backup.

**Positional arguments:**

``<backup>``
  Name or ID of backup to rename.

**Optional arguments:**

``--name [<name>]``
  New name for backup.

``--description <description>``
  Backup description. Default=None.

.. _cinder_cgsnapshot-create:

cinder cgsnapshot-create
------------------------

.. code-block:: console

   usage: cinder cgsnapshot-create [--name <name>] [--description <description>]
                                   <consistencygroup>

Creates a cgsnapshot.

**Positional arguments:**

``<consistencygroup>``
  Name or ID of a consistency group.

**Optional arguments:**

``--name <name>``
  Cgsnapshot name. Default=None.

``--description <description>``
  Cgsnapshot description. Default=None.

.. _cinder_cgsnapshot-delete:

cinder cgsnapshot-delete
------------------------

.. code-block:: console

   usage: cinder cgsnapshot-delete <cgsnapshot> [<cgsnapshot> ...]

Removes one or more cgsnapshots.

**Positional arguments:**

``<cgsnapshot>``
  Name or ID of one or more cgsnapshots to be deleted.

.. _cinder_cgsnapshot-list:

cinder cgsnapshot-list
----------------------

.. code-block:: console

   usage: cinder cgsnapshot-list [--all-tenants [<0|1>]] [--status <status>]
                                 [--consistencygroup-id <consistencygroup_id>]

Lists all cgsnapshots.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--status <status>``
  Filters results by a status. Default=None.

``--consistencygroup-id <consistencygroup_id>``
  Filters results by a consistency group ID.
  Default=None.

.. _cinder_cgsnapshot-show:

cinder cgsnapshot-show
----------------------

.. code-block:: console

   usage: cinder cgsnapshot-show <cgsnapshot>

Shows cgsnapshot details.

**Positional arguments:**

``<cgsnapshot>``
  Name or ID of cgsnapshot.

.. _cinder_cluster-disable:

cinder cluster-disable
----------------------

.. code-block:: console

   usage: cinder cluster-disable [--reason <reason>] [<binary>] <cluster-name>

Disables clustered services.

**Positional arguments:**

``<binary>``
  Binary to filter by. Default: cinder-volume.

``<cluster-name>``
  Name of the clustered services to update.

**Optional arguments:**

``--reason <reason>``
  Reason for disabling clustered service.

.. _cinder_cluster-enable:

cinder cluster-enable
---------------------

.. code-block:: console

   usage: cinder cluster-enable [<binary>] <cluster-name>

Enables clustered services.

**Positional arguments:**

``<binary>``
  Binary to filter by. Default: cinder-volume.

``<cluster-name>``
  Name of the clustered services to update.

.. _cinder_cluster-list:

cinder cluster-list
-------------------

.. code-block:: console

   usage: cinder cluster-list [--name <name>] [--binary <binary>]
                              [--is-up <True|true|False|false>]
                              [--disabled <True|true|False|false>]
                              [--num-hosts <num-hosts>]
                              [--num-down-hosts <num-down-hosts>] [--detailed]

Lists clustered services with optional filtering.

**Optional arguments:**

``--name <name>``
  Filter by cluster name, without backend will list all
  clustered services from the same cluster.
  Default=None.

``--binary <binary>``
  Cluster binary. Default=None.

``--is-up <True|true|False|false>``
  Filter by up/dow status. Default=None.

``--disabled <True|true|False|false>``
  Filter by disabled status. Default=None.

``--num-hosts <num-hosts>``
  Filter by number of hosts in the cluster.

``--num-down-hosts <num-down-hosts>``
  Filter by number of hosts that are down.

``--detailed``
  Get detailed clustered service information
  (Default=False).

.. _cinder_cluster-show:

cinder cluster-show
-------------------

.. code-block:: console

   usage: cinder cluster-show [<binary>] <cluster-name>

Show detailed information on a clustered service.

**Positional arguments:**

``<binary>``
  Binary to filter by. Default: cinder-volume.

``<cluster-name>``
  Name of the clustered service to show.

.. _cinder_consisgroup-create:

cinder consisgroup-create
-------------------------

.. code-block:: console

   usage: cinder consisgroup-create [--name <name>] [--description <description>]
                                    [--availability-zone <availability-zone>]
                                    <volume-types>

Creates a consistency group.

**Positional arguments:**

``<volume-types>``
  Volume types.

**Optional arguments:**

``--name <name>``
  Name of a consistency group.

``--description <description>``
  Description of a consistency group. Default=None.

``--availability-zone <availability-zone>``
  Availability zone for volume. Default=None.

.. _cinder_consisgroup-create-from-src:

cinder consisgroup-create-from-src
----------------------------------

.. code-block:: console

   usage: cinder consisgroup-create-from-src [--cgsnapshot <cgsnapshot>]
                                             [--source-cg <source-cg>]
                                             [--name <name>]
                                             [--description <description>]

Creates a consistency group from a cgsnapshot or a source CG.

**Optional arguments:**

``--cgsnapshot <cgsnapshot>``
  Name or ID of a cgsnapshot. Default=None.

``--source-cg <source-cg>``
  Name or ID of a source CG. Default=None.

``--name <name>``
  Name of a consistency group. Default=None.

``--description <description>``
  Description of a consistency group. Default=None.

.. _cinder_consisgroup-delete:

cinder consisgroup-delete
-------------------------

.. code-block:: console

   usage: cinder consisgroup-delete [--force]
                                    <consistencygroup> [<consistencygroup> ...]

Removes one or more consistency groups.

**Positional arguments:**

``<consistencygroup>``
  Name or ID of one or more consistency groups to be
  deleted.

**Optional arguments:**

``--force``
  Allows or disallows consistency groups to be deleted. If
  the consistency group is empty, it can be deleted
  without the force flag. If the consistency group is not
  empty, the force flag is required for it to be deleted.

.. _cinder_consisgroup-list:

cinder consisgroup-list
-----------------------

.. code-block:: console

   usage: cinder consisgroup-list [--all-tenants [<0|1>]]

Lists all consistency groups.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

.. _cinder_consisgroup-show:

cinder consisgroup-show
-----------------------

.. code-block:: console

   usage: cinder consisgroup-show <consistencygroup>

Shows details of a consistency group.

**Positional arguments:**

``<consistencygroup>``
  Name or ID of a consistency group.

.. _cinder_consisgroup-update:

cinder consisgroup-update
-------------------------

.. code-block:: console

   usage: cinder consisgroup-update [--name <name>] [--description <description>]
                                    [--add-volumes <uuid1,uuid2,......>]
                                    [--remove-volumes <uuid3,uuid4,......>]
                                    <consistencygroup>

Updates a consistency group.

**Positional arguments:**

``<consistencygroup>``
  Name or ID of a consistency group.

**Optional arguments:**

``--name <name>``
  New name for consistency group. Default=None.

``--description <description>``
  New description for consistency group. Default=None.

``--add-volumes <uuid1,uuid2,......>``
  UUID of one or more volumes to be added to the
  consistency group, separated by commas. Default=None.

``--remove-volumes <uuid3,uuid4,......>``
  UUID of one or more volumes to be removed from the
  consistency group, separated by commas. Default=None.

.. _cinder_create:

cinder create
-------------

.. code-block:: console

   usage: cinder create [--consisgroup-id <consistencygroup-id>]
                        [--group-id <group-id>] [--snapshot-id <snapshot-id>]
                        [--source-volid <source-volid>]
                        [--source-replica <source-replica>]
                        [--image-id <image-id>] [--image <image>] [--name <name>]
                        [--description <description>]
                        [--volume-type <volume-type>]
                        [--availability-zone <availability-zone>]
                        [--metadata [<key=value> [<key=value> ...]]]
                        [--hint <key=value>] [--allow-multiattach]
                        [<size>]

Creates a volume.

**Positional arguments:**

``<size>``
  Size of volume, in GiBs. (Required unless snapshot-id
  /source-volid is specified).

**Optional arguments:**

``--consisgroup-id <consistencygroup-id>``
  ID of a consistency group where the new volume belongs
  to. Default=None.

``--group-id <group-id>``
  ID of a group where the new volume belongs to.
  Default=None. (Supported by API version 3.13 and
  later)

``--snapshot-id <snapshot-id>``
  Creates volume from snapshot ID. Default=None.

``--source-volid <source-volid>``
  Creates volume from volume ID. Default=None.

``--source-replica <source-replica>``
  Creates volume from replicated volume ID.
  Default=None.

``--image-id <image-id>``
  Creates volume from image ID. Default=None.

``--image <image>``
  Creates a volume from image (ID or name).
  Default=None.

``--name <name>``
  Volume name. Default=None.

``--description <description>``
  Volume description. Default=None.

``--volume-type <volume-type>``
  Volume type. Default=None.

``--availability-zone <availability-zone>``
  Availability zone for volume. Default=None.

``--metadata [<key=value> [<key=value> ...]]``
  Metadata key and value pairs. Default=None.

``--hint <key=value>``
  Scheduler hint, like in nova.

``--allow-multiattach``
  Allow volume to be attached more than once.
  Default=False

.. _cinder_credentials:

cinder credentials
------------------

.. code-block:: console

   usage: cinder credentials

Shows user credentials returned from auth.

.. _cinder_delete:

cinder delete
-------------

.. code-block:: console

   usage: cinder delete [--cascade] <volume> [<volume> ...]

Removes one or more volumes.

**Positional arguments:**

``<volume>``
  Name or ID of volume or volumes to delete.

**Optional arguments:**

``--cascade``
  Remove any snapshots along with volume. Default=False.

.. _cinder_encryption-type-create:

cinder encryption-type-create
-----------------------------

.. code-block:: console

   usage: cinder encryption-type-create [--cipher <cipher>]
                                        [--key-size <key_size>]
                                        [--control-location <control_location>]
                                        <volume_type> <provider>

Creates encryption type for a volume type. Admin only.

**Positional arguments:**

``<volume_type>``
  Name or ID of volume type.

``<provider>``
  The class that provides encryption support. For
  example, LuksEncryptor.

**Optional arguments:**

``--cipher <cipher>``
  The
  encryption
  algorithm
  or
  mode.
  For
  example,
  aes-xts-plain64.
  Default=None.

``--key-size <key_size>``
  Size of encryption key, in bits. For example, 128 or
  256. Default=None.

``--control-location <control_location>``
  Notional service where encryption is performed. Valid
  values are "front-end" or "back-end." For example,
  front-end=Nova. Default is "front-end."

.. _cinder_encryption-type-delete:

cinder encryption-type-delete
-----------------------------

.. code-block:: console

   usage: cinder encryption-type-delete <volume_type>

Deletes encryption type for a volume type. Admin only.

**Positional arguments:**

``<volume_type>``
  Name or ID of volume type.

.. _cinder_encryption-type-list:

cinder encryption-type-list
---------------------------

.. code-block:: console

   usage: cinder encryption-type-list

Shows encryption type details for volume types. Admin only.

.. _cinder_encryption-type-show:

cinder encryption-type-show
---------------------------

.. code-block:: console

   usage: cinder encryption-type-show <volume_type>

Shows encryption type details for a volume type. Admin only.

**Positional arguments:**

``<volume_type>``
  Name or ID of volume type.

.. _cinder_encryption-type-update:

cinder encryption-type-update
-----------------------------

.. code-block:: console

   usage: cinder encryption-type-update [--provider <provider>]
                                        [--cipher [<cipher>]]
                                        [--key-size [<key-size>]]
                                        [--control-location <control-location>]
                                        <volume-type>

Update encryption type information for a volume type (Admin Only).

**Positional arguments:**

``<volume-type>``
  Name or ID of the volume type

**Optional arguments:**

``--provider <provider>``
  Class providing encryption support (e.g.
  LuksEncryptor)

``--cipher [<cipher>]``
  Encryption
  algorithm/mode
  to
  use
  (e.g.,
  aes-xts-plain64).
  Provide
  parameter
  without
  value
  to
  set
  to
  provider default.

``--key-size [<key-size>]``
  Size of the encryption key, in bits (e.g., 128, 256).
  Provide parameter without value to set to provider
  default.

``--control-location <control-location>``
  Notional service where encryption is performed (e.g.,
  front-end=Nova). Values: 'front-end', 'back-end'

.. _cinder_endpoints:

cinder endpoints
----------------

.. code-block:: console

   usage: cinder endpoints

Discovers endpoints registered by authentication service.

.. _cinder_extend:

cinder extend
-------------

.. code-block:: console

   usage: cinder extend <volume> <new_size>

Attempts to extend size of an existing volume.

**Positional arguments:**

``<volume>``
  Name or ID of volume to extend.

``<new_size>``
  New size of volume, in GiBs.

.. _cinder_extra-specs-list:

cinder extra-specs-list
-----------------------

.. code-block:: console

   usage: cinder extra-specs-list

Lists current volume types and extra specs.

.. _cinder_failover-host:

cinder failover-host
--------------------

.. code-block:: console

   usage: cinder failover-host [--backend_id <backend-id>] <hostname>

Failover a replicating cinder-volume host.

**Positional arguments:**

``<hostname>``
  Host name.

**Optional arguments:**

``--backend_id <backend-id>``
  ID of backend to failover to (Default=None)

.. _cinder_force-delete:

cinder force-delete
-------------------

.. code-block:: console

   usage: cinder force-delete <volume> [<volume> ...]

Attempts force-delete of volume, regardless of state.

**Positional arguments:**

``<volume>``
  Name or ID of volume or volumes to delete.

.. _cinder_freeze-host:

cinder freeze-host
------------------

.. code-block:: console

   usage: cinder freeze-host <hostname>

Freeze and disable the specified cinder-volume host.

**Positional arguments:**

``<hostname>``
  Host name.

.. _cinder_get-capabilities:

cinder get-capabilities
-----------------------

.. code-block:: console

   usage: cinder get-capabilities <host>

Show backend volume stats and properties. Admin only.

**Positional arguments:**

``<host>``
  Cinder host to show backend volume stats and properties; takes the
  form: host@backend-name

.. _cinder_get-pools:

cinder get-pools
----------------

.. code-block:: console

   usage: cinder get-pools [--detail] [--filters [<key=value> [<key=value> ...]]]

Show pool information for backends. Admin only.

**Optional arguments:**

``--detail``
  Show detailed information about pools.

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_group-create:

cinder group-create
-------------------

.. code-block:: console

   usage: cinder group-create [--name <name>] [--description <description>]
                              [--availability-zone <availability-zone>]
                              <group-type> <volume-types>

Creates a group.

**Positional arguments:**

``<group-type>``
  Group type.

``<volume-types>``
  Comma-separated list of volume types.

**Optional arguments:**

``--name <name>``
  Name of a group.

``--description <description>``
  Description of a group. Default=None.

``--availability-zone <availability-zone>``
  Availability zone for group. Default=None.

.. _cinder_group-create-from-src:

cinder group-create-from-src
----------------------------

.. code-block:: console

   usage: cinder group-create-from-src [--group-snapshot <group-snapshot>]
                                       [--source-group <source-group>]
                                       [--name <name>]
                                       [--description <description>]

Creates a group from a group snapshot or a source group.

**Optional arguments:**

``--group-snapshot <group-snapshot>``
  Name or ID of a group snapshot. Default=None.

``--source-group <source-group>``
  Name or ID of a source group. Default=None.

``--name <name>``
  Name of a group. Default=None.

``--description <description>``
  Description of a group. Default=None.

.. _cinder_group-delete:

cinder group-delete
-------------------

.. code-block:: console

   usage: cinder group-delete [--delete-volumes] <group> [<group> ...]

Removes one or more groups.

**Positional arguments:**

``<group>``
  Name or ID of one or more groups to be deleted.

**Optional arguments:**

``--delete-volumes``
  Allows or disallows groups to be deleted if they are not
  empty. If the group is empty, it can be deleted without
  the delete-volumes flag. If the group is not empty, the
  delete-volumes flag is required for it to be deleted. If
  True, all volumes in the group will also be deleted.

.. _cinder_group-list:

cinder group-list
-----------------

.. code-block:: console

   usage: cinder group-list [--all-tenants [<0|1>]]
                            [--filters [<key=value> [<key=value> ...]]]

Lists all groups.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_group-show:

cinder group-show
-----------------

.. code-block:: console

   usage: cinder group-show <group>

Shows details of a group.

**Positional arguments:**

``<group>``
  Name or ID of a group.

.. _cinder_group-snapshot-create:

cinder group-snapshot-create
----------------------------

.. code-block:: console

   usage: cinder group-snapshot-create [--name <name>]
                                       [--description <description>]
                                       <group>

Creates a group snapshot.

**Positional arguments:**

``<group>``
  Name or ID of a group.

**Optional arguments:**

``--name <name>``
  Group snapshot name. Default=None.

``--description <description>``
  Group snapshot description. Default=None.

.. _cinder_group-snapshot-delete:

cinder group-snapshot-delete
----------------------------

.. code-block:: console

   usage: cinder group-snapshot-delete <group_snapshot> [<group_snapshot> ...]

Removes one or more group snapshots.

**Positional arguments:**

``<group_snapshot>``
  Name or ID of one or more group snapshots to be deleted.

.. _cinder_group-snapshot-list:

cinder group-snapshot-list
--------------------------

.. code-block:: console

   usage: cinder group-snapshot-list [--all-tenants [<0|1>]] [--status <status>]
                                     [--group-id <group_id>]
                                     [--filters [<key=value> [<key=value> ...]]]

Lists all group snapshots.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--status <status>``
  Filters results by a status. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--group-id <group_id>``
  Filters results by a group ID. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_group-snapshot-show:

cinder group-snapshot-show
--------------------------

.. code-block:: console

   usage: cinder group-snapshot-show <group_snapshot>

Shows group snapshot details.

**Positional arguments:**

``<group_snapshot>``
  Name or ID of group snapshot.

.. _cinder_group-specs-list:

cinder group-specs-list
-----------------------

.. code-block:: console

   usage: cinder group-specs-list

Lists current group types and specs.

.. _cinder_group-type-create:

cinder group-type-create
------------------------

.. code-block:: console

   usage: cinder group-type-create [--description <description>]
                                   [--is-public <is-public>]
                                   <name>

Creates a group type.

**Positional arguments:**

``<name>``
  Name of new group type.

**Optional arguments:**

``--description <description>``
  Description of new group type.

``--is-public <is-public>``
  Make type accessible to the public (default true).

.. _cinder_group-type-default:

cinder group-type-default
-------------------------

.. code-block:: console

   usage: cinder group-type-default

List the default group type.

.. _cinder_group-type-delete:

cinder group-type-delete
------------------------

.. code-block:: console

   usage: cinder group-type-delete <group_type> [<group_type> ...]

Deletes group type or types.

**Positional arguments:**

``<group_type>``
  Name or ID of group type or types to delete.

.. _cinder_group-type-key:

cinder group-type-key
---------------------

.. code-block:: console

   usage: cinder group-type-key <gtype> <action> <key=value> [<key=value> ...]

Sets or unsets group_spec for a group type.

**Positional arguments:**

``<gtype>``
  Name or ID of group type.

``<action>``
  The action. Valid values are "set" or "unset."

``<key=value>``
  The group specs key and value pair to set or unset. For unset,
  specify only the key.

.. _cinder_group-type-list:

cinder group-type-list
----------------------

.. code-block:: console

   usage: cinder group-type-list

Lists available 'group types'. (Admin only will see private types)

.. _cinder_group-type-show:

cinder group-type-show
----------------------

.. code-block:: console

   usage: cinder group-type-show <group_type>

Show group type details.

**Positional arguments:**

``<group_type>``
  Name or ID of the group type.

.. _cinder_group-type-update:

cinder group-type-update
------------------------

.. code-block:: console

   usage: cinder group-type-update [--name <name>] [--description <description>]
                                   [--is-public <is-public>]
                                   <id>

Updates group type name, description, and/or is_public.

**Positional arguments:**

``<id>``
  ID of the group type.

**Optional arguments:**

``--name <name>``
  Name of the group type.

``--description <description>``
  Description of the group type.

``--is-public <is-public>``
  Make type accessible to the public or not.

.. _cinder_group-update:

cinder group-update
-------------------

.. code-block:: console

   usage: cinder group-update [--name <name>] [--description <description>]
                              [--add-volumes <uuid1,uuid2,......>]
                              [--remove-volumes <uuid3,uuid4,......>]
                              <group>

Updates a group.

**Positional arguments:**

``<group>``
  Name or ID of a group.

**Optional arguments:**

``--name <name>``
  New name for group. Default=None.

``--description <description>``
  New description for group. Default=None.

``--add-volumes <uuid1,uuid2,......>``
  UUID of one or more volumes to be added to the group,
  separated by commas. Default=None.

``--remove-volumes <uuid3,uuid4,......>``
  UUID of one or more volumes to be removed from the
  group, separated by commas. Default=None.

.. _cinder_image-metadata:

cinder image-metadata
---------------------

.. code-block:: console

   usage: cinder image-metadata <volume> <action> <key=value> [<key=value> ...]

Sets or deletes volume image metadata.

**Positional arguments:**

``<volume>``
  Name or ID of volume for which to update metadata.

``<action>``
  The action. Valid values are 'set' or 'unset.'

``<key=value>``
  Metadata key and value pair to set or unset. For unset, specify
  only the key.

.. _cinder_image-metadata-show:

cinder image-metadata-show
--------------------------

.. code-block:: console

   usage: cinder image-metadata-show <volume>

Shows volume image metadata.

**Positional arguments:**

``<volume>``
  ID of volume.

.. _cinder_list:

cinder list
-----------

.. code-block:: console

   usage: cinder list [--group_id <group_id>] [--all-tenants [<0|1>]]
                      [--name <name>] [--status <status>]
                      [--bootable [<True|true|False|false>]]
                      [--migration_status <migration_status>]
                      [--metadata [<key=value> [<key=value> ...]]]
                      [--image_metadata [<key=value> [<key=value> ...]]]
                      [--marker <marker>] [--limit <limit>] [--fields <fields>]
                      [--sort <key>[:<direction>]] [--tenant [<tenant>]]
                      [--filters [<key=value> [<key=value> ...]]]

Lists all volumes.

**Optional arguments:**

``--group_id <group_id>``
  Filters results by a group_id. Default=None.This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead. (Supported by API
  version 3.10 and later)

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--name <name>``
  Filters results by a name. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--status <status>``
  Filters results by a status. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--bootable [<True|true|False|false>]``
  Filters results by bootable status. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--migration_status <migration_status>``
  Filters results by a migration status. Default=None.
  Admin only. This option is deprecated and will be
  removed in newer release. Please use '--filters'
  option which is introduced since 3.33 instead.

``--metadata [<key=value> [<key=value> ...]]``
  Filters results by a metadata key and value pair.
  Default=None. This option is deprecated and will be
  removed in newer release. Please use '--filters'
  option which is introduced since 3.33 instead.

``--image_metadata [<key=value> [<key=value> ...]]``
  Filters results by a image metadata key and value
  pair. Require volume api version >=3.4.
  Default=None.This option is deprecated and will be
  removed in newer release. Please use '--filters'
  option which is introduced since 3.33 instead.
  (Supported by API version 3.4 and later)

``--marker <marker>``
  Begin returning volumes that appear later in the
  volume list than that represented by this volume id.
  Default=None.

``--limit <limit>``
  Maximum number of volumes to return. Default=None.

``--fields <fields>``
  Comma-separated list of fields to display. Use the
  show command to see which fields are available.
  Unavailable/non-existent fields will be ignored.
  Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: id,
  status, size, availability_zone, name, bootable,
  created_at, reference. Default=None.

``--tenant [<tenant>]``
  Display information from single tenant (Admin only).

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_list-extensions:

cinder list-extensions
----------------------

.. code-block:: console

   usage: cinder list-extensions


.. _cinder_list-filters:

cinder list-filters
-------------------

.. code-block:: console

   usage: cinder list-filters [--resource <resource>]


**Optional arguments:**

``--resource <resource>``
  Show enabled filters for specified resource.
  Default=None.

.. _cinder_manage:

cinder manage
-------------

.. code-block:: console

   usage: cinder manage [--id-type <id-type>] [--name <name>]
                        [--description <description>]
                        [--volume-type <volume-type>]
                        [--availability-zone <availability-zone>]
                        [--metadata [<key=value> [<key=value> ...]]] [--bootable]
                        <host> <identifier>

Manage an existing volume.

**Positional arguments:**

``<host>``
  Cinder host on which the existing volume resides;
  takes the form: host@backend-name#pool

``<identifier>``
  Name or other Identifier for existing volume

**Optional arguments:**

``--id-type <id-type>``
  Type of backend device identifier provided, typically
  source-name or source-id (Default=source-name)

``--name <name>``
  Volume name (Default=None)

``--description <description>``
  Volume description (Default=None)

``--volume-type <volume-type>``
  Volume type (Default=None)

``--availability-zone <availability-zone>``
  Availability zone for volume (Default=None)

``--metadata [<key=value> [<key=value> ...]]``
  Metadata key=value pairs (Default=None)

``--bootable``
  Specifies that the newly created volume should be
  marked as bootable

.. _cinder_manageable-list:

cinder manageable-list
----------------------

.. code-block:: console

   usage: cinder manageable-list [--detailed <detailed>] [--marker <marker>]
                                 [--limit <limit>] [--offset <offset>]
                                 [--sort <key>[:<direction>]]
                                 <host>

Lists all manageable volumes.

**Positional arguments:**

``<host>``
  Cinder host on which to list manageable volumes; takes
  the form: host@backend-name#pool

**Optional arguments:**

``--detailed <detailed>``
  Returned detailed information (default true).

``--marker <marker>``
  Begin returning volumes that appear later in the
  volume list than that represented by this reference.
  This reference should be json like. Default=None.

``--limit <limit>``
  Maximum number of volumes to return. Default=None.

``--offset <offset>``
  Number of volumes to skip after marker. Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: size,
  reference. Default=None.

.. _cinder_message-delete:

cinder message-delete
---------------------

.. code-block:: console

   usage: cinder message-delete <message> [<message> ...]

Removes one or more messages.

**Positional arguments:**

``<message>``
  ID of one or more message to be deleted.

.. _cinder_message-list:

cinder message-list
-------------------

.. code-block:: console

   usage: cinder message-list [--marker <marker>] [--limit <limit>]
                              [--sort <key>[:<direction>]]
                              [--resource_uuid <resource_uuid>]
                              [--resource_type <type>] [--event_id <id>]
                              [--request_id <request_id>] [--level <level>]
                              [--filters [<key=value> [<key=value> ...]]]

Lists all messages.

**Optional arguments:**

``--marker <marker>``
  Begin returning message that appear later in the
  message list than that represented by this id.
  Default=None. (Supported by API version 3.5 and later)

``--limit <limit>``
  Maximum number of messages to return. Default=None.
  (Supported by API version 3.5 and later)

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: id,
  status, size, availability_zone, name, bootable,
  created_at, reference. Default=None. (Supported by API
  version 3.5 and later)

``--resource_uuid <resource_uuid>``
  Filters results by a resource uuid. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--resource_type <type>``
  Filters results by a resource type. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--event_id <id>``
  Filters results by event id. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--request_id <request_id>``
  Filters results by request id. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--level <level>``
  Filters results by the message level. Default=None.
  This option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_message-show:

cinder message-show
-------------------

.. code-block:: console

   usage: cinder message-show <message>

Shows message details.

**Positional arguments:**

``<message>``
  ID of message.

.. _cinder_metadata:

cinder metadata
---------------

.. code-block:: console

   usage: cinder metadata <volume> <action> <key=value> [<key=value> ...]

Sets or deletes volume metadata.

**Positional arguments:**

``<volume>``
  Name or ID of volume for which to update metadata.

``<action>``
  The action. Valid values are "set" or "unset."

``<key=value>``
  Metadata key and value pair to set or unset. For unset, specify
  only the key(s): <key key> (Supported by API version 3.15 and
  later)

.. _cinder_metadata-show:

cinder metadata-show
--------------------

.. code-block:: console

   usage: cinder metadata-show <volume>

Shows volume metadata.

**Positional arguments:**

``<volume>``
  ID of volume.

.. _cinder_metadata-update-all:

cinder metadata-update-all
--------------------------

.. code-block:: console

   usage: cinder metadata-update-all <volume> <key=value> [<key=value> ...]

Updates volume metadata.

**Positional arguments:**

``<volume>``
  ID of volume for which to update metadata.

``<key=value>``
  Metadata key and value pair or pairs to update.

.. _cinder_migrate:

cinder migrate
--------------

.. code-block:: console

   usage: cinder migrate [--force-host-copy [<True|False>]]
                         [--lock-volume [<True|False>]]
                         <volume> <host>

Migrates volume to a new host.

**Positional arguments:**

``<volume>``
  ID of volume to migrate.

``<host>``
  Destination host. Takes the form: host@backend-name#pool

**Optional arguments:**

``--force-host-copy [<True|False>]``
  Enables
  or
  disables
  generic
  host-based
  force-migration,
  which
  bypasses
  driver
  optimizations.
  Default=False.

``--lock-volume [<True|False>]``
  Enables or disables the termination of volume
  migration caused by other commands. This option
  applies to the available volume. True means it locks
  the volume state and does not allow the migration to
  be aborted. The volume status will be in maintenance
  during the migration. False means it allows the volume
  migration to be aborted. The volume status is still in
  the original status. Default=False.

.. _cinder_qos-associate:

cinder qos-associate
--------------------

.. code-block:: console

   usage: cinder qos-associate <qos_specs> <volume_type_id>

Associates qos specs with specified volume type.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications.

``<volume_type_id>``
  ID of volume type with which to associate QoS
  specifications.

.. _cinder_qos-create:

cinder qos-create
-----------------

.. code-block:: console

   usage: cinder qos-create <name> <key=value> [<key=value> ...]

Creates a qos specs.

**Positional arguments:**

``<name>``
  Name of new QoS specifications.

``<key=value>``
  QoS specifications.

.. _cinder_qos-delete:

cinder qos-delete
-----------------

.. code-block:: console

   usage: cinder qos-delete [--force [<True|False>]] <qos_specs>

Deletes a specified qos specs.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications to delete.

**Optional arguments:**

``--force [<True|False>]``
  Enables or disables deletion of in-use QoS
  specifications. Default=False.

.. _cinder_qos-disassociate:

cinder qos-disassociate
-----------------------

.. code-block:: console

   usage: cinder qos-disassociate <qos_specs> <volume_type_id>

Disassociates qos specs from specified volume type.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications.

``<volume_type_id>``
  ID of volume type with which to associate QoS
  specifications.

.. _cinder_qos-disassociate-all:

cinder qos-disassociate-all
---------------------------

.. code-block:: console

   usage: cinder qos-disassociate-all <qos_specs>

Disassociates qos specs from all its associations.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications on which to operate.

.. _cinder_qos-get-association:

cinder qos-get-association
--------------------------

.. code-block:: console

   usage: cinder qos-get-association <qos_specs>

Lists all associations for specified qos specs.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications.

.. _cinder_qos-key:

cinder qos-key
--------------

.. code-block:: console

   usage: cinder qos-key <qos_specs> <action> key=value [key=value ...]

Sets or unsets specifications for a qos spec.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications.

``<action>``
  The action. Valid values are "set" or "unset."

``key=value``
  Metadata key and value pair to set or unset. For unset, specify
  only the key.

.. _cinder_qos-list:

cinder qos-list
---------------

.. code-block:: console

   usage: cinder qos-list

Lists qos specs.

.. _cinder_qos-show:

cinder qos-show
---------------

.. code-block:: console

   usage: cinder qos-show <qos_specs>

Shows qos specs details.

**Positional arguments:**

``<qos_specs>``
  ID of QoS specifications to show.

.. _cinder_quota-class-show:

cinder quota-class-show
-----------------------

.. code-block:: console

   usage: cinder quota-class-show <class>

Lists quotas for a quota class.

**Positional arguments:**

``<class>``
  Name of quota class for which to list quotas.

.. _cinder_quota-class-update:

cinder quota-class-update
-------------------------

.. code-block:: console

   usage: cinder quota-class-update [--volumes <volumes>]
                                    [--snapshots <snapshots>]
                                    [--gigabytes <gigabytes>]
                                    [--volume-type <volume_type_name>]
                                    <class_name>

Updates quotas for a quota class.

**Positional arguments:**

``<class_name>``
  Name of quota class for which to set quotas.

**Optional arguments:**

``--volumes <volumes>``
  The new "volumes" quota value. Default=None.

``--snapshots <snapshots>``
  The new "snapshots" quota value. Default=None.

``--gigabytes <gigabytes>``
  The new "gigabytes" quota value. Default=None.

``--volume-type <volume_type_name>``
  Volume type. Default=None.

.. _cinder_quota-defaults:

cinder quota-defaults
---------------------

.. code-block:: console

   usage: cinder quota-defaults <tenant_id>

Lists default quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  ID of tenant for which to list quota defaults.

.. _cinder_quota-delete:

cinder quota-delete
-------------------

.. code-block:: console

   usage: cinder quota-delete <tenant_id>

Delete the quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  UUID of tenant to delete the quotas for.

.. _cinder_quota-show:

cinder quota-show
-----------------

.. code-block:: console

   usage: cinder quota-show <tenant_id>

Lists quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  ID of tenant for which to list quotas.

.. _cinder_quota-update:

cinder quota-update
-------------------

.. code-block:: console

   usage: cinder quota-update [--volumes <volumes>] [--snapshots <snapshots>]
                              [--gigabytes <gigabytes>] [--backups <backups>]
                              [--backup-gigabytes <backup_gigabytes>]
                              [--consistencygroups <consistencygroups>]
                              [--groups <groups>]
                              [--volume-type <volume_type_name>]
                              [--per-volume-gigabytes <per_volume_gigabytes>]
                              <tenant_id>

Updates quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  ID of tenant for which to set quotas.

**Optional arguments:**

``--volumes <volumes>``
  The new "volumes" quota value. Default=None.

``--snapshots <snapshots>``
  The new "snapshots" quota value. Default=None.

``--gigabytes <gigabytes>``
  The new "gigabytes" quota value. Default=None.

``--backups <backups>``
  The new "backups" quota value. Default=None.

``--backup-gigabytes <backup_gigabytes>``
  The new "backup_gigabytes" quota value. Default=None.

``--consistencygroups <consistencygroups>``
  The new "consistencygroups" quota value. Default=None.

``--groups <groups>``
  The new "groups" quota value. Default=None. (Supported
  by API version 3.13 and later)

``--volume-type <volume_type_name>``
  Volume type. Default=None.

``--per-volume-gigabytes <per_volume_gigabytes>``
  Set max volume size limit. Default=None.

.. _cinder_quota-usage:

cinder quota-usage
------------------

.. code-block:: console

   usage: cinder quota-usage <tenant_id>

Lists quota usage for a tenant.

**Positional arguments:**

``<tenant_id>``
  ID of tenant for which to list quota usage.

.. _cinder_rate-limits:

cinder rate-limits
------------------

.. code-block:: console

   usage: cinder rate-limits [<tenant_id>]

Lists rate limits for a user.

**Positional arguments:**

``<tenant_id>``
  Display information for a single tenant (Admin only).

.. _cinder_readonly-mode-update:

cinder readonly-mode-update
---------------------------

.. code-block:: console

   usage: cinder readonly-mode-update <volume> <True|true|False|false>

Updates volume read-only access-mode flag.

**Positional arguments:**

``<volume>``
  ID of volume to update.

``<True|true|False|false>``
  Enables or disables update of volume to read-only
  access mode.

.. _cinder_rename:

cinder rename
-------------

.. code-block:: console

   usage: cinder rename [--description <description>] <volume> [<name>]

Renames a volume.

**Positional arguments:**

``<volume>``
  Name or ID of volume to rename.

``<name>``
  New name for volume.

**Optional arguments:**

``--description <description>``
  Volume description. Default=None.

.. _cinder_replication-promote:

cinder replication-promote
--------------------------

.. code-block:: console

   usage: cinder replication-promote <volume>

Promote a secondary volume to primary for a relationship.

**Positional arguments:**

``<volume>``
  Name or ID of the volume to promote. The volume should have the
  replica volume created with source-replica argument.

.. _cinder_replication-reenable:

cinder replication-reenable
---------------------------

.. code-block:: console

   usage: cinder replication-reenable <volume>

Sync the secondary volume with primary for a relationship.

**Positional arguments:**

``<volume>``
  Name
  or
  ID
  of
  the
  volume
  to
  reenable
  replication.
  The
  replication-status
  of
  the
  volume
  should
  be
  inactive.

.. _cinder_reset-state:

cinder reset-state
------------------

.. code-block:: console

   usage: cinder reset-state [--type <type>] [--state <state>]
                             [--attach-status <attach-status>]
                             [--reset-migration-status]
                             <entity> [<entity> ...]

Explicitly updates the entity state in the Cinder database. Being a database
change only, this has no impact on the true state of the entity and may not
match the actual state. This can render a entity unusable in the case of
changing to the 'available' state.

**Positional arguments:**

``<entity>``
  Name or ID of entity to update.

**Optional arguments:**

``--type <type>``
  Type of entity to update. Available resources are:
  'volume', 'snapshot', 'backup', 'group' (since 3.20)
  and 'group-snapshot' (since 3.19), Default=volume.

``--state <state>``
  The state to assign to the entity. NOTE: This command
  simply changes the state of the entity in the database
  with no regard to actual status, exercise caution when
  using. Default=None, that means the state is
  unchanged.

``--attach-status <attach-status>``
  This is only used for a volume entity. The attach
  status to assign to the volume in the database, with
  no regard to the actual status. Valid values are
  "attached" and "detached". Default=None, that means
  the status is unchanged.

``--reset-migration-status``
  This is only used for a volume entity. Clears the
  migration status of the volume in the DataBase that
  indicates the volume is source or destination of
  volume migration, with no regard to the actual status.

.. _cinder_retype:

cinder retype
-------------

.. code-block:: console

   usage: cinder retype [--migration-policy <never|on-demand>]
                        <volume> <volume-type>

Changes the volume type for a volume.

**Positional arguments:**

``<volume>``
  Name or ID of volume for which to modify type.

``<volume-type>``
  New volume type.

**Optional arguments:**

``--migration-policy <never|on-demand>``
  Migration policy during retype of volume.

.. _cinder_service-disable:

cinder service-disable
----------------------

.. code-block:: console

   usage: cinder service-disable [--reason <reason>] <hostname> <binary>

Disables the service.

**Positional arguments:**

``<hostname>``
  Host name.

``<binary>``
  Service binary.

**Optional arguments:**

``--reason <reason>``
  Reason for disabling service.

.. _cinder_service-enable:

cinder service-enable
---------------------

.. code-block:: console

   usage: cinder service-enable <hostname> <binary>

Enables the service.

**Positional arguments:**

``<hostname>``
  Host name.

``<binary>``
  Service binary.

.. _cinder_service-list:

cinder service-list
-------------------

.. code-block:: console

   usage: cinder service-list [--host <hostname>] [--binary <binary>]
                              [--withreplication [<True|False>]]

Lists all services. Filter by host and service binary.

**Optional arguments:**

``--host <hostname>``
  Host name. Default=None.

``--binary <binary>``
  Service binary. Default=None.

``--withreplication [<True|False>]``
  Enables or disables display of Replication info for
  c-vol services. Default=False. (Supported by API
  version 3.7 and later)

.. _cinder_set-bootable:

cinder set-bootable
-------------------

.. code-block:: console

   usage: cinder set-bootable <volume> <True|true|False|false>

Update bootable status of a volume.

**Positional arguments:**

``<volume>``
  ID of the volume to update.

``<True|true|False|false>``
  Flag to indicate whether volume is bootable.

.. _cinder_show:

cinder show
-----------

.. code-block:: console

   usage: cinder show <volume>

Shows volume details.

**Positional arguments:**

``<volume>``
  Name or ID of volume.

.. _cinder_snapshot-create:

cinder snapshot-create
----------------------

.. code-block:: console

   usage: cinder snapshot-create [--force [<True|False>]] [--name <name>]
                                 [--description <description>]
                                 [--metadata [<key=value> [<key=value> ...]]]
                                 <volume>

Creates a snapshot.

**Positional arguments:**

``<volume>``
  Name or ID of volume to snapshot.

**Optional arguments:**

``--force [<True|False>]``
  Allows or disallows snapshot of a volume when the
  volume is attached to an instance. If set to True,
  ignores the current status of the volume when
  attempting to snapshot it rather than forcing it to be
  available. Default=False.

``--name <name>``
  Snapshot name. Default=None.

``--description <description>``
  Snapshot description. Default=None.

``--metadata [<key=value> [<key=value> ...]]``
  Snapshot metadata key and value pairs. Default=None.

.. _cinder_snapshot-delete:

cinder snapshot-delete
----------------------

.. code-block:: console

   usage: cinder snapshot-delete [--force] <snapshot> [<snapshot> ...]

Removes one or more snapshots.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot(s) to delete.

**Optional arguments:**

``--force``
  Allows deleting snapshot of a volume when its status is other
  than "available" or "error". Default=False.

.. _cinder_snapshot-list:

cinder snapshot-list
--------------------

.. code-block:: console

   usage: cinder snapshot-list [--all-tenants [<0|1>]] [--name <name>]
                               [--status <status>] [--volume-id <volume-id>]
                               [--marker <marker>] [--limit <limit>]
                               [--sort <key>[:<direction>]] [--tenant [<tenant>]]
                               [--metadata [<key=value> [<key=value> ...]]]
                               [--filters [<key=value> [<key=value> ...]]]

Lists all snapshots.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

``--name <name>``
  Filters results by a name. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--status <status>``
  Filters results by a status. Default=None. This option
  is deprecated and will be removed in newer release.
  Please use '--filters' option which is introduced
  since 3.33 instead.

``--volume-id <volume-id>``
  Filters results by a volume ID. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead.

``--marker <marker>``
  Begin returning snapshots that appear later in the
  snapshot list than that represented by this id.
  Default=None.

``--limit <limit>``
  Maximum number of snapshots to return. Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: id,
  status, size, availability_zone, name, bootable,
  created_at, reference. Default=None.

``--tenant [<tenant>]``
  Display information from single tenant (Admin only).

``--metadata [<key=value> [<key=value> ...]]``
  Filters results by a metadata key and value pair.
  Require volume api version >=3.22. Default=None. This
  option is deprecated and will be removed in newer
  release. Please use '--filters' option which is
  introduced since 3.33 instead. (Supported by API
  version 3.22 and later)

``--filters [<key=value> [<key=value> ...]]``
  Filter
  key
  and
  value
  pairs.
  Please
  use
  'cinder
  list-filters'
  to
  check
  enabled
  filters
  from
  server,
  Default=None. (Supported by API version 3.33 and
  later)

.. _cinder_snapshot-manage:

cinder snapshot-manage
----------------------

.. code-block:: console

   usage: cinder snapshot-manage [--id-type <id-type>] [--name <name>]
                                 [--description <description>]
                                 [--metadata [<key=value> [<key=value> ...]]]
                                 <volume> <identifier>

Manage an existing snapshot.

**Positional arguments:**

``<volume>``
  Cinder volume already exists in volume backend

``<identifier>``
  Name or other Identifier for existing snapshot

**Optional arguments:**

``--id-type <id-type>``
  Type of backend device identifier provided, typically
  source-name or source-id (Default=source-name)

``--name <name>``
  Snapshot name (Default=None)

``--description <description>``
  Snapshot description (Default=None)

``--metadata [<key=value> [<key=value> ...]]``
  Metadata key=value pairs (Default=None)

.. _cinder_snapshot-manageable-list:

cinder snapshot-manageable-list
-------------------------------

.. code-block:: console

   usage: cinder snapshot-manageable-list [--detailed <detailed>]
                                          [--marker <marker>] [--limit <limit>]
                                          [--offset <offset>]
                                          [--sort <key>[:<direction>]]
                                          <host>

Lists all manageable snapshots.

**Positional arguments:**

``<host>``
  Cinder host on which to list manageable snapshots;
  takes the form: host@backend-name#pool

**Optional arguments:**

``--detailed <detailed>``
  Returned detailed information (default true).

``--marker <marker>``
  Begin returning volumes that appear later in the
  volume list than that represented by this reference.
  This reference should be json like. Default=None.

``--limit <limit>``
  Maximum number of volumes to return. Default=None.

``--offset <offset>``
  Number of volumes to skip after marker. Default=None.

``--sort <key>[:<direction>]``
  Comma-separated list of sort keys and directions in
  the form of <key>[:<asc|desc>]. Valid keys: size,
  reference. Default=None.

.. _cinder_snapshot-metadata:

cinder snapshot-metadata
------------------------

.. code-block:: console

   usage: cinder snapshot-metadata <snapshot> <action> <key=value>
                                   [<key=value> ...]

Sets or deletes snapshot metadata.

**Positional arguments:**

``<snapshot>``
  ID of snapshot for which to update metadata.

``<action>``
  The action. Valid values are "set" or "unset."

``<key=value>``
  Metadata key and value pair to set or unset. For unset, specify
  only the key.

.. _cinder_snapshot-metadata-show:

cinder snapshot-metadata-show
-----------------------------

.. code-block:: console

   usage: cinder snapshot-metadata-show <snapshot>

Shows snapshot metadata.

**Positional arguments:**

``<snapshot>``
  ID of snapshot.

.. _cinder_snapshot-metadata-update-all:

cinder snapshot-metadata-update-all
-----------------------------------

.. code-block:: console

   usage: cinder snapshot-metadata-update-all <snapshot> <key=value>
                                              [<key=value> ...]

Updates snapshot metadata.

**Positional arguments:**

``<snapshot>``
  ID of snapshot for which to update metadata.

``<key=value>``
  Metadata key and value pair to update.

.. _cinder_snapshot-rename:

cinder snapshot-rename
----------------------

.. code-block:: console

   usage: cinder snapshot-rename [--description <description>]
                                 <snapshot> [<name>]

Renames a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of snapshot.

``<name>``
  New name for snapshot.

**Optional arguments:**

``--description <description>``
  Snapshot description. Default=None.

.. _cinder_snapshot-reset-state:

cinder snapshot-reset-state
---------------------------

.. code-block:: console

   usage: cinder snapshot-reset-state [--state <state>]
                                      <snapshot> [<snapshot> ...]

Explicitly updates the snapshot state.

**Positional arguments:**

``<snapshot>``
  Name or ID of snapshot to modify.

**Optional arguments:**

``--state <state>``
  The state to assign to the snapshot. Valid values are
  "available", "error", "creating", "deleting", and
  "error_deleting". NOTE: This command simply changes the
  state of the Snapshot in the DataBase with no regard to
  actual status, exercise caution when using.
  Default=available.

.. _cinder_snapshot-show:

cinder snapshot-show
--------------------

.. code-block:: console

   usage: cinder snapshot-show <snapshot>

Shows snapshot details.

**Positional arguments:**

``<snapshot>``
  Name or ID of snapshot.

.. _cinder_snapshot-unmanage:

cinder snapshot-unmanage
------------------------

.. code-block:: console

   usage: cinder snapshot-unmanage <snapshot>

Stop managing a snapshot.

**Positional arguments:**

``<snapshot>``
  Name or ID of the snapshot to unmanage.

.. _cinder_thaw-host:

cinder thaw-host
----------------

.. code-block:: console

   usage: cinder thaw-host <hostname>

Thaw and enable the specified cinder-volume host.

**Positional arguments:**

``<hostname>``
  Host name.

.. _cinder_transfer-accept:

cinder transfer-accept
----------------------

.. code-block:: console

   usage: cinder transfer-accept <transfer> <auth_key>

Accepts a volume transfer.

**Positional arguments:**

``<transfer>``
  ID of transfer to accept.

``<auth_key>``
  Authentication key of transfer to accept.

.. _cinder_transfer-create:

cinder transfer-create
----------------------

.. code-block:: console

   usage: cinder transfer-create [--name <name>] <volume>

Creates a volume transfer.

**Positional arguments:**

``<volume>``
  Name or ID of volume to transfer.

**Optional arguments:**

``--name <name>``
  Transfer name. Default=None.

.. _cinder_transfer-delete:

cinder transfer-delete
----------------------

.. code-block:: console

   usage: cinder transfer-delete <transfer>

Undoes a transfer.

**Positional arguments:**

``<transfer>``
  Name or ID of transfer to delete.

.. _cinder_transfer-list:

cinder transfer-list
--------------------

.. code-block:: console

   usage: cinder transfer-list [--all-tenants [<0|1>]]

Lists all transfers.

**Optional arguments:**

``--all-tenants [<0|1>]``
  Shows details for all tenants. Admin only.

.. _cinder_transfer-show:

cinder transfer-show
--------------------

.. code-block:: console

   usage: cinder transfer-show <transfer>

Shows transfer details.

**Positional arguments:**

``<transfer>``
  Name or ID of transfer to accept.

.. _cinder_type-access-add:

cinder type-access-add
----------------------

.. code-block:: console

   usage: cinder type-access-add --volume-type <volume_type> --project-id
                                 <project_id>

Adds volume type access for the given project.

**Optional arguments:**

``--volume-type <volume_type>``
  Volume type name or ID to add access for the given
  project.

``--project-id <project_id>``
  Project ID to add volume type access for.

.. _cinder_type-access-list:

cinder type-access-list
-----------------------

.. code-block:: console

   usage: cinder type-access-list --volume-type <volume_type>

Print access information about the given volume type.

**Optional arguments:**

``--volume-type <volume_type>``
  Filter results by volume type name or ID.

.. _cinder_type-access-remove:

cinder type-access-remove
-------------------------

.. code-block:: console

   usage: cinder type-access-remove --volume-type <volume_type> --project-id
                                    <project_id>

Removes volume type access for the given project.

**Optional arguments:**

``--volume-type <volume_type>``
  Volume type name or ID to remove access for the given
  project.

``--project-id <project_id>``
  Project ID to remove volume type access for.

.. _cinder_type-create:

cinder type-create
------------------

.. code-block:: console

   usage: cinder type-create [--description <description>]
                             [--is-public <is-public>]
                             <name>

Creates a volume type.

**Positional arguments:**

``<name>``
  Name of new volume type.

**Optional arguments:**

``--description <description>``
  Description of new volume type.

``--is-public <is-public>``
  Make type accessible to the public (default true).

.. _cinder_type-default:

cinder type-default
-------------------

.. code-block:: console

   usage: cinder type-default

List the default volume type.

.. _cinder_type-delete:

cinder type-delete
------------------

.. code-block:: console

   usage: cinder type-delete <vol_type> [<vol_type> ...]

Deletes volume type or types.

**Positional arguments:**

``<vol_type>``
  Name or ID of volume type or types to delete.

.. _cinder_type-key:

cinder type-key
---------------

.. code-block:: console

   usage: cinder type-key <vtype> <action> <key=value> [<key=value> ...]

Sets or unsets extra_spec for a volume type.

**Positional arguments:**

``<vtype>``
  Name or ID of volume type.

``<action>``
  The action. Valid values are "set" or "unset."

``<key=value>``
  The extra specs key and value pair to set or unset. For unset,
  specify only the key.

.. _cinder_type-list:

cinder type-list
----------------

.. code-block:: console

   usage: cinder type-list

Lists available 'volume types'. (Only admin and tenant users will see private
types)

.. _cinder_type-show:

cinder type-show
----------------

.. code-block:: console

   usage: cinder type-show <volume_type>

Show volume type details.

**Positional arguments:**

``<volume_type>``
  Name or ID of the volume type.

.. _cinder_type-update:

cinder type-update
------------------

.. code-block:: console

   usage: cinder type-update [--name <name>] [--description <description>]
                             [--is-public <is-public>]
                             <id>

Updates volume type name, description, and/or is_public.

**Positional arguments:**

``<id>``
  ID of the volume type.

**Optional arguments:**

``--name <name>``
  Name of the volume type.

``--description <description>``
  Description of the volume type.

``--is-public <is-public>``
  Make type accessible to the public or not.

.. _cinder_unmanage:

cinder unmanage
---------------

.. code-block:: console

   usage: cinder unmanage <volume>

Stop managing a volume.

**Positional arguments:**

``<volume>``
  Name or ID of the volume to unmanage.

.. _cinder_upload-to-image:

cinder upload-to-image
----------------------

.. code-block:: console

   usage: cinder upload-to-image [--force [<True|False>]]
                                 [--container-format <container-format>]
                                 [--disk-format <disk-format>]
                                 [--visibility <public|private>]
                                 [--protected <True|False>]
                                 <volume> <image-name>

Uploads volume to Image Service as an image.

**Positional arguments:**

``<volume>``
  Name or ID of volume to snapshot.

``<image-name>``
  The new image name.

**Optional arguments:**

``--force [<True|False>]``
  Enables or disables upload of a volume that is
  attached to an instance. Default=False. This option
  may not be supported by your cloud.

``--container-format <container-format>``
  Container format type. Default is bare.

``--disk-format <disk-format>``
  Disk format type. Default is raw.

``--visibility <public|private>``
  Set image visibility to either public or private.
  Default=private. (Supported by API version 3.1 and
  later)

``--protected <True|False>``
  Prevents image from being deleted. Default=False.
  (Supported by API version 3.1 and later)

.. _cinder_version-list:

cinder version-list
-------------------

.. code-block:: console

   usage: cinder version-list

List all API versions.

