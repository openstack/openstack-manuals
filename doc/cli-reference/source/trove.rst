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

============================================
Database service (trove) command-line client
============================================

The trove client is the command-line interface (CLI) for
the Database service (trove) API and its extensions.

This chapter documents :command:`trove` version ``2.10.0``.

For help on a specific :command:`trove` command, enter:

.. code-block:: console

   $ trove help COMMAND

.. _trove_command_usage:

trove usage
~~~~~~~~~~~

.. code-block:: console

   usage: trove [--version] [--debug] [--service-type <service-type>]
                [--service-name <service-name>] [--bypass-url <bypass-url>]
                [--database-service-name <database-service-name>]
                [--endpoint-type <endpoint-type>]
                [--os-database-api-version <database-api-ver>]
                [--retries <retries>] [--json] [--profile HMAC_KEY] [--insecure]
                [--os-cacert <ca-certificate>] [--os-cert <certificate>]
                [--os-key <key>] [--timeout <seconds>] [--os-auth-type <name>]
                [--os-auth-url OS_AUTH_URL] [--os-domain-id OS_DOMAIN_ID]
                [--os-domain-name OS_DOMAIN_NAME] [--os-project-id OS_PROJECT_ID]
                [--os-project-name OS_PROJECT_NAME]
                [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                [--os-trust-id OS_TRUST_ID]
                [--os-default-domain-id OS_DEFAULT_DOMAIN_ID]
                [--os-default-domain-name OS_DEFAULT_DOMAIN_NAME]
                [--os-user-id OS_USER_ID] [--os-username OS_USERNAME]
                [--os-user-domain-id OS_USER_DOMAIN_ID]
                [--os-user-domain-name OS_USER_DOMAIN_NAME]
                [--os-password OS_PASSWORD] [--os-region-name <region-name>]
                <subcommand> ...

**Subcommands:**

``backup-copy``
  Creates a backup from another backup.

``backup-create``
  Creates a backup of an instance.

``backup-delete``
  Deletes a backup.

``backup-list``
  Lists available backups.

``backup-list-instance``
  Lists available backups for an instance.

``backup-show``
  Shows details of a backup.

``cluster-create``
  Creates a new cluster.

``cluster-delete``
  Deletes a cluster.

``cluster-force-delete``
  Force delete a cluster

``cluster-grow``
  Adds more instances to a cluster.

``cluster-instances``
  Lists all instances of a cluster.

``cluster-list``
  Lists all the clusters.

``cluster-modules``
  Lists all modules for each instance of a
  cluster.

``cluster-reset-status``
  Set the cluster task to NONE.

``cluster-show``
  Shows details of a cluster.

``cluster-shrink``
  Drops instances from a cluster.

``cluster-upgrade``
  Upgrades a cluster to a new datastore
  version.

``configuration-attach``
  Attaches a configuration group to an
  instance.

``configuration-create``
  Creates a configuration group.

``configuration-default``
  Shows the default configuration of an
  instance.

``configuration-delete``
  Deletes a configuration group.

``configuration-detach``
  Detaches a configuration group from an
  instance.

``configuration-instances``
  Lists all instances associated with a
  configuration group.

``configuration-list``
  Lists all configuration groups.

``configuration-parameter-list``
  Lists available parameters for a
  configuration group.

``configuration-parameter-show``
  Shows details of a configuration parameter.

``configuration-patch``
  Patches a configuration group.

``configuration-show``
  Shows details of a configuration group.

``configuration-update``
  Updates a configuration group.

``create``
  Creates a new instance.

``database-create``
  Creates a database on an instance.

``database-delete``
  Deletes a database from an instance.

``database-list``
  Lists available databases on an instance.

``datastore-list``
  Lists available datastores.

``datastore-show``
  Shows details of a datastore.

``datastore-version-list``
  Lists available versions for a datastore.

``datastore-version-show``
  Shows details of a datastore version.

``delete``
  Deletes an instance.

``detach-replica``
  Detaches a replica instance from its
  replication source.

``eject-replica-source``
  Ejects a replica source from its set.

``execution-delete``
  Deletes an execution.

``execution-list``
  Lists executions of a scheduled backup of an
  instance.

``flavor-list``
  Lists available flavors.

``flavor-show``
  Shows details of a flavor.

``force-delete``
  Force delete an instance.

``limit-list``
  Lists the limits for a tenant.

``list``
  Lists all the instances.

``log-disable``
  Instructs Trove guest to stop collecting log
  details.

``log-discard``
  Instructs Trove guest to discard the
  container of the published log.

``log-enable``
  Instructs Trove guest to start collecting
  log details.

``log-list``
  Lists the log files available for instance.

``log-publish``
  Instructs Trove guest to publish latest log
  entries on instance.

``log-save``
  Save log file for instance.

``log-show``
  Instructs Trove guest to show details of
  log.

``log-tail``
  Display log entries for instance.

``metadata-create``
  Creates metadata in the database for
  instance <id>.

``metadata-delete``
  Deletes metadata for instance <id>.

``metadata-edit``
  Replaces metadata value with a new one, this
  is non-destructive.

``metadata-list``
  Shows all metadata for instance <id>.

``metadata-show``
  Shows metadata entry for key <key> and
  instance <id>.

``metadata-update``
  Updates metadata, this is destructive.

``module-apply``
  Apply modules to an instance.

``module-create``
  Create a module.

``module-delete``
  Delete a module.

``module-instance-count``
  Lists a count of the instances for each
  module md5.

``module-instances``
  Lists the instances that have a particular
  module applied.

``module-list``
  Lists the modules available.

``module-list-instance``
  Lists the modules that have been applied to
  an instance.

``module-query``
  Query the status of the modules on an
  instance.

``module-reapply``
  Reapply a module.

``module-remove``
  Remove a module from an instance.

``module-retrieve``
  Retrieve module contents from an instance.

``module-show``
  Shows details of a module.

``module-update``
  Update a module.

``promote-to-replica-source``
  Promotes a replica to be the new replica
  source of its set.

``quota-show``
  Show quotas for a tenant.

``quota-update``
  Update quotas for a tenant.

``reset-status``
  Set the status to NONE.

``resize-instance``
  Resizes an instance with a new flavor.

``resize-volume``
  Resizes the volume size of an instance.

``restart``
  Restarts an instance.

``root-disable``
  Disables root for an instance.

``root-enable``
  Enables root for an instance and resets if
  already exists.

``root-show``
  Gets status if root was ever enabled for an
  instance or cluster.

``schedule-create``
  Schedules backups for an instance.

``schedule-delete``
  Deletes a schedule.

``schedule-list``
  Lists scheduled backups for an instance.

``schedule-show``
  Shows details of a schedule.

``secgroup-add-rule``
  Creates a security group rule.

``secgroup-delete-rule``
  Deletes a security group rule.

``secgroup-list``
  Lists all security groups.

``secgroup-list-rules``
  Lists all rules for a security group.

``secgroup-show``
  Shows details of a security group.

``show``
  Shows details of an instance.

``update``
  Updates an instance: Edits name,
  configuration, or replica source.

``upgrade``
  Upgrades an instance to a new datastore
  version.

``user-create``
  Creates a user on an instance.

``user-delete``
  Deletes a user from an instance.

``user-grant-access``
  Grants access to a database(s) for a user.

``user-list``
  Lists the users for an instance.

``user-revoke-access``
  Revokes access to a database for a user.

``user-show``
  Shows details of a user of an instance.

``user-show-access``
  Shows access details of a user of an
  instance.

``user-update-attributes``
  Updates a user's attributes on an instance.

``volume-type-list``
  Lists available volume types.

``volume-type-show``
  Shows details of a volume type.

``bash-completion``
  Prints arguments for bash_completion.

``help``
  Displays help about this program or one of
  its subcommands.

.. _trove_command_options:

trove optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Show program's version number and exit.

``--debug``
  Print debugging output.

``--service-type <service-type>``
  Defaults to database for most actions.

``--service-name <service-name>``
  Defaults to ``env[TROVE_SERVICE_NAME]``.

``--bypass-url <bypass-url>``
  Defaults to ``env[TROVE_BYPASS_URL]``.

``--database-service-name <database-service-name>``
  Defaults to
  ``env[TROVE_DATABASE_SERVICE_NAME]``.

``--endpoint-type <endpoint-type>``
  Defaults to ``env[TROVE_ENDPOINT_TYPE]`` or
  ``env[OS_ENDPOINT_TYPE]`` or publicURL.

``--os-database-api-version <database-api-ver>``
  Accepts 1, defaults to
  ``env[OS_DATABASE_API_VERSION]``.

``--retries <retries>``
  Number of retries.

``--json, --os-json-output``
  Output JSON instead of prettyprint. Defaults
  to ``env[OS_JSON_OUTPUT]``.

``--profile HMAC_KEY``
  HMAC key used to encrypt context data when
  profiling the performance of an operation.
  This key should be set to one of the HMAC
  keys configured in Trove (they are found in
  api-paste.ini, typically in /etc/trove).
  Without the key, profiling will not be
  triggered even if it is enabled on the
  server side. Defaults to
  ``env[OS_PROFILE_HMACKEY]``.

``--os-auth-type <name>, --os-auth-plugin <name>``
  Authentication type to use

``--os-region-name <region-name>``
  Specify the region to use. Defaults to
  ``env[OS_REGION_NAME]``.

.. _trove_backup-copy:

trove backup-copy
-----------------

.. code-block:: console

   usage: trove backup-copy [--description <description>] <name> <backup>

Creates a backup from another backup.

**Positional arguments:**

``<name>``
  Name of the backup.

``<backup>``
  Backup ID of the source backup.

**Optional arguments:**

``--description <description>``
  An optional description for the backup.

.. _trove_backup-create:

trove backup-create
-------------------

.. code-block:: console

   usage: trove backup-create <instance> <name>
                              [--description <description>] [--parent <parent>]
                              [--incremental]

Creates a backup of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of the backup.

**Optional arguments:**

``--description <description>``
  An optional description for the backup.

``--parent <parent>``
  Optional ID of the parent backup to perform an
  incremental backup from.

``--incremental``
  Create an incremental backup based on the last
  full or incremental backup. It will create a
  full backup if no existing backup found.

.. _trove_backup-delete:

trove backup-delete
-------------------

.. code-block:: console

   usage: trove backup-delete <backup>

Deletes a backup.

**Positional arguments:**

``<backup>``
  ID or name of the backup.

.. _trove_backup-list:

trove backup-list
-----------------

.. code-block:: console

   usage: trove backup-list [--limit <limit>] [--marker <ID>]
                            [--datastore <datastore>]

Lists available backups.

**Optional arguments:**

``--limit <limit>``
  Return up to N number of the most recent backups.

``--marker <ID>``
  Begin displaying the results for IDs greater than
  the specified marker. When used with --limit, set
  this to the last ID displayed in the previous run.

``--datastore <datastore>``
  ID or name of the datastore (to filter backups by).

.. _trove_backup-list-instance:

trove backup-list-instance
--------------------------

.. code-block:: console

   usage: trove backup-list-instance [--limit <limit>] [--marker <ID>] <instance>

Lists available backups for an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

**Optional arguments:**

``--limit <limit>``
  Return up to N number of the most recent backups.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to the
  last ID displayed in the previous run.

.. _trove_backup-show:

trove backup-show
-----------------

.. code-block:: console

   usage: trove backup-show <backup>

Shows details of a backup.

**Positional arguments:**

``<backup>``
  ID or name of the backup.

.. _trove_cluster-create:

trove cluster-create
--------------------

.. code-block:: console

   usage: trove cluster-create <name> <datastore> <datastore_version>
                               [--instance "opt=<value>[,opt=<value> ...] "]
                               [--locality <policy>]

Creates a new cluster.

**Positional arguments:**

``<name>``
  Name of the cluster.

``<datastore>``
  A datastore name or ID.

``<datastore_version>``
  A datastore version name or ID.

**Optional arguments:**

``--instance "opt=<value>[,opt=<value> ...] "``
  Add an instance to the cluster. Specify
  multiple times to create multiple instances.
  Valid options are:
  flavor=<flavor_name_or_id>,
  volume=<disk_size_in_GB>,
  volume_type=<type>, nic='<net-id=<net-uuid>,
  v4-fixed-ip=<ip-addr>, port-id=<port-uuid>>'
  (where net-id=network_id, v4-fixed-ip=IPv4r_fixed_address, port-id=port_id),
  availability_zone=<AZ_hint_for_Nova>,
  module=<module_name_or_id>,
  type=<type_of_cluster_node>.

``--locality <policy>``
  Locality policy to use when creating
  cluster. Choose one of affinity, anti-affinity.

.. _trove_cluster-delete:

trove cluster-delete
--------------------

.. code-block:: console

   usage: trove cluster-delete <cluster>

Deletes a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-force-delete:

trove cluster-force-delete
--------------------------

.. code-block:: console

   usage: trove cluster-force-delete <cluster>

Force delete a cluster

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-grow:

trove cluster-grow
------------------

.. code-block:: console

   usage: trove cluster-grow <cluster>
                             [--instance "opt=<value>[,opt=<value> ...] "]

Adds more instances to a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

**Optional arguments:**

``--instance "opt=<value>[,opt=<value> ...] "``
  Add an instance to the cluster. Specify
  multiple times to create multiple instances.
  Valid options are:
  flavor=<flavor_name_or_id>,
  volume=<disk_size_in_GB>,
  volume_type=<type>, nic='<net-id=<net-uuid>,
  v4-fixed-ip=<ip-addr>, port-id=<port-uuid>>'
  (where net-id=network_id, v4-fixed-ip=IPv4r_fixed_address, port-id=port_id),
  availability_zone=<AZ_hint_for_Nova>,
  module=<module_name_or_id>,
  type=<type_of_cluster_node>.

.. _trove_cluster-instances:

trove cluster-instances
-----------------------

.. code-block:: console

   usage: trove cluster-instances <cluster>

Lists all instances of a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-list:

trove cluster-list
------------------

.. code-block:: console

   usage: trove cluster-list [--limit <limit>] [--marker <ID>]

Lists all the clusters.

**Optional arguments:**

``--limit <limit>``
  Limit the number of results displayed.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to the
  last ID displayed in the previous run.

.. _trove_cluster-modules:

trove cluster-modules
---------------------

.. code-block:: console

   usage: trove cluster-modules <cluster>

Lists all modules for each instance of a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-reset-status:

trove cluster-reset-status
--------------------------

.. code-block:: console

   usage: trove cluster-reset-status <cluster>

Set the cluster task to NONE.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-show:

trove cluster-show
------------------

.. code-block:: console

   usage: trove cluster-show <cluster>

Shows details of a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

.. _trove_cluster-shrink:

trove cluster-shrink
--------------------

.. code-block:: console

   usage: trove cluster-shrink <cluster> <instance> [<instance> ...]

Drops instances from a cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

``<instance>``
  Drop instance(s) from the cluster. Specify multiple ids to drop
  multiple instances.

.. _trove_cluster-upgrade:

trove cluster-upgrade
---------------------

.. code-block:: console

   usage: trove cluster-upgrade <cluster> <datastore_version>

Upgrades a cluster to a new datastore version.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster.

``<datastore_version>``
  A datastore version name or ID.

.. _trove_configuration-attach:

trove configuration-attach
--------------------------

.. code-block:: console

   usage: trove configuration-attach <instance> <configuration>

Attaches a configuration group to an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<configuration>``
  ID or name of the configuration group to attach to the
  instance.

.. _trove_configuration-create:

trove configuration-create
--------------------------

.. code-block:: console

   usage: trove configuration-create <name> <values>
                                     [--datastore <datastore>]
                                     [--datastore_version <datastore_version>]
                                     [--description <description>]

Creates a configuration group.

**Positional arguments:**

``<name>``
  Name of the configuration group.

``<values>``
  Dictionary of the values to set.

**Optional arguments:**

``--datastore <datastore>``
  Datastore assigned to the configuration
  group. Required if default datastore is not
  configured.

``--datastore_version <datastore_version>``
  Datastore version ID assigned to the
  configuration group.

``--description <description>``
  An optional description for the
  configuration group.

.. _trove_configuration-default:

trove configuration-default
---------------------------

.. code-block:: console

   usage: trove configuration-default <instance>

Shows the default configuration of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_configuration-delete:

trove configuration-delete
--------------------------

.. code-block:: console

   usage: trove configuration-delete <configuration_group>

Deletes a configuration group.

**Positional arguments:**

``<configuration_group>``
  ID or name of the configuration group.

.. _trove_configuration-detach:

trove configuration-detach
--------------------------

.. code-block:: console

   usage: trove configuration-detach <instance>

Detaches a configuration group from an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_configuration-instances:

trove configuration-instances
-----------------------------

.. code-block:: console

   usage: trove configuration-instances <configuration_group>
                                        [--limit <limit>] [--marker <ID>]

Lists all instances associated with a configuration group.

**Positional arguments:**

``<configuration_group>``
  ID or name of the configuration group.

**Optional arguments:**

``--limit <limit>``
  Limit the number of results displayed.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to
  the last ID displayed in the previous run.

.. _trove_configuration-list:

trove configuration-list
------------------------

.. code-block:: console

   usage: trove configuration-list [--limit <limit>] [--marker <ID>]

Lists all configuration groups.

**Optional arguments:**

``--limit <limit>``
  Limit the number of results displayed.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to the
  last ID displayed in the previous run.

.. _trove_configuration-parameter-list:

trove configuration-parameter-list
----------------------------------

.. code-block:: console

   usage: trove configuration-parameter-list <datastore_version>
                                             [--datastore <datastore>]

Lists available parameters for a configuration group.

**Positional arguments:**

``<datastore_version>``
  Datastore version name or ID assigned to the
  configuration group.

**Optional arguments:**

``--datastore <datastore>``
  ID or name of the datastore to list configuration
  parameters for. Optional if the ID of the
  datastore_version is provided.

.. _trove_configuration-parameter-show:

trove configuration-parameter-show
----------------------------------

.. code-block:: console

   usage: trove configuration-parameter-show <datastore_version> <parameter>
                                             [--datastore <datastore>]

Shows details of a configuration parameter.

**Positional arguments:**

``<datastore_version>``
  Datastore version name or ID assigned to the
  configuration group.

``<parameter>``
  Name of the configuration parameter.

**Optional arguments:**

``--datastore <datastore>``
  ID or name of the datastore to list configuration
  parameters for. Optional if the ID of the
  datastore_version is provided.

.. _trove_configuration-patch:

trove configuration-patch
-------------------------

.. code-block:: console

   usage: trove configuration-patch <configuration_group> <values>

Patches a configuration group.

**Positional arguments:**

``<configuration_group>``
  ID or name of the configuration group.

``<values>``
  Dictionary of the values to set.

.. _trove_configuration-show:

trove configuration-show
------------------------

.. code-block:: console

   usage: trove configuration-show <configuration_group>

Shows details of a configuration group.

**Positional arguments:**

``<configuration_group>``
  ID or name of the configuration group.

.. _trove_configuration-update:

trove configuration-update
--------------------------

.. code-block:: console

   usage: trove configuration-update <configuration_group> <values>
                                     [--name <name>]
                                     [--description <description>]

Updates a configuration group.

**Positional arguments:**

``<configuration_group>``
  ID or name of the configuration group.

``<values>``
  Dictionary of the values to set.

**Optional arguments:**

``--name <name>``
  Name of the configuration group.

``--description <description>``
  An optional description for the configuration
  group.

.. _trove_create:

trove create
------------

.. code-block:: console

   usage: trove create <name> <flavor>
                       [--size <size>] [--volume_type <volume_type>]
                       [--databases <database> [<database> ...]]
                       [--users <user:password> [<user:password> ...]]
                       [--backup <backup>]
                       [--availability_zone <availability_zone>]
                       [--datastore <datastore>]
                       [--datastore_version <datastore_version>]
                       [--nic <net-id=<net-uuid>,v4-fixed-ip=<ip-addr>,port-id=<port-uuid>>]
                       [--configuration <configuration>]
                       [--replica_of <source_instance>] [--replica_count <count>]
                       [--module <module>] [--locality <policy>]

Creates a new instance.

**Positional arguments:**

``<name>``
  Name of the instance.

``<flavor>``
  A flavor name or ID.

**Optional arguments:**

``--size <size>``
  Size of the instance disk volume in GB.
  Required when volume support is enabled.

``--volume_type <volume_type>``
  Volume type. Optional when volume support is
  enabled.

``--databases <database> [<database> ...]``
  Optional list of databases.

``--users <user:password> [<user:password> ...]``
  Optional list of users.

``--backup <backup>``
  A backup name or ID.

``--availability_zone <availability_zone>``
  The Zone hint to give to Nova.

``--datastore <datastore>``
  A datastore name or ID.

``--datastore_version <datastore_version>``
  A datastore version name or ID.

``--nic <net-id=<net-uuid>,v4-fixed-ip=<ip-addr>,port-id=<port-uuid>>``
  Create a NIC on the instance. Specify option
  multiple
  times
  to
  create
  multiple
  NICs.
  net-id:
  attach
  NIC
  to
  network
  with
  this
  ID
  (either port-id or net-id must be
  specified), v4-fixed-ip: IPv4 fixed address
  for NIC (optional), port-id: attach NIC to
  port with this ID (either port-id or net-id
  must be specified).

``--configuration <configuration>``
  ID of the configuration group to attach to
  the instance.

``--replica_of <source_instance>``
  ID or name of an existing instance to
  replicate from.

``--replica_count <count>``
  Number of replicas to create (defaults to 1
  if replica_of specified).

``--module <module>``
  ID or name of the module to apply. Specify
  multiple times to apply multiple modules.

``--locality <policy>``
  Locality policy to use when creating
  replicas. Choose one of affinity, anti-affinity.

.. _trove_database-create:

trove database-create
---------------------

.. code-block:: console

   usage: trove database-create <instance> <name>
                                [--character_set <character_set>]
                                [--collate <collate>]

Creates a database on an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of the database.

**Optional arguments:**

``--character_set <character_set>``
  Optional character set for database.

``--collate <collate>``
  Optional collation type for database.

.. _trove_database-delete:

trove database-delete
---------------------

.. code-block:: console

   usage: trove database-delete <instance> <database>

Deletes a database from an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<database>``
  Name of the database.

.. _trove_database-list:

trove database-list
-------------------

.. code-block:: console

   usage: trove database-list <instance>

Lists available databases on an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_datastore-list:

trove datastore-list
--------------------

.. code-block:: console

   usage: trove datastore-list

Lists available datastores.

.. _trove_datastore-show:

trove datastore-show
--------------------

.. code-block:: console

   usage: trove datastore-show <datastore>

Shows details of a datastore.

**Positional arguments:**

``<datastore>``
  ID of the datastore.

.. _trove_datastore-version-list:

trove datastore-version-list
----------------------------

.. code-block:: console

   usage: trove datastore-version-list <datastore>

Lists available versions for a datastore.

**Positional arguments:**

``<datastore>``
  ID or name of the datastore.

.. _trove_datastore-version-show:

trove datastore-version-show
----------------------------

.. code-block:: console

   usage: trove datastore-version-show <datastore_version>
                                       [--datastore <datastore>]

Shows details of a datastore version.

**Positional arguments:**

``<datastore_version>``
  ID or name of the datastore version.

**Optional arguments:**

``--datastore <datastore>``
  ID or name of the datastore. Optional if the ID of
  the datastore_version is provided.

.. _trove_delete:

trove delete
------------

.. code-block:: console

   usage: trove delete <instance>

Deletes an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_detach-replica:

trove detach-replica
--------------------

.. code-block:: console

   usage: trove detach-replica <instance>

Detaches a replica instance from its replication source.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_eject-replica-source:

trove eject-replica-source
--------------------------

.. code-block:: console

   usage: trove eject-replica-source <instance>

Ejects a replica source from its set.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_execution-delete:

trove execution-delete
----------------------

.. code-block:: console

   usage: trove execution-delete <execution>

Deletes an execution.

**Positional arguments:**

``<execution>``
  Id of the execution to delete.

.. _trove_execution-list:

trove execution-list
--------------------

.. code-block:: console

   usage: trove execution-list [--limit <limit>] [--marker <ID>] <schedule id>

Lists executions of a scheduled backup of an instance.

**Positional arguments:**

``<schedule id>``
  Id of the schedule.

**Optional arguments:**

``--limit <limit>``
  Return up to N number of the most recent executions.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to the
  last ID displayed in the previous run.

.. _trove_flavor-list:

trove flavor-list
-----------------

.. code-block:: console

   usage: trove flavor-list [--datastore_type <datastore_type>]
                            [--datastore_version_id <datastore_version_id>]

Lists available flavors.

**Optional arguments:**

``--datastore_type <datastore_type>``
  Type of the datastore. For eg: mysql.

``--datastore_version_id <datastore_version_id>``
  ID of the datastore version.

.. _trove_flavor-show:

trove flavor-show
-----------------

.. code-block:: console

   usage: trove flavor-show <flavor>

Shows details of a flavor.

**Positional arguments:**

``<flavor>``
  ID or name of the flavor.

.. _trove_force-delete:

trove force-delete
------------------

.. code-block:: console

   usage: trove force-delete <instance>

Force delete an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_limit-list:

trove limit-list
----------------

.. code-block:: console

   usage: trove limit-list

Lists the limits for a tenant.

.. _trove_list:

trove list
----------

.. code-block:: console

   usage: trove list [--limit <limit>] [--marker <ID>] [--include_clustered]

Lists all the instances.

**Optional arguments:**

``--limit <limit>``
  Limit the number of results displayed.

``--marker <ID>``
  Begin displaying the results for IDs greater
  than the specified marker. When used with
  --limit, set this to the last ID displayed
  in the previous run.

``--include_clustered, --include-clustered``
  Include instances that are part of a cluster
  (default False). --include-clustered may be
  deprecated in the future, retaining just
  --include_clustered.

.. _trove_log-disable:

trove log-disable
-----------------

.. code-block:: console

   usage: trove log-disable [--discard] <instance> <log_name>

Instructs Trove guest to stop collecting log details.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

**Optional arguments:**

``--discard``
  Discard published contents of specified log.

.. _trove_log-discard:

trove log-discard
-----------------

.. code-block:: console

   usage: trove log-discard <instance> <log_name>

Instructs Trove guest to discard the container of the published log.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

.. _trove_log-enable:

trove log-enable
----------------

.. code-block:: console

   usage: trove log-enable <instance> <log_name>

Instructs Trove guest to start collecting log details.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

.. _trove_log-list:

trove log-list
--------------

.. code-block:: console

   usage: trove log-list <instance>

Lists the log files available for instance.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

.. _trove_log-publish:

trove log-publish
-----------------

.. code-block:: console

   usage: trove log-publish [--disable] [--discard] <instance> <log_name>

Instructs Trove guest to publish latest log entries on instance.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

**Optional arguments:**

``--disable``
  Stop collection of specified log.

``--discard``
  Discard published contents of specified log.

.. _trove_log-save:

trove log-save
--------------

.. code-block:: console

   usage: trove log-save [--publish] [--file <file>] <instance> <log_name>

Save log file for instance.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

**Optional arguments:**

``--publish``
  Publish latest entries from guest before display.

``--file <file>``
  Path of file to save log to for instance.

.. _trove_log-show:

trove log-show
--------------

.. code-block:: console

   usage: trove log-show <instance> <log_name>

Instructs Trove guest to show details of log.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to show.

.. _trove_log-tail:

trove log-tail
--------------

.. code-block:: console

   usage: trove log-tail [--publish] [--lines <lines>] <instance> <log_name>

Display log entries for instance.

**Positional arguments:**

``<instance>``
  Id or Name of the instance.

``<log_name>``
  Name of log to publish.

**Optional arguments:**

``--publish``
  Publish latest entries from guest before display.

``--lines <lines>``
  Publish latest entries from guest before display.

.. _trove_metadata-create:

trove metadata-create
---------------------

.. code-block:: console

   usage: trove metadata-create <instance_id> <key> <value>

Creates metadata in the database for instance <id>.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

``<key>``
  Key for assignment.

``<value>``
  Value to assign to <key>.

.. _trove_metadata-delete:

trove metadata-delete
---------------------

.. code-block:: console

   usage: trove metadata-delete <instance_id> <key>

Deletes metadata for instance <id>.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

``<key>``
  Metadata key to delete.

.. _trove_metadata-edit:

trove metadata-edit
-------------------

.. code-block:: console

   usage: trove metadata-edit <instance_id> <key> <value>

Replaces metadata value with a new one, this is non-destructive.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

``<key>``
  Key to replace.

``<value>``
  New value to assign to <key>.

.. _trove_metadata-list:

trove metadata-list
-------------------

.. code-block:: console

   usage: trove metadata-list <instance_id>

Shows all metadata for instance <id>.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

.. _trove_metadata-show:

trove metadata-show
-------------------

.. code-block:: console

   usage: trove metadata-show <instance_id> <key>

Shows metadata entry for key <key> and instance <id>.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

``<key>``
  Key to display.

.. _trove_metadata-update:

trove metadata-update
---------------------

.. code-block:: console

   usage: trove metadata-update <instance_id> <key> <newkey> <value>

Updates metadata, this is destructive.

**Positional arguments:**

``<instance_id>``
  UUID for instance.

``<key>``
  Key to update.

``<newkey>``
  New key.

``<value>``
  Value to assign to <newkey>.

.. _trove_module-apply:

trove module-apply
------------------

.. code-block:: console

   usage: trove module-apply <instance> <module> [<module> ...]

Apply modules to an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<module>``
  ID or name of the module.

.. _trove_module-create:

trove module-create
-------------------

.. code-block:: console

   usage: trove module-create <name> <type> <filename>
                              [--description <description>]
                              [--datastore <datastore>]
                              [--datastore_version <version>] [--auto_apply]
                              [--all_tenants] [--hidden] [--live_update]
                              [--priority_apply]
                              [--apply_order {0,1,2,3,4,5,6,7,8,9}]
                              [--full_access]

Create a module.

**Positional arguments:**

``<name>``
  Name of the module.

``<type>``
  Type of the module. The type must be
  supported by a corresponding module plugin
  on the datastore it is applied to.

``<filename>``
  File containing data contents for the
  module.

**Optional arguments:**

``--description <description>``
  Description of the module.

``--datastore <datastore>``
  Name or ID of datastore this module can be
  applied to. If not specified, module can be
  applied to all datastores.

``--datastore_version <version>``
  Name or ID of datastore version this module
  can be applied to. If not specified, module
  can be applied to all versions.

``--auto_apply``
  Automatically apply this module when
  creating an instance or cluster. Admin only.

``--all_tenants``
  Module is valid for all tenants. Admin only.

``--hidden``
  Hide this module from non-Admin. Useful in
  creating auto-apply modules without
  cluttering up module lists. Admin only.

``--live_update``
  Allow module to be updated even if it is
  already applied to a current instance or
  cluster.

``--priority_apply``
  Sets a priority for applying the module. All
  priority modules will be applied before non-priority ones. Admin only.

``--apply_order {0,1,2,3,4,5,6,7,8,9}``
  Sets an order for applying the module.
  Modules with a lower value will be applied
  before modules with a higher value. Modules
  having the same value may be applied in any
  order (default 5).

``--full_access``
  Marks a module as 'non-admin', unless an
  admin-only option was specified. Admin only.

.. _trove_module-delete:

trove module-delete
-------------------

.. code-block:: console

   usage: trove module-delete <module>

Delete a module.

**Positional arguments:**

``<module>``
  ID or name of the module.

.. _trove_module-instance-count:

trove module-instance-count
---------------------------

.. code-block:: console

   usage: trove module-instance-count [--include_clustered] <module>

Lists a count of the instances for each module md5.

**Positional arguments:**

``<module>``
  ID or name of the module.

**Optional arguments:**

``--include_clustered``
  Include instances that are part of a cluster (default
  False).

.. _trove_module-instances:

trove module-instances
----------------------

.. code-block:: console

   usage: trove module-instances <module>
                                 [--include_clustered] [--limit <limit>]
                                 [--marker <ID>]

Lists the instances that have a particular module applied.

**Positional arguments:**

``<module>``
  ID or name of the module.

**Optional arguments:**

``--include_clustered``
  Include instances that are part of a cluster (default
  False).

``--limit <limit>``
  Return up to N number of the most recent results.

``--marker <ID>``
  Begin displaying the results for IDs greater than the
  specified marker. When used with --limit, set this to
  the last ID displayed in the previous run.

.. _trove_module-list:

trove module-list
-----------------

.. code-block:: console

   usage: trove module-list [--datastore <datastore>]

Lists the modules available.

**Optional arguments:**

``--datastore <datastore>``
  Name or ID of datastore to list modules for. Use
  'all' to list modules that apply to all datastores.

.. _trove_module-list-instance:

trove module-list-instance
--------------------------

.. code-block:: console

   usage: trove module-list-instance <instance>

Lists the modules that have been applied to an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_module-query:

trove module-query
------------------

.. code-block:: console

   usage: trove module-query <instance>

Query the status of the modules on an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_module-reapply:

trove module-reapply
--------------------

.. code-block:: console

   usage: trove module-reapply <module>
                               [--md5 <md5>] [--include_clustered]
                               [--batch_size <batch_size>] [--delay <delay>]
                               [--force]

Reapply a module.

**Positional arguments:**

``<module>``
  Name or ID of the module.

**Optional arguments:**

``--md5 <md5>``
  Reapply the module only to instances applied with
  the specific md5.

``--include_clustered``
  Include instances that are part of a cluster
  (default False).

``--batch_size <batch_size>``
  Number of instances to reapply the module to
  before sleeping.

``--delay <delay>``
  Time to sleep in seconds between applying
  batches.

``--force``
  Force reapply even on modules already having the
  current MD5

.. _trove_module-remove:

trove module-remove
-------------------

.. code-block:: console

   usage: trove module-remove <instance> <module>

Remove a module from an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<module>``
  ID or name of the module.

.. _trove_module-retrieve:

trove module-retrieve
---------------------

.. code-block:: console

   usage: trove module-retrieve <instance>
                                [--directory <directory>]
                                [--prefix <filename_prefix>]

Retrieve module contents from an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

**Optional arguments:**

``--directory <directory>``
  Directory to write module content files in. It
  will be created if it does not exist. Defaults
  to the current directory.

``--prefix <filename_prefix>``
  Prefix to prepend to generated filename for each
  module.

.. _trove_module-show:

trove module-show
-----------------

.. code-block:: console

   usage: trove module-show <module>

Shows details of a module.

**Positional arguments:**

``<module>``
  ID or name of the module.

.. _trove_module-update:

trove module-update
-------------------

.. code-block:: console

   usage: trove module-update <module>
                              [--name <name>] [--type <type>] [--file <filename>]
                              [--description <description>]
                              [--datastore <datastore>] [--all_datastores]
                              [--datastore_version <version>]
                              [--all_datastore_versions] [--auto_apply]
                              [--no_auto_apply] [--all_tenants]
                              [--no_all_tenants] [--hidden] [--no_hidden]
                              [--live_update] [--no_live_update]
                              [--priority_apply] [--no_priority_apply]
                              [--apply_order {0,1,2,3,4,5,6,7,8,9}]
                              [--full_access] [--no_full_access]

Update a module.

**Positional arguments:**

``<module>``
  Name or ID of the module.

**Optional arguments:**

``--name <name>``
  Name of the module.

``--type <type>``
  Type of the module. The type must be
  supported by a corresponding module driver
  plugin on the datastore it is applied to.

``--file <filename>``
  File containing data contents for the
  module.

``--description <description>``
  Description of the module.

``--datastore <datastore>``
  Name or ID of datastore this module can be
  applied to. If not specified, module can be
  applied to all datastores.

``--all_datastores``
  Module is valid for all datastores.

``--datastore_version <version>``
  Name or ID of datastore version this module
  can be applied to. If not specified, module
  can be applied to all versions.

``--all_datastore_versions``
  Module is valid for all datastore versions.

``--auto_apply``
  Automatically apply this module when
  creating an instance or cluster. Admin only.

``--no_auto_apply``
  Do not automatically apply this module when
  creating an instance or cluster. Admin only.

``--all_tenants``
  Module is valid for all tenants. Admin only.

``--no_all_tenants``
  Module is valid for current tenant only.
  Admin only.

``--hidden``
  Hide this module from non-admin users.
  Useful in creating auto-apply modules
  without cluttering up module lists. Admin
  only.

``--no_hidden``
  Allow all users to see this module. Admin
  only.

``--live_update``
  Allow module to be updated or deleted even
  if it is already applied to a current
  instance or cluster.

``--no_live_update``
  Restricts a module from being updated or
  deleted if it is already applied to a
  current instance or cluster.

``--priority_apply``
  Sets a priority for applying the module. All
  priority modules will be applied before non-priority ones. Admin only.

``--no_priority_apply``
  Removes apply priority from the module.
  Admin only.

``--apply_order {0,1,2,3,4,5,6,7,8,9}``
  Sets an order for applying the module.
  Modules with a lower value will be applied
  before modules with a higher value. Modules
  having the same value may be applied in any
  order (default None).

``--full_access``
  Marks a module as 'non-admin', unless an
  admin-only option was specified. Admin only.

``--no_full_access``
  Restricts modification access for non-admin.
  Admin only.

.. _trove_promote-to-replica-source:

trove promote-to-replica-source
-------------------------------

.. code-block:: console

   usage: trove promote-to-replica-source <instance>

Promotes a replica to be the new replica source of its set.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_quota-show:

trove quota-show
----------------

.. code-block:: console

   usage: trove quota-show <tenant_id>

Show quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  Id of tenant for which to show quotas.

.. _trove_quota-update:

trove quota-update
------------------

.. code-block:: console

   usage: trove quota-update <tenant_id> <resource> <limit>

Update quotas for a tenant.

**Positional arguments:**

``<tenant_id>``
  Id of tenant for which to update quotas.

``<resource>``
  Id of resource to change.

``<limit>``
  New limit to set for the named resource.

.. _trove_reset-status:

trove reset-status
------------------

.. code-block:: console

   usage: trove reset-status <instance>

Set the status to NONE.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_resize-instance:

trove resize-instance
---------------------

.. code-block:: console

   usage: trove resize-instance <instance> <flavor>

Resizes an instance with a new flavor.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<flavor>``
  New flavor of the instance.

.. _trove_resize-volume:

trove resize-volume
-------------------

.. code-block:: console

   usage: trove resize-volume <instance> <size>

Resizes the volume size of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<size>``
  New size of the instance disk volume in GB.

.. _trove_restart:

trove restart
-------------

.. code-block:: console

   usage: trove restart <instance>

Restarts an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_root-disable:

trove root-disable
------------------

.. code-block:: console

   usage: trove root-disable <instance>

Disables root for an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_root-enable:

trove root-enable
-----------------

.. code-block:: console

   usage: trove root-enable <instance_or_cluster>
                            [--root_password <root_password>]

Enables root for an instance and resets if already exists.

**Positional arguments:**

``<instance_or_cluster>``
  ID or name of the instance or cluster.

**Optional arguments:**

``--root_password <root_password>``
  Root password to set.

.. _trove_root-show:

trove root-show
---------------

.. code-block:: console

   usage: trove root-show <instance_or_cluster>

Gets status if root was ever enabled for an instance or cluster.

**Positional arguments:**

``<instance_or_cluster>``
  ID or name of the instance or cluster.

.. _trove_schedule-create:

trove schedule-create
---------------------

.. code-block:: console

   usage: trove schedule-create <instance> <pattern> <name>
                                [--description <description>] [--incremental]

Schedules backups for an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<pattern>``
  Cron style pattern describing schedule
  occurrence.

``<name>``
  Name of the backup.

**Optional arguments:**

``--description <description>``
  An optional description for the backup.

``--incremental``
  Flag to select incremental backup based on most
  recent backup.

.. _trove_schedule-delete:

trove schedule-delete
---------------------

.. code-block:: console

   usage: trove schedule-delete <schedule id>

Deletes a schedule.

**Positional arguments:**

``<schedule id>``
  Id of the schedule.

.. _trove_schedule-list:

trove schedule-list
-------------------

.. code-block:: console

   usage: trove schedule-list <instance>

Lists scheduled backups for an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_schedule-show:

trove schedule-show
-------------------

.. code-block:: console

   usage: trove schedule-show <schedule id>

Shows details of a schedule.

**Positional arguments:**

``<schedule id>``
  Id of the schedule.

.. _trove_secgroup-add-rule:

trove secgroup-add-rule
-----------------------

.. code-block:: console

   usage: trove secgroup-add-rule <security_group> <cidr>

Creates a security group rule.

**Positional arguments:**

``<security_group>``
  Security group ID.

``<cidr>``
  CIDR address.

.. _trove_secgroup-delete-rule:

trove secgroup-delete-rule
--------------------------

.. code-block:: console

   usage: trove secgroup-delete-rule <security_group_rule>

Deletes a security group rule.

**Positional arguments:**

``<security_group_rule>``
  Name of security group rule.

.. _trove_secgroup-list:

trove secgroup-list
-------------------

.. code-block:: console

   usage: trove secgroup-list

Lists all security groups.

.. _trove_secgroup-list-rules:

trove secgroup-list-rules
-------------------------

.. code-block:: console

   usage: trove secgroup-list-rules <security_group>

Lists all rules for a security group.

**Positional arguments:**

``<security_group>``
  Security group ID.

.. _trove_secgroup-show:

trove secgroup-show
-------------------

.. code-block:: console

   usage: trove secgroup-show <security_group>

Shows details of a security group.

**Positional arguments:**

``<security_group>``
  Security group ID.

.. _trove_show:

trove show
----------

.. code-block:: console

   usage: trove show <instance>

Shows details of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_update:

trove update
------------

.. code-block:: console

   usage: trove update <instance>
                       [--name <name>] [--configuration <configuration>]
                       [--detach_replica_source] [--remove_configuration]

Updates an instance: Edits name, configuration, or replica source.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

**Optional arguments:**

``--name <name>``
  Name of the instance.

``--configuration <configuration>``
  ID of the configuration reference to attach.

``--detach_replica_source, --detach-replica-source``
  Detach the replica instance from its
  replication source. --detach-replica-source
  may be deprecated in the future in favor of
  just --detach_replica_source

``--remove_configuration``
  Drops the current configuration reference.

.. _trove_upgrade:

trove upgrade
-------------

.. code-block:: console

   usage: trove upgrade <instance> <datastore_version>

Upgrades an instance to a new datastore version.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<datastore_version>``
  A datastore version name or ID.

.. _trove_user-create:

trove user-create
-----------------

.. code-block:: console

   usage: trove user-create <instance> <name> <password>
                            [--host <host>]
                            [--databases <databases> [<databases> ...]]

Creates a user on an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

``<password>``
  Password of user.

**Optional arguments:**

``--host <host>``
  Optional host of user.

``--databases <databases> [<databases> ...]``
  Optional list of databases.

.. _trove_user-delete:

trove user-delete
-----------------

.. code-block:: console

   usage: trove user-delete [--host <host>] <instance> <name>

Deletes a user from an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

**Optional arguments:**

``--host <host>``
  Optional host of user.

.. _trove_user-grant-access:

trove user-grant-access
-----------------------

.. code-block:: console

   usage: trove user-grant-access <instance> <name> <databases> [<databases> ...]
                                  [--host <host>]

Grants access to a database(s) for a user.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

``<databases>``
  List of databases.

**Optional arguments:**

``--host <host>``
  Optional host of user.

.. _trove_user-list:

trove user-list
---------------

.. code-block:: console

   usage: trove user-list <instance>

Lists the users for an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

.. _trove_user-revoke-access:

trove user-revoke-access
------------------------

.. code-block:: console

   usage: trove user-revoke-access [--host <host>] <instance> <name> <database>

Revokes access to a database for a user.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

``<database>``
  A single database.

**Optional arguments:**

``--host <host>``
  Optional host of user.

.. _trove_user-show:

trove user-show
---------------

.. code-block:: console

   usage: trove user-show [--host <host>] <instance> <name>

Shows details of a user of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

**Optional arguments:**

``--host <host>``
  Optional host of user.

.. _trove_user-show-access:

trove user-show-access
----------------------

.. code-block:: console

   usage: trove user-show-access [--host <host>] <instance> <name>

Shows access details of a user of an instance.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

**Optional arguments:**

``--host <host>``
  Optional host of user.

.. _trove_user-update-attributes:

trove user-update-attributes
----------------------------

.. code-block:: console

   usage: trove user-update-attributes <instance> <name>
                                       [--host <host>] [--new_name <new_name>]
                                       [--new_password <new_password>]
                                       [--new_host <new_host>]

Updates a user's attributes on an instance. At least one optional argument
must be provided.

**Positional arguments:**

``<instance>``
  ID or name of the instance.

``<name>``
  Name of user.

**Optional arguments:**

``--host <host>``
  Optional host of user.

``--new_name <new_name>``
  Optional new name of user.

``--new_password <new_password>``
  Optional new password of user.

``--new_host <new_host>``
  Optional new host of user.

.. _trove_volume-type-list:

trove volume-type-list
----------------------

.. code-block:: console

   usage: trove volume-type-list [--datastore_type <datastore_type>]
                                 [--datastore_version_id <datastore_version_id>]

Lists available volume types.

**Optional arguments:**

``--datastore_type <datastore_type>``
  Type of the datastore. For eg: mysql.

``--datastore_version_id <datastore_version_id>``
  ID of the datastore version.

.. _trove_volume-type-show:

trove volume-type-show
----------------------

.. code-block:: console

   usage: trove volume-type-show <volume_type>

Shows details of a volume type.

**Positional arguments:**

``<volume_type>``
  ID or name of the volume type.

