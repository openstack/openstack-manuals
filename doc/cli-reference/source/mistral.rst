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

==============================================
Workflow service (mistral) command-line client
==============================================

The mistral client is the command-line interface (CLI) for the
Workflow service (mistral) API
and its extensions.

This chapter documents :command:`mistral` version ``3.1.0``.

For help on a specific :command:`mistral` command, enter:

.. code-block:: console

   $ mistral help COMMAND

.. _mistral_command_usage:

mistral usage
~~~~~~~~~~~~~

.. code-block:: console

   usage: mistral [--version] [-v] [--log-file LOG_FILE] [-q] [-h] [--debug]
                  [--os-mistral-url MISTRAL_URL]
                  [--os-mistral-version MISTRAL_VERSION]
                  [--os-mistral-service-type SERVICE_TYPE]
                  [--os-mistral-endpoint-type ENDPOINT_TYPE]
                  [--os-username USERNAME] [--os-password PASSWORD]
                  [--os-tenant-id TENANT_ID] [--os-project-id PROJECT_ID]
                  [--os-tenant-name TENANT_NAME] [--os-project-name PROJECT_NAME]
                  [--os-auth-token TOKEN]
                  [--os-project-domain-name PROJECT_DOMAIN_NAME]
                  [--os-user-domain-name USER_DOMAIN_NAME]
                  [--os-auth-url AUTH_URL] [--os-cert OS_CERT] [--os-key OS_KEY]
                  [--os-cacert OS_CACERT] [--os-region-name REGION_NAME]
                  [--insecure] [--auth-type AUTH_TYPE]
                  [--openid-client-id CLIENT_ID]
                  [--openid-client-secret CLIENT_SECRET]
                  [--os-target-username TARGET_USERNAME]
                  [--os-target-password TARGET_PASSWORD]
                  [--os-target-tenant-id TARGET_TENANT_ID]
                  [--os-target-tenant-name TARGET_TENANT_NAME]
                  [--os-target-auth-token TARGET_TOKEN]
                  [--os-target-auth-url TARGET_AUTH_URL]
                  [--os-target_cacert TARGET_CACERT]
                  [--os-target-region-name TARGET_REGION_NAME]
                  [--os-target-user-domain-name TARGET_USER_DOMAIN_NAME]
                  [--os-target-project-domain-name TARGET_PROJECT_DOMAIN_NAME]
                  [--target_insecure] [--profile HMAC_KEY]

.. _mistral_command_options:

mistral optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Show program's version number and exit.

``-v, --verbose``
  Increase verbosity of output. Can be repeated.

``--log-file LOG_FILE``
  Specify a file to log output. Disabled by
  default.

``-q, --quiet``
  Suppress output except warnings and errors.

``-h, --help``
  Show this help message and exit.

``--debug``
  Show tracebacks on errors.

``--os-mistral-url MISTRAL_URL``
  Mistral API host (Env: OS_MISTRAL_URL)

``--os-mistral-version MISTRAL_VERSION``
  Mistral API version (default = v2) (Env:
  OS_MISTRAL_VERSION)

``--os-mistral-service-type SERVICE_TYPE``
  Mistral service-type (should be the same name
  as in keystone-endpoint) (default =
  workflowv2) (Env: OS_MISTRAL_SERVICE_TYPE)

``--os-mistral-endpoint-type ENDPOINT_TYPE``
  Mistral endpoint-type (should be the same name
  as in keystone-endpoint) (default = publicURL)
  (Env: OS_MISTRAL_ENDPOINT_TYPE)

``--os-username USERNAME``
  Authentication username (Env: OS_USERNAME)

``--os-password PASSWORD``
  Authentication password (Env: OS_PASSWORD)

``--os-tenant-id TENANT_ID``
  Authentication tenant identifier (Env:
  OS_TENANT_ID or OS_PROJECT_ID)

``--os-project-id PROJECT_ID``
  Authentication project identifier (Env:
  OS_TENANT_ID or OS_PROJECT_ID), will use
  tenant_id if both tenant_id and project_id are
  set

``--os-tenant-name TENANT_NAME``
  Authentication tenant name (Env:
  OS_TENANT_NAME or OS_PROJECT_NAME)

``--os-project-name PROJECT_NAME``
  Authentication project name (Env:
  OS_TENANT_NAME or OS_PROJECT_NAME), will use
  tenant_name if both tenant_name and
  project_name are set

``--os-auth-token TOKEN``
  Authentication token (Env: OS_AUTH_TOKEN)

``--os-project-domain-name PROJECT_DOMAIN_NAME``
  Authentication project domain name (Env:
  OS_PROJECT_DOMAIN_NAME)

``--os-user-domain-name USER_DOMAIN_NAME``
  Authentication user domain name (Env:
  OS_USER_DOMAIN_NAME)

``--os-auth-url AUTH_URL``
  Authentication URL (Env: OS_AUTH_URL)

``--os-cert OS_CERT``
  Client Certificate (Env: OS_CERT)

``--os-key OS_KEY``
  Client Key (Env: OS_KEY)

``--os-cacert OS_CACERT``
  Authentication CA Certificate (Env: OS_CACERT)

``--os-region-name REGION_NAME``
  Region name (Env: OS_REGION_NAME)

``--insecure``
  Disables SSL/TLS certificate verification
  (Env: MISTRALCLIENT_INSECURE)

``--auth-type AUTH_TYPE``
  Authentication type. Valid options are:
  keystone, keycloak-oidc. (Env:
  MISTRAL_AUTH_TYPE)

``--openid-client-id CLIENT_ID``
  Client ID (according to OpenID Connect). (Env:
  OPENID_CLIENT_ID)

``--openid-client-secret CLIENT_SECRET``
  Client secret (according to OpenID Connect)
  (Env: OPENID_CLIENT_SECRET)

``--os-target-username TARGET_USERNAME``
  Authentication username for target cloud (Env:
  OS_TARGET_USERNAME)

``--os-target-password TARGET_PASSWORD``
  Authentication password for target cloud (Env:
  OS_TARGET_PASSWORD)

``--os-target-tenant-id TARGET_TENANT_ID``
  Authentication tenant identifier for target
  cloud (Env: OS_TARGET_TENANT_ID)

``--os-target-tenant-name TARGET_TENANT_NAME``
  Authentication tenant name for target cloud
  (Env: OS_TARGET_TENANT_NAME)

``--os-target-auth-token TARGET_TOKEN``
  Authentication token for target cloud (Env:
  OS_TARGET_AUTH_TOKEN)

``--os-target-auth-url TARGET_AUTH_URL``
  Authentication URL for target cloud (Env:
  OS_TARGET_AUTH_URL)

``--os-target_cacert TARGET_CACERT``
  Authentication CA Certificate for target cloud
  (Env: OS_TARGET_CACERT)

``--os-target-region-name TARGET_REGION_NAME``
  Region name for target cloud(Env:
  OS_TARGET_REGION_NAME)

``--os-target-user-domain-name TARGET_USER_DOMAIN_NAME``
  User domain name for target cloud(Env:
  OS_TARGET_USER_DOMAIN_NAME)

``--os-target-project-domain-name TARGET_PROJECT_DOMAIN_NAME``
  Project domain name for target cloud(Env:
  OS_TARGET_PROJECT_DOMAIN_NAME)

``--target_insecure``
  Disables SSL/TLS certificate verification for
  target cloud (Env:
  TARGET_MISTRALCLIENT_INSECURE)

``--profile HMAC_KEY``
  HMAC key to use for encrypting context data
  for performance profiling of operation. This
  key should be one of the values configured for
  the osprofiler middleware in mistral, it is
  specified in the profiler section of the
  mistral configuration (i.e.
  /etc/mistral/mistral.conf). Without the key,
  profiling will not be triggered even if
  osprofiler is enabled on the server side.

.. _mistral_action-create:

mistral action-create
---------------------

.. code-block:: console

   usage: mistral action-create [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--public]
                                definition

Create new action.

**Positional arguments:**

``definition``
  Action definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  With this flag action will be marked as "public".

.. _mistral_action-delete:

mistral action-delete
---------------------

.. code-block:: console

   usage: mistral action-delete [-h] action [action ...]

Delete action.

**Positional arguments:**

``action``
  Name or ID of action(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-delete:

mistral action-execution-delete
-------------------------------

.. code-block:: console

   usage: mistral action-execution-delete [-h]
                                          action_execution [action_execution ...]

Delete action execution.

**Positional arguments:**

``action_execution``
  Id of action execution identifier(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-get:

mistral action-execution-get
----------------------------

.. code-block:: console

   usage: mistral action-execution-get [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--print-empty] [--noindent]
                                       [--prefix PREFIX]
                                       action_execution

Show specific Action execution.

**Positional arguments:**

``action_execution``
  Action execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-get-input:

mistral action-execution-get-input
----------------------------------

.. code-block:: console

   usage: mistral action-execution-get-input [-h] id

Show Action execution input data.

**Positional arguments:**

``id``
  Action execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-get-output:

mistral action-execution-get-output
-----------------------------------

.. code-block:: console

   usage: mistral action-execution-get-output [-h] id

Show Action execution output data.

**Positional arguments:**

``id``
  Action execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-list:

mistral action-execution-list
-----------------------------

.. code-block:: console

   usage: mistral action-execution-list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--print-empty] [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        [task_execution_id]

List all Action executions.

**Positional arguments:**

``task_execution_id``
  Task execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-update:

mistral action-execution-update
-------------------------------

.. code-block:: console

   usage: mistral action-execution-update [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--print-empty] [--noindent]
                                          [--prefix PREFIX]
                                          [--state {IDLE,RUNNING,SUCCESS,ERROR,CANCELLED}]
                                          [--output OUTPUT]
                                          id

Update specific Action execution.

**Positional arguments:**

``id``
  Action execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--state {IDLE,RUNNING,SUCCESS,ERROR,CANCELLED}``
  Action execution state

``--output OUTPUT``
  Action execution output

.. _mistral_action-get:

mistral action-get
------------------

.. code-block:: console

   usage: mistral action-get [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX]
                             action

Show specific action.

**Positional arguments:**

``action``
  Action (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-get-definition:

mistral action-get-definition
-----------------------------

.. code-block:: console

   usage: mistral action-get-definition [-h] name

Show action definition.

**Positional arguments:**

``name``
  Action name

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-list:

mistral action-list
-------------------

.. code-block:: console

   usage: mistral action-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--filter FILTERS]

List all actions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--filter FILTERS``
  Filters. Can be repeated.

.. _mistral_action-update:

mistral action-update
---------------------

.. code-block:: console

   usage: mistral action-update [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--id ID]
                                [--public]
                                definition

Update action.

**Positional arguments:**

``definition``
  Action definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--id ID``
  Action ID.

``--public``
  With this flag action will be marked as "public".

.. _mistral_action-validate:

mistral action-validate
-----------------------

.. code-block:: console

   usage: mistral action-validate [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  definition

Validate action.

**Positional arguments:**

``definition``
  action definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_cron-trigger-create:

mistral cron-trigger-create
---------------------------

.. code-block:: console

   usage: mistral cron-trigger-create [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--print-empty] [--noindent]
                                      [--prefix PREFIX] [--params PARAMS]
                                      [--pattern <* * * * *>]
                                      [--first-time <YYYY-MM-DD HH:MM>]
                                      [--count <integer>] [--utc]
                                      name workflow_identifier [workflow_input]

Create new trigger.

**Positional arguments:**

``name``
  Cron trigger name

``workflow_identifier``
  Workflow name or ID

``workflow_input``
  Workflow input

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--params PARAMS``
  Workflow params

``--pattern <* * * * *>``
  Cron trigger pattern

``--first-time <YYYY-MM-DD HH:MM>``
  Date and time of the first execution. Time is treated
  as local time unless --utc is also specified

``--count <integer>``
  Number of wanted executions

``--utc``
  All times specified should be treated as UTC

.. _mistral_cron-trigger-delete:

mistral cron-trigger-delete
---------------------------

.. code-block:: console

   usage: mistral cron-trigger-delete [-h] cron_trigger [cron_trigger ...]

Delete trigger.

**Positional arguments:**

``cron_trigger``
  Name of cron trigger(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_cron-trigger-get:

mistral cron-trigger-get
------------------------

.. code-block:: console

   usage: mistral cron-trigger-get [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent] [--prefix PREFIX]
                                   cron_trigger

Show specific cron trigger.

**Positional arguments:**

``cron_trigger``
  Cron trigger name

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_cron-trigger-list:

mistral cron-trigger-list
-------------------------

.. code-block:: console

   usage: mistral cron-trigger-list [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]

List all cron triggers.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_environment-create:

mistral environment-create
--------------------------

.. code-block:: console

   usage: mistral environment-create [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX]
                                     file

Create new environment.

**Positional arguments:**

``file``
  Environment configuration file in JSON or YAML

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_environment-delete:

mistral environment-delete
--------------------------

.. code-block:: console

   usage: mistral environment-delete [-h] environment [environment ...]

Delete environment.

**Positional arguments:**

``environment``
  Name of environment(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_environment-get:

mistral environment-get
-----------------------

.. code-block:: console

   usage: mistral environment-get [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  environment

Show specific environment.

**Positional arguments:**

``environment``
  Environment name

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_environment-list:

mistral environment-list
------------------------

.. code-block:: console

   usage: mistral environment-list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]

List all environments.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_environment-update:

mistral environment-update
--------------------------

.. code-block:: console

   usage: mistral environment-update [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX]
                                     file

Update environment.

**Positional arguments:**

``file``
  Environment configuration file in JSON or YAML

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-create:

mistral execution-create
------------------------

.. code-block:: console

   usage: mistral execution-create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent] [--prefix PREFIX]
                                   [-d DESCRIPTION]
                                   workflow_identifier [workflow_input] [params]

Create new execution.

**Positional arguments:**

``workflow_identifier``
  Workflow ID or name. Workflow name will be deprecated
  sinceMitaka.

``workflow_input``
  Workflow input

``params``
  Workflow additional parameters

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-d DESCRIPTION, --description DESCRIPTION``
  Execution description

.. _mistral_execution-delete:

mistral execution-delete
------------------------

.. code-block:: console

   usage: mistral execution-delete [-h] execution [execution ...]

Delete execution.

**Positional arguments:**

``execution``
  Id of execution identifier(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-get:

mistral execution-get
---------------------

.. code-block:: console

   usage: mistral execution-get [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                execution

Show specific execution.

**Positional arguments:**

``execution``
  Execution identifier

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-get-input:

mistral execution-get-input
---------------------------

.. code-block:: console

   usage: mistral execution-get-input [-h] id

Show execution input data.

**Positional arguments:**

``id``
  Execution ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-get-output:

mistral execution-get-output
----------------------------

.. code-block:: console

   usage: mistral execution-get-output [-h] id

Show execution output data.

**Positional arguments:**

``id``
  Execution ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-list:

mistral execution-list
----------------------

.. code-block:: console

   usage: mistral execution-list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--task [TASK]] [--marker [MARKER]]
                                 [--limit [LIMIT]] [--sort_keys [SORT_KEYS]]
                                 [--sort_dirs [SORT_DIRS]] [--filter FILTERS]

List all executions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--task [TASK]``
  Parent task execution ID associated with workflow
  execution list.

``--marker [MARKER]``
  The last execution uuid of the previous page, displays
  list of executions after "marker".

``--limit [LIMIT]``
  Maximum number of executions to return in a single
  result.

``--sort_keys [SORT_KEYS]``
  Comma-separated list of sort keys to sort results by.
  Default: created_at. Example: mistral execution-list
  --sort_keys=id,description

``--sort_dirs [SORT_DIRS]``
  Comma-separated list of sort directions. Default: asc.
  Example: mistral execution-list
  --sort_keys=id,description --sort_dirs=asc,desc

``--filter FILTERS``
  Filters. Can be repeated.

.. _mistral_execution-update:

mistral execution-update
------------------------

.. code-block:: console

   usage: mistral execution-update [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent] [--prefix PREFIX]
                                   [-s {RUNNING,PAUSED,SUCCESS,ERROR,CANCELLED}]
                                   [-e ENV] [-d DESCRIPTION]
                                   id

Update execution.

**Positional arguments:**

``id``
  Execution identifier

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-s {RUNNING,PAUSED,SUCCESS,ERROR,CANCELLED}, --state {RUNNING,PAUSED,SUCCESS,ERROR,CANCELLED}``
  Execution state

``-e ENV, --env ENV``
  Environment variables

``-d DESCRIPTION, --description DESCRIPTION``
  Execution description

.. _mistral_member-create:

mistral member-create
---------------------

.. code-block:: console

   usage: mistral member-create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                resource_id resource_type member_id

Shares a resource to another tenant.

**Positional arguments:**

``resource_id``
  Resource ID to be shared.

``resource_type``
  Resource type.

``member_id``
  Project ID to whom the resource is shared to.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_member-delete:

mistral member-delete
---------------------

.. code-block:: console

   usage: mistral member-delete [-h] resource resource_type member_id

Delete a resource sharing relationship.

**Positional arguments:**

``resource``
  Resource ID to be shared.

``resource_type``
  Resource type.

``member_id``
  Project ID to whom the resource is shared to.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_member-get:

mistral member-get
------------------

.. code-block:: console

   usage: mistral member-get [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX] [-m MEMBER_ID]
                             resource resource_type

Show specific member information.

**Positional arguments:**

``resource``
  Resource ID to be shared.

``resource_type``
  Resource type.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-m MEMBER_ID, --member-id MEMBER_ID``
  Project ID to whom the resource is shared to. No need
  to provide this param if you are the resource member.

.. _mistral_member-list:

mistral member-list
-------------------

.. code-block:: console

   usage: mistral member-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              resource_id resource_type

List all members.

**Positional arguments:**

``resource_id``
  Resource id to be shared.

``resource_type``
  Resource type.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_member-update:

mistral member-update
---------------------

.. code-block:: console

   usage: mistral member-update [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                [-m MEMBER_ID] [-s {pending,accepted,rejected}]
                                resource_id resource_type

Update resource sharing status.

**Positional arguments:**

``resource_id``
  Resource ID to be shared.

``resource_type``
  Resource type.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-m MEMBER_ID, --member-id MEMBER_ID``
  Project ID to whom the resource is shared to. No need
  to provide this param if you are the resource member.

``-s {pending,accepted,rejected}, --status {pending,accepted,rejected}``
  status of the sharing.

.. _mistral_run-action:

mistral run-action
------------------

.. code-block:: console

   usage: mistral run-action [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX] [-s] [--run-sync]
                             [-t TARGET]
                             name [input]

Create new Action execution or just run specific action.

**Positional arguments:**

``name``
  Action name to execute.

``input``
  Action input.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-s, --save-result``
  Save the result into DB.

``--run-sync``
  Run the action synchronously.

``-t TARGET, --target TARGET``
  Action will be executed on <target> executor.

.. _mistral_service-list:

mistral service-list
--------------------

.. code-block:: console

   usage: mistral service-list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]

List all services.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_task-get:

mistral task-get
----------------

.. code-block:: console

   usage: mistral task-get [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--print-empty]
                           [--noindent] [--prefix PREFIX]
                           task

Show specific task.

**Positional arguments:**

``task``
  Task identifier

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_task-get-published:

mistral task-get-published
--------------------------

.. code-block:: console

   usage: mistral task-get-published [-h] id

Show task published variables.

**Positional arguments:**

``id``
  Task ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_task-get-result:

mistral task-get-result
-----------------------

.. code-block:: console

   usage: mistral task-get-result [-h] id

Show task output data.

**Positional arguments:**

``id``
  Task ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_task-list:

mistral task-list
-----------------

.. code-block:: console

   usage: mistral task-list [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--quote {all,minimal,none,nonnumeric}]
                            [--filter FILTERS]
                            [workflow_execution]

List all tasks.

**Positional arguments:**

``workflow_execution``
  Workflow execution ID associated with list of Tasks.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--filter FILTERS``
  Filters. Can be repeated.

.. _mistral_task-rerun:

mistral task-rerun
------------------

.. code-block:: console

   usage: mistral task-rerun [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX] [--resume] [-e ENV]
                             id

Rerun an existing task.

**Positional arguments:**

``id``
  Task identifier

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--resume``
  rerun only failed or unstarted action executions for
  with-items task

``-e ENV, --env ENV``
  Environment variables

.. _mistral_workbook-create:

mistral workbook-create
-----------------------

.. code-block:: console

   usage: mistral workbook-create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  definition

Create new workbook.

**Positional arguments:**

``definition``
  Workbook definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-delete:

mistral workbook-delete
-----------------------

.. code-block:: console

   usage: mistral workbook-delete [-h] workbook [workbook ...]

Delete workbook.

**Positional arguments:**

``workbook``
  Name of workbook(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-get:

mistral workbook-get
--------------------

.. code-block:: console

   usage: mistral workbook-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               workbook

Show specific workbook.

**Positional arguments:**

``workbook``
  Workbook name

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-get-definition:

mistral workbook-get-definition
-------------------------------

.. code-block:: console

   usage: mistral workbook-get-definition [-h] name

Show workbook definition.

**Positional arguments:**

``name``
  Workbook name

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-list:

mistral workbook-list
---------------------

.. code-block:: console

   usage: mistral workbook-list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

List all workbooks.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-update:

mistral workbook-update
-----------------------

.. code-block:: console

   usage: mistral workbook-update [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  definition

Update workbook.

**Positional arguments:**

``definition``
  Workbook definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-validate:

mistral workbook-validate
-------------------------

.. code-block:: console

   usage: mistral workbook-validate [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX]
                                    definition

Validate workbook.

**Positional arguments:**

``definition``
  Workbook definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-create:

mistral workflow-create
-----------------------

.. code-block:: console

   usage: mistral workflow-create [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--public]
                                  definition

Create new workflow.

**Positional arguments:**

``definition``
  Workflow definition file.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  With this flag workflow will be marked as "public".

.. _mistral_workflow-delete:

mistral workflow-delete
-----------------------

.. code-block:: console

   usage: mistral workflow-delete [-h] workflow [workflow ...]

Delete workflow.

**Positional arguments:**

``workflow``
  Name or ID of workflow(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-get:

mistral workflow-get
--------------------

.. code-block:: console

   usage: mistral workflow-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               workflow

Show specific workflow.

**Positional arguments:**

``workflow``
  Workflow ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-get-definition:

mistral workflow-get-definition
-------------------------------

.. code-block:: console

   usage: mistral workflow-get-definition [-h] identifier

Show workflow definition.

**Positional arguments:**

``identifier``
  Workflow ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-list:

mistral workflow-list
---------------------

.. code-block:: console

   usage: mistral workflow-list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--filter FILTERS]

List all workflows.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--filter FILTERS``
  Filters. Can be repeated.

.. _mistral_workflow-update:

mistral workflow-update
-----------------------

.. code-block:: console

   usage: mistral workflow-update [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--id ID] [--public]
                                  definition

Update workflow.

**Positional arguments:**

``definition``
  Workflow definition

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--id ID``
  Workflow ID.

``--public``
  With this flag workflow will be marked as "public".

.. _mistral_workflow-validate:

mistral workflow-validate
-------------------------

.. code-block:: console

   usage: mistral workflow-validate [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX]
                                    definition

Validate workflow.

**Positional arguments:**

``definition``
  Workflow definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

