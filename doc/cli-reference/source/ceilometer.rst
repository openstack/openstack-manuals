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

==================================================================
Telemetry Data Collection service (ceilometer) command-line client
==================================================================

The ceilometer client is the command-line interface (CLI) for
the Telemetry Data Collection service (ceilometer) API and its extensions.

This chapter documents :command:`ceilometer` version ``2.8.0``.

For help on a specific :command:`ceilometer` command, enter:

.. code-block:: console

   $ ceilometer help COMMAND

.. _ceilometer_command_usage:

ceilometer usage
~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: ceilometer [--version] [-d] [-v] [--timeout TIMEOUT]
                     [--ceilometer-url <CEILOMETER_URL>]
                     [--ceilometer-api-version CEILOMETER_API_VERSION]
                     [--os-tenant-id <tenant-id>]
                     [--os-region-name <region-name>]
                     [--os-auth-token <auth-token>]
                     [--os-service-type <service-type>]
                     [--os-endpoint-type <endpoint-type>] [--os-cacert <cacert>]
                     [--os-insecure <insecure>] [--os-cert-file <cert-file>]
                     [--os-key-file <key-file>] [--os-cert <cert>]
                     [--os-key <key>] [--os-project-name <project-name>]
                     [--os-project-id <project-id>]
                     [--os-project-domain-id <project-domain-id>]
                     [--os-project-domain-name <project-domain-name>]
                     [--os-user-id <user-id>]
                     [--os-user-domain-id <user-domain-id>]
                     [--os-user-domain-name <user-domain-name>]
                     [--os-endpoint <endpoint>] [--os-auth-system <auth-system>]
                     [--os-username <username>] [--os-password <password>]
                     [--os-tenant-name <tenant-name>] [--os-token <token>]
                     [--os-auth-url <auth-url>]
                     <subcommand> ...

**Subcommands:**

``alarm-combination-create``
  Create a new alarm based on state of other
  alarms.

``alarm-combination-update``
  Update an existing alarm based on state of
  other alarms.

``alarm-create``
  Create a new alarm (Deprecated). Use alarm-threshold-create instead.

``alarm-delete``
  Delete an alarm.

``alarm-event-create``
  Create a new alarm based on events.

``alarm-event-update``
  Update an existing alarm based on events.

``alarm-gnocchi-aggregation-by-metrics-threshold-create``
  Create a new alarm based on computed
  statistics.

``alarm-gnocchi-aggregation-by-metrics-threshold-update``
  Update an existing alarm based on computed
  statistics.

``alarm-gnocchi-aggregation-by-resources-threshold-create``
  Create a new alarm based on computed
  statistics.

``alarm-gnocchi-aggregation-by-resources-threshold-update``
  Update an existing alarm based on computed
  statistics.

``alarm-gnocchi-resources-threshold-create``
  Create a new alarm based on computed
  statistics.

``alarm-gnocchi-resources-threshold-update``
  Update an existing alarm based on computed
  statistics.

``alarm-history``
  Display the change history of an alarm.

``alarm-list``
  List the user's alarms.

``alarm-show``
  Show an alarm.

``alarm-state-get``
  Get the state of an alarm.

``alarm-state-set``
  Set the state of an alarm.

``alarm-threshold-create``
  Create a new alarm based on computed
  statistics.

``alarm-threshold-update``
  Update an existing alarm based on computed
  statistics.

``alarm-update``
  Update an existing alarm (Deprecated).

``capabilities``
  Print Ceilometer capabilities.

``event-list``
  List events.

``event-show``
  Show a particular event.

``event-type-list``
  List event types.

``meter-list``
  List the user's meters.

``query-alarm-history``
  Query Alarm History.

``query-alarms``
  Query Alarms.

``query-samples``
  Query samples.

``resource-list``
  List the resources.

``resource-show``
  Show the resource.

``sample-create``
  Create a sample.

``sample-create-list``
  Create a sample list.

``sample-list``
  List the samples (return OldSample objects if
  -m/--meter is set).

``sample-show``
  Show a sample.

``statistics``
  List the statistics for a meter.

``trait-description-list``
  List trait info for an event type.

``trait-list``
  List all traits with name <trait_name> for
  Event Type <event_type>.

``bash-completion``
  Prints all of the commands and options to
  stdout.

``help``
  Display help about this program or one of its
  subcommands.

.. _ceilometer_command_options:

ceilometer optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-d, --debug``
  Defaults to ``env[CEILOMETERCLIENT_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``--timeout TIMEOUT``
  Number of seconds to wait for a response.

``--ceilometer-url <CEILOMETER_URL>``
  **DEPRECATED**, use --os-endpoint instead.
  Defaults to ``env[CEILOMETER_URL]``.

``--ceilometer-api-version CEILOMETER_API_VERSION``
  Defaults to ``env[CEILOMETER_API_VERSION]`` or 2.

``--os-tenant-id <tenant-id>``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-region-name <region-name>``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-auth-token <auth-token>``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--os-service-type <service-type>``
  Defaults to ``env[OS_SERVICE_TYPE]``.

``--os-endpoint-type <endpoint-type>``
  Defaults to ``env[OS_ENDPOINT_TYPE]``.

``--os-cacert <cacert>``
  Defaults to ``env[OS_CACERT]``.

``--os-insecure <insecure>``
  Defaults to ``env[OS_INSECURE]``.

``--os-cert-file <cert-file>``
  Defaults to ``env[OS_CERT_FILE]``.

``--os-key-file <key-file>``
  Defaults to ``env[OS_KEY_FILE]``.

``--os-cert <cert>``
  Defaults to ``env[OS_CERT]``.

``--os-key <key>``
  Defaults to ``env[OS_KEY]``.

``--os-project-name <project-name>``
  Defaults to ``env[OS_PROJECT_NAME]``.

``--os-project-id <project-id>``
  Defaults to ``env[OS_PROJECT_ID]``.

``--os-project-domain-id <project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-user-id <user-id>``
  Defaults to ``env[OS_USER_ID]``.

``--os-user-domain-id <user-domain-id>``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <user-domain-name>``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-endpoint <endpoint>``
  Defaults to ``env[OS_ENDPOINT]``.

``--os-auth-system <auth-system>``
  Defaults to ``env[OS_AUTH_SYSTEM]``.

``--os-username <username>``
  Defaults to ``env[OS_USERNAME]``.

``--os-password <password>``
  Defaults to ``env[OS_PASSWORD]``.

``--os-tenant-name <tenant-name>``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-token <token>``
  Defaults to ``env[OS_TOKEN]``.

``--os-auth-url <auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

.. _ceilometer_alarm-combination-create:

ceilometer alarm-combination-create
-----------------------------------

.. code-block:: console

   usage: ceilometer alarm-combination-create --name <NAME>
                                              [--project-id <ALARM_PROJECT_ID>]
                                              [--user-id <ALARM_USER_ID>]
                                              [--description <DESCRIPTION>]
                                              [--state <STATE>]
                                              [--severity <SEVERITY>]
                                              [--enabled {True|False}]
                                              [--alarm-action <Webhook URL>]
                                              [--ok-action <Webhook URL>]
                                              [--insufficient-data-action <Webhook URL>]
                                              [--time-constraint <Time Constraint>]
                                              [--repeat-actions {True|False}]
                                              --alarm_ids <ALARM IDS>
                                              [--operator <OPERATOR>]

Create a new alarm based on state of other alarms.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--alarm_ids <ALARM IDS>``
  List of alarm IDs. Required.

``--operator <OPERATOR>``
  Operator to compare with, one of: ['and',
  'or'].

.. _ceilometer_alarm-combination-update:

ceilometer alarm-combination-update
-----------------------------------

.. code-block:: console

   usage: ceilometer alarm-combination-update [--name <NAME>]
                                              [--project-id <ALARM_PROJECT_ID>]
                                              [--user-id <ALARM_USER_ID>]
                                              [--description <DESCRIPTION>]
                                              [--state <STATE>]
                                              [--severity <SEVERITY>]
                                              [--enabled {True|False}]
                                              [--alarm-action <Webhook URL>]
                                              [--ok-action <Webhook URL>]
                                              [--insufficient-data-action <Webhook URL>]
                                              [--time-constraint <Time Constraint>]
                                              [--repeat-actions {True|False}]
                                              [--remove-time-constraint <Constraint names>]
                                              [--alarm_ids <ALARM IDS>]
                                              [--operator <OPERATOR>]
                                              [<ALARM_ID>]

Update an existing alarm based on state of other alarms.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--remove-time-constraint <Constraint names>``
  Name or list of names of the time constraints
  to remove.

``--alarm_ids <ALARM IDS>``
  List of alarm IDs.

``--operator <OPERATOR>``
  Operator to compare with, one of: ['and',
  'or'].

.. _ceilometer_alarm-delete:

ceilometer alarm-delete
-----------------------

.. code-block:: console

   usage: ceilometer alarm-delete [<ALARM_ID>]

Delete an alarm.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to delete.

.. _ceilometer_alarm-event-create:

ceilometer alarm-event-create
-----------------------------

.. code-block:: console

   usage: ceilometer alarm-event-create --name <NAME>
                                        [--project-id <ALARM_PROJECT_ID>]
                                        [--user-id <ALARM_USER_ID>]
                                        [--description <DESCRIPTION>]
                                        [--state <STATE>] [--severity <SEVERITY>]
                                        [--enabled {True|False}]
                                        [--alarm-action <Webhook URL>]
                                        [--ok-action <Webhook URL>]
                                        [--insufficient-data-action <Webhook URL>]
                                        [--time-constraint <Time Constraint>]
                                        [--repeat-actions {True|False}]
                                        [--event-type <EVENT_TYPE>] [-q <QUERY>]

Create a new alarm based on events.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--event-type <EVENT_TYPE>``
  Event type for event alarm.

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list for filtering
  events. data_type is optional, but if supplied
  must be string, integer, float or datetime.

.. _ceilometer_alarm-event-update:

ceilometer alarm-event-update
-----------------------------

.. code-block:: console

   usage: ceilometer alarm-event-update [--name <NAME>]
                                        [--project-id <ALARM_PROJECT_ID>]
                                        [--user-id <ALARM_USER_ID>]
                                        [--description <DESCRIPTION>]
                                        [--state <STATE>] [--severity <SEVERITY>]
                                        [--enabled {True|False}]
                                        [--alarm-action <Webhook URL>]
                                        [--ok-action <Webhook URL>]
                                        [--insufficient-data-action <Webhook URL>]
                                        [--time-constraint <Time Constraint>]
                                        [--repeat-actions {True|False}]
                                        [--event-type <EVENT_TYPE>] [-q <QUERY>]
                                        [<ALARM_ID>]

Update an existing alarm based on events.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--event-type <EVENT_TYPE>``
  Event type for event alarm.

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list for filtering
  events. data_type is optional, but if supplied
  must be string, integer, float or datetime.

.. _ceilometer_alarm-gnocchi-aggregation-by-metrics-threshold-create:

ceilometer alarm-gnocchi-aggregation-by-metrics-threshold-create
----------------------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-aggregation-by-metrics-threshold-create
          --name <NAME> [--project-id <ALARM_PROJECT_ID>]
          [--user-id <ALARM_USER_ID>] [--description <DESCRIPTION>]
          [--state <STATE>] [--severity <SEVERITY>] [--enabled {True|False}]
          [--alarm-action <Webhook URL>] [--ok-action <Webhook URL>]
          [--insufficient-data-action <Webhook URL>]
          [--time-constraint <Time Constraint>] [--repeat-actions {True|False}]
          [--granularity <GRANULARITY>] [--evaluation-periods <COUNT>]
          --aggregation-method <AGGREATION> [--comparison-operator <OPERATOR>]
          --threshold <THRESHOLD> -m <METRICS>

Create a new alarm based on computed statistics.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct']. Required.

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against. Required.

``-m <METRICS>, --metrics <METRICS>``
  Metric to evaluate against. Required.

.. _ceilometer_alarm-gnocchi-aggregation-by-metrics-threshold-update:

ceilometer alarm-gnocchi-aggregation-by-metrics-threshold-update
----------------------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-aggregation-by-metrics-threshold-update
          [--name <NAME>] [--project-id <ALARM_PROJECT_ID>]
          [--user-id <ALARM_USER_ID>] [--description <DESCRIPTION>]
          [--state <STATE>] [--severity <SEVERITY>] [--enabled {True|False}]
          [--alarm-action <Webhook URL>] [--ok-action <Webhook URL>]
          [--insufficient-data-action <Webhook URL>]
          [--time-constraint <Time Constraint>] [--repeat-actions {True|False}]
          [--granularity <GRANULARITY>] [--evaluation-periods <COUNT>]
          [--aggregation-method <AGGREATION>] [--comparison-operator <OPERATOR>]
          [--threshold <THRESHOLD>] [-m <METRICS>]
          [--remove-time-constraint <Constraint names>]
          [<ALARM_ID>]

Update an existing alarm based on computed statistics.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct'].

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against.

``-m <METRICS>, --metrics <METRICS>``
  Metric to evaluate against.

``--remove-time-constraint <Constraint names>``
  Name or list of names of the time constraints
  to remove.

.. _ceilometer_alarm-gnocchi-aggregation-by-resources-threshold-create:

ceilometer alarm-gnocchi-aggregation-by-resources-threshold-create
------------------------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-aggregation-by-resources-threshold-create
          --name <NAME> [--project-id <ALARM_PROJECT_ID>]
          [--user-id <ALARM_USER_ID>] [--description <DESCRIPTION>]
          [--state <STATE>] [--severity <SEVERITY>] [--enabled {True|False}]
          [--alarm-action <Webhook URL>] [--ok-action <Webhook URL>]
          [--insufficient-data-action <Webhook URL>]
          [--time-constraint <Time Constraint>] [--repeat-actions {True|False}]
          [--granularity <GRANULARITY>] [--evaluation-periods <COUNT>]
          --aggregation-method <AGGREATION> [--comparison-operator <OPERATOR>]
          --threshold <THRESHOLD> -m <METRIC> --resource-type <RESOURCE_TYPE>
          --query <QUERY>

Create a new alarm based on computed statistics.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct']. Required.

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against. Required.

``-m <METRIC>, --metric <METRIC>``
  Metric to evaluate against. Required.

``--resource-type <RESOURCE_TYPE>``
  Resource_type to evaluate against. Required.

``--query <QUERY>``
  Gnocchi resources search query filter
  Required.

.. _ceilometer_alarm-gnocchi-aggregation-by-resources-threshold-update:

ceilometer alarm-gnocchi-aggregation-by-resources-threshold-update
------------------------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-aggregation-by-resources-threshold-update
          [--name <NAME>] [--project-id <ALARM_PROJECT_ID>]
          [--user-id <ALARM_USER_ID>] [--description <DESCRIPTION>]
          [--state <STATE>] [--severity <SEVERITY>] [--enabled {True|False}]
          [--alarm-action <Webhook URL>] [--ok-action <Webhook URL>]
          [--insufficient-data-action <Webhook URL>]
          [--time-constraint <Time Constraint>] [--repeat-actions {True|False}]
          [--granularity <GRANULARITY>] [--evaluation-periods <COUNT>]
          [--aggregation-method <AGGREATION>] [--comparison-operator <OPERATOR>]
          [--threshold <THRESHOLD>] [-m <METRIC>]
          [--resource-type <RESOURCE_TYPE>] [--query <QUERY>]
          [--remove-time-constraint <Constraint names>]
          [<ALARM_ID>]

Update an existing alarm based on computed statistics.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct'].

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against.

``-m <METRIC>, --metric <METRIC>``
  Metric to evaluate against.

``--resource-type <RESOURCE_TYPE>``
  Resource_type to evaluate against.

``--query <QUERY>``
  Gnocchi resources search query filter

``--remove-time-constraint <Constraint names>``
  Name or list of names of the time constraints
  to remove.

.. _ceilometer_alarm-gnocchi-resources-threshold-create:

ceilometer alarm-gnocchi-resources-threshold-create
---------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-resources-threshold-create --name <NAME>
                                                              [--project-id <ALARM_PROJECT_ID>]
                                                              [--user-id <ALARM_USER_ID>]
                                                              [--description <DESCRIPTION>]
                                                              [--state <STATE>]
                                                              [--severity <SEVERITY>]
                                                              [--enabled {True|False}]
                                                              [--alarm-action <Webhook URL>]
                                                              [--ok-action <Webhook URL>]
                                                              [--insufficient-data-action <Webhook URL>]
                                                              [--time-constraint <Time Constraint>]
                                                              [--repeat-actions {True|False}]
                                                              [--granularity <GRANULARITY>]
                                                              [--evaluation-periods <COUNT>]
                                                              --aggregation-method
                                                              <AGGREATION>
                                                              [--comparison-operator <OPERATOR>]
                                                              --threshold
                                                              <THRESHOLD> -m
                                                              <METRIC>
                                                              --resource-type
                                                              <RESOURCE_TYPE>
                                                              --resource-id
                                                              <RESOURCE_ID>

Create a new alarm based on computed statistics.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct']. Required.

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against. Required.

``-m <METRIC>, --metric <METRIC>``
  Metric to evaluate against. Required.

``--resource-type <RESOURCE_TYPE>``
  Resource_type to evaluate against. Required.

``--resource-id <RESOURCE_ID>``
  Resource id to evaluate against Required.

.. _ceilometer_alarm-gnocchi-resources-threshold-update:

ceilometer alarm-gnocchi-resources-threshold-update
---------------------------------------------------

.. code-block:: console

   usage: ceilometer alarm-gnocchi-resources-threshold-update [--name <NAME>]
                                                              [--project-id <ALARM_PROJECT_ID>]
                                                              [--user-id <ALARM_USER_ID>]
                                                              [--description <DESCRIPTION>]
                                                              [--state <STATE>]
                                                              [--severity <SEVERITY>]
                                                              [--enabled {True|False}]
                                                              [--alarm-action <Webhook URL>]
                                                              [--ok-action <Webhook URL>]
                                                              [--insufficient-data-action <Webhook URL>]
                                                              [--time-constraint <Time Constraint>]
                                                              [--repeat-actions {True|False}]
                                                              [--granularity <GRANULARITY>]
                                                              [--evaluation-periods <COUNT>]
                                                              [--aggregation-method <AGGREATION>]
                                                              [--comparison-operator <OPERATOR>]
                                                              [--threshold <THRESHOLD>]
                                                              [-m <METRIC>]
                                                              [--resource-type <RESOURCE_TYPE>]
                                                              [--resource-id <RESOURCE_ID>]
                                                              [--remove-time-constraint <Constraint names>]
                                                              [<ALARM_ID>]

Update an existing alarm based on computed statistics.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--granularity <GRANULARITY>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--aggregation-method <AGGREATION>``
  Aggregation method to use, one of: ['last',
  'min', 'median', 'sum', 'std', 'first',
  'mean', 'count', 'moving-average', 'max',
  '1pct', '2pct', '3pct', '4pct', '5pct',
  '6pct', '7pct', '8pct', '9pct', '10pct',
  '11pct', '12pct', '13pct', '14pct', '15pct',
  '16pct', '17pct', '18pct', '19pct', '20pct',
  '21pct', '22pct', '23pct', '24pct', '25pct',
  '26pct', '27pct', '28pct', '29pct', '30pct',
  '31pct', '32pct', '33pct', '34pct', '35pct',
  '36pct', '37pct', '38pct', '39pct', '40pct',
  '41pct', '42pct', '43pct', '44pct', '45pct',
  '46pct', '47pct', '48pct', '49pct', '50pct',
  '51pct', '52pct', '53pct', '54pct', '55pct',
  '56pct', '57pct', '58pct', '59pct', '60pct',
  '61pct', '62pct', '63pct', '64pct', '65pct',
  '66pct', '67pct', '68pct', '69pct', '70pct',
  '71pct', '72pct', '73pct', '74pct', '75pct',
  '76pct', '77pct', '78pct', '79pct', '80pct',
  '81pct', '82pct', '83pct', '84pct', '85pct',
  '86pct', '87pct', '88pct', '89pct', '90pct',
  '91pct', '92pct', '93pct', '94pct', '95pct',
  '96pct', '97pct', '98pct', '99pct'].

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against.

``-m <METRIC>, --metric <METRIC>``
  Metric to evaluate against.

``--resource-type <RESOURCE_TYPE>``
  Resource_type to evaluate against.

``--resource-id <RESOURCE_ID>``
  Resource id to evaluate against

``--remove-time-constraint <Constraint names>``
  Name or list of names of the time constraints
  to remove.

.. _ceilometer_alarm-history:

ceilometer alarm-history
------------------------

.. code-block:: console

   usage: ceilometer alarm-history [-q <QUERY>] [<ALARM_ID>]

Display the change history of an alarm.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm for which history is shown.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

.. _ceilometer_alarm-list:

ceilometer alarm-list
---------------------

.. code-block:: console

   usage: ceilometer alarm-list [-q <QUERY>]

List the user's alarms.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

.. _ceilometer_alarm-show:

ceilometer alarm-show
---------------------

.. code-block:: console

   usage: ceilometer alarm-show [<ALARM_ID>]

Show an alarm.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to show.

.. _ceilometer_alarm-state-get:

ceilometer alarm-state-get
--------------------------

.. code-block:: console

   usage: ceilometer alarm-state-get [<ALARM_ID>]

Get the state of an alarm.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm state to show.

.. _ceilometer_alarm-state-set:

ceilometer alarm-state-set
--------------------------

.. code-block:: console

   usage: ceilometer alarm-state-set --state <STATE> [<ALARM_ID>]

Set the state of an alarm.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm state to set.

**Optional arguments:**

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm', 'insufficient
  data']. Required.

.. _ceilometer_alarm-threshold-create:

ceilometer alarm-threshold-create
---------------------------------

.. code-block:: console

   usage: ceilometer alarm-threshold-create --name <NAME>
                                            [--project-id <ALARM_PROJECT_ID>]
                                            [--user-id <ALARM_USER_ID>]
                                            [--description <DESCRIPTION>]
                                            [--state <STATE>]
                                            [--severity <SEVERITY>]
                                            [--enabled {True|False}]
                                            [--alarm-action <Webhook URL>]
                                            [--ok-action <Webhook URL>]
                                            [--insufficient-data-action <Webhook URL>]
                                            [--time-constraint <Time Constraint>]
                                            [--repeat-actions {True|False}] -m
                                            <METRIC> [--period <PERIOD>]
                                            [--evaluation-periods <COUNT>]
                                            [--statistic <STATISTIC>]
                                            [--comparison-operator <OPERATOR>]
                                            --threshold <THRESHOLD> [-q <QUERY>]

Create a new alarm based on computed statistics.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).
  Required.

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``-m <METRIC>, --meter-name <METRIC>``
  Metric to evaluate against. Required.

``--period <PERIOD>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--statistic <STATISTIC>``
  Statistic to evaluate, one of: ['max', 'min',
  'avg', 'sum', 'count'].

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against. Required.

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

.. _ceilometer_alarm-threshold-update:

ceilometer alarm-threshold-update
---------------------------------

.. code-block:: console

   usage: ceilometer alarm-threshold-update [--name <NAME>]
                                            [--project-id <ALARM_PROJECT_ID>]
                                            [--user-id <ALARM_USER_ID>]
                                            [--description <DESCRIPTION>]
                                            [--state <STATE>]
                                            [--severity <SEVERITY>]
                                            [--enabled {True|False}]
                                            [--alarm-action <Webhook URL>]
                                            [--ok-action <Webhook URL>]
                                            [--insufficient-data-action <Webhook URL>]
                                            [--time-constraint <Time Constraint>]
                                            [--repeat-actions {True|False}]
                                            [--remove-time-constraint <Constraint names>]
                                            [-m <METRIC>] [--period <PERIOD>]
                                            [--evaluation-periods <COUNT>]
                                            [--statistic <STATISTIC>]
                                            [--comparison-operator <OPERATOR>]
                                            [--threshold <THRESHOLD>]
                                            [-q <QUERY>]
                                            [<ALARM_ID>]

Update an existing alarm based on computed statistics.

**Positional arguments:**

``<ALARM_ID>``
  ID of the alarm to update.

**Optional arguments:**

``--name <NAME>``
  Name of the alarm (must be unique per tenant).

``--project-id <ALARM_PROJECT_ID>``
  Tenant to associate with alarm (configurable
  by admin users only).

``--user-id <ALARM_USER_ID>``
  User to associate with alarm (configurable by
  admin users only).

``--description <DESCRIPTION>``
  Free text description of the alarm.

``--state <STATE>``
  State of the alarm, one of: ['ok', 'alarm',
  'insufficient data']

``--severity <SEVERITY>``
  Severity of the alarm, one of: ['low',
  'moderate', 'critical']

``--enabled {True|False}``
  True if alarm evaluation/actioning is enabled.

``--alarm-action <Webhook URL>``
  URL to invoke when state transitions to alarm.
  May be used multiple times. Defaults to None.

``--ok-action <Webhook URL>``
  URL to invoke when state transitions to OK.
  May be used multiple times. Defaults to None.

``--insufficient-data-action <Webhook URL>``
  URL to invoke when state transitions to
  insufficient data. May be used multiple times.
  Defaults to None.

``--time-constraint <Time Constraint>``
  Only evaluate the alarm if the time at
  evaluation is within this time constraint.
  Start point(s) of the constraint are specified
  with a cron expression, whereas its duration
  is given in seconds. Can be specified multiple
  times for multiple time constraints, format
  is: name=<CONSTRAINT_NAME>;start=<CRON>;durati
  on=<SECONDS>;[description=<DESCRIPTION>;[timez
  one=<IANA Timezone>]] Defaults to None.

``--repeat-actions {True|False}``
  True if actions should be repeatedly notified
  while alarm remains in target state.

``--remove-time-constraint <Constraint names>``
  Name or list of names of the time constraints
  to remove.

``-m <METRIC>, --meter-name <METRIC>``
  Metric to evaluate against.

``--period <PERIOD>``
  Length of each period (seconds) to evaluate
  over.

``--evaluation-periods <COUNT>``
  Number of periods to evaluate over.

``--statistic <STATISTIC>``
  Statistic to evaluate, one of: ['max', 'min',
  'avg', 'sum', 'count'].

``--comparison-operator <OPERATOR>``
  Operator to compare with, one of: ['lt', 'le',
  'eq', 'ne', 'ge', 'gt'].

``--threshold <THRESHOLD>``
  Threshold to evaluate against.

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

.. _ceilometer_capabilities:

ceilometer capabilities
-----------------------

.. code-block:: console

   usage: ceilometer capabilities

Print Ceilometer capabilities.

.. _ceilometer_event-list:

ceilometer event-list
---------------------

.. code-block:: console

   usage: ceilometer event-list [-q <QUERY>] [--no-traits] [-l <NUMBER>]

List events.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float or datetime.

``--no-traits``
  If specified, traits will not be printed.

``-l <NUMBER>, --limit <NUMBER>``
  Maximum number of events to return. API server
  limits result to <default_api_return_limit>
  rows if no limit provided. Option is
  configured in ceilometer.conf [api] group

.. _ceilometer_event-show:

ceilometer event-show
---------------------

.. code-block:: console

   usage: ceilometer event-show <message_id>

Show a particular event.

**Positional arguments:**

``<message_id>``
  The ID of the event. Should be a UUID.

.. _ceilometer_event-type-list:

ceilometer event-type-list
--------------------------

.. code-block:: console

   usage: ceilometer event-type-list

List event types.

.. _ceilometer_meter-list:

ceilometer meter-list
---------------------

.. code-block:: console

   usage: ceilometer meter-list [-q <QUERY>] [-l <NUMBER>]
                                [--unique {True|False}]

List the user's meters.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

``-l <NUMBER>, --limit <NUMBER>``
  Maximum number of meters to return. API server
  limits result to <default_api_return_limit>
  rows if no limit provided. Option is
  configured in ceilometer.conf [api] group

``--unique {True|False}``
  Retrieves unique list of meters.

.. _ceilometer_query-alarm-history:

ceilometer query-alarm-history
------------------------------

.. code-block:: console

   usage: ceilometer query-alarm-history [-f <FILTER>] [-o <ORDERBY>]
                                         [-l <LIMIT>]

Query Alarm History.

**Optional arguments:**

``-f <FILTER>, --filter <FILTER>``
  {complex_op: [{simple_op: {field_name:
  value}}]} The complex_op is one of: ['and',
  'or'], simple_op is one of: ['=', '!=', '<',
  '<=', '>', '>='].

``-o <ORDERBY>, --orderby <ORDERBY>``
  [{field_name: direction}, {field_name:
  direction}] The direction is one of: ['asc',
  'desc'].

``-l <LIMIT>, --limit <LIMIT>``
  Maximum number of alarm history items to
  return. API server limits result to
  <default_api_return_limit> rows if no limit
  provided. Option is configured in
  ceilometer.conf [api] group

.. _ceilometer_query-alarms:

ceilometer query-alarms
-----------------------

.. code-block:: console

   usage: ceilometer query-alarms [-f <FILTER>] [-o <ORDERBY>] [-l <LIMIT>]

Query Alarms.

**Optional arguments:**

``-f <FILTER>, --filter <FILTER>``
  {complex_op: [{simple_op: {field_name:
  value}}]} The complex_op is one of: ['and',
  'or'], simple_op is one of: ['=', '!=', '<',
  '<=', '>', '>='].

``-o <ORDERBY>, --orderby <ORDERBY>``
  [{field_name: direction}, {field_name:
  direction}] The direction is one of: ['asc',
  'desc'].

``-l <LIMIT>, --limit <LIMIT>``
  Maximum number of alarms to return. API server
  limits result to <default_api_return_limit>
  rows if no limit provided. Option is
  configured in ceilometer.conf [api] group

.. _ceilometer_query-samples:

ceilometer query-samples
------------------------

.. code-block:: console

   usage: ceilometer query-samples [-f <FILTER>] [-o <ORDERBY>] [-l <LIMIT>]

Query samples.

**Optional arguments:**

``-f <FILTER>, --filter <FILTER>``
  {complex_op: [{simple_op: {field_name:
  value}}]} The complex_op is one of: ['and',
  'or'], simple_op is one of: ['=', '!=', '<',
  '<=', '>', '>='].

``-o <ORDERBY>, --orderby <ORDERBY>``
  [{field_name: direction}, {field_name:
  direction}] The direction is one of: ['asc',
  'desc'].

``-l <LIMIT>, --limit <LIMIT>``
  Maximum number of samples to return. API
  server limits result to
  <default_api_return_limit> rows if no limit
  provided. Option is configured in
  ceilometer.conf [api] group

.. _ceilometer_resource-list:

ceilometer resource-list
------------------------

.. code-block:: console

   usage: ceilometer resource-list [-q <QUERY>] [-l <NUMBER>]

List the resources.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

``-l <NUMBER>, --limit <NUMBER>``
  Maximum number of resources to return. API
  server limits result to
  <default_api_return_limit> rows if no limit
  provided. Option is configured in
  ceilometer.conf [api] group

.. _ceilometer_resource-show:

ceilometer resource-show
------------------------

.. code-block:: console

   usage: ceilometer resource-show <RESOURCE_ID>

Show the resource.

**Positional arguments:**

``<RESOURCE_ID>``
  ID of the resource to show.

.. _ceilometer_sample-create:

ceilometer sample-create
------------------------

.. code-block:: console

   usage: ceilometer sample-create [--project-id <SAMPLE_PROJECT_ID>]
                                   [--user-id <SAMPLE_USER_ID>] -r <RESOURCE_ID>
                                   -m <METER_NAME> --meter-type <METER_TYPE>
                                   --meter-unit <METER_UNIT> --sample-volume
                                   <SAMPLE_VOLUME>
                                   [--resource-metadata <RESOURCE_METADATA>]
                                   [--timestamp <TIMESTAMP>] [--direct <DIRECT>]

Create a sample.

**Optional arguments:**

``--project-id <SAMPLE_PROJECT_ID>``
  Tenant to associate with sample (configurable
  by admin users only).

``--user-id <SAMPLE_USER_ID>``
  User to associate with sample (configurable by
  admin users only).

``-r <RESOURCE_ID>, --resource-id <RESOURCE_ID>``
  ID of the resource. Required.

``-m <METER_NAME>, --meter-name <METER_NAME>``
  The meter name. Required.

``--meter-type <METER_TYPE>``
  The meter type. Required.

``--meter-unit <METER_UNIT>``
  The meter unit. Required.

``--sample-volume <SAMPLE_VOLUME>``
  The sample volume. Required.

``--resource-metadata <RESOURCE_METADATA>``
  Resource metadata. Provided value should be a
  set of key-value pairs e.g. {"key":"value"}.

``--timestamp <TIMESTAMP>``
  The sample timestamp.

``--direct <DIRECT>``
  Post sample to storage directly. Defaults to
  False.

.. _ceilometer_sample-create-list:

ceilometer sample-create-list
-----------------------------

.. code-block:: console

   usage: ceilometer sample-create-list [--direct <DIRECT>] <SAMPLES_LIST>

Create a sample list.

**Positional arguments:**

``<SAMPLES_LIST>``
  Json array with samples to create.

**Optional arguments:**

``--direct <DIRECT>``
  Post samples to storage directly. Defaults to False.

.. _ceilometer_sample-list:

ceilometer sample-list
----------------------

.. code-block:: console

   usage: ceilometer sample-list [-q <QUERY>] [-m <NAME>] [-l <NUMBER>]

List the samples (return OldSample objects if -m/--meter is set).

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

``-m <NAME>, --meter <NAME>``
  Name of meter to show samples for.

``-l <NUMBER>, --limit <NUMBER>``
  Maximum number of samples to return. API
  server limits result to
  <default_api_return_limit> rows if no limit
  provided. Option is configured in
  ceilometer.conf [api] group

.. _ceilometer_sample-show:

ceilometer sample-show
----------------------

.. code-block:: console

   usage: ceilometer sample-show <SAMPLE_ID>

Show a sample.

**Positional arguments:**

``<SAMPLE_ID>``
  ID (aka message ID) of the sample to show.

.. _ceilometer_statistics:

ceilometer statistics
---------------------

.. code-block:: console

   usage: ceilometer statistics [-q <QUERY>] -m <NAME> [-p <PERIOD>] [-g <FIELD>]
                                [-a <FUNC>[<-<PARAM>]]

List the statistics for a meter.

**Optional arguments:**

``-q <QUERY>, --query <QUERY>``
  key[op]data_type::value; list. data_type is
  optional, but if supplied must be string,
  integer, float, or boolean.

``-m <NAME>, --meter <NAME>``
  Name of meter to list statistics for.
  Required.

``-p <PERIOD>, --period <PERIOD>``
  Period in seconds over which to group samples.

``-g <FIELD>, --groupby <FIELD>``
  Field for group by.

``-a <FUNC>[<-<PARAM>], --aggregate <FUNC>[<-<PARAM>]``
  Function for data aggregation. Available
  aggregates are: count, cardinality, min, max,
  sum, stddev, avg. Defaults to [].

.. _ceilometer_trait-description-list:

ceilometer trait-description-list
---------------------------------

.. code-block:: console

   usage: ceilometer trait-description-list -e <EVENT_TYPE>

List trait info for an event type.

**Optional arguments:**

``-e <EVENT_TYPE>, --event_type <EVENT_TYPE>``
  Type of the event for which traits will be
  shown. Required.

.. _ceilometer_trait-list:

ceilometer trait-list
---------------------

.. code-block:: console

   usage: ceilometer trait-list -e <EVENT_TYPE> -t <TRAIT_NAME>

List all traits with name <trait_name> for Event Type <event_type>.

**Optional arguments:**

``-e <EVENT_TYPE>, --event_type <EVENT_TYPE>``
  Type of the event for which traits will
  listed. Required.

``-t <TRAIT_NAME>, --trait_name <TRAIT_NAME>``
  The name of the trait to list. Required.

