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

=================================================================
Infrastructure Optimization service (watcher) command-line client
=================================================================

The watcher client is the command-line interface (CLI) for
the Infrastructure Optimization service (watcher) API and its extensions.

This chapter documents :command:`watcher` version ``1.2.0``.

For help on a specific :command:`watcher` command, enter:

.. code-block:: console

   $ watcher help COMMAND

.. _watcher_command_usage:

watcher usage
~~~~~~~~~~~~~

.. code-block:: console

   usage: watcher [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                  [--no-auth] [--os-identity-api-version <identity-api-version>]
                  [--os-auth-url <auth-url>] [--os-region-name <region-name>]
                  [--os-username <auth-user-name>] [--os-user-id <auth-user-id>]
                  [--os-password <auth-password>]
                  [--os-user-domain-id <auth-user-domain-id>]
                  [--os-user-domain-name <auth-user-domain-name>]
                  [--os-tenant-name <auth-tenant-name>]
                  [--os-tenant-id <tenant-id>]
                  [--os-project-id <auth-project-id>]
                  [--os-project-name <auth-project-name>]
                  [--os-project-domain-id <auth-project-domain-id>]
                  [--os-project-domain-name <auth-project-domain-name>]
                  [--os-auth-token <auth-token>]
                  [--os-watcher-api-version <os-watcher-api-version>]
                  [--os-endpoint-type OS_ENDPOINT_TYPE]
                  [--os-endpoint-override <endpoint-override>] [--insecure]
                  [--os-cacert <ca-certificate>] [--os-cert <certificate>]
                  [--os-key <key>] [--timeout <seconds>]

.. _watcher_command_options:

watcher optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-v, --verbose``
  Increase verbosity of output. Can be repeated.

``-q, --quiet``
  Suppress output except warnings and errors.

``--log-file LOG_FILE``
  Specify a file to log output. Disabled by default.

``-h, --help``
  Show help message and exit.

``--debug``
  Show tracebacks on errors.

``--no-auth, -N``
  Do not use authentication.

``--os-identity-api-version <identity-api-version>``
  Specify Identity API version to use. Defaults to
  ``env[OS_IDENTITY_API_VERSION]`` or 3.

``--os-auth-url <auth-url>, -A <auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-region-name <region-name>, -R <region-name>``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-username <auth-user-name>, -U <auth-user-name>``
  Defaults to ``env[OS_USERNAME]``.

``--os-user-id <auth-user-id>``
  Defaults to ``env[OS_USER_ID]``.

``--os-password <auth-password>, -P <auth-password>``
  Defaults to ``env[OS_PASSWORD]``.

``--os-user-domain-id <auth-user-domain-id>``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-tenant-name <auth-tenant-name>, -T <auth-tenant-name>``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-tenant-id <tenant-id>, -I <tenant-id>``
  Defaults to ``env[OS_TENANT_ID]``.

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

``--os-auth-token <auth-token>``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--os-watcher-api-version <os-watcher-api-version>``
  Defaults to ``env[OS_WATCHER_API_VERSION]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]`` or "publicURL"

``--os-endpoint-override <endpoint-override>``
  Use this API endpoint instead of the Service Catalog.

.. _watcher_action_list:

watcher action list
-------------------

.. code-block:: console

   usage: watcher action list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--action-plan <action-plan>] [--audit <audit>]
                              [--detail] [--limit <limit>] [--sort-key <field>]
                              [--sort-dir <direction>]

List information on retrieved actions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--action-plan <action-plan>``
  UUID of the action plan used for filtering.

``--audit <audit>``
  UUID of the audit used for filtering.

``--detail``
  Show detailed information about actions.

``--limit <limit>``
  Maximum number of actions to return per request, 0 for
  no limit. Default is the maximum number used by the
  Watcher API Service.

``--sort-key <field>``
  Action field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_action_show:

watcher action show
-------------------

.. code-block:: console

   usage: watcher action show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              <action>

Show detailed information about a given action.

**Positional arguments:**

``<action>``
  UUID of the action

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_actionplan_create:

watcher actionplan create
-------------------------

.. code-block:: console

   usage: watcher actionplan create [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX] -a <audit_template>
                                    [-t <audit_type>]

Create new audit.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-a <audit_template>, --audit-template <audit_template>``
  Audit template used for this audit (name or uuid).

``-t <audit_type>, --audit_type <audit_type>``
  Audit type. It must be ONESHOT or CONTINUOUS. Default
  is ONESHOT.

.. _watcher_actionplan_delete:

watcher actionplan delete
-------------------------

.. code-block:: console

   usage: watcher actionplan delete [-h] <action-plan> [<action-plan> ...]

Delete action plan command.

**Positional arguments:**

``<action-plan>``
  UUID of the action plan

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_actionplan_list:

watcher actionplan list
-----------------------

.. code-block:: console

   usage: watcher actionplan list [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--audit <audit>] [--detail] [--limit <limit>]
                                  [--sort-key <field>] [--sort-dir <direction>]

List information on retrieved action plans.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--audit <audit>``
  UUID of an audit used for filtering.

``--detail``
  Show detailed information about action plans.

``--limit <limit>``
  Maximum number of action plans to return per request,
  0 for no limit. Default is the maximum number used by
  the Watcher API Service.

``--sort-key <field>``
  Action Plan field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_actionplan_show:

watcher actionplan show
-----------------------

.. code-block:: console

   usage: watcher actionplan show [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  <action-plan>

Show detailed information about a given action plan.

**Positional arguments:**

``<action-plan>``
  UUID of the action plan

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_actionplan_start:

watcher actionplan start
------------------------

.. code-block:: console

   usage: watcher actionplan start [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent] [--prefix PREFIX]
                                   <action-plan>

Start action plan command.

**Positional arguments:**

``<action-plan>``
  UUID of the action_plan.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_actionplan_update:

watcher actionplan update
-------------------------

.. code-block:: console

   usage: watcher actionplan update [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX]
                                    <action-plan> <op> <path=value>
                                    [<path=value> ...]

Update action plan command.

**Positional arguments:**

``<action-plan>``
  UUID of the action_plan.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is
  necessary.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audit_create:

watcher audit create
--------------------

.. code-block:: console

   usage: watcher audit create [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               [-t <audit_type>] [-p <name=value>]
                               [-i <interval>] [-g <goal>] [-s <strategy>]
                               [-a <audit_template>] [--auto-trigger]

Create new audit.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-t <audit_type>, --audit_type <audit_type>``
  Audit type. It must be ONESHOT or CONTINUOUS. Default
  is ONESHOT.

``-p <name=value>, --parameter <name=value>``
  Record strategy parameter/value metadata. Can be
  specified multiple times.

``-i <interval>, --interval <interval>``
  Audit interval (in seconds). Only used if the audit is
  CONTINUOUS.

``-g <goal>, --goal <goal>``
  Goal UUID or name associated to this audit.

``-s <strategy>, --strategy <strategy>``
  Strategy UUID or name associated to this audit.

``-a <audit_template>, --audit-template <audit_template>``
  Audit template used for this audit (name or uuid).

``--auto-trigger``
  Trigger automatically action plan once audit is
  succeeded.

.. _watcher_audit_delete:

watcher audit delete
--------------------

.. code-block:: console

   usage: watcher audit delete [-h] <audit> [<audit> ...]

Delete audit command.

**Positional arguments:**

``<audit>``
  UUID of the audit

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audit_list:

watcher audit list
------------------

.. code-block:: console

   usage: watcher audit list [-h] [-f {csv,html,json,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--quote {all,minimal,none,nonnumeric}]
                             [--detail] [--goal <goal>] [--strategy <strategy>]
                             [--limit <limit>] [--sort-key <field>]
                             [--sort-dir <direction>]

List information on retrieved audits.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--detail``
  Show detailed information about audits.

``--goal <goal>``
  UUID or name of the goal used for filtering.

``--strategy <strategy>``
  UUID or name of the strategy used for filtering.

``--limit <limit>``
  Maximum number of audits to return per request, 0 for
  no limit. Default is the maximum number used by the
  Watcher API Service.

``--sort-key <field>``
  Audit field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_audit_show:

watcher audit show
------------------

.. code-block:: console

   usage: watcher audit show [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX]
                             <audit>

Show detailed information about a given audit.

**Positional arguments:**

``<audit>``
  UUID of the audit

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audit_update:

watcher audit update
--------------------

.. code-block:: console

   usage: watcher audit update [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               <audit> <op> <path=value> [<path=value> ...]

Update audit command.

**Positional arguments:**

``<audit>``
  UUID of the audit.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is
  necessary.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audittemplate_create:

watcher audittemplate create
----------------------------

.. code-block:: console

   usage: watcher audittemplate create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--print-empty] [--noindent]
                                       [--prefix PREFIX] [-s <strategy>]
                                       [-d <description>] [--scope <path>]
                                       <name> <goal>

Create new audit template.

**Positional arguments:**

``<name>``
  Name for this audit template.

``<goal>``
  Goal UUID or name associated to this audit template.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-s <strategy>, --strategy <strategy>``
  Strategy UUID or name associated to this audit
  template.

``-d <description>, --description <description>``
  Description of the audit template.

``--scope <path>``
  Part of the cluster on which an audit will be done.
  Can be provided either in yaml or json file.
  YAML example:
  ---- host_aggregates:
  - id: 1
  - id: 2
  - id: 3
  - availability_zones:
  - name: AZ1
  - name: AZ2
  - exclude:
  - instances:
  - uuid: UUID1
  - uuid: UUID2
  - compute_nodes:
  - name: compute1

  JSON example:
  [{'host_aggregates': [
  {'id': 1},
  {'id': 2},
  {'id': 3}]},
  {'availability_zones': [
  {'name': 'AZ1'},
  {'name': 'AZ2'}]},
  {'exclude': [
  {'instances': [
  {'uuid': 'UUID1'},
  {'uuid': 'UUID2'}
  ]},
  {'compute_nodes': [
  {'name': 'compute1'}
  ]}
  ]}]

.. _watcher_audittemplate_delete:

watcher audittemplate delete
----------------------------

.. code-block:: console

   usage: watcher audittemplate delete [-h]
                                       <audit-template> [<audit-template> ...]

Delete audit template command.

**Positional arguments:**

``<audit-template>``
  UUID or name of the audit template

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audittemplate_list:

watcher audittemplate list
--------------------------

.. code-block:: console

   usage: watcher audittemplate list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--detail] [--goal <goal>]
                                     [--strategy <strategy>] [--limit <limit>]
                                     [--sort-key <field>]
                                     [--sort-dir <direction>]

List information on retrieved audit templates.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--detail``
  Show detailed information about audit templates.

``--goal <goal>``
  UUID or name of the goal used for filtering.

``--strategy <strategy>``
  UUID or name of the strategy used for filtering.

``--limit <limit>``
  Maximum number of audit templates to return per
  request, 0 for no limit. Default is the maximum number
  used by the Watcher API Service.

``--sort-key <field>``
  Audit template field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_audittemplate_show:

watcher audittemplate show
--------------------------

.. code-block:: console

   usage: watcher audittemplate show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX]
                                     <audit-template>

Show detailed information about a given audit template.

**Positional arguments:**

``<audit-template>``
  UUID or name of the audit template

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_audittemplate_update:

watcher audittemplate update
----------------------------

.. code-block:: console

   usage: watcher audittemplate update [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--print-empty] [--noindent]
                                       [--prefix PREFIX]
                                       <audit-template> <op> <path=value>
                                       [<path=value> ...]

Update audit template command.

**Positional arguments:**

``<audit-template>``
  UUID or name of the audit_template.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is
  necessary.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_goal_list:

watcher goal list
-----------------

.. code-block:: console

   usage: watcher goal list [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--quote {all,minimal,none,nonnumeric}]
                            [--detail] [--limit <limit>] [--sort-key <field>]
                            [--sort-dir <direction>]

List information on retrieved goals.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--detail``
  Show detailed information about each goal.

``--limit <limit>``
  Maximum number of goals to return per request, 0 for
  no limit. Default is the maximum number used by the
  Watcher API Service.

``--sort-key <field>``
  Goal field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_goal_show:

watcher goal show
-----------------

.. code-block:: console

   usage: watcher goal show [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            <goal>

Show detailed information about a given goal.

**Positional arguments:**

``<goal>``
  UUID or name of the goal

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_scoringengine_list:

watcher scoringengine list
--------------------------

.. code-block:: console

   usage: watcher scoringengine list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--detail] [--limit <limit>]
                                     [--sort-key <field>]
                                     [--sort-dir <direction>]

List information on retrieved scoring engines.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--detail``
  Show detailed information about scoring engines.

``--limit <limit>``
  Maximum number of actions to return per request, 0 for
  no limit. Default is the maximum number used by the
  Watcher API Service.

``--sort-key <field>``
  Action field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_scoringengine_show:

watcher scoringengine show
--------------------------

.. code-block:: console

   usage: watcher scoringengine show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX]
                                     <scoring_engine>

Show detailed information about a given scoring engine.

**Positional arguments:**

``<scoring_engine>``
  Name of the scoring engine

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_service_list:

watcher service list
--------------------

.. code-block:: console

   usage: watcher service list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}] [--detail]
                               [--limit <limit>] [--sort-key <field>]
                               [--sort-dir <direction>]

List information on retrieved services.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--detail``
  Show detailed information about each service.

``--limit <limit>``
  Maximum number of services to return per request, 0
  for no limit. Default is the maximum number used by
  the Watcher API Service.

``--sort-key <field>``
  Goal field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_service_show:

watcher service show
--------------------

.. code-block:: console

   usage: watcher service show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               <service>

Show detailed information about a given service.

**Positional arguments:**

``<service>``
  ID or name of the service

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _watcher_strategy_list:

watcher strategy list
---------------------

.. code-block:: console

   usage: watcher strategy list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--goal <goal>] [--detail] [--limit <limit>]
                                [--sort-key <field>] [--sort-dir <direction>]

List information on retrieved strategies.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--goal <goal>``
  UUID or name of the goal

``--detail``
  Show detailed information about each strategy.

``--limit <limit>``
  Maximum number of strategies to return per request, 0
  for no limit. Default is the maximum number used by
  the Watcher API Service.

``--sort-key <field>``
  Goal field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

.. _watcher_strategy_show:

watcher strategy show
---------------------

.. code-block:: console

   usage: watcher strategy show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                <strategy>

Show detailed information about a given strategy.

**Positional arguments:**

``<strategy>``
  UUID or name of the strategy

**Optional arguments:**

``-h, --help``
  show this help message and exit

