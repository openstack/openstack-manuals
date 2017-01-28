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

================================================
Orchestration service (heat) command-line client
================================================

.. warning::

   The heat CLI is deprecated
   in favor of python-openstackclient.

The heat client is the command-line interface (CLI) for
the Orchestration service (heat) API and its extensions.

This chapter documents :command:`heat` version ``1.8.0``.

For help on a specific :command:`heat` command, enter:

.. code-block:: console

   $ heat help COMMAND

.. _heat_command_usage:

heat usage
~~~~~~~~~~

.. code-block:: console

   usage: heat [--version] [-d] [-v] [--api-timeout API_TIMEOUT]
               [--os-no-client-auth] [--heat-url HEAT_URL]
               [--heat-api-version HEAT_API_VERSION] [--include-password] [-k]
               [--os-cert OS_CERT] [--cert-file OS_CERT] [--os-key OS_KEY]
               [--key-file OS_KEY] [--os-cacert <ca-certificate-file>]
               [--ca-file OS_CACERT] [--os-username OS_USERNAME]
               [--os-user-id OS_USER_ID] [--os-user-domain-id OS_USER_DOMAIN_ID]
               [--os-user-domain-name OS_USER_DOMAIN_NAME]
               [--os-project-id OS_PROJECT_ID]
               [--os-project-name OS_PROJECT_NAME]
               [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
               [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
               [--os-password OS_PASSWORD] [--os-tenant-id OS_TENANT_ID]
               [--os-tenant-name OS_TENANT_NAME] [--os-auth-url OS_AUTH_URL]
               [--os-region-name OS_REGION_NAME] [--os-auth-token OS_AUTH_TOKEN]
               [--os-service-type OS_SERVICE_TYPE]
               [--os-endpoint-type OS_ENDPOINT_TYPE] [--profile HMAC_KEY]
               <subcommand> ...

**Subcommands:**

``action-check``
  Check that stack resources are in expected states.

``action-resume``
  Resume the stack.

``action-suspend``
  Suspend the stack.

``build-info``
  Retrieve build information.

``config-create``
  Create a software configuration.

``config-delete``
  Delete the software configuration(s).

``config-list``
  List software configs.

``config-show``
  View details of a software configuration.

``deployment-create``
  Create a software deployment.

``deployment-delete``
  Delete the software deployment(s).

``deployment-list``
  List software deployments.

``deployment-metadata-show``
  Get deployment configuration metadata for the
  specified server.

``deployment-output-show``
  Show a specific deployment output.

``deployment-show``
  Show the details of a software deployment.

``event``
  **DEPRECATED!**

``event-list``
  List events for a stack.

``event-show``
  Describe the event.

``hook-clear``
  Clear hooks on a given stack.

``hook-poll``
  List resources with pending hook for a stack.

``output-list``
  Show available outputs.

``output-show``
  Show a specific stack output.

``resource-list``
  Show list of resources belonging to a stack.

``resource-mark-unhealthy``
  Set resource's health.

``resource-metadata``
  List resource metadata.

``resource-show``
  Describe the resource.

``resource-signal``
  Send a signal to a resource.

``resource-template``
  **DEPRECATED!**

``resource-type-list``
  List the available resource types.

``resource-type-show``
  Show the resource type.

``resource-type-template``
  Generate a template based on a resource type.

``service-list``
  List the Heat engines.

``snapshot-delete``
  Delete a snapshot of a stack.

``snapshot-list``
  List the snapshots of a stack.

``snapshot-show``
  Show a snapshot of a stack.

``stack-abandon``
  Abandon the stack.

``stack-adopt``
  Adopt a stack.

``stack-cancel-update``
  Cancel currently running update of the stack.

``stack-create``
  Create the stack.

``stack-delete``
  Delete the stack(s).

``stack-list``
  List the user's stacks.

``stack-preview``
  Preview the stack.

``stack-restore``
  Restore a snapshot of a stack.

``stack-show``
  Describe the stack.

``stack-snapshot``
  Make a snapshot of a stack.

``stack-update``
  Update the stack.

``template-function-list``
  List the available functions.

``template-show``
  Get the template for the specified stack.

``template-validate``
  Validate a template with parameters.

``template-version-list``
  List the available template versions.

``bash-completion``
  Prints all of the commands and options to stdout.

``help``
  Display help about this program or one of its
  subcommands.

.. _heat_command_options:

heat optional arguments
~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Shows the client version and exits.

``-d, --debug``
  Defaults to ``env[HEATCLIENT_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``--api-timeout API_TIMEOUT``
  Number of seconds to wait for an API response,
  defaults to system socket timeout

``--os-no-client-auth``
  Do not contact keystone for a token. Defaults to
  ``env[OS_NO_CLIENT_AUTH]``.

``--heat-url HEAT_URL``
  Defaults to ``env[HEAT_URL]``.

``--heat-api-version HEAT_API_VERSION``
  Defaults to ``env[HEAT_API_VERSION]`` or 1.

``--include-password``
  Send os-username and os-password to heat.

``-k, --insecure``
  Explicitly allow heatclient to perform "insecure SSL"
  (https) requests. The server's certificate will not be
  verified against any certificate authorities. This
  option should be used with caution.

``--os-cert OS_CERT``
  Path of certificate file to use in SSL connection.
  This file can optionally be prepended with the private
  key.

``--cert-file OS_CERT``
  **DEPRECATED!** Use --os-cert.

``--os-key OS_KEY``
  Path of client key to use in SSL connection. This
  option is not necessary if your key is prepended to
  your cert file.

``--key-file OS_KEY``
  **DEPRECATED!** Use --os-key.

``--os-cacert <ca-certificate-file>``
  Path of CA TLS certificate(s) used to verify the
  remote server's certificate. Without this option
  glance looks for the default system CA certificates.

``--ca-file OS_CACERT``
  **DEPRECATED!** Use --os-cacert.

``--os-username OS_USERNAME``
  Defaults to ``env[OS_USERNAME]``.

``--os-user-id OS_USER_ID``
  Defaults to ``env[OS_USER_ID]``.

``--os-user-domain-id OS_USER_DOMAIN_ID``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name OS_USER_DOMAIN_NAME``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-id OS_PROJECT_ID``
  Another way to specify tenant ID. This option is
  mutually exclusive with --os-tenant-id. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-project-name OS_PROJECT_NAME``
  Another way to specify tenant name. This option is
  mutually exclusive with --os-tenant-name. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-project-domain-id OS_PROJECT_DOMAIN_ID``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name OS_PROJECT_DOMAIN_NAME``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-password OS_PASSWORD``
  Defaults to ``env[OS_PASSWORD]``.

``--os-tenant-id OS_TENANT_ID``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-tenant-name OS_TENANT_NAME``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-auth-url OS_AUTH_URL``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-region-name OS_REGION_NAME``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-auth-token OS_AUTH_TOKEN``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--os-service-type OS_SERVICE_TYPE``
  Defaults to ``env[OS_SERVICE_TYPE]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]``.

``--profile HMAC_KEY``
  HMAC key to use for encrypting context data for
  performance profiling of operation. This key should be
  the value of HMAC key configured in osprofiler
  middleware in heat, it is specified in the paste
  configuration (/etc/heat/api-paste.ini). Without the
  key, profiling will not be triggered even if
  osprofiler is enabled on server side.

.. _heat_action-check:

heat action-check
-----------------

.. code-block:: console

   usage: heat action-check <NAME or ID>

Check that stack resources are in expected states.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to check.

.. _heat_action-resume:

heat action-resume
------------------

.. code-block:: console

   usage: heat action-resume <NAME or ID>

Resume the stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to resume.

.. _heat_action-suspend:

heat action-suspend
-------------------

.. code-block:: console

   usage: heat action-suspend <NAME or ID>

Suspend the stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to suspend.

.. _heat_build-info:

heat build-info
---------------

.. code-block:: console

   usage: heat build-info

Retrieve build information.

.. _heat_config-create:

heat config-create
------------------

.. code-block:: console

   usage: heat config-create [-f <FILE or URL>] [-c <FILE or URL>]
                             [-g <GROUP_NAME>]
                             <CONFIG_NAME>

Create a software configuration.

**Positional arguments:**

``<CONFIG_NAME>``
  Name of the configuration to create.

**Optional arguments:**

``-f <FILE or URL>, --definition-file <FILE or URL>``
  Path to JSON/YAML containing map defining <inputs>,
  <outputs>, and <options>.

``-c <FILE or URL>, --config-file <FILE or URL>``
  Path to configuration script/data.

``-g <GROUP_NAME>, --group <GROUP_NAME>``
  Group name of configuration tool expected by the
  config.

.. _heat_config-delete:

heat config-delete
------------------

.. code-block:: console

   usage: heat config-delete <ID> [<ID> ...]

Delete the software configuration(s).

**Positional arguments:**

``<ID>``
  ID of the configuration(s) to delete.

.. _heat_config-list:

heat config-list
----------------

.. code-block:: console

   usage: heat config-list [-l <LIMIT>] [-m <ID>]

List software configs.

**Optional arguments:**

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of configs returned.

``-m <ID>, --marker <ID>``
  Return configs that appear after the given config ID.

.. _heat_config-show:

heat config-show
----------------

.. code-block:: console

   usage: heat config-show [-c] <ID>

View details of a software configuration.

**Positional arguments:**

``<ID>``
  ID of the config.

**Optional arguments:**

``-c, --config-only``
  Only display the value of the <config> property.

.. _heat_deployment-create:

heat deployment-create
----------------------

.. code-block:: console

   usage: heat deployment-create [-i <KEY=VALUE>] [-a <ACTION>] [-c <CONFIG>] -s
                                 <SERVER> [-t <TRANSPORT>]
                                 [--container <CONTAINER_NAME>]
                                 [--timeout <TIMEOUT>]
                                 <DEPLOY_NAME>

Create a software deployment.

**Positional arguments:**

``<DEPLOY_NAME>``
  Name of the derived config associated with this
  deployment. This is used to apply a sort order to the
  list of configurations currently deployed to the
  server.

**Optional arguments:**

``-i <KEY=VALUE>, --input-value <KEY=VALUE>``
  Input value to set on the deployment. This can be
  specified multiple times.

``-a <ACTION>, --action <ACTION>``
  Name of action for this deployment. Can be a custom
  action, or one of: CREATE, UPDATE, DELETE, SUSPEND,
  RESUME

``-c <CONFIG>, --config <CONFIG>``
  ID of the configuration to deploy.

``-s <SERVER>, --server <SERVER>``
  ID of the server being deployed to.

``-t <TRANSPORT>, --signal-transport <TRANSPORT>``
  How the server should signal to heat with the
  deployment output values. TEMP_URL_SIGNAL will create
  a Swift TempURL to be signaled via HTTP PUT. NO_SIGNAL
  will result in the resource going to the COMPLETE
  state without waiting for any signal.

``--container <CONTAINER_NAME>``
  Optional name of container to store TEMP_URL_SIGNAL
  objects in. If not specified a container will be
  created with a name derived from the DEPLOY_NAME

``--timeout <TIMEOUT>``
  Deployment timeout in minutes.

.. _heat_deployment-delete:

heat deployment-delete
----------------------

.. code-block:: console

   usage: heat deployment-delete <ID> [<ID> ...]

Delete the software deployment(s).

**Positional arguments:**

``<ID>``
  ID of the deployment(s) to delete.

.. _heat_deployment-list:

heat deployment-list
--------------------

.. code-block:: console

   usage: heat deployment-list [-s <SERVER>]

List software deployments.

**Optional arguments:**

``-s <SERVER>, --server <SERVER>``
  ID of the server to fetch deployments for.

.. _heat_deployment-metadata-show:

heat deployment-metadata-show
-----------------------------

.. code-block:: console

   usage: heat deployment-metadata-show <ID>

Get deployment configuration metadata for the specified server.

**Positional arguments:**

``<ID>``
  ID of the server to fetch deployments for.

.. _heat_deployment-output-show:

heat deployment-output-show
---------------------------

.. code-block:: console

   usage: heat deployment-output-show [-a] [-F <FORMAT>] <ID> [<OUTPUT NAME>]

Show a specific deployment output.

**Positional arguments:**

``<ID>``
  ID deployment to show the output for.

``<OUTPUT NAME>``
  Name of an output to display.

**Optional arguments:**

``-a, --all``
  Display all deployment outputs.

``-F <FORMAT>, --format <FORMAT>``
  The output value format, one of: raw, json

.. _heat_deployment-show:

heat deployment-show
--------------------

.. code-block:: console

   usage: heat deployment-show <ID>

Show the details of a software deployment.

**Positional arguments:**

``<ID>``
  ID of the deployment.

.. _heat_event-list:

heat event-list
---------------

.. code-block:: console

   usage: heat event-list [-r <RESOURCE>] [-f <KEY1=VALUE1;KEY2=VALUE2...>]
                          [-l <LIMIT>] [-m <ID>] [-n <DEPTH>] [-F <FORMAT>]
                          <NAME or ID>

List events for a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the events for.

**Optional arguments:**

``-r <RESOURCE>, --resource <RESOURCE>``
  Name of the resource to filter events by.

``-f <KEY1=VALUE1;KEY2=VALUE2...>, --filters <KEY1=VALUE1;KEY2=VALUE2...>``
  Filter parameters to apply on returned events. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of events returned.

``-m <ID>, --marker <ID>``
  Only return events that appear after the given event
  ID.

``-n <DEPTH>, --nested-depth <DEPTH>``
  Depth of nested stacks from which to display events.
  Note this cannot be specified with --resource.

``-F <FORMAT>, --format <FORMAT>``
  The output value format, one of: log, table

.. _heat_event-show:

heat event-show
---------------

.. code-block:: console

   usage: heat event-show <NAME or ID> <RESOURCE> <EVENT>

Describe the event.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the events for.

``<RESOURCE>``
  Name of the resource the event belongs to.

``<EVENT>``
  ID of event to display details for.

.. _heat_hook-clear:

heat hook-clear
---------------

.. code-block:: console

   usage: heat hook-clear [--pre-create] [--pre-update] [--pre-delete]
                          <NAME or ID> <RESOURCE> [<RESOURCE> ...]

Clear hooks on a given stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of the stack these resources belong to.

``<RESOURCE>``
  Resource names with hooks to clear. Resources in nested stacks
  can be set using slash as a separator:
  nested_stack/another/my_resource. You can use wildcards to
  match multiple stacks or resources:
  nested_stack/an\*/\*_resource

**Optional arguments:**

``--pre-create``
  Clear the pre-create hooks (optional)

``--pre-update``
  Clear the pre-update hooks (optional)

``--pre-delete``
  Clear the pre-delete hooks (optional)

.. _heat_hook-poll:

heat hook-poll
--------------

.. code-block:: console

   usage: heat hook-poll [-n <DEPTH>] <NAME or ID>

List resources with pending hook for a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the pending hooks for.

**Optional arguments:**

``-n <DEPTH>, --nested-depth <DEPTH>``
  Depth of nested stacks from which to display hooks.

.. _heat_output-list:

heat output-list
----------------

.. code-block:: console

   usage: heat output-list <NAME or ID>

Show available outputs.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to query.

.. _heat_output-show:

heat output-show
----------------

.. code-block:: console

   usage: heat output-show [-F <FORMAT>] [-a] [--with-detail]
                           <NAME or ID> [<OUTPUT NAME>]

Show a specific stack output.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to query.

``<OUTPUT NAME>``
  Name of an output to display.

**Optional arguments:**

``-F <FORMAT>, --format <FORMAT>``
  The output value format, one of: json, raw.

``-a, --all``
  Display all stack outputs.

``--with-detail``
  Enable detail information presented, like key and
  description.

.. _heat_resource-list:

heat resource-list
------------------

.. code-block:: console

   usage: heat resource-list [-n <DEPTH>] [--with-detail] [-f <KEY=VALUE>]
                             <NAME or ID>

Show list of resources belonging to a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the resources for.

**Optional arguments:**

``-n <DEPTH>, --nested-depth <DEPTH>``
  Depth of nested stacks from which to display
  resources.

``--with-detail``
  Enable detail information presented for each resource
  in resources list.

``-f <KEY=VALUE>, --filter <KEY=VALUE>``
  Filter parameters to apply on returned resources based
  on their name, status, type, action, id and
  physical_resource_id. This can be specified multiple
  times.

.. _heat_resource-mark-unhealthy:

heat resource-mark-unhealthy
----------------------------

.. code-block:: console

   usage: heat resource-mark-unhealthy [--reset] <NAME or ID> <RESOURCE> [reason]

Set resource's health.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack the resource belongs to.

``<RESOURCE>``
  Name or physical ID of the resource.

``reason``
  Reason for state change.

**Optional arguments:**

``--reset``
  Set the resource as healthy.

.. _heat_resource-metadata:

heat resource-metadata
----------------------

.. code-block:: console

   usage: heat resource-metadata <NAME or ID> <RESOURCE>

List resource metadata.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the resource metadata for.

``<RESOURCE>``
  Name of the resource to show the metadata for.

.. _heat_resource-show:

heat resource-show
------------------

.. code-block:: console

   usage: heat resource-show [-a <ATTRIBUTE>] <NAME or ID> <RESOURCE>

Describe the resource.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to show the resource for.

``<RESOURCE>``
  Name of the resource to show the details for.

**Optional arguments:**

``-a <ATTRIBUTE>, --with-attr <ATTRIBUTE>``
  Attribute to show, it can be specified multiple times.

.. _heat_resource-signal:

heat resource-signal
--------------------

.. code-block:: console

   usage: heat resource-signal [-D <DATA>] [-f <FILE>] <NAME or ID> <RESOURCE>

Send a signal to a resource.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack the resource belongs to.

``<RESOURCE>``
  Name of the resource to signal.

**Optional arguments:**

``-D <DATA>, --data <DATA>``
  JSON Data to send to the signal handler.

``-f <FILE>, --data-file <FILE>``
  File containing JSON data to send to the signal
  handler.

.. _heat_resource-type-list:

heat resource-type-list
-----------------------

.. code-block:: console

   usage: heat resource-type-list [-f <KEY1=VALUE1;KEY2=VALUE2...>]

List the available resource types.

**Optional arguments:**

``-f <KEY1=VALUE1;KEY2=VALUE2...>, --filters <KEY1=VALUE1;KEY2=VALUE2...>``
  Filter parameters to apply on returned resource types.
  This can be specified multiple times, or once with
  parameters separated by a semicolon. It can be any of
  name, version and support_status

.. _heat_resource-type-show:

heat resource-type-show
-----------------------

.. code-block:: console

   usage: heat resource-type-show <RESOURCE_TYPE>

Show the resource type.

**Positional arguments:**

``<RESOURCE_TYPE>``
  Resource type to get the details for.

.. _heat_resource-type-template:

heat resource-type-template
---------------------------

.. code-block:: console

   usage: heat resource-type-template [-t <TEMPLATE_TYPE>] [-F <FORMAT>]
                                      <RESOURCE_TYPE>

Generate a template based on a resource type.

**Positional arguments:**

``<RESOURCE_TYPE>``
  Resource type to generate a template for.

**Optional arguments:**

``-t <TEMPLATE_TYPE>, --template-type <TEMPLATE_TYPE>``
  Template type to generate, hot or cfn.

``-F <FORMAT>, --format <FORMAT>``
  The template output format, one of: yaml, json.

.. _heat_service-list:

heat service-list
-----------------

.. code-block:: console

   usage: heat service-list

List the Heat engines.

.. _heat_snapshot-delete:

heat snapshot-delete
--------------------

.. code-block:: console

   usage: heat snapshot-delete <NAME or ID> <SNAPSHOT>

Delete a snapshot of a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of the stack containing the snapshot.

``<SNAPSHOT>``
  The ID of the snapshot to delete.

.. _heat_snapshot-list:

heat snapshot-list
------------------

.. code-block:: console

   usage: heat snapshot-list <NAME or ID>

List the snapshots of a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of the stack containing the snapshots.

.. _heat_snapshot-show:

heat snapshot-show
------------------

.. code-block:: console

   usage: heat snapshot-show <NAME or ID> <SNAPSHOT>

Show a snapshot of a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of the stack containing the snapshot.

``<SNAPSHOT>``
  The ID of the snapshot to show.

.. _heat_stack-abandon:

heat stack-abandon
------------------

.. code-block:: console

   usage: heat stack-abandon [-O <FILE>] <NAME or ID>

Abandon the stack. This will delete the record of the stack from Heat, but
will not delete any of the underlying resources. Prints an adoptable JSON
representation of the stack to stdout or a file on success.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to abandon.

**Optional arguments:**

``-O <FILE>, --output-file <FILE>``
  file to output abandon result. If the option is
  specified, the result will be output into <FILE>.

.. _heat_stack-adopt:

heat stack-adopt
----------------

.. code-block:: console

   usage: heat stack-adopt [-e <FILE or URL>] [-c <TIMEOUT>] [-t <TIMEOUT>]
                           [-a <FILE or URL>] [-r]
                           [-P <KEY1=VALUE1;KEY2=VALUE2...>]
                           <STACK_NAME>

Adopt a stack.

**Positional arguments:**

``<STACK_NAME>``
  Name of the stack to adopt.

**Optional arguments:**

``-e <FILE or URL>, --environment-file <FILE or URL>``
  Path to the environment, it can be specified multiple
  times.

``-c <TIMEOUT>, --create-timeout <TIMEOUT>``
  Stack creation timeout in minutes. **DEPRECATED** use
  --timeout instead.

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  Stack creation timeout in minutes.

``-a <FILE or URL>, --adopt-file <FILE or URL>``
  Path to adopt stack data file.

``-r, --enable-rollback``
  Enable rollback on create/update failure.

``-P <KEY1=VALUE1;KEY2=VALUE2...>, --parameters <KEY1=VALUE1;KEY2=VALUE2...>``
  Parameter values used to create the stack. This can be
  specified multiple times, or once with parameters
  separated by a semicolon.

.. _heat_stack-cancel-update:

heat stack-cancel-update
------------------------

.. code-block:: console

   usage: heat stack-cancel-update <NAME or ID>

Cancel currently running update of the stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to cancel update for.

.. _heat_stack-create:

heat stack-create
-----------------

.. code-block:: console

   usage: heat stack-create [-f <FILE>] [-e <FILE or URL>]
                            [--pre-create <RESOURCE>] [-u <URL>] [-o <URL>]
                            [-c <TIMEOUT>] [-t <TIMEOUT>] [-r]
                            [-P <KEY1=VALUE1;KEY2=VALUE2...>] [-Pf <KEY=FILE>]
                            [--poll [SECONDS]] [--tags <TAG1,TAG2>]
                            <STACK_NAME>

Create the stack.

**Positional arguments:**

``<STACK_NAME>``
  Name of the stack to create.

**Optional arguments:**

``-f <FILE>, --template-file <FILE>``
  Path to the template.

``-e <FILE or URL>, --environment-file <FILE or URL>``
  Path to the environment, it can be specified multiple
  times.

``--pre-create <RESOURCE>``
  Name of a resource to set a pre-create hook to.
  Resources in nested stacks can be set using slash as a
  separator: nested_stack/another/my_resource. You can
  use wildcards to match multiple stacks or resources:
  nested_stack/an\*/\*_resource. This can be specified
  multiple times

``-u <URL>, --template-url <URL>``
  URL of template.

``-o <URL>, --template-object <URL>``
  URL to retrieve template object (e.g. from swift).

``-c <TIMEOUT>, --create-timeout <TIMEOUT>``
  Stack creation timeout in minutes. **DEPRECATED** use
  --timeout instead.

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  Stack creation timeout in minutes.

``-r, --enable-rollback``
  Enable rollback on create/update failure.

``-P <KEY1=VALUE1;KEY2=VALUE2...>, --parameters <KEY1=VALUE1;KEY2=VALUE2...>``
  Parameter values used to create the stack. This can be
  specified multiple times, or once with parameters
  separated by a semicolon.

``-Pf <KEY=FILE>, --parameter-file <KEY=FILE>``
  Parameter values from file used to create the stack.
  This can be specified multiple times. Parameter value
  would be the content of the file

``--poll [SECONDS]``
  Poll and report events until stack completes. Optional
  poll interval in seconds can be provided as argument,
  default 5.

``--tags <TAG1,TAG2>``
  A list of tags to associate with the stack.

.. _heat_stack-delete:

heat stack-delete
-----------------

.. code-block:: console

   usage: heat stack-delete [-y] <NAME or ID> [<NAME or ID> ...]

Delete the stack(s).

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack(s) to delete.

**Optional arguments:**

``-y, --yes``
  Skip yes/no prompt (assume yes).

.. _heat_stack-list:

heat stack-list
---------------

.. code-block:: console

   usage: heat stack-list [-s] [-n] [-a] [-f <KEY1=VALUE1;KEY2=VALUE2...>]
                          [-t <TAG1,TAG2...>] [--tags-any <TAG1,TAG2...>]
                          [--not-tags <TAG1,TAG2...>]
                          [--not-tags-any <TAG1,TAG2...>] [-l <LIMIT>] [-m <ID>]
                          [-k <KEY1;KEY2...>] [-d [asc|desc]] [-g] [-o]

List the user's stacks.

**Optional arguments:**

``-s, --show-deleted``
  Include soft-deleted stacks in the stack listing.

``-n, --show-nested``
  Include nested stacks in the stack listing.

``-a, --show-hidden``
  Include hidden stacks in the stack listing.

``-f <KEY1=VALUE1;KEY2=VALUE2...>, --filters <KEY1=VALUE1;KEY2=VALUE2...>``
  Filter parameters to apply on returned stacks. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-t <TAG1,TAG2...>, --tags <TAG1,TAG2...>``
  Show stacks containing these tags. If multiple tags
  are passed, they will be combined using the AND
  boolean expression.

``--tags-any <TAG1,TAG2...>``
  Show stacks containing these tags, If multiple tags
  are passed, they will be combined using the OR boolean
  expression.

``--not-tags <TAG1,TAG2...>``
  Show stacks not containing these tags, If multiple
  tags are passed, they will be combined using the AND
  boolean expression.

``--not-tags-any <TAG1,TAG2...>``
  Show stacks not containing these tags, If multiple
  tags are passed, they will be combined using the OR
  boolean expression.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of stacks returned.

``-m <ID>, --marker <ID>``
  Only return stacks that appear after the given stack
  ID.

``-k <KEY1;KEY2...>, --sort-keys <KEY1;KEY2...>``
  List of keys for sorting the returned stacks. This can
  be specified multiple times or once with keys
  separated by semicolons. Valid sorting keys include
  "stack_name", "stack_status", "creation_time" and
  "updated_time".

``-d [asc|desc], --sort-dir [asc|desc]``
  Sorting direction (either "asc" or "desc") for the
  sorting keys.

``-g, --global-tenant``
  Display stacks from all tenants. Operation only
  authorized for users who match the policy in heat's
  policy.json.

``-o, --show-owner``
  Display stack owner information. This is automatically
  enabled when using --global-tenant.

.. _heat_stack-preview:

heat stack-preview
------------------

.. code-block:: console

   usage: heat stack-preview [-f <FILE>] [-e <FILE or URL>] [-u <URL>] [-o <URL>]
                             [-t <TIMEOUT>] [-r]
                             [-P <KEY1=VALUE1;KEY2=VALUE2...>] [-Pf <KEY=FILE>]
                             [--tags <TAG1,TAG2>]
                             <STACK_NAME>

Preview the stack.

**Positional arguments:**

``<STACK_NAME>``
  Name of the stack to preview.

**Optional arguments:**

``-f <FILE>, --template-file <FILE>``
  Path to the template.

``-e <FILE or URL>, --environment-file <FILE or URL>``
  Path to the environment, it can be specified multiple
  times.

``-u <URL>, --template-url <URL>``
  URL of template.

``-o <URL>, --template-object <URL>``
  URL to retrieve template object (e.g. from swift)

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  Stack creation timeout in minutes. This is only used
  during validation in preview.

``-r, --enable-rollback``
  Enable rollback on failure. This option is not used
  during preview and exists only for symmetry with
  stack-create.

``-P <KEY1=VALUE1;KEY2=VALUE2...>, --parameters <KEY1=VALUE1;KEY2=VALUE2...>``
  Parameter values used to preview the stack. This can
  be specified multiple times, or once with parameters
  separated by semicolon.

``-Pf <KEY=FILE>, --parameter-file <KEY=FILE>``
  Parameter values from file used to create the stack.
  This can be specified multiple times. Parameter value
  would be the content of the file

``--tags <TAG1,TAG2>``
  A list of tags to associate with the stack.

.. _heat_stack-restore:

heat stack-restore
------------------

.. code-block:: console

   usage: heat stack-restore <NAME or ID> <SNAPSHOT>

Restore a snapshot of a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of the stack containing the snapshot.

``<SNAPSHOT>``
  The ID of the snapshot to restore.

.. _heat_stack-show:

heat stack-show
---------------

.. code-block:: console

   usage: heat stack-show [--no-resolve-outputs] <NAME or ID>

Describe the stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to describe.

**Optional arguments:**

``--no-resolve-outputs``
  Do not resolve outputs of the stack.

.. _heat_stack-snapshot:

heat stack-snapshot
-------------------

.. code-block:: console

   usage: heat stack-snapshot [-n <NAME>] <NAME or ID>

Make a snapshot of a stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to snapshot.

**Optional arguments:**

``-n <NAME>, --name <NAME>``
  If specified, the name given to the snapshot.

.. _heat_stack-update:

heat stack-update
-----------------

.. code-block:: console

   usage: heat stack-update [-f <FILE>] [-e <FILE or URL>]
                            [--pre-update <RESOURCE>] [-u <URL>] [-o <URL>]
                            [-t <TIMEOUT>] [-r] [--rollback <VALUE>] [-y] [-n]
                            [-P <KEY1=VALUE1;KEY2=VALUE2...>] [-Pf <KEY=FILE>]
                            [-x] [-c <PARAMETER>] [--tags <TAG1,TAG2>]
                            <NAME or ID>

Update the stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to update.

**Optional arguments:**

``-f <FILE>, --template-file <FILE>``
  Path to the template.

``-e <FILE or URL>, --environment-file <FILE or URL>``
  Path to the environment, it can be specified multiple
  times.

``--pre-update <RESOURCE>``
  Name of a resource to set a pre-update hook to.
  Resources in nested stacks can be set using slash as a
  separator: nested_stack/another/my_resource. You can
  use wildcards to match multiple stacks or resources:
  nested_stack/an\*/\*_resource. This can be specified
  multiple times

``-u <URL>, --template-url <URL>``
  URL of template.

``-o <URL>, --template-object <URL>``
  URL to retrieve template object (e.g. from swift).

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  Stack update timeout in minutes.

``-r, --enable-rollback``
  **DEPRECATED!** Use --rollback argument instead. Enable
  rollback on stack update failure. NOTE: default
  behavior is now to use the rollback value of existing
  stack.

``--rollback <VALUE>``
  Set rollback on update failure. Values ('1', 't',
  'true', 'on', 'y', 'yes') set rollback to enabled.
  Values ('0', 'f', 'false', 'off', 'n', 'no') set
  rollback to disabled. Default is to use the value of
  existing stack to be updated.

``-y, --dry-run``
  Do not actually perform the stack update, but show
  what would be changed

``-n, --show-nested``
  Show nested stacks when performing --dry-run

``-P <KEY1=VALUE1;KEY2=VALUE2...>, --parameters <KEY1=VALUE1;KEY2=VALUE2...>``
  Parameter values used to create the stack. This can be
  specified multiple times, or once with parameters
  separated by a semicolon.

``-Pf <KEY=FILE>, --parameter-file <KEY=FILE>``
  Parameter values from file used to create the stack.
  This can be specified multiple times. Parameter value
  would be the content of the file

``-x, --existing``
  Re-use the template, parameters and environment of the
  current stack. If the template argument is omitted
  then the existing template is used. If no
  --environment-file is specified then the existing
  environment is used. Parameters specified in
  --parameters will patch over the existing values in
  the current stack. Parameters omitted will keep the
  existing values.

``-c <PARAMETER>, --clear-parameter <PARAMETER>``
  Remove the parameters from the set of parameters of
  current stack for the stack-update. The default value
  in the template will be used. This can be specified
  multiple times.

``--tags <TAG1,TAG2>``
  An updated list of tags to associate with the stack.

.. _heat_template-function-list:

heat template-function-list
---------------------------

.. code-block:: console

   usage: heat template-function-list <TEMPLATE_VERSION>

List the available functions.

**Positional arguments:**

``<TEMPLATE_VERSION>``
  Template version to get the functions for.

.. _heat_template-show:

heat template-show
------------------

.. code-block:: console

   usage: heat template-show <NAME or ID>

Get the template for the specified stack.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to get the template for.

.. _heat_template-validate:

heat template-validate
----------------------

.. code-block:: console

   usage: heat template-validate [-u <URL>] [-f <FILE>] [-e <FILE or URL>]
                                 [-o <URL>] [-n]
                                 [-P <KEY1=VALUE1;KEY2=VALUE2...>]
                                 [-I <ERR1,ERR2...>]

Validate a template with parameters.

**Optional arguments:**

``-u <URL>, --template-url <URL>``
  URL of template.

``-f <FILE>, --template-file <FILE>``
  Path to the template.

``-e <FILE or URL>, --environment-file <FILE or URL>``
  Path to the environment, it can be specified multiple
  times.

``-o <URL>, --template-object <URL>``
  URL to retrieve template object (e.g. from swift).

``-n, --show-nested``
  Resolve parameters from nested templates as well.

``-P <KEY1=VALUE1;KEY2=VALUE2...>, --parameters <KEY1=VALUE1;KEY2=VALUE2...>``
  Parameter values for the template. This can be
  specified multiple times, or once with parameters
  separated by a semicolon.

``-I <ERR1,ERR2...>, --ignore-errors <ERR1,ERR2...>``
  List of heat errors to ignore.

.. _heat_template-version-list:

heat template-version-list
--------------------------

.. code-block:: console

   usage: heat template-version-list

List the available template versions.

