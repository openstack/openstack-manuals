.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

===========================================
DNS service (designate) command-line client
===========================================

The designate client is the command-line interface (CLI) for
the DNS service (designate) API and its extensions.

This chapter documents :command:`designate` version ``2.5.0``.

For help on a specific :command:`designate` command, enter:

.. code-block:: console

   $ designate help COMMAND

.. _designate_command_usage:

designate usage
~~~~~~~~~~~~~~~

.. code-block:: console

   usage: designate [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                    [--os-username OS_USERNAME] [--os-user-id OS_USER_ID]
                    [--os-user-domain-id OS_USER_DOMAIN_ID]
                    [--os-user-domain-name OS_USER_DOMAIN_NAME]
                    [--os-password OS_PASSWORD] [--os-tenant-name OS_TENANT_NAME]
                    [--os-tenant-id OS_TENANT_ID]
                    [--os-project-name OS_PROJECT_NAME]
                    [--os-domain-name OS_DOMAIN_NAME]
                    [--os-domain-id OS_DOMAIN_ID] [--os-project-id OS_PROJECT_ID]
                    [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                    [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                    [--os-auth-url OS_AUTH_URL] [--os-region-name OS_REGION_NAME]
                    [--os-token OS_TOKEN] [--os-endpoint OS_ENDPOINT]
                    [--os-endpoint-type OS_ENDPOINT_TYPE]
                    [--os-service-type OS_SERVICE_TYPE] [--os-cacert OS_CACERT]
                    [--insecure] [--all-tenants] [--edit-managed]

.. _designate_command_options:

designate optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

``--os-username OS_USERNAME``
  Name used for authentication with the OpenStack
  Identity service. Defaults to ``env[OS_USERNAME]``.

``--os-user-id OS_USER_ID``
  User ID used for authentication with the OpenStack
  Identity service. Defaults to ``env[OS_USER_ID]``.

``--os-user-domain-id OS_USER_DOMAIN_ID``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name OS_USER_DOMAIN_NAME``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-password OS_PASSWORD``
  Password used for authentication with the OpenStack
  Identity service. Defaults to ``env[OS_PASSWORD]``.

``--os-tenant-name OS_TENANT_NAME``
  Tenant to request authorization on. Defaults to
  ``env[OS_TENANT_NAME]``.

``--os-tenant-id OS_TENANT_ID``
  Tenant to request authorization on. Defaults to
  ``env[OS_TENANT_ID]``.

``--os-project-name OS_PROJECT_NAME``
  Project to request authorization on. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-domain-name OS_DOMAIN_NAME``
  Project to request authorization on. Defaults to
  ``env[OS_DOMAIN_NAME]``.

``--os-domain-id OS_DOMAIN_ID``
  Defaults to ``env[OS_DOMAIN_ID]``.

``--os-project-id OS_PROJECT_ID``
  Project to request authorization on. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-project-domain-id OS_PROJECT_DOMAIN_ID``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name OS_PROJECT_DOMAIN_NAME``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-auth-url OS_AUTH_URL``
  Specify the Identity endpoint to use for
  authentication. Defaults to ``env[OS_AUTH_URL]``.

``--os-region-name OS_REGION_NAME``
  Specify the region to use. Defaults to
  ``env[OS_REGION_NAME]``.

``--os-token OS_TOKEN``
  Specify an existing token to use instead of retrieving
  one via authentication (e.g. with username &
  password). Defaults to ``env[OS_SERVICE_TOKEN]``.

``--os-endpoint OS_ENDPOINT``
  Specify an endpoint to use instead of retrieving one
  from the service catalog (via authentication).
  Defaults to ``env[OS_DNS_ENDPOINT]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]``.

``--os-service-type OS_SERVICE_TYPE``
  Defaults to ``env[OS_DNS_SERVICE_TYPE]``, or 'dns'.

``--os-cacert OS_CACERT``
  CA certificate bundle file. Defaults to
  ``env[OS_CACERT]``.

``--insecure``
  Explicitly allow 'insecure' SSL requests.

``--all-tenants``
  Allows to list all domains from all tenants.

``--edit-managed``
  Allows to edit records that are marked as managed.

.. _designate_diagnostics-ping:

designate diagnostics-ping
--------------------------

.. code-block:: console

   usage: designate diagnostics-ping [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX] --service SERVICE --host
                                     HOST

Ping a service on a given host

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--service SERVICE``
  Service name (e.g. central)

``--host HOST``
  Hostname

.. _designate_domain-create:

designate domain-create
-----------------------

.. code-block:: console

   usage: designate domain-create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  --name NAME --email EMAIL [--ttl TTL]
                                  [--description DESCRIPTION]

Create Domain

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Domain name.

``--email EMAIL``
  Domain email.

``--ttl TTL``
  Time to live (seconds).

``--description DESCRIPTION``
  Description.

.. _designate_domain-delete:

designate domain-delete
-----------------------

.. code-block:: console

   usage: designate domain-delete [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  id

Delete Domain

**Positional arguments:**

``id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_domain-get:

designate domain-get
--------------------

.. code-block:: console

   usage: designate domain-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               id

Get Domain

**Positional arguments:**

``id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_domain-list:

designate domain-list
---------------------

.. code-block:: console

   usage: designate domain-list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

List Domains

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_domain-servers-list:

designate domain-servers-list
-----------------------------

.. code-block:: console

   usage: designate domain-servers-list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--print-empty] [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        id

List Domain Servers

**Positional arguments:**

``id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_domain-update:

designate domain-update
-----------------------

.. code-block:: console

   usage: designate domain-update [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  [--name NAME] [--email EMAIL] [--ttl TTL]
                                  [--description DESCRIPTION | --no-description]
                                  id

Update Domain

**Positional arguments:**

``id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Domain name.

``--email EMAIL``
  Domain email.

``--ttl TTL``
  Time to live (seconds).

``--description DESCRIPTION``
  Description.

``--no-description``

.. _designate_quota-get:

designate quota-get
-------------------

.. code-block:: console

   usage: designate quota-get [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              tenant_id

Get Quota

**Positional arguments:**

``tenant_id``
  Tenant ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_quota-reset:

designate quota-reset
---------------------

.. code-block:: console

   usage: designate quota-reset [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                tenant_id

Reset Quota

**Positional arguments:**

``tenant_id``
  Tenant ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_quota-update:

designate quota-update
----------------------

.. code-block:: console

   usage: designate quota-update [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent] [--prefix PREFIX]
                                 [--domains DOMAINS]
                                 [--domain-recordsets DOMAIN_RECORDSETS]
                                 [--recordset-records RECORDSET_RECORDS]
                                 [--domain-records DOMAIN_RECORDS]
                                 [--api-export-size API_EXPORT_SIZE]
                                 tenant_id

Update Quota

**Positional arguments:**

``tenant_id``
  Tenant ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domains DOMAINS``
  Allowed domains.

``--domain-recordsets DOMAIN_RECORDSETS``
  Allowed domain records.

``--recordset-records RECORDSET_RECORDS``
  Allowed recordset records.

``--domain-records DOMAIN_RECORDS``
  Allowed domain records.

``--api-export-size API_EXPORT_SIZE``
  Allowed zone export recordsets.

.. _designate_record-create:

designate record-create
-----------------------

.. code-block:: console

   usage: designate record-create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  --name NAME --type TYPE --data DATA [--ttl TTL]
                                  [--priority PRIORITY]
                                  [--description DESCRIPTION]
                                  domain_id

Create Record

**Positional arguments:**

``domain_id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Record (relative|absolute) name.

``--type TYPE``
  Record type.

``--data DATA``
  Record data.

``--ttl TTL``
  Record TTL.

``--priority PRIORITY``
  Record priority.

``--description DESCRIPTION``
  Description.

.. _designate_record-delete:

designate record-delete
-----------------------

.. code-block:: console

   usage: designate record-delete [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  domain_id id

Delete Record

**Positional arguments:**

``domain_id``
  Domain ID or name.

``id``
  Record ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_record-get:

designate record-get
--------------------

.. code-block:: console

   usage: designate record-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               domain_id id

Get Record

**Positional arguments:**

``domain_id``
  Domain ID or name.

``id``
  Record ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_record-list:

designate record-list
---------------------

.. code-block:: console

   usage: designate record-list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                domain_id

List Records

**Positional arguments:**

``domain_id``
  Domain ID or name.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_record-update:

designate record-update
-----------------------

.. code-block:: console

   usage: designate record-update [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  [--name NAME] [--type TYPE] [--data DATA]
                                  [--description DESCRIPTION | --no-description]
                                  [--ttl TTL | --no-ttl]
                                  [--priority PRIORITY | --no-priority]
                                  domain_id id

Update Record

**Positional arguments:**

``domain_id``
  Domain ID or name.

``id``
  Record ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Record name.

``--type TYPE``
  Record type.

``--data DATA``
  Record data.

``--description DESCRIPTION``
  Description.

``--no-description``

``--ttl TTL``
  Record time to live (seconds).

``--no-ttl``

``--priority PRIORITY``
  Record priority.

``--no-priority``

.. _designate_report-count-all:

designate report-count-all
--------------------------

.. code-block:: console

   usage: designate report-count-all [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
                                     [--prefix PREFIX]

Get count totals for all tenants, domains and records

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_report-count-domains:

designate report-count-domains
------------------------------

.. code-block:: console

   usage: designate report-count-domains [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--print-empty] [--noindent]
                                         [--prefix PREFIX]

Get counts for total domains

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_report-count-records:

designate report-count-records
------------------------------

.. code-block:: console

   usage: designate report-count-records [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--print-empty] [--noindent]
                                         [--prefix PREFIX]

Get counts for total records

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_report-count-tenants:

designate report-count-tenants
------------------------------

.. code-block:: console

   usage: designate report-count-tenants [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--print-empty] [--noindent]
                                         [--prefix PREFIX]

Get counts for total tenants

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_report-tenant-domains:

designate report-tenant-domains
-------------------------------

.. code-block:: console

   usage: designate report-tenant-domains [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--print-empty] [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]
                                          --report-tenant-id REPORT_TENANT_ID

Get a list of domains for given tenant

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--report-tenant-id REPORT_TENANT_ID``
  The tenant_id being reported on.

.. _designate_report-tenants-all:

designate report-tenants-all
----------------------------

.. code-block:: console

   usage: designate report-tenants-all [-h] [-f {csv,html,json,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--print-empty] [--noindent]
                                       [--quote {all,minimal,none,nonnumeric}]

Get list of tenants and domain count for each

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_server-create:

designate server-create
-----------------------

.. code-block:: console

   usage: designate server-create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  --name NAME

Create Server

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Server name.

.. _designate_server-delete:

designate server-delete
-----------------------

.. code-block:: console

   usage: designate server-delete [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  id

Delete Server

**Positional arguments:**

``id``
  Server ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_server-get:

designate server-get
--------------------

.. code-block:: console

   usage: designate server-get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               id

Get Server

**Positional arguments:**

``id``
  Server ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_server-list:

designate server-list
---------------------

.. code-block:: console

   usage: designate server-list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

List Servers

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_server-update:

designate server-update
-----------------------

.. code-block:: console

   usage: designate server-update [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--print-empty] [--noindent] [--prefix PREFIX]
                                  [--name NAME]
                                  id

Update Server

**Positional arguments:**

``id``
  Server ID.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Server name.

.. _designate_sync-all:

designate sync-all
------------------

.. code-block:: console

   usage: designate sync-all [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--prefix PREFIX]

Sync Everything

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_sync-domain:

designate sync-domain
---------------------

.. code-block:: console

   usage: designate sync-domain [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                domain_id

Sync a single Domain

**Positional arguments:**

``domain_id``
  Domain ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_sync-record:

designate sync-record
---------------------

.. code-block:: console

   usage: designate sync-record [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                domain_id record_id

Sync a single Record

**Positional arguments:**

``domain_id``
  Domain ID

``record_id``
  Record ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _designate_touch-domain:

designate touch-domain
----------------------

.. code-block:: console

   usage: designate touch-domain [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>]
                                 [--print-empty] [--noindent] [--prefix PREFIX]
                                 domain_id

Touch a single Domain

**Positional arguments:**

``domain_id``
  Domain ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

