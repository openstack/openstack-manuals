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

===============================================================
RCA (Root Cause Analysis) service (vitrage) command-line client
===============================================================

The vitrage client is the command-line interface (CLI) for
the RCA (Root Cause Analysis) service (vitrage) API and its extensions.

This chapter documents :command:`vitrage` version ``1.2.0``.

For help on a specific :command:`vitrage` command, enter:

.. code-block:: console

   $ vitrage help COMMAND

.. _vitrage_command_usage:

vitrage usage
~~~~~~~~~~~~~

.. code-block:: console

   usage: vitrage [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                  [--os-region-name <auth-region-name>]
                  [--os-interface <interface>] [--insecure]
                  [--os-cacert <ca-certificate>] [--os-cert <certificate>]
                  [--os-key <key>] [--timeout <seconds>] [--os-auth-type <name>]
                  [--os-auth-url OS_AUTH_URL] [--os-domain-id OS_DOMAIN_ID]
                  [--os-domain-name OS_DOMAIN_NAME]
                  [--os-project-id OS_PROJECT_ID]
                  [--os-project-name OS_PROJECT_NAME]
                  [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                  [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                  [--os-trust-id OS_TRUST_ID]
                  [--os-default-domain-id OS_DEFAULT_DOMAIN_ID]
                  [--os-default-domain-name OS_DEFAULT_DOMAIN_NAME]
                  [--os-user-id OS_USER_ID] [--os-username OS_USERNAME]
                  [--os-user-domain-id OS_USER_DOMAIN_ID]
                  [--os-user-domain-name OS_USER_DOMAIN_NAME]
                  [--os-password OS_PASSWORD]
                  [--vitrage-api-version VITRAGE_API_VERSION]
                  [--endpoint ENDPOINT]

.. _vitrage_command_options:

vitrage optional arguments
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

``--os-region-name <auth-region-name>``
  Authentication region name (Env: OS_REGION_NAME)

``--os-interface <interface>``
  Select an interface type. Valid interface types:
  [admin, public, internal]. (Env: OS_INTERFACE)

``--os-auth-type <name>, --os-auth-plugin <name>``
  Authentication type to use

``--vitrage-api-version VITRAGE_API_VERSION``
  Defaults to ``env[VITRAGE_API_VERSION]`` or 1.

``--endpoint ENDPOINT``
  Vitrage endpoint (Env: VITRAGE_ENDPOINT)

.. _vitrage_alarm_list:

vitrage alarm list
------------------

.. code-block:: console

   usage: vitrage alarm list [-h] [-f {csv,html,json,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--print-empty]
                             [--noindent] [--quote {all,minimal,none,nonnumeric}]
                             [--all-tenants]
                             [<vitrage id>]

List alarms on entity

**Positional arguments:**

``<vitrage id>``
  Vitrage id of the affected resource

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-tenants``
  Shows alarms of all the tenants in the entity graph

.. _vitrage_event_post:

vitrage event post
------------------

.. code-block:: console

   usage: vitrage event post [-h] [--type TYPE] [--time TIME] [--details DETAILS]

Show the event of the system

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type TYPE``
  The type of the event

``--time TIME``
  The
  timestamp
  of
  the
  event
  in
  ISO
  8601
  format:
  YYYY-MM-DDTHH:MM:SS.mmmmmm.
  If
  not
  specified,
  the
  current
  time
  is
  used

``--details DETAILS``
  A json string with the event details

.. _vitrage_rca_show:

vitrage rca show
----------------

.. code-block:: console

   usage: vitrage rca show [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--print-empty]
                           [--noindent] [--prefix PREFIX] [--all-tenants]
                           alarm_vitrage_id

Show an RCA

**Positional arguments:**

``alarm_vitrage_id``
  ID of an alarm

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-tenants``
  Shows alarms of all the tenants for the RCA

.. _vitrage_resource_list:

vitrage resource list
---------------------

.. code-block:: console

   usage: vitrage resource list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--type <resource type>] [--all-tenants]

List resources

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <resource type>``
  Type of resource

``--all-tenants``
  Shows resources of all the tenants

.. _vitrage_resource_show:

vitrage resource show
---------------------

.. code-block:: console

   usage: vitrage resource show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                vitrage_id

Show a resource

**Positional arguments:**

``vitrage_id``
  vitrage_id of a resource

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _vitrage_template_list:

vitrage template list
---------------------

.. code-block:: console

   usage: vitrage template list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

Template list

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _vitrage_template_show:

vitrage template show
---------------------

.. code-block:: console

   usage: vitrage template show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                uuid

Template show

**Positional arguments:**

``uuid``
  Template UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _vitrage_template_validate:

vitrage template validate
-------------------------

.. code-block:: console

   usage: vitrage template validate [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX] [--path PATH]


**Optional arguments:**

``-h, --help``
  show this help message and exit

``--path PATH``
  full path for template file or templates dir)

.. _vitrage_topology_show:

vitrage topology show
---------------------

.. code-block:: console

   usage: vitrage topology show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                [--filter <query>] [--limit <depth>]
                                [--root ROOT] [--graph-type {tree,graph}]
                                [--all-tenants]

Show the topology of the system

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--filter <query>``
  query for the graph)

``--limit <depth>``
  the depth of the topology graph

``--root ROOT``
  the root of the topology graph

``--graph-type {tree,graph}``
  graph type. Valid graph types: [tree, graph]

``--all-tenants``
  Shows entities of all the tenants in the entity graph

