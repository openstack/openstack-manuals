.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

======================================================
NFV Orchestration service (tacker) command-line client
======================================================

The tacker client is the command-line interface (CLI) for
the NFV Orchestration service (tacker) API and its extensions.

This chapter documents :command:`tacker` version ``0.9.0``.

For help on a specific :command:`tacker` command, enter:

.. code-block:: console

   $ tacker help COMMAND

.. _tacker_command_usage:

tacker usage
~~~~~~~~~~~~

.. code-block:: console

   usage: tacker [--version] [-v] [-q] [-h] [-r NUM]
                 [--os-service-type <os-service-type>]
                 [--os-endpoint-type <os-endpoint-type>]
                 [--service-type <service-type>]
                 [--endpoint-type <endpoint-type>]
                 [--os-auth-strategy <auth-strategy>] [--os-auth-url <auth-url>]
                 [--os-tenant-name <auth-tenant-name> | --os-project-name <auth-project-name>]
                 [--os-tenant-id <auth-tenant-id> | --os-project-id <auth-project-id>]
                 [--os-username <auth-username>] [--os-user-id <auth-user-id>]
                 [--os-user-domain-id <auth-user-domain-id>]
                 [--os-user-domain-name <auth-user-domain-name>]
                 [--os-project-domain-id <auth-project-domain-id>]
                 [--os-project-domain-name <auth-project-domain-name>]
                 [--os-cert <certificate>] [--os-cacert <ca-certificate>]
                 [--os-key <key>] [--os-password <auth-password>]
                 [--os-region-name <auth-region-name>] [--os-token <token>]
                 [--http-timeout <seconds>] [--os-url <url>] [--insecure]

.. _tacker_command_options:

tacker optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-v, --verbose, --debug``
  Increase verbosity of output and show tracebacks on
  errors. You can repeat this option.

``-q, --quiet``
  Suppress output except warnings and errors.

``-h, --help``
  Show this help message and exit.

``-r NUM, --retries NUM``
  How many times the request to the Tacker server should
  be retried if it fails.

``--os-service-type <os-service-type>``
  Defaults to ``env[OS_TACKER_SERVICE_TYPE]`` or nfv-orchestration.

``--os-endpoint-type <os-endpoint-type>``
  Defaults to ``env[OS_ENDPOINT_TYPE]`` or publicURL.

``--service-type <service-type>``
  **DEPRECATED!** Use --os-service-type.

``--endpoint-type <endpoint-type>``
  **DEPRECATED!** Use --os-endpoint-type.

``--os-auth-strategy <auth-strategy>``
  **DEPRECATED!** Only keystone is supported.

``--os-auth-url <auth-url>``
  Authentication URL, defaults to ``env[OS_AUTH_URL]``.

``--os-tenant-name <auth-tenant-name>``
  Authentication tenant name, defaults to
  ``env[OS_TENANT_NAME]``.

``--os-project-name <auth-project-name>``
  Another way to specify tenant name. This option is
  mutually exclusive with --os-tenant-name. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-tenant-id <auth-tenant-id>``
  Authentication tenant ID, defaults to
  ``env[OS_TENANT_ID]``.

``--os-project-id <auth-project-id>``
  Another way to specify tenant ID. This option is
  mutually exclusive with --os-tenant-id. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-username <auth-username>``
  Authentication username, defaults to ``env[OS_USERNAME]``.

``--os-user-id <auth-user-id>``
  Authentication user ID (Env: OS_USER_ID)

``--os-user-domain-id <auth-user-domain-id>``
  OpenStack user domain ID. Defaults to
  ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  OpenStack user domain name. Defaults to
  ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-domain-id <auth-project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <auth-project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-cert <certificate>``
  Path of certificate file to use in SSL connection.
  This file can optionally be prepended with the private
  key. Defaults to ``env[OS_CERT]``.

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS
  (https) server certificate. Defaults to
  ``env[OS_CACERT]``.

``--os-key <key>``
  Path of client key to use in SSL connection. This
  option is not necessary if your key is prepended to
  your certificate file. Defaults to ``env[OS_KEY]``.

``--os-password <auth-password>``
  Authentication password, defaults to ``env[OS_PASSWORD]``.

``--os-region-name <auth-region-name>``
  Authentication region name, defaults to
  ``env[OS_REGION_NAME]``.

``--os-token <token>``
  Authentication token, defaults to ``env[OS_TOKEN]``.

``--http-timeout <seconds>``
  Timeout in seconds to wait for an HTTP response.
  Defaults to ``env[OS_NETWORK_TIMEOUT]`` or None if not
  specified.

``--os-url <url>``
  Defaults to ``env[OS_URL]``.

``--insecure``
  Explicitly allow tackerclient to perform "insecure"
  SSL (https) requests. The server's certificate will
  not be verified against any certificate authorities.
  This option should be used with caution.

.. _tacker_chain-list:

tacker chain-list
-----------------

.. code-block:: console

   usage: tacker chain-list [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--quote {all,minimal,none,nonnumeric}]
                            [--request-format {json,xml}] [-D] [-F FIELD]

List SFCs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_chain-show:

tacker chain-show
-----------------

.. code-block:: console

   usage: tacker chain-show [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            [--request-format {json,xml}] [-D] [-F FIELD]
                            SFC

Show information of a given SFC.

**Positional arguments:**

``SFC``
  ID or name of sfc to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_classifier-list:

tacker classifier-list
----------------------

.. code-block:: console

   usage: tacker classifier-list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--request-format {json,xml}] [-D] [-F FIELD]

List FCs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_classifier-show:

tacker classifier-show
----------------------

.. code-block:: console

   usage: tacker classifier-show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent] [--prefix PREFIX]
                                 [--request-format {json,xml}] [-D] [-F FIELD]
                                 CLASSIFIER

Show information of a given FC.

**Positional arguments:**

``CLASSIFIER``
  ID or name of classifier to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_event-show:

tacker event-show
-----------------

.. code-block:: console

   usage: tacker event-show [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            [--request-format {json,xml}] [-D] [-F FIELD]
                            EVENT

Show event given the event id.

**Positional arguments:**

``EVENT``
  ID or name of event to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_events-list:

tacker events-list
------------------

.. code-block:: console

   usage: tacker events-list [-h] [-f {csv,html,json,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--quote {all,minimal,none,nonnumeric}]
                             [--request-format {json,xml}] [-D] [-F FIELD]
                             [--id ID] [--resource-id RESOURCE_ID]
                             [--resource-state RESOURCE_STATE]
                             [--event-type EVENT_TYPE]
                             [--resource-type RESOURCE_TYPE]

List events of resources.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

``--id ID``
  id of the event to look up.

``--resource-id RESOURCE_ID``
  resource id of the events to look up.

``--resource-state RESOURCE_STATE``
  resource state of the events to look up.

``--event-type EVENT_TYPE``
  event type of the events to look up.

``--resource-type RESOURCE_TYPE``
  resource type of the events to look up.

.. _tacker_ext-list:

tacker ext-list
---------------

.. code-block:: console

   usage: tacker ext-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--request-format {json,xml}] [-D] [-F FIELD]

List all extensions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_ext-show:

tacker ext-show
---------------

.. code-block:: console

   usage: tacker ext-show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          [--request-format {json,xml}] [-D] [-F FIELD]
                          EXT-ALIAS

Show information of a given resource.

**Positional arguments:**

``EXT-ALIAS``
  ID of extension to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_nfp-list:

tacker nfp-list
---------------

.. code-block:: console

   usage: tacker nfp-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--request-format {json,xml}] [-D] [-F FIELD]

List NFPs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_nfp-show:

tacker nfp-show
---------------

.. code-block:: console

   usage: tacker nfp-show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          [--request-format {json,xml}] [-D] [-F FIELD]
                          NFP

Show information of a given NFP.

**Positional arguments:**

``NFP``
  ID or name of nfp to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_ns-create:

tacker ns-create
----------------

.. code-block:: console

   usage: tacker ns-create [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--print-empty]
                           [--noindent] [--prefix PREFIX]
                           [--request-format {json,xml}] [--tenant-id TENANT_ID]
                           [--description DESCRIPTION]
                           (--nsd-id NSD_ID | --nsd-name NSD_NAME)
                           [--vim-id VIM_ID | --vim-name VIM_NAME]
                           [--vim-region-name VIM_REGION_NAME]
                           [--param-file PARAM_FILE]
                           NAME

Create a NS.

**Positional arguments:**

``NAME``
  Set a name for the NS

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--description DESCRIPTION``
  Set description for the NS

``--nsd-id NSD_ID``
  NSD ID to use as template to create NS

``--nsd-name NSD_NAME``
  NSD name to use as template to create NS

``--vim-id VIM_ID``
  VIM ID to use to create NS on the specified VIM

``--vim-name VIM_NAME``
  VIM name to use to create NS on the specified VIM

``--vim-region-name VIM_REGION_NAME``
  VIM Region to use to create NS on the specified VIM

``--param-file PARAM_FILE``
  Specify parameter yaml file

.. _tacker_ns-delete:

tacker ns-delete
----------------

.. code-block:: console

   usage: tacker ns-delete [-h] [--request-format {json,xml}] NS [NS ...]

Delete given NS(s).

**Positional arguments:**

``NS``
  IDs or names of ns to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_ns-list:

tacker ns-list
--------------

.. code-block:: console

   usage: tacker ns-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                         [--max-width <integer>] [--print-empty] [--noindent]
                         [--quote {all,minimal,none,nonnumeric}]
                         [--request-format {json,xml}] [-D] [-F FIELD]

List NS that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_ns-show:

tacker ns-show
--------------

.. code-block:: console

   usage: tacker ns-show [-h] [-f {html,json,shell,table,value,yaml}] [-c COLUMN]
                         [--max-width <integer>] [--print-empty] [--noindent]
                         [--prefix PREFIX] [--request-format {json,xml}] [-D]
                         [-F FIELD]
                         NS

Show information of a given NS.

**Positional arguments:**

``NS``
  ID or name of ns to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_nsd-create:

tacker nsd-create
-----------------

.. code-block:: console

   usage: tacker nsd-create [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            [--request-format {json,xml}] [--tenant-id TENANT_ID]
                            --nsd-file NSD_FILE [--description DESCRIPTION]
                            NAME

Create a NSD.

**Positional arguments:**

``NAME``
  Set a name for the NSD

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--nsd-file NSD_FILE``
  Specify NSD file

``--description DESCRIPTION``
  Set a description for the NSD

.. _tacker_nsd-delete:

tacker nsd-delete
-----------------

.. code-block:: console

   usage: tacker nsd-delete [-h] [--request-format {json,xml}] NSD [NSD ...]

Delete a given NSD.

**Positional arguments:**

``NSD``
  IDs or names of nsd to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_nsd-list:

tacker nsd-list
---------------

.. code-block:: console

   usage: tacker nsd-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--request-format {json,xml}] [-D] [-F FIELD]

List NSDs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_nsd-show:

tacker nsd-show
---------------

.. code-block:: console

   usage: tacker nsd-show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          [--request-format {json,xml}] [-D] [-F FIELD]
                          NSD

Show information of a given NSD.

**Positional arguments:**

``NSD``
  ID or name of nsd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_nsd-template-show:

tacker nsd-template-show
------------------------

.. code-block:: console

   usage: tacker nsd-template-show [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent] [--prefix PREFIX]
                                   [--request-format {json,xml}] [-D] [-F FIELD]
                                   NSD

Show template of a given NSD.

**Positional arguments:**

``NSD``
  ID or name of nsd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vim-delete:

tacker vim-delete
-----------------

.. code-block:: console

   usage: tacker vim-delete [-h] [--request-format {json,xml}] VIM [VIM ...]

Delete given VIM(s).

**Positional arguments:**

``VIM``
  IDs or names of vim to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_vim-events-list:

tacker vim-events-list
----------------------

.. code-block:: console

   usage: tacker vim-events-list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--request-format {json,xml}] [-D] [-F FIELD]
                                 [--id ID] [--resource-id RESOURCE_ID]
                                 [--resource-state RESOURCE_STATE]
                                 [--event-type EVENT_TYPE]

List events of VIMs.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

``--id ID``
  id of the event to look up.

``--resource-id RESOURCE_ID``
  resource id of the events to look up.

``--resource-state RESOURCE_STATE``
  resource state of the events to look up.

``--event-type EVENT_TYPE``
  event type of the events to look up.

.. _tacker_vim-list:

tacker vim-list
---------------

.. code-block:: console

   usage: tacker vim-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--request-format {json,xml}] [-D] [-F FIELD]

List VIMs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vim-register:

tacker vim-register
-------------------

.. code-block:: console

   usage: tacker vim-register [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              [--request-format {json,xml}]
                              [--tenant-id TENANT_ID] --config-file CONFIG_FILE
                              [--description DESCRIPTION] [--is-default]
                              NAME

Create a VIM.

**Positional arguments:**

``NAME``
  Set a name for the VIM

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--config-file CONFIG_FILE``
  YAML file with VIM configuration parameters

``--description DESCRIPTION``
  Set a description for the VIM

``--is-default``
  Set as default VIM

.. _tacker_vim-show:

tacker vim-show
---------------

.. code-block:: console

   usage: tacker vim-show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          [--request-format {json,xml}] [-D] [-F FIELD]
                          VIM

Show information of a given VIM.

**Positional arguments:**

``VIM``
  ID or name of vim to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vim-update:

tacker vim-update
-----------------

.. code-block:: console

   usage: tacker vim-update [-h] [--request-format {json,xml}] --config-file
                            CONFIG_FILE [--name NAME] [--description DESCRIPTION]
                            [--is-default {True,False}]
                            VIM

Update a given VIM.

**Positional arguments:**

``VIM``
  ID or name of vim to update

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--config-file CONFIG_FILE``
  YAML file with VIM configuration parameters

``--name NAME``
  New name for the VIM

``--description DESCRIPTION``
  New description for the VIM

``--is-default {True,False}``
  Indicate whether the VIM is used as default

.. _tacker_vnf-create:

tacker vnf-create
-----------------

.. code-block:: console

   usage: tacker vnf-create [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            [--request-format {json,xml}] [--tenant-id TENANT_ID]
                            [--description DESCRIPTION]
                            (--vnfd-id VNFD_ID | --vnfd-name VNFD_NAME | --vnfd-template VNFD_TEMPLATE)
                            [--vim-id VIM_ID | --vim-name VIM_NAME]
                            [--vim-region-name VIM_REGION_NAME]
                            [--config-file CONFIG_FILE] [--config CONFIG]
                            [--param-file PARAM_FILE]
                            NAME

Create a VNF.

**Positional arguments:**

``NAME``
  Set a name for the VNF

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--description DESCRIPTION``
  Set description for the VNF

``--vnfd-id VNFD_ID``
  VNFD ID to use as template to create VNF

``--vnfd-name VNFD_NAME``
  VNFD Name to use as template to create VNF

``--vnfd-template VNFD_TEMPLATE``
  VNFD file to create VNF

``--vim-id VIM_ID``
  VIM ID to use to create VNF on the specified VIM

``--vim-name VIM_NAME``
  VIM name to use to create VNF on the specified VIM

``--vim-region-name VIM_REGION_NAME``
  VIM Region to use to create VNF on the specified VIM

``--config-file CONFIG_FILE``
  YAML file with VNF configuration

``--config CONFIG``
  Specify config yaml data (**DEPRECATED**)

``--param-file PARAM_FILE``
  Specify parameter yaml file

.. _tacker_vnf-delete:

tacker vnf-delete
-----------------

.. code-block:: console

   usage: tacker vnf-delete [-h] [--request-format {json,xml}] VNF [VNF ...]

Delete given VNF(s).

**Positional arguments:**

``VNF``
  IDs or names of vnf to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_vnf-events-list:

tacker vnf-events-list
----------------------

.. code-block:: console

   usage: tacker vnf-events-list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--request-format {json,xml}] [-D] [-F FIELD]
                                 [--id ID] [--resource-id RESOURCE_ID]
                                 [--resource-state RESOURCE_STATE]
                                 [--event-type EVENT_TYPE]

List events of VNFs.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

``--id ID``
  id of the event to look up.

``--resource-id RESOURCE_ID``
  resource id of the events to look up.

``--resource-state RESOURCE_STATE``
  resource state of the events to look up.

``--event-type EVENT_TYPE``
  event type of the events to look up.

.. _tacker_vnf-list:

tacker vnf-list
---------------

.. code-block:: console

   usage: tacker vnf-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                          [--max-width <integer>] [--print-empty] [--noindent]
                          [--quote {all,minimal,none,nonnumeric}]
                          [--request-format {json,xml}] [-D] [-F FIELD]

List VNF that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnf-resource-list:

tacker vnf-resource-list
------------------------

.. code-block:: console

   usage: tacker vnf-resource-list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]
                                   [--request-format {json,xml}] [-D] [-F FIELD]
                                   VNF

List resources of a VNF like VDU, CP, etc.

**Positional arguments:**

``VNF``
  ID or name of vnf to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnf-scale:

tacker vnf-scale
----------------

.. code-block:: console

   usage: tacker vnf-scale [-h] [--request-format {json,xml}]
                           (--vnf-id VNF_ID | --vnf-name VNF_NAME)
                           [--scaling-policy-name SCALING_POLICY_NAME]
                           [--scaling-type SCALING_TYPE]

Scale a VNF.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--vnf-id VNF_ID``
  VNF ID

``--vnf-name VNF_NAME``
  VNF name

``--scaling-policy-name SCALING_POLICY_NAME``
  VNF policy name used to scale

``--scaling-type SCALING_TYPE``
  VNF scaling type, it could be either "out" or "in"

.. _tacker_vnf-show:

tacker vnf-show
---------------

.. code-block:: console

   usage: tacker vnf-show [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          [--request-format {json,xml}] [-D] [-F FIELD]
                          VNF

Show information of a given VNF.

**Positional arguments:**

``VNF``
  ID or name of vnf to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnf-update:

tacker vnf-update
-----------------

.. code-block:: console

   usage: tacker vnf-update [-h] [--request-format {json,xml}]
                            [--config-file CONFIG_FILE] [--config CONFIG]
                            VNF

Update a given VNF.

**Positional arguments:**

``VNF``
  ID or name of vnf to update

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--config-file CONFIG_FILE``
  YAML file with VNF configuration

``--config CONFIG``
  Specify config yaml data

.. _tacker_vnfd-create:

tacker vnfd-create
------------------

.. code-block:: console

   usage: tacker vnfd-create [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX]
                             [--request-format {json,xml}]
                             [--tenant-id TENANT_ID]
                             (--vnfd-file VNFD_FILE | --vnfd VNFD)
                             [--description DESCRIPTION]
                             NAME

Create a VNFD.

**Positional arguments:**

``NAME``
  Set a name for the VNFD

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--vnfd-file VNFD_FILE``
  Specify VNFD file

``--vnfd VNFD``
  Specify VNFD (**DEPRECATED**)

``--description DESCRIPTION``
  Set a description for the VNFD

.. _tacker_vnfd-delete:

tacker vnfd-delete
------------------

.. code-block:: console

   usage: tacker vnfd-delete [-h] [--request-format {json,xml}] VNFD [VNFD ...]

Delete given VNFD(s).

**Positional arguments:**

``VNFD``
  IDs or names of vnfd to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_vnfd-events-list:

tacker vnfd-events-list
-----------------------

.. code-block:: console

   usage: tacker vnfd-events-list [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--request-format {json,xml}] [-D] [-F FIELD]
                                  [--id ID] [--resource-id RESOURCE_ID]
                                  [--resource-state RESOURCE_STATE]
                                  [--event-type EVENT_TYPE]

List events of VNFDs.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

``--id ID``
  id of the event to look up.

``--resource-id RESOURCE_ID``
  resource id of the events to look up.

``--resource-state RESOURCE_STATE``
  resource state of the events to look up.

``--event-type EVENT_TYPE``
  event type of the events to look up.

.. _tacker_vnfd-list:

tacker vnfd-list
----------------

.. code-block:: console

   usage: tacker vnfd-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                           [--max-width <integer>] [--print-empty] [--noindent]
                           [--quote {all,minimal,none,nonnumeric}]
                           [--request-format {json,xml}] [-D] [-F FIELD]
                           [--template-source TEMPLATE_SOURCE]

List VNFD that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

``--template-source TEMPLATE_SOURCE``
  List VNFD with specified template source. Available
  options are 'onboarded' (default), 'inline' or 'all'

.. _tacker_vnfd-show:

tacker vnfd-show
----------------

.. code-block:: console

   usage: tacker vnfd-show [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--print-empty]
                           [--noindent] [--prefix PREFIX]
                           [--request-format {json,xml}] [-D] [-F FIELD]
                           VNFD

Show information of a given VNFD.

**Positional arguments:**

``VNFD``
  ID or name of vnfd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnfd-template-show:

tacker vnfd-template-show
-------------------------

.. code-block:: console

   usage: tacker vnfd-template-show [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX]
                                    [--request-format {json,xml}] [-D] [-F FIELD]
                                    VNFD

Show template of a given VNFD.

**Positional arguments:**

``VNFD``
  ID or name of vnfd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnffg-create:

tacker vnffg-create
-------------------

.. code-block:: console

   usage: tacker vnffg-create [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              [--request-format {json,xml}]
                              [--tenant-id TENANT_ID]
                              (--vnffgd-id VNFFGD_ID | --vnffgd-name VNFFGD_NAME)
                              [--vnf-mapping VNF_MAPPING]
                              [--symmetrical {True,False}]
                              [--param-file PARAM_FILE]
                              NAME

Create a VNFFG.

**Positional arguments:**

``NAME``
  Set a name for the VNFFG

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--vnffgd-id VNFFGD_ID``
  VNFFGD ID to use as template to create VNFFG

``--vnffgd-name VNFFGD_NAME``
  VNFFGD Name to use as template to create VNFFG

``--vnf-mapping VNF_MAPPING``
  List of logical VNFD name to VNF instance name
  mapping. Example: VNF1:my_vnf1,VNF2:my_vnf2

``--symmetrical {True,False}``
  Should a reverse path be created for the NFP

``--param-file PARAM_FILE``
  Specify parameter yaml file

.. _tacker_vnffg-delete:

tacker vnffg-delete
-------------------

.. code-block:: console

   usage: tacker vnffg-delete [-h] [--request-format {json,xml}]
                              VNFFG [VNFFG ...]

Delete a given VNFFG.

**Positional arguments:**

``VNFFG``
  IDs or names of vnffg to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_vnffg-list:

tacker vnffg-list
-----------------

.. code-block:: console

   usage: tacker vnffg-list [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--quote {all,minimal,none,nonnumeric}]
                            [--request-format {json,xml}] [-D] [-F FIELD]

List VNFFGs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnffg-show:

tacker vnffg-show
-----------------

.. code-block:: console

   usage: tacker vnffg-show [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--print-empty]
                            [--noindent] [--prefix PREFIX]
                            [--request-format {json,xml}] [-D] [-F FIELD]
                            VNFFG

Show information of a given VNFFG.

**Positional arguments:**

``VNFFG``
  ID or name of vnffg to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnffg-update:

tacker vnffg-update
-------------------

.. code-block:: console

   usage: tacker vnffg-update [-h] [--request-format {json,xml}]
                              [--vnf-mapping VNF_MAPPING]
                              [--symmetrical {True,False}]
                              VNFFG

Update a given VNFFG.

**Positional arguments:**

``VNFFG``
  ID or name of vnffg to update

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--vnf-mapping VNF_MAPPING``
  List of logical VNFD name to VNF instance name
  mapping. Example: VNF1:my_vnf1,VNF2:my_vnf2

``--symmetrical {True,False}``
  Should a reverse path be created for the NFP

.. _tacker_vnffgd-create:

tacker vnffgd-create
--------------------

.. code-block:: console

   usage: tacker vnffgd-create [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               [--request-format {json,xml}]
                               [--tenant-id TENANT_ID]
                               (--vnffgd-file VNFFGD_FILE | --vnffgd VNFFGD)
                               [--description DESCRIPTION]
                               NAME

Create a VNFFGD.

**Positional arguments:**

``NAME``
  Set a name for the VNFFGD

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``--tenant-id TENANT_ID``
  The owner tenant ID

``--vnffgd-file VNFFGD_FILE``
  Specify VNFFGD file

``--vnffgd VNFFGD``
  Specify VNFFGD (**DEPRECATED**)

``--description DESCRIPTION``
  Set a description for the VNFFGD

.. _tacker_vnffgd-delete:

tacker vnffgd-delete
--------------------

.. code-block:: console

   usage: tacker vnffgd-delete [-h] [--request-format {json,xml}]
                               VNFFGD [VNFFGD ...]

Delete a given VNFFGD.

**Positional arguments:**

``VNFFGD``
  IDs or names of vnffgd to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

.. _tacker_vnffgd-list:

tacker vnffgd-list
------------------

.. code-block:: console

   usage: tacker vnffgd-list [-h] [-f {csv,html,json,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--quote {all,minimal,none,nonnumeric}]
                             [--request-format {json,xml}] [-D] [-F FIELD]

List VNFFGDs that belong to a given tenant.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnffgd-show:

tacker vnffgd-show
------------------

.. code-block:: console

   usage: tacker vnffgd-show [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX]
                             [--request-format {json,xml}] [-D] [-F FIELD]
                             VNFFGD

Show information of a given VNFFGD.

**Positional arguments:**

``VNFFGD``
  ID or name of vnffgd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

.. _tacker_vnffgd-template-show:

tacker vnffgd-template-show
---------------------------

.. code-block:: console

   usage: tacker vnffgd-template-show [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--print-empty] [--noindent]
                                      [--prefix PREFIX]
                                      [--request-format {json,xml}] [-D]
                                      [-F FIELD]
                                      VNFFGD

Show template of a given VNFFGD.

**Positional arguments:**

``VNFFGD``
  ID or name of vnffgd to look up

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-format {json,xml}``
  The xml or json request format

``-D, --show-details``
  Show detailed info

``-F FIELD, --field FIELD``
  Specify the field(s) to be returned by server. You can
  repeat this option.

