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

========================================
Monitoring (monasca) command-line client
========================================

The monasca client is the command-line interface (CLI) for
the Monitoring (monasca) API and its extensions.

This chapter documents :command:`monasca` version ``1.5.0``.

For help on a specific :command:`monasca` command, enter:

.. code-block:: console

   $ monasca help COMMAND

.. _monasca_command_usage:

monasca usage
~~~~~~~~~~~~~

.. code-block:: console

   usage: monasca [-j] [--version] [-d] [-v] [-k] [--cert-file CERT_FILE]
                  [--key-file KEY_FILE] [--os-cacert OS_CACERT]
                  [--keystone_timeout KEYSTONE_TIMEOUT]
                  [--os-username OS_USERNAME] [--os-password OS_PASSWORD]
                  [--os-user-domain-id OS_USER_DOMAIN_ID]
                  [--os-user-domain-name OS_USER_DOMAIN_NAME]
                  [--os-project-id OS_PROJECT_ID]
                  [--os-project-name OS_PROJECT_NAME]
                  [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                  [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                  [--os-auth-url OS_AUTH_URL] [--os-region-name OS_REGION_NAME]
                  [--os-auth-token OS_AUTH_TOKEN] [--os-no-client-auth]
                  [--monasca-api-url MONASCA_API_URL]
                  [--monasca-api-version MONASCA_API_VERSION]
                  [--os-service-type OS_SERVICE_TYPE]
                  [--os-endpoint-type OS_ENDPOINT_TYPE]
                  <subcommand> ...
     <subcommand>
       alarm-count              Count alarms.
       alarm-definition-create  Create an alarm definition.
       alarm-definition-delete  Delete the alarm definition.
       alarm-definition-list    List alarm definitions for this tenant.
       alarm-definition-patch   Patch the alarm definition.
       alarm-definition-show    Describe the alarm definition.
       alarm-definition-update  Update the alarm definition.
       alarm-delete             Delete the alarm.
       alarm-history            Alarm state transition history.
       alarm-history-list       List alarms state history.
       alarm-list               List alarms for this tenant.
       alarm-patch              Patch the alarm state.
       alarm-show               Describe the alarm.
       alarm-update             Update the alarm state.
       dimension-name-list      List names of metric dimensions.
       dimension-value-list     List names of metric dimensions.
       measurement-list         List measurements for the specified metric.
       metric-create            Create metric.
       metric-create-raw        Create metric from raw json body.
       metric-list              List metrics for this tenant.
       metric-name-list         List names of metrics.
       metric-statistics        List measurement statistics for the specified
                                metric.
       notification-create      Create notification.
       notification-delete      Delete notification.
       notification-list        List notifications for this tenant.
       notification-patch       Patch notification.
       notification-show        Describe the notification.
       notification-type-list   List notification types supported by monasca.
       notification-update      Update notification.
       bash-completion          Prints all of the commands and options to stdout.
       help                     Display help about this program or one of its
                                subcommands.

.. _monasca_command_options:

monasca optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~

``-j, --json``
  output raw json response

``--version``
  Shows the client version and exits.

``-d, --debug``
  Defaults to ``env[MONASCA_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``-k, --insecure``
  Explicitly allow the client to perform "insecure"
  SSL (https) requests. The server's certificate
  will not be verified against any certificate
  authorities. This option should be used with
  caution.

``--cert-file CERT_FILE``
  Path of certificate file to use in SSL
  connection. This file can optionally be prepended
  with the private key.

``--key-file KEY_FILE``
  Path of client key to use in SSL connection. This
  option is not necessary if your key is prepended
  to your cert file.

``--os-cacert OS_CACERT``
  Specify a CA bundle file to use in verifying a
  TLS (https) server certificate. Defaults to
  ``env[OS_CACERT]``. Without either of these, the
  client looks for the default system CA
  certificates.

``--keystone_timeout KEYSTONE_TIMEOUT``
  Number of seconds to wait for a response from
  keystone.

``--os-username OS_USERNAME``
  Defaults to ``env[OS_USERNAME]``.

``--os-password OS_PASSWORD``
  Defaults to ``env[OS_PASSWORD]``.

``--os-user-domain-id OS_USER_DOMAIN_ID``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name OS_USER_DOMAIN_NAME``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-id OS_PROJECT_ID``
  Defaults to ``env[OS_PROJECT_ID]``.

``--os-project-name OS_PROJECT_NAME``
  Defaults to ``env[OS_PROJECT_NAME]``.

``--os-project-domain-id OS_PROJECT_DOMAIN_ID``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name OS_PROJECT_DOMAIN_NAME``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-auth-url OS_AUTH_URL``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-region-name OS_REGION_NAME``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-auth-token OS_AUTH_TOKEN``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--os-no-client-auth``
  Do not contact keystone for a token. Defaults to
  ``env[OS_NO_CLIENT_AUTH]``.

``--monasca-api-url MONASCA_API_URL``
  Defaults to ``env[MONASCA_API_URL]``.

``--monasca-api-version MONASCA_API_VERSION``
  Defaults to ``env[MONASCA_API_VERSION]`` or 2_0

``--os-service-type OS_SERVICE_TYPE``
  Defaults to ``env[OS_SERVICE_TYPE]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]``.

.. _monasca_alarm-count:

monasca alarm-count
-------------------

.. code-block:: console

   usage: monasca alarm-count [--alarm-definition-id <ALARM_DEFINITION_ID>]
                              [--metric-name <METRIC_NAME>]
                              [--metric-dimensions <KEY1=VALUE1,KEY2,KEY3=VALUE2...>]
                              [--state <ALARM_STATE>] [--severity <SEVERITY>]
                              [--state-updated-start-time <UTC_STATE_UPDATED_START>]
                              [--lifecycle-state <LIFECYCLE_STATE>]
                              [--link <LINK>] [--group-by <GROUP_BY>]
                              [--offset <OFFSET LOCATION>]
                              [--limit <RETURN LIMIT>]

Count alarms.

**Optional arguments:**

``--alarm-definition-id <ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

``--metric-name <METRIC_NAME>``
  Name of the metric.

``--metric-dimensions <KEY1=VALUE1,KEY2,KEY3=VALUE2...>``
  key value pair used to specify a metric dimension or
  just key to select all values of that dimension.This
  can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--state <ALARM_STATE>``
  ALARM_STATE is one of [UNDETERMINED, OK, ALARM].

``--severity <SEVERITY>``
  Severity is one of ["LOW", "MEDIUM", "HIGH",
  "CRITICAL"].

``--state-updated-start-time <UTC_STATE_UPDATED_START>``
  Return all alarms whose state was updated on or after
  the time specified.

``--lifecycle-state <LIFECYCLE_STATE>``
  The lifecycle state of the alarm.

``--link <LINK>``
  The link to external data associated with the alarm.

``--group-by <GROUP_BY>``
  Comma separated list of one or more fields to group
  the results by. Group by is one or more of
  [alarm_definition_id, name, state, link,
  lifecycle_state, metric_name, dimension_name,
  dimension_value].

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_alarm-definition-create:

monasca alarm-definition-create
-------------------------------

.. code-block:: console

   usage: monasca alarm-definition-create [--description <DESCRIPTION>]
                                          [--severity <SEVERITY>]
                                          [--match-by <MATCH_BY_DIMENSION_KEY1,MATCH_BY_DIMENSION_KEY2,...>]
                                          [--alarm-actions <NOTIFICATION-ID>]
                                          [--ok-actions <NOTIFICATION-ID>]
                                          [--undetermined-actions <NOTIFICATION-ID>]
                                          <ALARM_DEFINITION_NAME> <EXPRESSION>

Create an alarm definition.

**Positional arguments:**

``<ALARM_DEFINITION_NAME>``
  Name of the alarm definition to create.

``<EXPRESSION>``
  The alarm expression to evaluate. Quoted.

**Optional arguments:**

``--description <DESCRIPTION>``
  Description of the alarm.

``--severity <SEVERITY>``
  Severity is one of [LOW, MEDIUM, HIGH, CRITICAL].

``--match-by <MATCH_BY_DIMENSION_KEY1,MATCH_BY_DIMENSION_KEY2,...>``
  The metric dimensions to use to create unique alarms.
  One or more dimension key names separated by a comma.
  Key names need quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--alarm-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  ALARM. This param may be specified multiple times.

``--ok-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  OK. This param may be specified multiple times.

``--undetermined-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  UNDETERMINED. This param may be specified multiple
  times.

.. _monasca_alarm-definition-delete:

monasca alarm-definition-delete
-------------------------------

.. code-block:: console

   usage: monasca alarm-definition-delete <ALARM_DEFINITION_ID>

Delete the alarm definition.

**Positional arguments:**

``<ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

.. _monasca_alarm-definition-list:

monasca alarm-definition-list
-----------------------------

.. code-block:: console

   usage: monasca alarm-definition-list [--name <ALARM_DEFINITION_NAME>]
                                        [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                        [--severity <SEVERITY>]
                                        [--sort-by <SORT BY FIELDS>]
                                        [--offset <OFFSET LOCATION>]
                                        [--limit <RETURN LIMIT>]

List alarm definitions for this tenant.

**Optional arguments:**

``--name <ALARM_DEFINITION_NAME>``
  Name of the alarm definition.

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--severity <SEVERITY>``
  Severity is one of ["LOW", "MEDIUM", "HIGH",
  "CRITICAL"].

``--sort-by <SORT BY FIELDS>``
  Fields to sort by as a comma separated list. Valid
  values are id, name, severity, created_at, updated_at.
  Fields may be followed by "asc" or "desc", ex
  "severity desc", to set the direction of sorting.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_alarm-definition-patch:

monasca alarm-definition-patch
------------------------------

.. code-block:: console

   usage: monasca alarm-definition-patch [--name <ALARM_DEFINITION_NAME>]
                                         [--description <DESCRIPTION>]
                                         [--expression <EXPRESSION>]
                                         [--alarm-actions <NOTIFICATION-ID>]
                                         [--ok-actions <NOTIFICATION-ID>]
                                         [--undetermined-actions <NOTIFICATION-ID>]
                                         [--actions-enabled <ACTIONS-ENABLED>]
                                         [--severity <SEVERITY>]
                                         <ALARM_DEFINITION_ID>

Patch the alarm definition.

**Positional arguments:**

``<ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

**Optional arguments:**

``--name <ALARM_DEFINITION_NAME>``
  Name of the alarm definition.

``--description <DESCRIPTION>``
  Description of the alarm.

``--expression <EXPRESSION>``
  The alarm expression to evaluate. Quoted.

``--alarm-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  ALARM. This param may be specified multiple times.

``--ok-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  OK. This param may be specified multiple times.

``--undetermined-actions <NOTIFICATION-ID>``
  The notification method to use when an alarm state is
  UNDETERMINED. This param may be specified multiple
  times.

``--actions-enabled <ACTIONS-ENABLED>``
  The actions-enabled boolean is one of [true,false].

``--severity <SEVERITY>``
  Severity is one of [LOW, MEDIUM, HIGH, CRITICAL].

.. _monasca_alarm-definition-show:

monasca alarm-definition-show
-----------------------------

.. code-block:: console

   usage: monasca alarm-definition-show <ALARM_DEFINITION_ID>

Describe the alarm definition.

**Positional arguments:**

``<ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

.. _monasca_alarm-definition-update:

monasca alarm-definition-update
-------------------------------

.. code-block:: console

   usage: monasca alarm-definition-update <ALARM_DEFINITION_ID>
                                          <ALARM_DEFINITION_NAME> <DESCRIPTION>
                                          <EXPRESSION>
                                          <ALARM-NOTIFICATION-ID1,ALARM-NOTIFICATION-ID2,...>
                                          <OK-NOTIFICATION-ID1,OK-NOTIFICATION-ID2,...>
                                          <UNDETERMINED-NOTIFICATION-ID1,UNDETERMINED-NOTIFICATION-ID2,...>
                                          <ACTIONS-ENABLED>
                                          <MATCH_BY_DIMENSION_KEY1,MATCH_BY_DIMENSION_KEY2,...>
                                          <SEVERITY>

Update the alarm definition.

**Positional arguments:**

``<ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

``<ALARM_DEFINITION_NAME>``
  Name of the alarm definition.

``<DESCRIPTION>``
  Description of the alarm.

``<EXPRESSION>``
  The alarm expression to evaluate. Quoted.

``<ALARM-NOTIFICATION-ID1,ALARM-NOTIFICATION-ID2,...>``
  The notification method(s) to use when an alarm state
  is ALARM as a comma separated list.

``<OK-NOTIFICATION-ID1,OK-NOTIFICATION-ID2,...>``
  The notification method(s) to use when an alarm state
  is OK as a comma separated list.

``<UNDETERMINED-NOTIFICATION-ID1,UNDETERMINED-NOTIFICATION-ID2,...>``
  The notification method(s) to use when an alarm state
  is UNDETERMINED as a comma separated list.

``<ACTIONS-ENABLED>``
  The actions-enabled boolean is one of [true,false]

``<MATCH_BY_DIMENSION_KEY1,MATCH_BY_DIMENSION_KEY2,...>``
  The metric dimensions to use to create unique alarms.
  One or more dimension key names separated by a comma.
  Key names need quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``<SEVERITY>``
  Severity is one of [LOW, MEDIUM, HIGH, CRITICAL].

.. _monasca_alarm-delete:

monasca alarm-delete
--------------------

.. code-block:: console

   usage: monasca alarm-delete <ALARM_ID>

Delete the alarm.

**Positional arguments:**

``<ALARM_ID>``
  The ID of the alarm.

.. _monasca_alarm-history:

monasca alarm-history
---------------------

.. code-block:: console

   usage: monasca alarm-history [--offset <OFFSET LOCATION>]
                                [--limit <RETURN LIMIT>]
                                <ALARM_ID>

Alarm state transition history.

**Positional arguments:**

``<ALARM_ID>``
  The ID of the alarm.

**Optional arguments:**

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_alarm-history-list:

monasca alarm-history-list
--------------------------

.. code-block:: console

   usage: monasca alarm-history-list [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                     [--starttime <UTC_START_TIME>]
                                     [--endtime <UTC_END_TIME>]
                                     [--offset <OFFSET LOCATION>]
                                     [--limit <RETURN LIMIT>]

List alarms state history.

**Optional arguments:**

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--starttime <UTC_START_TIME>``
  measurements >= UTC time. format:
  2014-01-01T00:00:00Z. OR format: -120 (previous 120
  minutes).

``--endtime <UTC_END_TIME>``
  measurements <= UTC time. format:
  2014-01-01T00:00:00Z.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_alarm-list:

monasca alarm-list
------------------

.. code-block:: console

   usage: monasca alarm-list [--alarm-definition-id <ALARM_DEFINITION_ID>]
                             [--metric-name <METRIC_NAME>]
                             [--metric-dimensions <KEY1=VALUE1,KEY2,KEY3=VALUE2...>]
                             [--state <ALARM_STATE>] [--severity <SEVERITY>]
                             [--state-updated-start-time <UTC_STATE_UPDATED_START>]
                             [--lifecycle-state <LIFECYCLE_STATE>]
                             [--link <LINK>] [--sort-by <SORT BY FIELDS>]
                             [--offset <OFFSET LOCATION>]
                             [--limit <RETURN LIMIT>]

List alarms for this tenant.

**Optional arguments:**

``--alarm-definition-id <ALARM_DEFINITION_ID>``
  The ID of the alarm definition.

``--metric-name <METRIC_NAME>``
  Name of the metric.

``--metric-dimensions <KEY1=VALUE1,KEY2,KEY3=VALUE2...>``
  key value pair used to specify a metric dimension or
  just key to select all values of that dimension.This
  can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--state <ALARM_STATE>``
  ALARM_STATE is one of [UNDETERMINED, OK, ALARM].

``--severity <SEVERITY>``
  Severity is one of ["LOW", "MEDIUM", "HIGH",
  "CRITICAL"].

``--state-updated-start-time <UTC_STATE_UPDATED_START>``
  Return all alarms whose state was updated on or after
  the time specified.

``--lifecycle-state <LIFECYCLE_STATE>``
  The lifecycle state of the alarm.

``--link <LINK>``
  The link to external data associated with the alarm.

``--sort-by <SORT BY FIELDS>``
  Fields to sort by as a comma separated list. Valid
  values are alarm_id, alarm_definition_id, state,
  severity, lifecycle_state, link,
  state_updated_timestamp, updated_timestamp,
  created_timestamp. Fields may be followed by "asc" or
  "desc", ex "severity desc", to set the direction of
  sorting.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_alarm-patch:

monasca alarm-patch
-------------------

.. code-block:: console

   usage: monasca alarm-patch [--state <ALARM_STATE>]
                              [--lifecycle-state <LIFECYCLE_STATE>]
                              [--link <LINK>]
                              <ALARM_ID>

Patch the alarm state.

**Positional arguments:**

``<ALARM_ID>``
  The ID of the alarm.

**Optional arguments:**

``--state <ALARM_STATE>``
  ALARM_STATE is one of [UNDETERMINED, OK, ALARM].

``--lifecycle-state <LIFECYCLE_STATE>``
  The lifecycle state of the alarm.

``--link <LINK>``
  A link to an external resource with information about
  the alarm.

.. _monasca_alarm-show:

monasca alarm-show
------------------

.. code-block:: console

   usage: monasca alarm-show <ALARM_ID>

Describe the alarm.

**Positional arguments:**

``<ALARM_ID>``
  The ID of the alarm.

.. _monasca_alarm-update:

monasca alarm-update
--------------------

.. code-block:: console

   usage: monasca alarm-update <ALARM_ID> <ALARM_STATE> <LIFECYCLE_STATE> <LINK>

Update the alarm state.

**Positional arguments:**

``<ALARM_ID>``
  The ID of the alarm.

``<ALARM_STATE>``
  ALARM_STATE is one of [UNDETERMINED, OK, ALARM].

``<LIFECYCLE_STATE>``
  The lifecycle state of the alarm.

``<LINK>``
  A link to an external resource with information about the
  alarm.

.. _monasca_dimension-name-list:

monasca dimension-name-list
---------------------------

.. code-block:: console

   usage: monasca dimension-name-list [--metric-name <METRIC_NAME>]
                                      [--offset <OFFSET LOCATION>]
                                      [--limit <RETURN LIMIT>]
                                      [--tenant-id <TENANT_ID>]

List names of metric dimensions.

**Optional arguments:**

``--metric-name <METRIC_NAME>``
  Name of the metric to report dimension name list.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_dimension-value-list:

monasca dimension-value-list
----------------------------

.. code-block:: console

   usage: monasca dimension-value-list [--metric-name <METRIC_NAME>]
                                       [--offset <OFFSET LOCATION>]
                                       [--limit <RETURN LIMIT>]
                                       [--tenant-id <TENANT_ID>]
                                       <DIMENSION_NAME>

List names of metric dimensions.

**Positional arguments:**

``<DIMENSION_NAME>``
  Name of the dimension to list dimension values.

**Optional arguments:**

``--metric-name <METRIC_NAME>``
  Name of the metric to report dimension value list.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_measurement-list:

monasca measurement-list
------------------------

.. code-block:: console

   usage: monasca measurement-list [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                   [--endtime <UTC_END_TIME>]
                                   [--offset <OFFSET LOCATION>]
                                   [--limit <RETURN LIMIT>] [--merge_metrics]
                                   [--group_by <KEY1,KEY2,...>]
                                   [--tenant-id <TENANT_ID>]
                                   <METRIC_NAME> <UTC_START_TIME>

List measurements for the specified metric.

**Positional arguments:**

``<METRIC_NAME>``
  Name of the metric to list measurements.

``<UTC_START_TIME>``
  measurements >= UTC time. format:
  2014-01-01T00:00:00Z. OR Format: -120 (previous 120
  minutes).

**Optional arguments:**

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--endtime <UTC_END_TIME>``
  measurements <= UTC time. format:
  2014-01-01T00:00:00Z.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--merge_metrics``
  Merge multiple metrics into a single result.

``--group_by <KEY1,KEY2,...>``
  Select which keys to use for grouping. A '\*' groups by
  all keys.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_metric-create:

monasca metric-create
---------------------

.. code-block:: console

   usage: monasca metric-create [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                [--value-meta <KEY1=VALUE1,KEY2=VALUE2...>]
                                [--time <UNIX_TIMESTAMP>]
                                [--project-id <CROSS_PROJECT_ID>]
                                <METRIC_NAME> <METRIC_VALUE>

Create metric.

**Positional arguments:**

``<METRIC_NAME>``
  Name of the metric to create.

``<METRIC_VALUE>``
  Metric value.

**Optional arguments:**

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to create a metric dimension. This
  can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--value-meta <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair for extra information about a value.
  This can be specified multiple times, or once with
  parameters separated by a comma. value_meta need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--time <UNIX_TIMESTAMP>``
  Metric timestamp in milliseconds. Default: current
  timestamp.

``--project-id <CROSS_PROJECT_ID>``
  The Project ID to create metric on behalf of. Requires
  monitoring-delegate role in keystone.

.. _monasca_metric-create-raw:

monasca metric-create-raw
-------------------------

.. code-block:: console

   usage: monasca metric-create-raw <JSON_BODY>

Create metric from raw json body.

**Positional arguments:**

``<JSON_BODY>``
  The raw JSON body in single quotes. See api doc.

.. _monasca_metric-list:

monasca metric-list
-------------------

.. code-block:: console

   usage: monasca metric-list [--name <METRIC_NAME>]
                              [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                              [--starttime <UTC_START_TIME>]
                              [--endtime <UTC_END_TIME>]
                              [--offset <OFFSET LOCATION>]
                              [--limit <RETURN LIMIT>] [--tenant-id <TENANT_ID>]

List metrics for this tenant.

**Optional arguments:**

``--name <METRIC_NAME>``
  Name of the metric to list.

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--starttime <UTC_START_TIME>``
  measurements >= UTC time. format:
  2014-01-01T00:00:00Z. OR Format: -120 (previous 120
  minutes).

``--endtime <UTC_END_TIME>``
  measurements <= UTC time. format:
  2014-01-01T00:00:00Z.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_metric-name-list:

monasca metric-name-list
------------------------

.. code-block:: console

   usage: monasca metric-name-list [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                   [--offset <OFFSET LOCATION>]
                                   [--limit <RETURN LIMIT>]
                                   [--tenant-id <TENANT_ID>]

List names of metrics.

**Optional arguments:**

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_metric-statistics:

monasca metric-statistics
-------------------------

.. code-block:: console

   usage: monasca metric-statistics [--dimensions <KEY1=VALUE1,KEY2=VALUE2...>]
                                    [--endtime <UTC_END_TIME>]
                                    [--period <PERIOD>]
                                    [--offset <OFFSET LOCATION>]
                                    [--limit <RETURN LIMIT>] [--merge_metrics]
                                    [--group_by <KEY1,KEY2,...>]
                                    [--tenant-id <TENANT_ID>]
                                    <METRIC_NAME> <STATISTICS> <UTC_START_TIME>

List measurement statistics for the specified metric.

**Positional arguments:**

``<METRIC_NAME>``
  Name of the metric to report measurement statistics.

``<STATISTICS>``
  Statistics is one or more (separated by commas) of
  [AVG, MIN, MAX, COUNT, SUM].

``<UTC_START_TIME>``
  measurements >= UTC time. format:
  2014-01-01T00:00:00Z. OR Format: -120 (previous 120
  minutes).

**Optional arguments:**

``--dimensions <KEY1=VALUE1,KEY2=VALUE2...>``
  key value pair used to specify a metric dimension.
  This can be specified multiple times, or once with
  parameters separated by a comma. Dimensions need
  quoting when they contain special chars
  [&,(,),{,},>,<] that confuse the CLI parser.

``--endtime <UTC_END_TIME>``
  measurements <= UTC time. format:
  2014-01-01T00:00:00Z.

``--period <PERIOD>``
  number of seconds per interval (default is 300)

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

``--merge_metrics``
  Merge multiple metrics into a single result.

``--group_by <KEY1,KEY2,...>``
  Select which keys to use for grouping. A '\*' groups by
  all keys.

``--tenant-id <TENANT_ID>``
  Retrieve data for the specified tenant/project id
  instead of the tenant/project from the user's Keystone
  credentials.

.. _monasca_notification-create:

monasca notification-create
---------------------------

.. code-block:: console

   usage: monasca notification-create [--period <PERIOD>]
                                      <NOTIFICATION_NAME> <TYPE> <ADDRESS>

Create notification.

**Positional arguments:**

``<NOTIFICATION_NAME>``
  Name of the notification to create.

``<TYPE>``
  The notification type. Type must be EMAIL, WEBHOOK, or
  PAGERDUTY.

``<ADDRESS>``
  A valid EMAIL Address, URL, or SERVICE KEY.

**Optional arguments:**

``--period <PERIOD>``
  A period for the notification method. Can only be non
  zero with webhooks

.. _monasca_notification-delete:

monasca notification-delete
---------------------------

.. code-block:: console

   usage: monasca notification-delete <NOTIFICATION_ID>

Delete notification.

**Positional arguments:**

``<NOTIFICATION_ID>``
  The ID of the notification.

.. _monasca_notification-list:

monasca notification-list
-------------------------

.. code-block:: console

   usage: monasca notification-list [--sort-by <SORT BY FIELDS>]
                                    [--offset <OFFSET LOCATION>]
                                    [--limit <RETURN LIMIT>]

List notifications for this tenant.

**Optional arguments:**

``--sort-by <SORT BY FIELDS>``
  Fields to sort by as a comma separated list. Valid
  values are id, name, type, address, created_at,
  updated_at. Fields may be followed by "asc" or "desc",
  ex "address desc", to set the direction of sorting.

``--offset <OFFSET LOCATION>``
  The offset used to paginate the return data.

``--limit <RETURN LIMIT>``
  The amount of data to be returned up to the API
  maximum limit.

.. _monasca_notification-patch:

monasca notification-patch
--------------------------

.. code-block:: console

   usage: monasca notification-patch [--name <NOTIFICATION_NAME>] [--type <TYPE>]
                                     [--address <ADDRESS>] [--period <PERIOD>]
                                     <NOTIFICATION_ID>

Patch notification.

**Positional arguments:**

``<NOTIFICATION_ID>``
  The ID of the notification.

**Optional arguments:**

``--name <NOTIFICATION_NAME>``
  Name of the notification.

``--type <TYPE>``
  The notification type. Type must be either EMAIL,
  WEBHOOK, or PAGERDUTY.

``--address <ADDRESS>``
  A valid EMAIL Address, URL, or SERVICE KEY.

``--period <PERIOD>``
  A period for the notification method. Can only be non
  zero with webhooks

.. _monasca_notification-show:

monasca notification-show
-------------------------

.. code-block:: console

   usage: monasca notification-show <NOTIFICATION_ID>

Describe the notification.

**Positional arguments:**

``<NOTIFICATION_ID>``
  The ID of the notification.

.. _monasca_notification-type-list:

monasca notification-type-list
------------------------------

.. code-block:: console

   usage: monasca notification-type-list

List notification types supported by monasca.

.. _monasca_notification-update:

monasca notification-update
---------------------------

.. code-block:: console

   usage: monasca notification-update <NOTIFICATION_ID> <NOTIFICATION_NAME>
                                      <TYPE> <ADDRESS> <PERIOD>

Update notification.

**Positional arguments:**

``<NOTIFICATION_ID>``
  The ID of the notification.

``<NOTIFICATION_NAME>``
  Name of the notification.

``<TYPE>``
  The notification type. Type must be either EMAIL,
  WEBHOOK, or PAGERDUTY.

``<ADDRESS>``
  A valid EMAIL Address, URL, or SERVICE KEY.

``<PERIOD>``
  A period for the notification method. Can only be non
  zero with webhooks

