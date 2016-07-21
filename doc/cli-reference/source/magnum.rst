.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

===============================================================
Container Infrastructure Management service command-line client
===============================================================

The magnum client is the command-line interface (CLI) for
the Container Infrastructure Management service API and its extensions.

This chapter documents :command:`magnum` version ``2.2.0``.

For help on a specific :command:`magnum` command, enter:

.. code-block:: console

   $ magnum help COMMAND

.. _magnum_command_usage:

magnum usage
~~~~~~~~~~~~

.. code-block:: console

   usage: magnum [--version] [--debug] [--os-cache]
                 [--os-region-name <region-name>] [--service-type <service-type>]
                 [--endpoint-type <endpoint-type>]
                 [--magnum-api-version <magnum-api-ver>]
                 [--os-cacert <ca-certificate>] [--bypass-url <bypass-url>]
                 [--insecure] [--os-auth-system <auth-system>]
                 [--os-username <username>] [--os-password <password>]
                 [--os-tenant-id <tenant-id>] [--os-tenant-name <tenant-name>]
                 [--os-project-id <project-id>]
                 [--os-project-name <project-name>]
                 [--os-user-domain-id <user-domain-id>]
                 [--os-user-domain-name <user-domain-name>]
                 [--os-project-domain-id <project-domain-id>]
                 [--os-project-domain-name <project-domain-name>]
                 [--os-token <token>] [--os-auth-url <auth-url>]
                 <subcommand> ...

**Subcommands:**

``baymodel-create``
  Create a baymodel.

``baymodel-delete``
  Delete specified baymodel.

``baymodel-list``
  Print a list of baymodels.

``baymodel-show``
  Show details about the given baymodel.

``baymodel-update``
  Updates one or more baymodel attributes.

``bay-create``
  Create a bay.

``bay-delete``
  Delete specified bay.

``bay-list``
  Print a list of available bays.

``bay-show``
  Show details about the given bay.

``bay-update``
  Update information about the given bay.

``ca-show``
  Show details about the CA certificate for a bay.

``ca-sign``
  Generate the CA certificate for a bay.

``service-list``
  Print a list of magnum services.

``bash-completion``
  Prints arguments for bash-completion. Prints all of
  the commands and options to stdout so that the
  magnum.bash_completion script doesn't have to hard
  code them.

``help``
  Display help about this program or one of its
  subcommands.

.. _magnum_command_options:

magnum optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``--debug``
  Print debugging output.

``--os-cache``
  Use the auth token cache. Defaults to False if
  ``env[OS_CACHE]`` is not set.

``--os-region-name <region-name>``
  Region name. Default= ``env[OS_REGION_NAME]``.

``--service-type <service-type>``
  Defaults to container for all actions.

``--endpoint-type <endpoint-type>``
  Defaults to ``env[OS_ENDPOINT_TYPE]`` or publicURL.

``--magnum-api-version <magnum-api-ver>``
  Accepts "api", defaults to ``env[MAGNUM_API_VERSION]``.

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS
  (https) server certificate. Defaults to
  ``env[OS_CACERT]``.

``--bypass-url <bypass-url>``
  Use this API endpoint instead of the Service Catalog.

``--insecure``
  Do not verify https connections


magnum.. _magnum_common_auth:

magnum common authentication arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``--os-auth-system <auth-system>``
  Defaults to ``env[OS_AUTH_SYSTEM]``.

``--os-username <username>``
  Defaults to ``env[OS_USERNAME]``.

``--os-password <password>``
  Defaults to ``env[OS_PASSWORD]``.

``--os-tenant-id <tenant-id>``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-tenant-name <tenant-name>``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-project-id <project-id>``
  Defaults to ``env[OS_PROJECT_ID]``.

``--os-project-name <project-name>``
  Defaults to ``env[OS_PROJECT_NAME]``.

``--os-user-domain-id <user-domain-id>``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <user-domain-name>``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-domain-id <project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-token <token>``
  Defaults to ``env[OS_TOKEN]``.

``--os-auth-url <auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

.. _magnum_bay-create:

magnum bay-create
-----------------

.. code-block:: console

   usage: magnum bay-create [--name <name>] --baymodel <baymodel>
                            [--node-count <node-count>]
                            [--master-count <master-count>]
                            [--discovery-url <discovery-url>]
                            [--timeout <timeout>]

Create a bay.

**Optional arguments:**

``--name <name>``
  Name of the bay to create.

``--baymodel <baymodel>``
  ID or name of the baymodel.

``--node-count <node-count>``
  The bay node count.

``--master-count <master-count>``
  The number of master nodes for the bay.

``--discovery-url <discovery-url>``
  Specifies custom discovery url for node discovery.

``--timeout <timeout>``
  The timeout for bay creation in minutes. The default
  is 60 minutes.

.. _magnum_bay-delete:

magnum bay-delete
-----------------

.. code-block:: console

   usage: magnum bay-delete <bay> [<bay> ...]

Delete specified bay.

**Positional arguments:**

``<bay>``
  ID or name of the (bay)s to delete.

.. _magnum_bay-list:

magnum bay-list
---------------

.. code-block:: console

   usage: magnum bay-list [--marker <marker>] [--limit <limit>]
                          [--sort-key <sort-key>] [--sort-dir <sort-dir>]
                          [--fields <fields>]

Print a list of available bays.

**Optional arguments:**

``--marker <marker>``
  The last bay UUID of the previous page; displays list
  of bays after "marker".

``--limit <limit>``
  Maximum number of bays to return.

``--sort-key <sort-key>``
  Column to sort results by.

``--sort-dir <sort-dir>``
  Direction to sort. "asc" or "desc".

``--fields <fields>``
  Comma-separated list of fields to display. Available
  fields: uuid, name, baymodel_id, stack_id, status,
  master_count, node_count, links, bay_create_timeout

.. _magnum_bay-show:

magnum bay-show
---------------

.. code-block:: console

   usage: magnum bay-show <bay>

Show details about the given bay.

**Positional arguments:**

``<bay>``
  ID or name of the bay to show.

.. _magnum_bay-update:

magnum bay-update
-----------------

.. code-block:: console

   usage: magnum bay-update <bay> <op> <path=value> [<path=value> ...]

Update information about the given bay.

**Positional arguments:**

``<bay>``
  UUID or name of bay

``<op>``
  Operations: 'add', 'replace' or 'remove'

``<path=value>``
  Attributes to add/replace or remove (only PATH is necessary on
  remove)

.. _magnum_baymodel-create:

magnum baymodel-create
----------------------

.. code-block:: console

   usage: magnum baymodel-create [--name <name>] --image-id <image-id>
                                 --keypair-id <keypair-id> --external-network-id
                                 <external-network-id> --coe <coe>
                                 [--fixed-network <fixed-network>]
                                 [--fixed-subnet <fixed-subnet>]
                                 [--network-driver <network-driver>]
                                 [--volume-driver <volume-driver>]
                                 [--dns-nameserver <dns-nameserver>]
                                 [--flavor-id <flavor-id>]
                                 [--master-flavor-id <master-flavor-id>]
                                 [--docker-volume-size <docker-volume-size>]
                                 [--docker-storage-driver <docker-storage-driver>]
                                 [--http-proxy <http-proxy>]
                                 [--https-proxy <https-proxy>]
                                 [--no-proxy <no-proxy>]
                                 [--labels <KEY1=VALUE1,KEY2=VALUE2;KEY3=VALUE3...>]
                                 [--tls-disabled] [--public] [--registry-enabled]
                                 [--server-type <server-type>]
                                 [--master-lb-enabled]

Create a baymodel.

**Optional arguments:**

``--name <name>``
  Name of the baymodel to create.

``--image-id <image-id>``
  The name or UUID of the base image to customize for
  the bay.

``--keypair-id <keypair-id>``
  The name or UUID of the SSH keypair to load into the
  Bay nodes.

``--external-network-id <external-network-id>``
  The external Neutron network ID to connect to this bay
  model.

``--coe <coe>``
  Specify the Container Orchestration Engine to use.

``--fixed-network <fixed-network>``
  The private Neutron network name to connect to this
  bay model.

``--fixed-subnet <fixed-subnet>``
  The private Neutron subnet name to connect to bay.

``--network-driver <network-driver>``
  The network driver name for instantiating container
  networks.

``--volume-driver <volume-driver>``
  The volume driver name for instantiating container
  volume.

``--dns-nameserver <dns-nameserver>``
  The DNS nameserver to use for this baymodel.

``--flavor-id <flavor-id>``
  The nova flavor id to use when launching the bay.

``--master-flavor-id <master-flavor-id>``
  The nova flavor id to use when launching the master
  node of the bay.

``--docker-volume-size <docker-volume-size>``
  Specify the number of size in GB for the docker volume
  to use.

``--docker-storage-driver <docker-storage-driver>``
  Select a docker storage driver. Supported:
  devicemapper, overlay. Default: devicemapper

``--http-proxy <http-proxy>``
  The http_proxy address to use for nodes in bay.

``--https-proxy <https-proxy>``
  The https_proxy address to use for nodes in bay.

``--no-proxy <no-proxy>``
  The no_proxy address to use for nodes in bay.

``--labels <KEY1=VALUE1,KEY2=VALUE2;KEY3=VALUE3...>``
  Arbitrary labels in the form of key=value pairs to
  associate with a baymodel. May be used multiple times.

``--tls-disabled``
  Disable TLS in the Bay.

``--public``
  Make baymodel public.

``--registry-enabled``
  Enable docker registry in the Bay

``--server-type <server-type>``
  Specify the server type to be used for example vm. For
  this release default server type will be vm.

``--master-lb-enabled``
  Indicates whether created bays should have a load
  balancer for master nodes or not.

.. _magnum_baymodel-delete:

magnum baymodel-delete
----------------------

.. code-block:: console

   usage: magnum baymodel-delete <baymodels> [<baymodels> ...]

Delete specified baymodel.

**Positional arguments:**

``<baymodels>``
  ID or name of the (baymodel)s to delete.

.. _magnum_baymodel-list:

magnum baymodel-list
--------------------

.. code-block:: console

   usage: magnum baymodel-list [--limit <limit>] [--sort-key <sort-key>]
                               [--sort-dir <sort-dir>] [--fields <fields>]

Print a list of baymodels.

**Optional arguments:**

``--limit <limit>``
  Maximum number of baymodels to return

``--sort-key <sort-key>``
  Column to sort results by

``--sort-dir <sort-dir>``
  Direction to sort. "asc" or "desc".

``--fields <fields>``
  Comma-separated list of fields to display. Available
  fields: uuid, name, coe, image_id, public, link,
  apiserver_port, server_type, tls_disabled,
  registry_enabled

.. _magnum_baymodel-show:

magnum baymodel-show
--------------------

.. code-block:: console

   usage: magnum baymodel-show <baymodel>

Show details about the given baymodel.

**Positional arguments:**

``<baymodel>``
  ID or name of the baymodel to show.

.. _magnum_baymodel-update:

magnum baymodel-update
----------------------

.. code-block:: console

   usage: magnum baymodel-update <baymodel> <op> <path=value> [<path=value> ...]

Updates one or more baymodel attributes.

**Positional arguments:**

``<baymodel>``
  UUID or name of baymodel

``<op>``
  Operations: 'add', 'replace' or 'remove'

``<path=value>``
  Attributes to add/replace or remove (only PATH is necessary on
  remove)

.. _magnum_ca-show:

magnum ca-show
--------------

.. code-block:: console

   usage: magnum ca-show --bay <bay>

Show details about the CA certificate for a bay.

**Optional arguments:**

``--bay <bay>``
  ID or name of the bay.

.. _magnum_ca-sign:

magnum ca-sign
--------------

.. code-block:: console

   usage: magnum ca-sign [--csr <csr>] --bay <bay>

Generate the CA certificate for a bay.

**Optional arguments:**

``--csr <csr>``
  File path of the csr file to send to Magnum to get signed.

``--bay <bay>``
  ID or name of the bay.

.. _magnum_service-list:

magnum service-list
-------------------

.. code-block:: console

   usage: magnum service-list

Print a list of magnum services.

