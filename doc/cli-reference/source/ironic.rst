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
Bare Metal service (ironic) command-line client
===============================================

The ironic client is the command-line interface (CLI) for
the Bare Metal service (ironic) API and its extensions.

This chapter documents :command:`ironic` version ``1.12.0``.

For help on a specific :command:`ironic` command, enter:

.. code-block:: console

   $ ironic help COMMAND

.. _ironic_command_usage:

ironic usage
~~~~~~~~~~~~

.. code-block:: console

   usage: ironic [--insecure] [--os-cacert <ca-certificate>]
                 [--os-cert <certificate>] [--os-key <key>] [--timeout <seconds>]
                 [--version] [--debug] [--json] [-v] [--cert-file OS_CERT]
                 [--key-file OS_KEY] [--ca-file OS_CACERT]
                 [--os-username OS_USERNAME] [--os-password OS_PASSWORD]
                 [--os-tenant-id OS_TENANT_ID] [--os-tenant-name OS_TENANT_NAME]
                 [--os-auth-url OS_AUTH_URL] [--os-region-name OS_REGION_NAME]
                 [--os-auth-token OS_AUTH_TOKEN] [--ironic-url IRONIC_URL]
                 [--ironic-api-version IRONIC_API_VERSION]
                 [--os-service-type OS_SERVICE_TYPE] [--os-endpoint IRONIC_URL]
                 [--os-endpoint-type OS_ENDPOINT_TYPE]
                 [--os-user-domain-id OS_USER_DOMAIN_ID]
                 [--os-user-domain-name OS_USER_DOMAIN_NAME]
                 [--os-project-id OS_PROJECT_ID]
                 [--os-project-name OS_PROJECT_NAME]
                 [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                 [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                 [--max-retries MAX_RETRIES] [--retry-interval RETRY_INTERVAL]
                 <subcommand> ...

**Subcommands:**

``chassis-create``
  Create a new chassis.

``chassis-delete``
  Delete a chassis.

``chassis-list``
  List the chassis.

``chassis-node-list``
  List the nodes contained in a chassis.

``chassis-show``
  Show detailed information about a chassis.

``chassis-update``
  Update information about a chassis.

``node-create``
  Register a new node with the Ironic service.

``node-delete``
  Unregister node(s) from the Ironic service.

``node-get-boot-device``
  Get the current boot device for a node.

``node-get-console``
  Get the connection information for a node's console,
  if enabled.

``node-get-supported-boot-devices``
  Get the supported boot devices for a node.

``node-get-vendor-passthru-methods``
  Get the vendor passthru methods for a node.

``node-inject-nmi``
  Inject NMI to a node.

``node-list``
  List the nodes which are registered with the Ironic
  service.

``node-port-list``
  List the ports associated with a node.

``node-set-boot-device``
  Set the boot device for a node.

``node-set-console-mode``
  Enable or disable serial console access for a node.

``node-set-maintenance``
  Enable or disable maintenance mode for a node.

``node-set-power-state``
  Power a node on or off or reboot.

``node-set-provision-state``
  Initiate a provisioning state change for a node.

``node-set-target-raid-config``
  Set target RAID config on a node.

``node-show``
  Show detailed information about a node.

``node-show-states``
  Show information about the node's states.

``node-update``
  Update information about a registered node.

``node-validate``
  Validate a node's driver interfaces.

``node-vendor-passthru``
  Call a vendor-passthru extension for a node.

``node-vif-attach``
  Attach VIF to a given node.

``node-vif-detach``
  Detach VIF from a given node.

``node-vif-list``
  List VIFs for a given node.

``port-create``
  Create a new port.

``port-delete``
  Delete a port.

``port-list``
  List the ports.

``port-show``
  Show detailed information about a port.

``port-update``
  Update information about a port.

``portgroup-create``
  Create a new portgroup.

``portgroup-delete``
  Delete a portgroup.

``portgroup-list``
  List the portgroups.

``portgroup-port-list``
  List the ports associated with a portgroup.

``portgroup-show``
  Show detailed information about a portgroup.

``portgroup-update``
  Update information about a portgroup.

``driver-get-vendor-passthru-methods``
  Get the vendor passthru methods for a driver.

``driver-list``
  List the enabled drivers.

``driver-properties``
  Get properties of a driver.

``driver-raid-logical-disk-properties``
  Get RAID logical disk properties for a driver.

``driver-show``
  Show information about a driver.

``driver-vendor-passthru``
  Call a vendor-passthru extension for a driver.

``create``
  Create baremetal resources (chassis, nodes, port
  groups and ports).

``bash-completion``
  Prints all of the commands and options for bash-completion.

``help``
  Display help about this program or one of its
  subcommands.

.. _ironic_command_options:

ironic optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``--debug``
  Defaults to ``env[IRONICCLIENT_DEBUG]``

``--json``
  Print JSON response without formatting.

``-v, --verbose``
  Print more verbose output

``--cert-file OS_CERT``
  **DEPRECATED!** Use --os-cert.

``--key-file OS_KEY``
  **DEPRECATED!** Use --os-key.

``--ca-file OS_CACERT``
  **DEPRECATED!** Use --os-cacert.

``--os-username OS_USERNAME``
  Defaults to ``env[OS_USERNAME]``

``--os-password OS_PASSWORD``
  Defaults to ``env[OS_PASSWORD]``

``--os-tenant-id OS_TENANT_ID``
  Defaults to ``env[OS_TENANT_ID]``

``--os-tenant-name OS_TENANT_NAME``
  Defaults to ``env[OS_TENANT_NAME]``

``--os-auth-url OS_AUTH_URL``
  Defaults to ``env[OS_AUTH_URL]``

``--os-region-name OS_REGION_NAME``
  Defaults to ``env[OS_REGION_NAME]``

``--os-auth-token OS_AUTH_TOKEN``
  Defaults to ``env[OS_AUTH_TOKEN]``

``--ironic-url IRONIC_URL``
  Defaults to ``env[IRONIC_URL]``

``--ironic-api-version IRONIC_API_VERSION``
  Accepts 1.x (where "x" is microversion) or "latest",
  Defaults to ``env[IRONIC_API_VERSION]`` or 1

``--os-service-type OS_SERVICE_TYPE``
  Defaults to ``env[OS_SERVICE_TYPE]`` or "baremetal"

``--os-endpoint IRONIC_URL``
  Specify an endpoint to use instead of retrieving one
  from the service catalog (via authentication).
  Defaults to ``env[OS_SERVICE_ENDPOINT]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]`` or "publicURL"

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

``--max-retries MAX_RETRIES``
  Maximum number of retries in case of conflict error
  (HTTP 409). Defaults to ``env[IRONIC_MAX_RETRIES]`` or 5.
  Use 0 to disable retrying.

``--retry-interval RETRY_INTERVAL``
  Amount of time (in seconds) between retries in case of
  conflict error (HTTP 409). Defaults to
  ``env[IRONIC_RETRY_INTERVAL]`` or 2.

.. _ironic_chassis-create:

ironic chassis-create
---------------------

.. code-block:: console

   usage: ironic chassis-create [-d <description>] [-e <key=value>] [-u <uuid>]

Create a new chassis.

**Optional arguments:**

``-d <description>, --description <description>``
  Description of the chassis.

``-e <key=value>, --extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``-u <uuid>, --uuid <uuid>``
  UUID of the chassis.

.. _ironic_chassis-delete:

ironic chassis-delete
---------------------

.. code-block:: console

   usage: ironic chassis-delete <chassis> [<chassis> ...]

Delete a chassis.

**Positional arguments:**

``<chassis>``
  UUID of the chassis.

.. _ironic_chassis-list:

ironic chassis-list
-------------------

.. code-block:: console

   usage: ironic chassis-list [--detail] [--limit <limit>] [--marker <chassis>]
                              [--sort-key <field>] [--sort-dir <direction>]
                              [--fields <field> [<field> ...]]

List the chassis.

**Optional arguments:**

``--detail``
  Show detailed information about the chassis.

``--limit <limit>``
  Maximum number of chassis to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <chassis>``
  Chassis UUID (for example, of the last chassis in the
  list from a previous request). Returns the list of
  chassis after this UUID.

``--sort-key <field>``
  Chassis field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more chassis fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

.. _ironic_chassis-node-list:

ironic chassis-node-list
------------------------

.. code-block:: console

   usage: ironic chassis-node-list [--detail] [--limit <limit>] [--marker <node>]
                                   [--sort-key <field>] [--sort-dir <direction>]
                                   [--fields <field> [<field> ...]]
                                   [--maintenance <boolean>]
                                   [--associated <boolean>]
                                   [--provision-state <provision-state>]
                                   <chassis>

List the nodes contained in a chassis.

**Positional arguments:**

``<chassis>``
  UUID of the chassis.

**Optional arguments:**

``--detail``
  Show detailed information about the nodes.

``--limit <limit>``
  Maximum number of nodes to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <node>``
  Node UUID (for example, of the last node in the list
  from a previous request). Returns the list of nodes
  after this UUID.

``--sort-key <field>``
  Node field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more node fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

``--maintenance <boolean>``
  List nodes in maintenance mode: 'true' or 'false'.

``--associated <boolean>``
  List nodes by instance association: 'true' or 'false'.

``--provision-state <provision-state>``
  List nodes in specified provision state.

.. _ironic_chassis-show:

ironic chassis-show
-------------------

.. code-block:: console

   usage: ironic chassis-show [--fields <field> [<field> ...]] <chassis>

Show detailed information about a chassis.

**Positional arguments:**

``<chassis>``
  UUID of the chassis.

**Optional arguments:**

``--fields <field> [<field> ...]``
  One or more chassis fields. Only these fields will be
  fetched from the server.

.. _ironic_chassis-update:

ironic chassis-update
---------------------

.. code-block:: console

   usage: ironic chassis-update <chassis> <op> <path=value> [<path=value> ...]

Update information about a chassis.

**Positional arguments:**

``<chassis>``
  UUID of the chassis.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is necessary.

.. _ironic_create:

ironic create
-------------

.. code-block:: console

   usage: ironic create <file> [<file> ...]

Create baremetal resources (chassis, nodes, port groups and ports). The
resources may be described in one or more JSON or YAML files. If any file
cannot be validated, no resources are created. An attempt is made to create
all the resources; those that could not be created are skipped (with a
corresponding error message).

**Positional arguments:**

``<file>``
  File (.yaml or .json) containing descriptions of the resources to
  create. Can be specified multiple times.

.. _ironic_driver-get-vendor-passthru-methods:

ironic driver-get-vendor-passthru-methods
-----------------------------------------

.. code-block:: console

   usage: ironic driver-get-vendor-passthru-methods <driver>

Get the vendor passthru methods for a driver.

**Positional arguments:**

``<driver>``
  Name of the driver.

.. _ironic_driver-list:

ironic driver-list
------------------

.. code-block:: console

   usage: ironic driver-list

List the enabled drivers.

.. _ironic_driver-properties:

ironic driver-properties
------------------------

.. code-block:: console

   usage: ironic driver-properties [--wrap <integer>] <driver>

Get properties of a driver.

**Positional arguments:**

``<driver>``
  Name of the driver.

**Optional arguments:**

``--wrap <integer>``
  Wrap the output to a specified length. Positive number can
  realize wrap functionality. 0 is default for disabled.

.. _ironic_driver-raid-logical-disk-properties:

ironic driver-raid-logical-disk-properties
------------------------------------------

.. code-block:: console

   usage: ironic driver-raid-logical-disk-properties [--wrap <integer>] <driver>

Get RAID logical disk properties for a driver.

**Positional arguments:**

``<driver>``
  Name of the driver.

**Optional arguments:**

``--wrap <integer>``
  Wrap the output to a specified length. Positive number can
  realize wrap functionality. 0 is default for disabled.

.. _ironic_driver-show:

ironic driver-show
------------------

.. code-block:: console

   usage: ironic driver-show <driver>

Show information about a driver.

**Positional arguments:**

``<driver>``
  Name of the driver.

.. _ironic_driver-vendor-passthru:

ironic driver-vendor-passthru
-----------------------------

.. code-block:: console

   usage: ironic driver-vendor-passthru [--http-method <http-method>]
                                        <driver> <method>
                                        [<arg=value> [<arg=value> ...]]

Call a vendor-passthru extension for a driver.

**Positional arguments:**

``<driver>``
  Name of the driver.

``<method>``
  Vendor-passthru method to be called.

``<arg=value>``
  Argument to be passed to the vendor-passthru method.
  Can be specified multiple times.

**Optional arguments:**

``--http-method <http-method>``
  The HTTP method to use in the request. Valid HTTP
  methods are: POST, PUT, GET, DELETE, PATCH. Defaults
  to 'POST'.

.. _ironic_node-create:

ironic node-create
------------------

.. code-block:: console

   usage: ironic node-create [-c <chassis>] -d <driver> [-i <key=value>]
                             [-p <key=value>] [-e <key=value>] [-u <uuid>]
                             [-n <name>] [--boot-interface <boot-interface>]
                             [--console-interface <console-interface>]
                             [--deploy-interface <deploy-interface>]
                             [--inspect-interface <inspect-interface>]
                             [--management-interface <management-interface>]
                             [--network-interface <network_interface>]
                             [--power-interface <power-interface>]
                             [--raid-interface <raid-interface>]
                             [--vendor-interface <vendor-interface>]
                             [--resource-class <resource_class>]

Register a new node with the Ironic service.

**Optional arguments:**

``-c <chassis>, --chassis <chassis>``
  UUID of the chassis that this node belongs to.

``-i <key=value>, --driver-info <key=value>``
  Key/value pair used by the driver, such as out-of-band
  management credentials. Can be specified multiple
  times.

``-p <key=value>, --properties <key=value>``
  Key/value pair describing the physical characteristics
  of the node. This is exported to Nova and used by the
  scheduler. Can be specified multiple times.

``-e <key=value>, --extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``-u <uuid>, --uuid <uuid>``
  Unique UUID for the node.

``-n <name>, --name <name>``
  Unique name for the node.

``--boot-interface <boot-interface>``
  Boot interface used by the node's driver. This is only
  applicable when the specified --driver is a hardware
  type.

``--console-interface <console-interface>``
  Console interface used by the node's driver. This is
  only applicable when the specified --driver is a
  hardware type.

``--deploy-interface <deploy-interface>``
  Deploy interface used by the node's driver. This is
  only applicable when the specified --driver is a
  hardware type.

``--inspect-interface <inspect-interface>``
  Inspect interface used by the node's driver. This is
  only applicable when the specified --driver is a
  hardware type.

``--management-interface <management-interface>``
  Management interface used by the node's driver. This
  is only applicable when the specified --driver is a
  hardware type.

``--network-interface <network_interface>``
  Network interface used for switching node to
  cleaning/provisioning networks.

``--power-interface <power-interface>``
  Power interface used by the node's driver. This is
  only applicable when the specified --driver is a
  hardware type.

``--raid-interface <raid-interface>``
  RAID interface used by the node's driver. This is only
  applicable when the specified --driver is a hardware
  type.

``--vendor-interface <vendor-interface>``
  Vendor interface used by the node's driver. This is
  only applicable when the specified --driver is a
  hardware type.

``--resource-class <resource_class>``
  Resource class for classifying or grouping nodes.
  Used, for example, to classify nodes in Nova's
  placement engine.

**Required arguments:**

``-d <driver>, --driver <driver>``
  Driver used to control the node.

.. _ironic_node-delete:

ironic node-delete
------------------

.. code-block:: console

   usage: ironic node-delete <node> [<node> ...]

Unregister node(s) from the Ironic service. Returns errors for any nodes that
could not be unregistered.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-get-boot-device:

ironic node-get-boot-device
---------------------------

.. code-block:: console

   usage: ironic node-get-boot-device <node>

Get the current boot device for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-get-console:

ironic node-get-console
-----------------------

.. code-block:: console

   usage: ironic node-get-console <node>

Get the connection information for a node's console, if enabled.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-get-supported-boot-devices:

ironic node-get-supported-boot-devices
--------------------------------------

.. code-block:: console

   usage: ironic node-get-supported-boot-devices <node>

Get the supported boot devices for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-get-vendor-passthru-methods:

ironic node-get-vendor-passthru-methods
---------------------------------------

.. code-block:: console

   usage: ironic node-get-vendor-passthru-methods <node>

Get the vendor passthru methods for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-inject-nmi:

ironic node-inject-nmi
----------------------

.. code-block:: console

   usage: ironic node-inject-nmi <node>

Inject NMI to a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-list:

ironic node-list
----------------

.. code-block:: console

   usage: ironic node-list [--limit <limit>] [--marker <node>]
                           [--sort-key <field>] [--sort-dir <direction>]
                           [--maintenance <boolean>] [--associated <boolean>]
                           [--provision-state <provision-state>]
                           [--driver <driver>] [--detail]
                           [--fields <field> [<field> ...]]
                           [--resource-class <resource class>]

List the nodes which are registered with the Ironic service.

**Optional arguments:**

``--limit <limit>``
  Maximum number of nodes to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <node>``
  Node UUID (for example, of the last node in the list
  from a previous request). Returns the list of nodes
  after this UUID.

``--sort-key <field>``
  Node field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--maintenance <boolean>``
  List nodes in maintenance mode: 'true' or 'false'.

``--associated <boolean>``
  List nodes by instance association: 'true' or 'false'.

``--provision-state <provision-state>``
  List nodes in specified provision state.

``--driver <driver>``
  List nodes using specified driver.

``--detail``
  Show detailed information about the nodes.

``--fields <field> [<field> ...]``
  One or more node fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

``--resource-class <resource class>``
  List nodes using specified resource class.

.. _ironic_node-port-list:

ironic node-port-list
---------------------

.. code-block:: console

   usage: ironic node-port-list [--detail] [--limit <limit>] [--marker <port>]
                                [--sort-key <field>] [--sort-dir <direction>]
                                [--fields <field> [<field> ...]]
                                <node>

List the ports associated with a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``--detail``
  Show detailed information about the ports.

``--limit <limit>``
  Maximum number of ports to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <port>``
  Port UUID (for example, of the last port in the list
  from a previous request). Returns the list of ports
  after this UUID.

``--sort-key <field>``
  Port field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more port fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

.. _ironic_node-set-boot-device:

ironic node-set-boot-device
---------------------------

.. code-block:: console

   usage: ironic node-set-boot-device [--persistent] <node> <boot-device>

Set the boot device for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<boot-device>``
  One of pxe, disk, cdrom, bios, safe.

**Optional arguments:**

``--persistent``
  Make changes persistent for all future boots.

.. _ironic_node-set-console-mode:

ironic node-set-console-mode
----------------------------

.. code-block:: console

   usage: ironic node-set-console-mode <node> <enabled>

Enable or disable serial console access for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<enabled>``
  Enable or disable console access for a node: 'true' or 'false'.

.. _ironic_node-set-maintenance:

ironic node-set-maintenance
---------------------------

.. code-block:: console

   usage: ironic node-set-maintenance [--reason <reason>]
                                      <node> <maintenance-mode>

Enable or disable maintenance mode for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<maintenance-mode>``
  'true' or 'false'; 'on' or 'off'.

**Optional arguments:**

``--reason <reason>``
  Reason for setting maintenance mode to 'true' or 'on';
  not valid when setting to 'false' or 'off'.

.. _ironic_node-set-power-state:

ironic node-set-power-state
---------------------------

.. code-block:: console

   usage: ironic node-set-power-state [--soft] [--power-timeout <power-timeout>]
                                      <node> <power-state>

Power a node on or off or reboot.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<power-state>``
  'on', 'off', or 'reboot'.

**Optional arguments:**

``--soft``
  Gracefully change the power state. Only valid for
  'off' and 'reboot' power states.

``--power-timeout <power-timeout>``
  Timeout (in seconds, positive integer) to wait for the
  target power state before erroring out.

.. _ironic_node-set-provision-state:

ironic node-set-provision-state
-------------------------------

.. code-block:: console

   usage: ironic node-set-provision-state [--config-drive <config-drive>]
                                          [--clean-steps <clean-steps>]
                                          [--wait [WAIT_TIMEOUT]]
                                          <node> <provision-state>

Initiate a provisioning state change for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<provision-state>``
  Supported states: deleted, provide, clean, manage,
  active, rebuild, inspect, abort, adopt.

**Optional arguments:**

``--config-drive <config-drive>``
  A gzipped, base64-encoded configuration drive string
  OR the path to the configuration drive file OR the
  path to a directory containing the config drive files.
  In case it's a directory, a config drive will be
  generated from it. This argument is only valid when
  setting provision-state to 'active'.

``--clean-steps <clean-steps>``
  The clean steps in JSON format. May be the path to a
  file containing the clean steps; OR '-', with the
  clean steps being read from standard input; OR a
  string. The value should be a list of clean-step
  dictionaries; each dictionary should have keys
  'interface' and 'step', and optional key 'args'. This
  argument must be specified (and is only valid) when
  setting provision-state to 'clean'.

``--wait [WAIT_TIMEOUT]``
  Wait for a node to reach the expected state. Not
  supported for 'abort'. Optionally takes a timeout in
  seconds. The default value is 0, meaning no timeout.
  Fails if the node reaches an unexpected stable state,
  a failure state or a state with last_error set.

.. _ironic_node-set-target-raid-config:

ironic node-set-target-raid-config
----------------------------------

.. code-block:: console

   usage: ironic node-set-target-raid-config <node> <target-raid-config>

Set target RAID config on a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<target-raid-config>``
  A file containing JSON data of the desired RAID
  configuration. Use '-' to read the contents from
  standard input. It also accepts the valid json string
  as input if file/standard input are not used for
  providing input. The input can be an empty dictionary
  too which unsets the node.target_raid_config on the
  node.

.. _ironic_node-show:

ironic node-show
----------------

.. code-block:: console

   usage: ironic node-show [--instance] [--fields <field> [<field> ...]] <id>

Show detailed information about a node.

**Positional arguments:**

``<id>``
  Name or UUID of the node (or instance UUID if
  --instance is specified).

**Optional arguments:**

``--instance <id>``
  is an instance UUID.

``--fields <field> [<field> ...]``
  One or more node fields. Only these fields will be
  fetched from the server.

.. _ironic_node-show-states:

ironic node-show-states
-----------------------

.. code-block:: console

   usage: ironic node-show-states <node>

Show information about the node's states.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-update:

ironic node-update
------------------

.. code-block:: console

   usage: ironic node-update <node> <op> <path=value> [<path=value> ...]

Update information about a registered node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is necessary. For
  nested attributes, separate the components with slashes, eg
  'driver_info/deploy_kernel=uuid'.

.. _ironic_node-validate:

ironic node-validate
--------------------

.. code-block:: console

   usage: ironic node-validate <node>

Validate a node's driver interfaces.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_node-vendor-passthru:

ironic node-vendor-passthru
---------------------------

.. code-block:: console

   usage: ironic node-vendor-passthru [--http-method <http-method>]
                                      <node> <method>
                                      [<arg=value> [<arg=value> ...]]

Call a vendor-passthru extension for a node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<method>``
  Vendor-passthru method to be called.

``<arg=value>``
  Argument to be passed to the vendor-passthru method.
  Can be specified multiple times.

**Optional arguments:**

``--http-method <http-method>``
  The HTTP method to use in the request. Valid HTTP
  methods are: POST, PUT, GET, DELETE, PATCH. Defaults
  to 'POST'.

.. _ironic_node-vif-attach:

ironic node-vif-attach
----------------------

.. code-block:: console

   usage: ironic node-vif-attach [--vif-info <key=value>] <node> <vif-id>

Attach VIF to a given node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<vif-id>``
  Name or UUID of the VIF to attach to node.

**Optional arguments:**

``--vif-info <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times. The mandatory 'id' parameter cannot be
  specified as a key.

.. _ironic_node-vif-detach:

ironic node-vif-detach
----------------------

.. code-block:: console

   usage: ironic node-vif-detach <node> <vif-id>

Detach VIF from a given node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

``<vif-id>``
  Name or UUID of the VIF to detach from node.

.. _ironic_node-vif-list:

ironic node-vif-list
--------------------

.. code-block:: console

   usage: ironic node-vif-list <node>

List VIFs for a given node.

**Positional arguments:**

``<node>``
  Name or UUID of the node.

.. _ironic_port-create:

ironic port-create
------------------

.. code-block:: console

   usage: ironic port-create -a <address> -n <node> [-l <key=value>]
                             [--portgroup <portgroup>] [--pxe-enabled <boolean>]
                             [-e <key=value>] [-u <uuid>]

Create a new port.

**Optional arguments:**

``-l <key=value>, --local-link-connection <key=value>``
  Key/value metadata describing Local link connection
  information. Valid keys are switch_info, switch_id,
  port_id.Can be specified multiple times.

``--portgroup <portgroup>``
  UUID of the portgroup that this port belongs to.

``--pxe-enabled <boolean>``
  Indicates whether this Port should be used when PXE
  booting this Node.

``-e <key=value>, --extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``-u <uuid>, --uuid <uuid>``
  UUID of the port.

**Required arguments:**

``-a <address>, --address <address>``
  MAC address for this port.

``-n <node>, --node <node>, --node_uuid <node>``
  UUID of the node that this port belongs to.

.. _ironic_port-delete:

ironic port-delete
------------------

.. code-block:: console

   usage: ironic port-delete <port> [<port> ...]

Delete a port.

**Positional arguments:**

``<port>``
  UUID of the port.

.. _ironic_port-list:

ironic port-list
----------------

.. code-block:: console

   usage: ironic port-list [--detail] [--address <mac-address>] [--limit <limit>]
                           [--marker <port>] [--sort-key <field>]
                           [--sort-dir <direction>]
                           [--fields <field> [<field> ...]]

List the ports.

**Optional arguments:**

``--detail``
  Show detailed information about ports.

``--address <mac-address>``
  Only show information for the port with this MAC
  address.

``--limit <limit>``
  Maximum number of ports to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <port>``
  Port UUID (for example, of the last port in the list
  from a previous request). Returns the list of ports
  after this UUID.

``--sort-key <field>``
  Port field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more port fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

.. _ironic_port-show:

ironic port-show
----------------

.. code-block:: console

   usage: ironic port-show [--address] [--fields <field> [<field> ...]] <id>

Show detailed information about a port.

**Positional arguments:**

``<id>``
  UUID of the port (or MAC address if --address is
  specified).

**Optional arguments:**

``--address <id>``
  is the MAC address (instead of the UUID) of the
  port.

``--fields <field> [<field> ...]``
  One or more port fields. Only these fields will be
  fetched from the server.

.. _ironic_port-update:

ironic port-update
------------------

.. code-block:: console

   usage: ironic port-update <port> <op> <path=value> [<path=value> ...]

Update information about a port.

**Positional arguments:**

``<port>``
  UUID of the port.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is necessary.

.. _ironic_portgroup-create:

ironic portgroup-create
-----------------------

.. code-block:: console

   usage: ironic portgroup-create [-a <address>] -n <node> [--name <name>]
                                  [-e <key=value>]
                                  [--standalone-ports-supported <boolean>]
                                  [-u <uuid>] [-m <mode>] [-p <key=value>]

Create a new portgroup.

**Optional arguments:**

``-a <address>, --address <address>``
  MAC address for this portgroup.

``--name <name>``
  Name for the portgroup.

``-e <key=value>, --extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``--standalone-ports-supported <boolean>``
  Specifies whether ports from this portgroup can be
  used in stand alone mode.

``-u <uuid>, --uuid <uuid>``
  UUID of the portgroup.

``-m <mode>, --mode <mode>``
  Portgroup mode. For possible values, refer to https://
  www.kernel.org/doc/Documentation/networking/bonding.tx
  t

``-p <key=value>, --properties <key=value>``
  Record key/value properties related to this
  portgroup's configuration.

**Required arguments:**

``-n <node>, --node <node>``
  UUID of the node that this portgroup belongs to.

.. _ironic_portgroup-delete:

ironic portgroup-delete
-----------------------

.. code-block:: console

   usage: ironic portgroup-delete <portgroup> [<portgroup> ...]

Delete a portgroup.

**Positional arguments:**

``<portgroup>``
  UUID or Name of the portgroup.

.. _ironic_portgroup-list:

ironic portgroup-list
---------------------

.. code-block:: console

   usage: ironic portgroup-list [--detail] [-n <node>] [-a <mac-address>]
                                [--limit <limit>] [--marker <portgroup>]
                                [--sort-key <field>] [--sort-dir <direction>]
                                [--fields <field> [<field> ...]]

List the portgroups.

**Optional arguments:**

``--detail``
  Show detailed information about portgroups.

``-n <node>, --node <node>``
  UUID of the node that this portgroup belongs to.

``-a <mac-address>, --address <mac-address>``
  Only show information for the portgroup with this MAC
  address.

``--limit <limit>``
  Maximum number of portgroups to return per request, 0
  for no limit. Default is the maximum number used by
  the Ironic API Service.

``--marker <portgroup>``
  Portgroup UUID (for example, of the last portgroup in
  the list from a previous request). Returns the list of
  portgroups after this UUID.

``--sort-key <field>``
  Portgroup field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more portgroup fields. Only these fields will
  be fetched from the server. Can not be used when '--detail' is specified.

.. _ironic_portgroup-port-list:

ironic portgroup-port-list
--------------------------

.. code-block:: console

   usage: ironic portgroup-port-list [--detail] [--limit <limit>]
                                     [--marker <port>] [--sort-key <field>]
                                     [--sort-dir <direction>]
                                     [--fields <field> [<field> ...]]
                                     <portgroup>

List the ports associated with a portgroup.

**Positional arguments:**

``<portgroup>``
  Name or UUID of the portgroup.

**Optional arguments:**

``--detail``
  Show detailed information about the ports.

``--limit <limit>``
  Maximum number of ports to return per request, 0 for
  no limit. Default is the maximum number used by the
  Ironic API Service.

``--marker <port>``
  Port UUID (for example, of the last port in the list
  from a previous request). Returns the list of ports
  after this UUID.

``--sort-key <field>``
  Port field that will be used for sorting.

``--sort-dir <direction>``
  Sort direction: "asc" (the default) or "desc".

``--fields <field> [<field> ...]``
  One or more port fields. Only these fields will be
  fetched from the server. Can not be used when '--detail' is specified.

.. _ironic_portgroup-show:

ironic portgroup-show
---------------------

.. code-block:: console

   usage: ironic portgroup-show [--address] [--fields <field> [<field> ...]] <id>

Show detailed information about a portgroup.

**Positional arguments:**

``<id>``
  Name or UUID of the portgroup (or MAC address if
  --address is specified).

**Optional arguments:**

``--address <id>``
  is the MAC address (instead of the UUID) of the
  portgroup.

``--fields <field> [<field> ...]``
  One or more portgroup fields. Only these fields will
  be fetched from the server.

.. _ironic_portgroup-update:

ironic portgroup-update
-----------------------

.. code-block:: console

   usage: ironic portgroup-update <portgroup> <op> <path=value>
                                  [<path=value> ...]

Update information about a portgroup.

**Positional arguments:**

``<portgroup>``
  UUID or Name of the portgroup.

``<op>``
  Operation: 'add', 'replace', or 'remove'.

``<path=value>``
  Attribute to add, replace, or remove. Can be specified
  multiple times. For 'remove', only <path> is necessary.

