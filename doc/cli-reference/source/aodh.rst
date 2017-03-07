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

=====================================================
Telemetry Alarming service (aodh) command-line client
=====================================================

The aodh client is the command-line interface (CLI) for
the Telemetry Alarming service (aodh) API and its extensions.

This chapter documents :command:`aodh` version ``0.9.0``.

For help on a specific :command:`aodh` command, enter:

.. code-block:: console

   $ aodh help COMMAND

.. _aodh_command_usage:

aodh usage
~~~~~~~~~~

.. code-block:: console

   usage: aodh [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
               [--os-region-name <auth-region-name>] [--os-interface <interface>]
               [--aodh-api-version AODH_API_VERSION] [--insecure]
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
               [--os-password OS_PASSWORD] [--aodh-endpoint <endpoint>]

.. _aodh_command_options:

aodh optional arguments
~~~~~~~~~~~~~~~~~~~~~~~

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

``--os-region-name <auth-region-name>``
  Authentication region name (Env: OS_REGION_NAME)

``--os-interface <interface>``
  Select an interface type. Valid interface types:
  [admin, public, internal]. (Env: OS_INTERFACE)

``--aodh-api-version AODH_API_VERSION``
  Defaults to ``env[AODH_API_VERSION]`` or 2.

``--os-auth-type <name>, --os-auth-plugin <name>``
  Authentication type to use

``--aodh-endpoint <endpoint>``
  Aodh endpoint (Env: AODH_ENDPOINT)

.. _aodh_alarm_create:

aodh alarm create
-----------------

.. code-block:: console

   usage: aodh alarm create [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX] --name <NAME> -t
                            <TYPE> [--project-id <PROJECT_ID>]
                            [--user-id <USER_ID>] [--description <DESCRIPTION>]
                            [--state <STATE>] [--severity <SEVERITY>]
                            [--enabled {True|False}]
                            [--alarm-action <Webhook URL>]
                            [--ok-action <Webhook URL>]
                            [--insufficient-data-action <Webhook URL>]
                            [--time-constraint <Time Constraint>]
                            [--repeat-actions {True|False}] [--query <QUERY>]
                            [--comparison-operator <OPERATOR>]
                            [--evaluation-periods <EVAL_PERIODS>]
                            [--threshold <THRESHOLD>] [--metric <METRIC>]
                            [-m <METER NAME>] [--period <PERIOD>]
                            [--statistic <STATISTIC>] [--event-type <EVENT_TYPE>]
                            [--granularity <GRANULARITY>]
                            [--aggregation-method <AGGR_METHOD>]
                            [--resource-type <RESOURCE_TYPE>]
                            [--resource-id <RESOURCE_ID>] [--metrics <METRICS>]
                            [--composite-rule <COMPOSITE_RULE>]

Create an alarm

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

``-t <TYPE>, --type <TYPE>``
  Type of alarm, should be one of: threshold, event,
  composite, gnocchi_resources_threshold,
  gnocchi_aggregation_by_metrics_threshold,
  gnocchi_aggregation_by_resources_threshold.

``--project-id <PROJECT_ID>``
  Project to associate with alarm (configurable by admin
  users only)

``--user-id <USER_ID>``
  User to associate with alarm (configurable by admin
  users only)

``--description <DESCRIPTION>``
  Free text description of the alarm

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low', 'moderate',
  'critical']

``--enabled {True|False}``
  True if alarm evaluation is enabled

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm. May be
  used multiple times

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK. May be
  used multiple times

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to insufficient
  data. May be used multiple times

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at evaluation is
  within this time constraint. Start point(s) of the
  constraint are specified with a cron expression,
  whereas its duration is given in seconds. Can be
  specified multiple times for multiple time
  constraints, format is: name=<CONSTRAINT_NAME>;start=<
  CRON>;duration=<SECONDS>;[description=<DESCRIPTION>;[t
  imezone=<IANA Timezone>]]

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified while
  alarm remains in target state

.. _aodh_alarm_delete:

aodh alarm delete
-----------------

.. code-block:: console

   usage: aodh alarm delete [-h] [--name <NAME>] [<ALARM ID or NAME>]

Delete an alarm

**Positional arguments:**

``<ALARM ID or NAME>``
  ID or name of an alarm.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

.. _aodh_alarm_list:

aodh alarm list
---------------

.. code-block:: console

   usage: aodh alarm list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--query QUERY | --filter <KEY1=VALUE1;KEY2=VALUE2...>]
                          [--limit <LIMIT>] [--marker <MARKER>]
                          [--sort <SORT_KEY:SORT_DIR>]

List alarms

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--query QUERY``
  Rich query supported by aodh, e.g. project_id!=my-id
  user_id=foo or user_id=bar

``--filter <KEY1=VALUE1;KEY2=VALUE2...>``
  Filter parameters to apply on returned alarms.

``--limit <LIMIT>``
  Number of resources to return (Default is server
  default)

``--marker <MARKER>``
  Last item of the previous listing. Return the next
  results after this value,the supported marker is
  alarm_id.

``--sort <SORT_KEY:SORT_DIR>``
  Sort of resource attribute, e.g. name:asc

.. _aodh_alarm_show:

aodh alarm show
---------------

.. code-block:: console

   usage: aodh alarm show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX] [--name <NAME>]
                          [<ALARM ID or NAME>]

Show an alarm

**Positional arguments:**

``<ALARM ID or NAME>``
  ID or name of an alarm.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

.. _aodh_alarm_state_get:

aodh alarm state get
--------------------

.. code-block:: console

   usage: aodh alarm state get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               [--name <NAME>]
                               [<ALARM ID or NAME>]

Get state of an alarm

**Positional arguments:**

``<ALARM ID or NAME>``
  ID or name of an alarm.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

.. _aodh_alarm_state_set:

aodh alarm state set
--------------------

.. code-block:: console

   usage: aodh alarm state set [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               [--name <NAME>] --state <STATE>
                               [<ALARM ID or NAME>]

Set state of an alarm

**Positional arguments:**

``<ALARM ID or NAME>``
  ID or name of an alarm.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

.. _aodh_alarm_update:

aodh alarm update
-----------------

.. code-block:: console

   usage: aodh alarm update [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX] [--name <NAME>]
                            [-t <TYPE>] [--project-id <PROJECT_ID>]
                            [--user-id <USER_ID>] [--description <DESCRIPTION>]
                            [--state <STATE>] [--severity <SEVERITY>]
                            [--enabled {True|False}]
                            [--alarm-action <Webhook URL>]
                            [--ok-action <Webhook URL>]
                            [--insufficient-data-action <Webhook URL>]
                            [--time-constraint <Time Constraint>]
                            [--repeat-actions {True|False}] [--query <QUERY>]
                            [--comparison-operator <OPERATOR>]
                            [--evaluation-periods <EVAL_PERIODS>]
                            [--threshold <THRESHOLD>] [--metric <METRIC>]
                            [-m <METER NAME>] [--period <PERIOD>]
                            [--statistic <STATISTIC>] [--event-type <EVENT_TYPE>]
                            [--granularity <GRANULARITY>]
                            [--aggregation-method <AGGR_METHOD>]
                            [--resource-type <RESOURCE_TYPE>]
                            [--resource-id <RESOURCE_ID>] [--metrics <METRICS>]
                            [--composite-rule <COMPOSITE_RULE>]
                            [<ALARM ID or NAME>]

Update an alarm

**Positional arguments:**

``<ALARM ID or NAME>``
  ID or name of an alarm.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <NAME>``
  Name of the alarm

``-t <TYPE>, --type <TYPE>``
  Type of alarm, should be one of: threshold, event,
  composite, gnocchi_resources_threshold,
  gnocchi_aggregation_by_metrics_threshold,
  gnocchi_aggregation_by_resources_threshold.

``--project-id <PROJECT_ID>``
  Project to associate with alarm (configurable by admin
  users only)

``--user-id <USER_ID>``
  User to associate with alarm (configurable by admin
  users only)

``--description <DESCRIPTION>``
  Free text description of the alarm

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low', 'moderate',
  'critical']

``--enabled {True|False}``
  True if alarm evaluation is enabled

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm. May be
  used multiple times

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK. May be
  used multiple times

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to insufficient
  data. May be used multiple times

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at evaluation is
  within this time constraint. Start point(s) of the
  constraint are specified with a cron expression,
  whereas its duration is given in seconds. Can be
  specified multiple times for multiple time
  constraints, format is: name=<CONSTRAINT_NAME>;start=<
  CRON>;duration=<SECONDS>;[description=<DESCRIPTION>;[t
  imezone=<IANA Timezone>]]

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified while
  alarm remains in target state

.. _aodh_alarm-history_search:

aodh alarm-history search
-------------------------

.. code-block:: console

   usage: aodh alarm-history search [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]
                                    [--query QUERY]

Show history for all alarms based on query

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--query QUERY``
  Rich query supported by aodh, e.g. project_id!=my-id
  user_id=foo or user_id=bar

.. _aodh_alarm-history_show:

aodh alarm-history show
-----------------------

.. code-block:: console

   usage: aodh alarm-history show [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--limit <LIMIT>] [--marker <MARKER>]
                                  [--sort <SORT_KEY:SORT_DIR>]
                                  alarm_id

Show history for an alarm

**Positional arguments:**

``alarm_id``
  ID of an alarm

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit <LIMIT>``
  Number of resources to return (Default is server
  default)

``--marker <MARKER>``
  Last item of the previous listing. Return the next
  results after this value,the supported marker is
  event_id.

``--sort <SORT_KEY:SORT_DIR>``
  Sort of resource attribute. e.g. timestamp:desc

.. _aodh_capabilities_list:

aodh capabilities list
----------------------

.. code-block:: console

   usage: aodh capabilities list [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent] [--prefix PREFIX]

List capabilities of alarming service

**Optional arguments:**

``-h, --help``
  show this help message and exit

