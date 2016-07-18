.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

====================================
Workflow service command-line client
====================================

The mistral client is the command-line interface (CLI) for
the Workflow service API and its extensions.

This chapter documents :command:`mistral` version ``2.0.0``.

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
                  [--os-tenant-id TENANT_ID] [--os-tenant-name TENANT_NAME]
                  [--os-auth-token TOKEN] [--os-auth-url AUTH_URL]
                  [--os-cacert CACERT] [--insecure]

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
  OS_TENANT_ID)

``--os-tenant-name TENANT_NAME``
  Authentication tenant name (Env:
  OS_TENANT_NAME)

``--os-auth-token TOKEN``
  Authentication token (Env: OS_AUTH_TOKEN)

``--os-auth-url AUTH_URL``
  Authentication URL (Env: OS_AUTH_URL)

``--os-cacert CACERT``
  Authentication CA Certificate (Env: OS_CACERT)

``--insecure``
  Disables SSL/TLS certificate verification
  (Env: MISTRALCLIENT_INSECURE)

.. _mistral_action-create:

mistral action-create
---------------------

.. code-block:: console

   usage: mistral action-create [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
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

   usage: mistral action-delete [-h] name [name ...]

Delete action.

**Positional arguments:**

``name``
  Name of action(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-execution-delete:

mistral action-execution-delete
-------------------------------

.. code-block:: console

   usage: mistral action-execution-delete [-h] id [id ...]

Delete action execution.

**Positional arguments:**

``id``
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
                                       [--noindent] [--prefix PREFIX]
                                       id

Show specific Action execution.

**Positional arguments:**

``id``
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
                                        [--noindent]
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
                                          [--noindent] [--prefix PREFIX]
                                          [--state {IDLE,RUNNING,SUCCESS,ERROR}]
                                          [--output OUTPUT]
                                          id

Update specific Action execution.

**Positional arguments:**

``id``
  Action execution ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--state {IDLE,RUNNING,SUCCESS,ERROR}``
  Action execution state

``--output OUTPUT``
  Action execution output

.. _mistral_action-get:

mistral action-get
------------------

.. code-block:: console

   usage: mistral action-get [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX]
                             name

Show specific action.

**Positional arguments:**

``name``
  Action name

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
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]

List all actions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_action-update:

mistral action-update
---------------------

.. code-block:: console

   usage: mistral action-update [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--public]
                                definition

Update action.

**Positional arguments:**

``definition``
  Action definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  With this flag action will be marked as "public".

.. _mistral_cron-trigger-create:

mistral cron-trigger-create
---------------------------

.. code-block:: console

   usage: mistral cron-trigger-create [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      [--params PARAMS] [--pattern <* * * * *>]
                                      [--first-time <YYYY-MM-DD HH:MM>]
                                      [--count <integer>]
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
  Date and time of the first execution

``--count <integer>``
  Number of wanted executions

.. _mistral_cron-trigger-delete:

mistral cron-trigger-delete
---------------------------

.. code-block:: console

   usage: mistral cron-trigger-delete [-h] name [name ...]

Delete trigger.

**Positional arguments:**

``name``
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
                                   [--noindent] [--prefix PREFIX]
                                   name

Show specific cron trigger.

**Positional arguments:**

``name``
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
                                    [--noindent]
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
                                     [--noindent] [--prefix PREFIX]
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

   usage: mistral environment-delete [-h] name [name ...]

Delete environment.

**Positional arguments:**

``name``
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
                                  [--noindent] [--prefix PREFIX]
                                  name

Show specific environment.

**Positional arguments:**

``name``
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
                                   [--noindent]
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
                                     [--noindent] [--prefix PREFIX]
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
                                   [--noindent] [--prefix PREFIX]
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

   usage: mistral execution-delete [-h] id [id ...]

Delete execution.

**Positional arguments:**

``id``
  Id of execution identifier(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_execution-get:

mistral execution-get
---------------------

.. code-block:: console

   usage: mistral execution-get [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                id

Show specific execution.

**Positional arguments:**

``id``
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
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--marker [MARKER]] [--limit [LIMIT]]
                                 [--sort_keys [SORT_KEYS]]
                                 [--sort_dirs [SORT_DIRS]]

List all executions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--marker [MARKER]``
  The last execution uuid of the previous page, displays
  list of executions after "marker".

``--limit [LIMIT]``
  Maximum number of executions to return in a single
  result.

``--sort_keys [SORT_KEYS]``
  Comma-separated list of sort keys to sort results by.
  Default: created_at. Example: mistral execution-list
  :option:`--sort_keys=id,description`

``--sort_dirs [SORT_DIRS]``
  Comma-separated list of sort directions. Default: asc.
  Example: mistral execution-list
  :option:`--sort_keys=id,description` :option:`--sort_dirs=asc,desc`

.. _mistral_execution-update:

mistral execution-update
------------------------

.. code-block:: console

   usage: mistral execution-update [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [-s {RUNNING,PAUSED,SUCCESS,ERROR}] [-e ENV]
                                   [-d DESCRIPTION]
                                   id

Update execution.

**Positional arguments:**

``id``
  Execution identifier

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-s {RUNNING,PAUSED,SUCCESS,ERROR}, --state {RUNNING,PAUSED,SUCCESS,ERROR}``
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
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
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

   usage: mistral member-delete [-h] resource_id resource_type member_id

Delete a resource sharing relationship.

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

.. _mistral_member-get:

mistral member-get
------------------

.. code-block:: console

   usage: mistral member-get [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX] [-m MEMBER_ID]
                             resource_id resource_type

Show specific member information.

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

.. _mistral_member-list:

mistral member-list
-------------------

.. code-block:: console

   usage: mistral member-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
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
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [-m MEMBER_ID]
                                [-s {pending,accepted,rejected}]
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
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX] [-s] [-t TARGET]
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

``-t TARGET, --target TARGET``
  Action will be executed on <target> executor.

.. _mistral_service-list:

mistral service-list
--------------------

.. code-block:: console

   usage: mistral service-list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
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
                           [-c COLUMN] [--max-width <integer>] [--noindent]
                           [--prefix PREFIX]
                           id

Show specific task.

**Positional arguments:**

``id``
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
                            [-c COLUMN] [--max-width <integer>] [--noindent]
                            [--quote {all,minimal,none,nonnumeric}]
                            [workflow_execution]

List all tasks.

**Positional arguments:**

``workflow_execution``
  Workflow execution ID associated with list of Tasks.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_task-rerun:

mistral task-rerun
------------------

.. code-block:: console

   usage: mistral task-rerun [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX] [--resume] [-e ENV]
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
                                  [--noindent] [--prefix PREFIX]
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

   usage: mistral workbook-delete [-h] name [name ...]

Delete workbook.

**Positional arguments:**

``name``
  Name of workbook(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workbook-get:

mistral workbook-get
--------------------

.. code-block:: console

   usage: mistral workbook-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX]
                               name

Show specific workbook.

**Positional arguments:**

``name``
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
                                [-c COLUMN] [--max-width <integer>] [--noindent]
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
                                  [--noindent] [--prefix PREFIX]
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
                                    [--noindent] [--prefix PREFIX]
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
                                  [--noindent]
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

   usage: mistral workflow-delete [-h] identifier [identifier ...]

Delete workflow.

**Positional arguments:**

``identifier``
  Name or ID of workflow(s).

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-get:

mistral workflow-get
--------------------

.. code-block:: console

   usage: mistral workflow-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX]
                               identifier

Show specific workflow.

**Positional arguments:**

``identifier``
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
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

List all workflows.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _mistral_workflow-update:

mistral workflow-update
-----------------------

.. code-block:: console

   usage: mistral workflow-update [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
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
                                    [--noindent] [--prefix PREFIX]
                                    definition

Validate workflow.

**Positional arguments:**

``definition``
  Workflow definition file

**Optional arguments:**

``-h, --help``
  show this help message and exit

