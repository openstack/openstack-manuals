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

========================================================================
Container Infrastructure Management service (magnum) command-line client
========================================================================

The magnum client is the command-line interface (CLI) for
the Container Infrastructure Management service (magnum) API and its
extensions.

This chapter documents :command:`magnum` version ``2.3.1``.

For help on a specific :command:`magnum` command, enter:

.. code-block:: console

   $ magnum help COMMAND

.. _magnum_command_usage:

magnum usage
~~~~~~~~~~~~

.. code-block:: console

   usage: magnum [--version] [--debug] [--os-cache]
                 [--os-region-name <region-name>] [--os-auth-url <auth-auth-url>]
                 [--os-user-id <auth-user-id>] [--os-username <auth-username>]
                 [--os-user-domain-id <auth-user-domain-id>]
                 [--os-user-domain-name <auth-user-domain-name>]
                 [--os-project-id <auth-project-id>]
                 [--os-project-name <auth-project-name>]
                 [--os-project-domain-id <auth-project-domain-id>]
                 [--os-project-domain-name <auth-project-domain-name>]
                 [--os-token <auth-token>] [--os-password <auth-password>]
                 [--service-type <service-type>]
                 [--os-endpoint-type <os-endpoint-type>]
                 [--os-cloud <auth-cloud>]
                 [--magnum-api-version <magnum-api-ver>]
                 [--os-cacert <ca-certificate>]
                 [--os-endpoint-override <endpoint-override>] [--insecure]
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

``bay-config``
  Configure native client to access bay. You can source
  the output of this command to get the native client of
  the corresponding COE configured to access the bay.
  Example: eval $(magnum bay-config <bay-name>).

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
  Show details about the CA certificate for a bay or
  cluster.

``ca-sign``
  Generate the CA certificate for a bay or cluster.

``cluster-config``
  Configure native client to access cluster. You can
  source the output of this command to get the native
  client of the corresponding COE configured to access
  the cluster. Example: eval $(magnum cluster-config
  <cluster-name>).

``cluster-create``
  Create a cluster.

``cluster-delete``
  Delete specified cluster.

``cluster-list``
  Print a list of available clusters.

``cluster-show``
  Show details about the given cluster.

``cluster-update``
  Update information about the given cluster.

``cluster-template-create``
  Create a cluster template.

``cluster-template-delete``
  Delete specified cluster template.

``cluster-template-list``
  Print a list of cluster templates.

``cluster-template-show``
  Show details about the given cluster template.

``cluster-template-update``
  Updates one or more cluster template attributes.

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

``--os-auth-url <auth-auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-user-id <auth-user-id>``
  Defaults to ``env[OS_USER_ID]``.

``--os-username <auth-username>``
  Defaults to ``env[OS_USERNAME]``.

``--os-user-domain-id <auth-user-domain-id>``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-project-id <auth-project-id>``
  Defaults to ``env[OS_PROJECT_ID]``.

``--os-project-name <auth-project-name>``
  Defaults to ``env[OS_PROJECT_NAME]``.

``--os-project-domain-id <auth-project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <auth-project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-token <auth-token>``
  Defaults to ``env[OS_TOKEN]``.

``--os-password <auth-password>``
  Defaults to ``env[OS_PASSWORD]``.

``--service-type <service-type>``
  Defaults to container-infra for all actions.

``--os-endpoint-type <os-endpoint-type>``
  Defaults to ``env[OS_ENDPOINT_TYPE]``

``--os-cloud <auth-cloud>``
  Defaults to ``env[OS_CLOUD]``.

``--magnum-api-version <magnum-api-ver>``
  Accepts "api", defaults to ``env[MAGNUM_API_VERSION]``.

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS
  (https) server certificate. Defaults to
  ``env[OS_CACERT]``.

``--os-endpoint-override <endpoint-override>``
  Use this API endpoint instead of the Service Catalog.

``--insecure``
  Do not verify https connections

.. _magnum_bay-config:

magnum bay-config
-----------------

.. code-block:: console

   usage: magnum bay-config [--dir <dir>] [--force] <bay>

Configure native client to access bay. You can source the output of this
command to get the native client of the corresponding COE configured to access
the bay. Example: eval $(magnum bay-config <bay-name>).

**Positional arguments:**

``<bay>``
  ID or name of the bay to retrieve config.

**Optional arguments:**

``--dir <dir>``
  Directory to save the certificate and config files.

``--force``
  Overwrite files if existing.

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

   usage: magnum bay-show [--long] <bay>

Show details about the given bay.

**Positional arguments:**

``<bay>``
  ID or name of the bay to show.

**Optional arguments:**

``--long``
  Display extra associated Baymodel info.

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
                                 [--master-lb-enabled] [--floating-ip-enabled]

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

``--floating-ip-enabled``
  Indicates whether created bays should have a floating
  ipor not.

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

   usage: magnum ca-show [--bay <bay>] [--cluster <cluster>]

Show details about the CA certificate for a bay or cluster.

**Optional arguments:**

``--bay <bay>``
  ID or name of the bay.

``--cluster <cluster>``
  ID or name of the cluster.

.. _magnum_ca-sign:

magnum ca-sign
--------------

.. code-block:: console

   usage: magnum ca-sign [--csr <csr>] [--bay <bay>] [--cluster <cluster>]

Generate the CA certificate for a bay or cluster.

**Optional arguments:**

``--csr <csr>``
  File path of the csr file to send to Magnum to get
  signed.

``--bay <bay>``
  ID or name of the bay.

``--cluster <cluster>``
  ID or name of the cluster.

.. _magnum_cluster-config:

magnum cluster-config
---------------------

.. code-block:: console

   usage: magnum cluster-config [--dir <dir>] [--force] <cluster>

Configure native client to access cluster. You can source the output of this
command to get the native client of the corresponding COE configured to access
the cluster. Example: eval $(magnum cluster-config <cluster-name>).

**Positional arguments:**

``<cluster>``
  ID or name of the cluster to retrieve config.

**Optional arguments:**

``--dir <dir>``
  Directory to save the certificate and config files.

``--force``
  Overwrite files if existing.

.. _magnum_cluster-create:

magnum cluster-create
---------------------

.. code-block:: console

   usage: magnum cluster-create [--name <name>] --cluster-template
                                <cluster_template> [--node-count <node-count>]
                                [--master-count <master-count>]
                                [--discovery-url <discovery-url>]
                                [--timeout <timeout>]

Create a cluster.

**Optional arguments:**

``--name <name>``
  Name of the cluster to create.

``--cluster-template <cluster_template>``
  ID or name of the cluster template.

``--node-count <node-count>``
  The cluster node count.

``--master-count <master-count>``
  The number of master nodes for the cluster.

``--discovery-url <discovery-url>``
  Specifies custom discovery url for node discovery.

``--timeout <timeout>``
  The timeout for cluster creation in minutes. The
  default is 60 minutes.

.. _magnum_cluster-delete:

magnum cluster-delete
---------------------

.. code-block:: console

   usage: magnum cluster-delete <cluster> [<cluster> ...]

Delete specified cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the (cluster)s to delete.

.. _magnum_cluster-list:

magnum cluster-list
-------------------

.. code-block:: console

   usage: magnum cluster-list [--marker <marker>] [--limit <limit>]
                              [--sort-key <sort-key>] [--sort-dir <sort-dir>]
                              [--fields <fields>]

Print a list of available clusters.

**Optional arguments:**

``--marker <marker>``
  The last cluster UUID of the previous page; displays
  list of clusters after "marker".

``--limit <limit>``
  Maximum number of clusters to return.

``--sort-key <sort-key>``
  Column to sort results by.

``--sort-dir <sort-dir>``
  Direction to sort. "asc" or "desc".

``--fields <fields>``
  Comma-separated list of fields to display. Available
  fields: uuid, name, baymodel_id, stack_id, status,
  master_count, node_count, links,
  cluster_create_timeout

.. _magnum_cluster-show:

magnum cluster-show
-------------------

.. code-block:: console

   usage: magnum cluster-show [--long] <cluster>

Show details about the given cluster.

**Positional arguments:**

``<cluster>``
  ID or name of the cluster to show.

**Optional arguments:**

``--long``
  Display extra associated cluster template info.

.. _magnum_cluster-template-create:

magnum cluster-template-create
------------------------------

.. code-block:: console

   usage: magnum cluster-template-create [--name <name>] --image-id <image-id>
                                         --keypair-id <keypair-id>
                                         --external-network-id
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
                                         [--tls-disabled] [--public]
                                         [--registry-enabled]
                                         [--server-type <server-type>]
                                         [--master-lb-enabled]
                                         [--floating-ip-enabled]

Create a cluster template.

**Optional arguments:**

``--name <name>``
  Name of the cluster template to create.

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
  The DNS nameserver to use for this cluster template.

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
  associate with a cluster template. May be used
  multiple times.

``--tls-disabled``
  Disable TLS in the Bay.

``--public``
  Make cluster template public.

``--registry-enabled``
  Enable docker registry in the Bay

``--server-type <server-type>``
  Specify the server type to be used for example vm. For
  this release default server type will be vm.

``--master-lb-enabled``
  Indicates whether created bays should have a load
  balancer for master nodes or not.

``--floating-ip-enabled``
  Indicates whether created bays should have a floating
  ipor not.

.. _magnum_cluster-template-delete:

magnum cluster-template-delete
------------------------------

.. code-block:: console

   usage: magnum cluster-template-delete <cluster_templates>
                                         [<cluster_templates> ...]

Delete specified cluster template.

**Positional arguments:**

``<cluster_templates>``
  ID or name of the (cluster template)s to delete.

.. _magnum_cluster-template-list:

magnum cluster-template-list
----------------------------

.. code-block:: console

   usage: magnum cluster-template-list [--limit <limit>] [--sort-key <sort-key>]
                                       [--sort-dir <sort-dir>]
                                       [--fields <fields>]

Print a list of cluster templates.

**Optional arguments:**

``--limit <limit>``
  Maximum number of cluster templates to return

``--sort-key <sort-key>``
  Column to sort results by

``--sort-dir <sort-dir>``
  Direction to sort. "asc" or "desc".

``--fields <fields>``
  Comma-separated list of fields to display. Available
  fields: uuid, name, coe, image_id, public, link,
  apiserver_port, server_type, tls_disabled,
  registry_enabled

.. _magnum_cluster-template-show:

magnum cluster-template-show
----------------------------

.. code-block:: console

   usage: magnum cluster-template-show <cluster_template>

Show details about the given cluster template.

**Positional arguments:**

``<cluster_template>``
  ID or name of the cluster template to show.

.. _magnum_cluster-template-update:

magnum cluster-template-update
------------------------------

.. code-block:: console

   usage: magnum cluster-template-update <cluster_template> <op> <path=value>
                                         [<path=value> ...]

Updates one or more cluster template attributes.

**Positional arguments:**

``<cluster_template>``
  UUID or name of cluster template

``<op>``
  Operations: 'add', 'replace' or 'remove'

``<path=value>``
  Attributes to add/replace or remove (only PATH is
  necessary on remove)

.. _magnum_cluster-update:

magnum cluster-update
---------------------

.. code-block:: console

   usage: magnum cluster-update <cluster> <op> <path=value> [<path=value> ...]

Update information about the given cluster.

**Positional arguments:**

``<cluster>``
  UUID or name of cluster

``<op>``
  Operations: 'add', 'replace' or 'remove'

``<path=value>``
  Attributes to add/replace or remove (only PATH is necessary on
  remove)

.. _magnum_service-list:

magnum service-list
-------------------

.. code-block:: console

   usage: magnum service-list

Print a list of magnum services.

