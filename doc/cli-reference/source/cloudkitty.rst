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

===============================================
Rating service (cloudkitty) command-line client
===============================================

The cloudkitty client is the command-line interface (CLI) for
the Rating service (cloudkitty) API and its extensions.

This chapter documents :command:`cloudkitty` version ``1.1.0``.

For help on a specific :command:`cloudkitty` command, enter:

.. code-block:: console

   $ cloudkitty help COMMAND

.. _cloudkitty_command_usage:

cloudkitty usage
~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: cloudkitty [--version] [-d] [-v] [--timeout TIMEOUT]
                     [--cloudkitty-url <CLOUDKITTY_URL>]
                     [--cloudkitty-api-version CLOUDKITTY_API_VERSION]
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

``info-config-get``
  Get cloudkitty configuration.

``info-service-get``
  Get service info.

``module-disable``
  Disable a module.

``module-enable``
  Enable a module.

``module-list``
  List the samples for this meters.

``module-set-priority``
  Set module priority.

``collector-mapping-create``
  Create collector mapping.

``collector-mapping-delete``
  Delete collector mapping.

``collector-mapping-get``
  Show collector mapping detail.

``collector-mapping-list``
  List collector mapping.

``collector-state-disable``
  Disable collector state.

``collector-state-enable``
  Enable collector state.

``collector-state-get``
  Show collector state.

``report-tenant-list``
  List tenant report.

``summary-get``
  Get summary report.

``total-get``
  Get total reports.

``storage-dataframe-list``
  List dataframes.

``hashmap-field-create``
  Create a field.

``hashmap-field-delete``
  Delete a field.

``hashmap-field-list``
  List fields.

``hashmap-group-create``
  Create a group.

``hashmap-group-delete``
  Delete a group.

``hashmap-group-list``
  List groups.

``hashmap-mapping-create``
  Create a mapping.

``hashmap-mapping-delete``
  Delete a mapping.

``hashmap-mapping-list``
  List mappings.

``hashmap-mapping-update``
  Update a mapping.

``hashmap-service-create``
  Create a service.

``hashmap-service-delete``
  Delete a service.

``hashmap-service-list``
  List services.

``hashmap-threshold-create``
  Create a mapping.

``hashmap-threshold-delete``
  Delete a threshold.

``hashmap-threshold-get``
  Get a threshold.

``hashmap-threshold-group``
  Get a threshold group.

``hashmap-threshold-list``
  List thresholds.

``hashmap-threshold-update``
  Update a threshold.

``pyscripts-script-create``
  Create a script.

``pyscripts-script-delete``
  Delete a script.

``pyscripts-script-get``
  Get script.

``pyscripts-script-get-data``
  Get script data.

``pyscripts-script-list``
  List scripts.

``pyscripts-script-update``
  Update a mapping.

``bash-completion``
  Prints all of the commands and options to
  stdout.

``help``
  Display help about this program or one of its
  subcommands.

.. _cloudkitty_command_options:

cloudkitty optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-d, --debug``
  Defaults to ``env[CLOUDKITTYCLIENT_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``--timeout TIMEOUT``
  Number of seconds to wait for a response.

``--cloudkitty-url <CLOUDKITTY_URL>``
  **DEPRECATED**, use --os-endpoint instead.
  Defaults to ``env[CLOUDKITTY_URL]``.

``--cloudkitty-api-version CLOUDKITTY_API_VERSION``
  Defaults to ``env[CLOUDKITTY_API_VERSION]`` or 1.

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

.. _cloudkitty_collector-mapping-create:

cloudkitty collector-mapping-create
-----------------------------------

.. code-block:: console

   usage: cloudkitty collector-mapping-create -c COLLECTOR -s SERVICE

Create collector mapping.

**Optional arguments:**

``-c COLLECTOR, --collector COLLECTOR``
  Map a service to this collector. required.

``-s SERVICE, --service SERVICE``
  Map a collector to this service. required.

.. _cloudkitty_collector-mapping-delete:

cloudkitty collector-mapping-delete
-----------------------------------

.. code-block:: console

   usage: cloudkitty collector-mapping-delete -s SERVICE

Delete collector mapping.

**Optional arguments:**

``-s SERVICE, --service SERVICE``
  Filter on this service. required.

.. _cloudkitty_collector-mapping-get:

cloudkitty collector-mapping-get
--------------------------------

.. code-block:: console

   usage: cloudkitty collector-mapping-get -s SERVICE

Show collector mapping detail.

**Optional arguments:**

``-s SERVICE, --service SERVICE``
  Which service to get the mapping for.
  required.

.. _cloudkitty_collector-mapping-list:

cloudkitty collector-mapping-list
---------------------------------

.. code-block:: console

   usage: cloudkitty collector-mapping-list [-c COLLECTOR]

List collector mapping.

**Optional arguments:**

``-c COLLECTOR, --collector COLLECTOR``
  Collector name to filter on. Defaults to None.

.. _cloudkitty_collector-state-disable:

cloudkitty collector-state-disable
----------------------------------

.. code-block:: console

   usage: cloudkitty collector-state-disable -n NAME

Disable collector state.

**Optional arguments:**

``-n NAME, --name NAME``
  Name of the collector. required.

.. _cloudkitty_collector-state-enable:

cloudkitty collector-state-enable
---------------------------------

.. code-block:: console

   usage: cloudkitty collector-state-enable -n NAME

Enable collector state.

**Optional arguments:**

``-n NAME, --name NAME``
  Name of the collector. required.

.. _cloudkitty_collector-state-get:

cloudkitty collector-state-get
------------------------------

.. code-block:: console

   usage: cloudkitty collector-state-get -n NAME

Show collector state.

**Optional arguments:**

``-n NAME, --name NAME``
  Name of the collector. required.

.. _cloudkitty_hashmap-field-create:

cloudkitty hashmap-field-create
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-field-create -n NAME -s SERVICE_ID

Create a field.

**Optional arguments:**

``-n NAME, --name NAME``
  Field name required.

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id required.

.. _cloudkitty_hashmap-field-delete:

cloudkitty hashmap-field-delete
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-field-delete -f FIELD_ID

Delete a field.

**Optional arguments:**

``-f FIELD_ID, --field-id FIELD_ID``
  Field uuid required.

.. _cloudkitty_hashmap-field-list:

cloudkitty hashmap-field-list
-----------------------------

.. code-block:: console

   usage: cloudkitty hashmap-field-list -s SERVICE_ID

List fields.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id required.

.. _cloudkitty_hashmap-group-create:

cloudkitty hashmap-group-create
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-group-create -n NAME

Create a group.

**Optional arguments:**

``-n NAME, --name NAME``
  Group name required.

.. _cloudkitty_hashmap-group-delete:

cloudkitty hashmap-group-delete
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-group-delete -g GROUP_ID [-r RECURSIVE]

Delete a group.

**Optional arguments:**

``-g GROUP_ID, --group-id GROUP_ID``
  Group uuid required.

``-r RECURSIVE, --recursive RECURSIVE``
  Delete the group's mappings Defaults to False.

.. _cloudkitty_hashmap-group-list:

cloudkitty hashmap-group-list
-----------------------------

.. code-block:: console

   usage: cloudkitty hashmap-group-list

List groups.

.. _cloudkitty_hashmap-mapping-create:

cloudkitty hashmap-mapping-create
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-mapping-create [-s SERVICE_ID] [-f FIELD_ID] -c COST
                                            [-v VALUE] [-t TYPE] [-g GROUP_ID]
                                            [-p PROJECT_ID]

Create a mapping.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id.

``-f FIELD_ID, --field-id FIELD_ID``
  Field id.

``-c COST, --cost COST``
  Mapping cost required.

``-v VALUE, --value VALUE``
  Mapping value.

``-t TYPE, --type TYPE``
  Mapping type (flat, rate).

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_hashmap-mapping-delete:

cloudkitty hashmap-mapping-delete
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-mapping-delete -m MAPPING_ID

Delete a mapping.

**Optional arguments:**

``-m MAPPING_ID, --mapping-id MAPPING_ID``
  Mapping uuid required.

.. _cloudkitty_hashmap-mapping-list:

cloudkitty hashmap-mapping-list
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-mapping-list [-s SERVICE_ID] [-f FIELD_ID]
                                          [-g GROUP_ID] [-p PROJECT_ID]

List mappings.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id.

``-f FIELD_ID, --field-id FIELD_ID``
  Field id.

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_hashmap-mapping-update:

cloudkitty hashmap-mapping-update
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-mapping-update -m MAPPING_ID [-c COST] [-v VALUE]
                                            [-t TYPE] [-g GROUP_ID]
                                            [-p PROJECT_ID]

Update a mapping.

**Optional arguments:**

``-m MAPPING_ID, --mapping-id MAPPING_ID``
  Mapping id required.

``-c COST, --cost COST``
  Mapping cost.

``-v VALUE, --value VALUE``
  Mapping value.

``-t TYPE, --type TYPE``
  Mapping type (flat, rate).

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_hashmap-service-create:

cloudkitty hashmap-service-create
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-service-create -n NAME

Create a service.

**Optional arguments:**

``-n NAME, --name NAME``
  Service name required.

.. _cloudkitty_hashmap-service-delete:

cloudkitty hashmap-service-delete
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-service-delete -s SERVICE_ID

Delete a service.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service uuid required.

.. _cloudkitty_hashmap-service-list:

cloudkitty hashmap-service-list
-------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-service-list

List services.

.. _cloudkitty_hashmap-threshold-create:

cloudkitty hashmap-threshold-create
-----------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-create [-s SERVICE_ID] [-f FIELD_ID] -l
                                              LEVEL -c COST [-t TYPE]
                                              [-g GROUP_ID] [-p PROJECT_ID]

Create a mapping.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id.

``-f FIELD_ID, --field-id FIELD_ID``
  Field id.

``-l LEVEL, --level LEVEL``
  Threshold level required.

``-c COST, --cost COST``
  Threshold cost required.

``-t TYPE, --type TYPE``
  Threshold type (flat, rate).

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_hashmap-threshold-delete:

cloudkitty hashmap-threshold-delete
-----------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-delete -i THRESHOLD_ID

Delete a threshold.

**Optional arguments:**

``-i THRESHOLD_ID, --threshold-id THRESHOLD_ID``
  Threshold uuid required.

.. _cloudkitty_hashmap-threshold-get:

cloudkitty hashmap-threshold-get
--------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-get -i THRESHOLD_ID

Get a threshold.

**Optional arguments:**

``-i THRESHOLD_ID, --threshold-id THRESHOLD_ID``
  Threshold uuid required.

.. _cloudkitty_hashmap-threshold-group:

cloudkitty hashmap-threshold-group
----------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-group -i THRESHOLD_ID

Get a threshold group.

**Optional arguments:**

``-i THRESHOLD_ID, --threshold-id THRESHOLD_ID``
  Threshold uuid required.

.. _cloudkitty_hashmap-threshold-list:

cloudkitty hashmap-threshold-list
---------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-list [-s SERVICE_ID] [-f FIELD_ID]
                                            [-g GROUP_ID]
                                            [--no-group {True,False}]
                                            [-p PROJECT_ID]

List thresholds.

**Optional arguments:**

``-s SERVICE_ID, --service-id SERVICE_ID``
  Service id.

``-f FIELD_ID, --field-id FIELD_ID``
  Field id.

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``--no-group {True,False}``
  If True, list only orhpaned thresholds.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_hashmap-threshold-update:

cloudkitty hashmap-threshold-update
-----------------------------------

.. code-block:: console

   usage: cloudkitty hashmap-threshold-update -i THRESHOLD_ID [-l LEVEL]
                                              [-c COST] [-t TYPE] [-g GROUP_ID]
                                              [-p PROJECT_ID]

Update a threshold.

**Optional arguments:**

``-i THRESHOLD_ID, --threshold-id THRESHOLD_ID``
  Threshold id required.

``-l LEVEL, --level LEVEL``
  Threshold level.

``-c COST, --cost COST``
  Threshold cost.

``-t TYPE, --type TYPE``
  Threshold type (flat, rate).

``-g GROUP_ID, --group-id GROUP_ID``
  Group id.

``-p PROJECT_ID, --project-id PROJECT_ID``
  Project/tenant id.

.. _cloudkitty_info-config-get:

cloudkitty info-config-get
--------------------------

.. code-block:: console

   usage: cloudkitty info-config-get

Get cloudkitty configuration.

.. _cloudkitty_info-service-get:

cloudkitty info-service-get
---------------------------

.. code-block:: console

   usage: cloudkitty info-service-get [-n NAME]

Get service info.

**Optional arguments:**

``-n NAME, --name NAME``
  Service name.

.. _cloudkitty_module-disable:

cloudkitty module-disable
-------------------------

.. code-block:: console

   usage: cloudkitty module-disable -n NAME

Disable a module.

**Optional arguments:**

``-n NAME, --name NAME``
  Module name required.

.. _cloudkitty_module-enable:

cloudkitty module-enable
------------------------

.. code-block:: console

   usage: cloudkitty module-enable -n NAME

Enable a module.

**Optional arguments:**

``-n NAME, --name NAME``
  Module name required.

.. _cloudkitty_module-list:

cloudkitty module-list
----------------------

.. code-block:: console

   usage: cloudkitty module-list

List the samples for this meters.

.. _cloudkitty_module-set-priority:

cloudkitty module-set-priority
------------------------------

.. code-block:: console

   usage: cloudkitty module-set-priority -n NAME -p PRIORITY

Set module priority.

**Optional arguments:**

``-n NAME, --name NAME``
  Module name required.

``-p PRIORITY, --priority PRIORITY``
  Module priority required.

.. _cloudkitty_pyscripts-script-create:

cloudkitty pyscripts-script-create
----------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-create -n NAME [-f FILE]

Create a script.

**Optional arguments:**

``-n NAME, --name NAME``
  Script name required.

``-f FILE, --file FILE``
  Script file.

.. _cloudkitty_pyscripts-script-delete:

cloudkitty pyscripts-script-delete
----------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-delete -s SCRIPT_ID

Delete a script.

**Optional arguments:**

``-s SCRIPT_ID, --script-id SCRIPT_ID``
  Script uuid required.

.. _cloudkitty_pyscripts-script-get:

cloudkitty pyscripts-script-get
-------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-get -s SCRIPT_ID

Get script.

**Optional arguments:**

``-s SCRIPT_ID, --script-id SCRIPT_ID``
  Script uuid required.

.. _cloudkitty_pyscripts-script-get-data:

cloudkitty pyscripts-script-get-data
------------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-get-data -s SCRIPT_ID

Get script data.

**Optional arguments:**

``-s SCRIPT_ID, --script-id SCRIPT_ID``
  Script uuid required.

.. _cloudkitty_pyscripts-script-list:

cloudkitty pyscripts-script-list
--------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-list [-d SHOW_DATA]

List scripts.

**Optional arguments:**

``-d SHOW_DATA, --show-data SHOW_DATA``
  Show data in the listing Defaults to False.

.. _cloudkitty_pyscripts-script-update:

cloudkitty pyscripts-script-update
----------------------------------

.. code-block:: console

   usage: cloudkitty pyscripts-script-update -s SCRIPT_ID -f FILE

Update a mapping.

**Optional arguments:**

``-s SCRIPT_ID, --script-id SCRIPT_ID``
  Script uuid required.

``-f FILE, --file FILE``
  Script file required.

.. _cloudkitty_report-tenant-list:

cloudkitty report-tenant-list
-----------------------------

.. code-block:: console

   usage: cloudkitty report-tenant-list

List tenant report.

.. _cloudkitty_storage-dataframe-list:

cloudkitty storage-dataframe-list
---------------------------------

.. code-block:: console

   usage: cloudkitty storage-dataframe-list [-b BEGIN] [-e END] [-t TENANT]
                                            [-r RESOURCE_TYPE]

List dataframes.

**Optional arguments:**

``-b BEGIN, --begin BEGIN``
  Starting date/time (YYYY-MM-DDTHH:MM:SS).

``-e END, --end END``
  Ending date/time (YYYY-MM-DDTHH:MM:SS).

``-t TENANT, --tenant TENANT``
  Tenant ID Defaults to None.

``-r RESOURCE_TYPE, --resource-type RESOURCE_TYPE``
  Resource type (compute, image, ...) Defaults
  to None.

.. _cloudkitty_summary-get:

cloudkitty summary-get
----------------------

.. code-block:: console

   usage: cloudkitty summary-get [-t SUMMARY_TENANT_ID] [-b BEGIN] [-e END]
                                 [-s SERVICE] [-g GROUPBY] [-a]

Get summary report.

**Optional arguments:**

``-t SUMMARY_TENANT_ID, --tenant-id SUMMARY_TENANT_ID``
  Tenant id.

``-b BEGIN, --begin BEGIN``
  Begin timestamp.

``-e END, --end END``
  End timestamp.

``-s SERVICE, --service SERVICE``
  Service Type.

``-g GROUPBY, --groupby GROUPBY``
  Fields to groupby, separated by commas if
  multiple, now support res_type,tenant_id.

``-a, --all-tenants``
  Allows to get summary from all tenants (admin
  only). Defaults to False.

.. _cloudkitty_total-get:

cloudkitty total-get
--------------------

.. code-block:: console

   usage: cloudkitty total-get [-t TOTAL_TENANT_ID] [-b BEGIN] [-e END]
                               [-s SERVICE] [-a]

Get total reports.

**Optional arguments:**

``-t TOTAL_TENANT_ID, --tenant-id TOTAL_TENANT_ID``
  Tenant id.

``-b BEGIN, --begin BEGIN``
  Starting date/time (YYYY-MM-DDTHH:MM:SS).

``-e END, --end END``
  Ending date/time (YYYY-MM-DDTHH:MM:SS).

``-s SERVICE, --service SERVICE``
  Service Type.

``-a, --all-tenants``
  Allows to get total from all tenants (admin
  only). Defaults to False.

