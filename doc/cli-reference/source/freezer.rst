.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

============================================================================
Backup, Restore, and Disaster Recovery service (freezer) command-line client
============================================================================

The freezer client is the command-line interface (CLI) for
the Backup, Restore, and Disaster Recovery service (freezer) API and its
extensions.

This chapter documents :command:`freezer` version ``1.2.0``.

For help on a specific :command:`freezer` command, enter:

.. code-block:: console

   $ freezer help COMMAND

.. _freezer_command_usage:

freezer usage
~~~~~~~~~~~~~

.. code-block:: console

   usage: freezer [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                  [--os-auth-url OS_AUTH_URL] [--os-backup-url OS_BACKUP_URL]
                  [--os-endpoint-type OS_ENDPOINT_TYPE]
                  [--os-identity-api-version OS_IDENTITY_API_VERSION]
                  [--os-password OS_PASSWORD] [--os-username OS_USERNAME]
                  [--os-token OS_TOKEN]
                  [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                  [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                  [--os-project-name OS_PROJECT_NAME]
                  [--os-region-name OS_REGION_NAME] [--os-tenant-id OS_TENANT_ID]
                  [--os-tenant-name OS_TENANT_NAME]
                  [--os-user-domain-name OS_USER_DOMAIN_NAME]
                  [--os-user-domain-id OS_USER_DOMAIN_ID] [-k]
                  [--os-cacert OS_CACERT] [--os-cert OS_CERT]

.. _freezer_command_options:

freezer optional arguments
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

``--os-auth-url OS_AUTH_URL``
  Specify identity endpoint

``--os-backup-url OS_BACKUP_URL``
  Specify the Freezer backup service endpoint to use

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Endpoint type to select. Valid endpoint types:
  "public" or "publicURL", "internal" or "internalURL",
  "admin" or "adminURL"

``--os-identity-api-version OS_IDENTITY_API_VERSION``
  Identity API version: 2.0 or 3

``--os-password OS_PASSWORD``
  Password used for authentication with the OpenStack
  Identity service

``--os-username OS_USERNAME``
  Name used for authentication with the OpenStack
  Identity service

``--os-token OS_TOKEN``
  Specify an existing token to use instead of retrieving
  one via authentication

``--os-project-domain-name OS_PROJECT_DOMAIN_NAME``
  Domain name containing project

``--os-project-domain-id OS_PROJECT_DOMAIN_ID``
  OpenStack project domain ID. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-project-name OS_PROJECT_NAME``
  Project name to scope to

``--os-region-name OS_REGION_NAME``
  Specify the region to use

``--os-tenant-id OS_TENANT_ID``
  Tenant to request authorization on

``--os-tenant-name OS_TENANT_NAME``
  Tenant to request authorization on

``--os-user-domain-name OS_USER_DOMAIN_NAME``
  User domain name

``--os-user-domain-id OS_USER_DOMAIN_ID``
  OpenStack user domain ID. Defaults to
  ``env[OS_USER_DOMAIN_ID]``.

``-k, --insecure``
  use python-freezerclient with insecure connections

``--os-cacert OS_CACERT``
  Path of CA TLS certificate(s) used to verify the
  remote server's certificate. Without this option
  freezer looks for the default system CA certificates.

``--os-cert OS_CERT``
  Path of CERT TLS certificate(s) used to verify the
  remote server's certificate.1

.. _freezer_action-create:

freezer action-create
---------------------

.. code-block:: console

   usage: freezer action-create [-h] --file FILE

Create an action from a file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file FILE``
  Path to json file with the action

.. _freezer_action-delete:

freezer action-delete
---------------------

.. code-block:: console

   usage: freezer action-delete [-h] action_id

Delete an action from the api

**Positional arguments:**

``action_id``
  ID of the action

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_action-list:

freezer action-list
-------------------

.. code-block:: console

   usage: freezer action-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--limit LIMIT] [--offset OFFSET] [--search SEARCH]

List all actions for your user

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT``
  Specify a limit for search query

``--offset OFFSET``

``--search SEARCH``
  Define a filter for the query

.. _freezer_action-show:

freezer action-show
-------------------

.. code-block:: console

   usage: freezer action-show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              action_id

Show a single action

**Positional arguments:**

``action_id``
  ID of the action

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_action-update:

freezer action-update
---------------------

.. code-block:: console

   usage: freezer action-update [-h] action_id file

Update an action from a file

**Positional arguments:**

``action_id``
  ID of the session

``file``
  Path to json file with the action

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_backup-delete:

freezer backup-delete
---------------------

.. code-block:: console

   usage: freezer backup-delete [-h] backup_id

Delete a backup from the api

**Positional arguments:**

``backup_id``
  ID of the backup

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_backup-list:

freezer backup-list
-------------------

.. code-block:: console

   usage: freezer backup-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--limit LIMIT] [--offset OFFSET] [--search SEARCH]

List all backups for your user

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT``
  Specify a limit for search query

``--offset OFFSET``

``--search SEARCH``
  Define a filter for the query

.. _freezer_backup-show:

freezer backup-show
-------------------

.. code-block:: console

   usage: freezer backup-show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              backup_id

Show the metadata of a single backup

**Positional arguments:**

``backup_id``
  ID of the backup

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_client-delete:

freezer client-delete
---------------------

.. code-block:: console

   usage: freezer client-delete [-h] client_id

Delete a client from the api

**Positional arguments:**

``client_id``
  ID of the client

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_client-list:

freezer client-list
-------------------

.. code-block:: console

   usage: freezer client-list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--limit LIMIT] [--offset OFFSET] [--search SEARCH]

List of clients registered in the api

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT``
  Specify a limit for search query

``--offset OFFSET``

``--search SEARCH``
  Define a filter for the query

.. _freezer_client-register:

freezer client-register
-----------------------

.. code-block:: console

   usage: freezer client-register [-h] --file FILE

Register a new client

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file FILE``
  Path to json file with the client

.. _freezer_client-show:

freezer client-show
-------------------

.. code-block:: console

   usage: freezer client-show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX]
                              client_id

Show a single client

**Positional arguments:**

``client_id``
  ID of the client

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-abort:

freezer job-abort
-----------------

.. code-block:: console

   usage: freezer job-abort [-h] job_id

Abort a running job

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-create:

freezer job-create
------------------

.. code-block:: console

   usage: freezer job-create [-h] --file FILE

Create a new job from a file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file FILE``
  Path to json file with the job

.. _freezer_job-delete:

freezer job-delete
------------------

.. code-block:: console

   usage: freezer job-delete [-h] job_id

Delete a job from the api

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-get:

freezer job-get
---------------

.. code-block:: console

   usage: freezer job-get [-h] [--no-format] job_id

Download a job as a json file

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--no-format``
  Return a job in json without pretty print

.. _freezer_job-list:

freezer job-list
----------------

.. code-block:: console

   usage: freezer job-list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                           [--max-width <integer>] [--print-empty] [--noindent]
                           [--quote {all,minimal,none,nonnumeric}]
                           [--limit LIMIT] [--offset OFFSET] [--search SEARCH]
                           [--client CLIENT_ID]

List all the jobs for your user

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT``
  Specify a limit for search query

``--offset OFFSET``

``--search SEARCH``
  Define a filter for the query

``--client CLIENT_ID, -C``
  CLIENT_ID
  Get jobs for a specific client

.. _freezer_job-show:

freezer job-show
----------------

.. code-block:: console

   usage: freezer job-show [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--print-empty]
                           [--noindent] [--prefix PREFIX]
                           job_id

Show a single job

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-start:

freezer job-start
-----------------

.. code-block:: console

   usage: freezer job-start [-h] job_id

Send a start signal for a job

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-stop:

freezer job-stop
----------------

.. code-block:: console

   usage: freezer job-stop [-h] job_id

Send a stop signal for a job

**Positional arguments:**

``job_id``
  ID of the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_job-update:

freezer job-update
------------------

.. code-block:: console

   usage: freezer job-update [-h] job_id file

Update a job from a file

**Positional arguments:**

``job_id``
  ID of the job

``file``
  Path to json file with the job

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_session-add-job:

freezer session-add-job
-----------------------

.. code-block:: console

   usage: freezer session-add-job [-h] --session-id SESSION_ID --job-id JOB_ID

Add a job to a session

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--session-id SESSION_ID``
  ID of the session

``--job-id JOB_ID``
  ID of the job to add

.. _freezer_session-create:

freezer session-create
----------------------

.. code-block:: console

   usage: freezer session-create [-h] --file FILE

Create a session from a file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file FILE``
  Path to json file with the job

.. _freezer_session-delete:

freezer session-delete
----------------------

.. code-block:: console

   usage: freezer session-delete [-h] session_id

Delete a session

**Positional arguments:**

``session_id``
  ID of the session

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_session-list:

freezer session-list
--------------------

.. code-block:: console

   usage: freezer session-list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--limit LIMIT] [--offset OFFSET]
                               [--search SEARCH]

List all the sessions for your user

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT``
  Specify a limit for search query

``--offset OFFSET``

``--search SEARCH``
  Define a filter for the query

.. _freezer_session-remove-job:

freezer session-remove-job
--------------------------

.. code-block:: console

   usage: freezer session-remove-job [-h] --session-id SESSION_ID --job-id JOB_ID

Remove a job from a session

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--session-id SESSION_ID``
  ID of the session

``--job-id JOB_ID``
  ID of the job to add

.. _freezer_session-show:

freezer session-show
--------------------

.. code-block:: console

   usage: freezer session-show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               session_id

Show a single session

**Positional arguments:**

``session_id``
  ID of the session

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _freezer_session-update:

freezer session-update
----------------------

.. code-block:: console

   usage: freezer session-update [-h] session_id file

Update a session from a file

**Positional arguments:**

``session_id``
  ID of the session

``file``
  Path to json file with the session

**Optional arguments:**

``-h, --help``
  show this help message and exit

