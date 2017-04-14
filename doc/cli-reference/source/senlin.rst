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
Clustering service (senlin) command-line client
===============================================

The senlin client is the command-line interface (CLI) for
the Clustering service (senlin) API and its extensions.

This chapter documents :command:`senlin` version ``1.3.0``.

For help on a specific :command:`senlin` command, enter:

.. code-block:: console

   $ senlin help COMMAND

.. _senlin_command_usage:

senlin usage
~~~~~~~~~~~~

.. code-block:: console

   usage: senlin [--version] [-d] [-v] [--api-timeout API_TIMEOUT]
                 [--senlin-api-version SENLIN_API_VERSION]
                 [--os-auth-plugin AUTH_PLUGIN] [--os-auth-url AUTH_URL]
                 [--os-project-id PROJECT_ID] [--os-project-name PROJECT_NAME]
                 [--os-tenant-id TENANT_ID] [--os-tenant-name TENANT_NAME]
                 [--os-domain-id DOMAIN_ID] [--os-domain-name DOMAIN_NAME]
                 [--os-project-domain-id PROJECT_DOMAIN_ID]
                 [--os-project-domain-name PROJECT_DOMAIN_NAME]
                 [--os-user-domain-id USER_DOMAIN_ID]
                 [--os-user-domain-name USER_DOMAIN_NAME]
                 [--os-username USERNAME] [--os-user-id USER_ID]
                 [--os-password PASSWORD] [--os-trust-id TRUST_ID]
                 [--os-cacert CA_BUNDLE_FILE | --verify | --insecure]
                 [--os-token TOKEN] [--os-access-info ACCESS_INFO]
                 [--os-profile HMAC_KEY]
                 <subcommand> ...

**Subcommands:**

``action-list``
  List actions.

``action-show``
  Show detailed info about the specified action.

``build-info``
  Retrieve build information.

``cluster-check``
  Check the cluster(s).

``cluster-collect``
  Collect attributes across a cluster.

``cluster-create``
  Create the cluster.

``cluster-delete``
  Delete the cluster(s).

``cluster-list``
  List the user's clusters.

``cluster-node-add``
  Add specified nodes to cluster.

``cluster-node-del``
  Delete specified nodes from cluster.

``cluster-node-list``
  List nodes from cluster.

``cluster-node-replace``
  Replace the nodes in cluster with specified nodes.

``cluster-policy-attach``
  Attach policy to cluster.

``cluster-policy-detach``
  Detach policy from cluster.

``cluster-policy-list``
  List policies from cluster.

``cluster-policy-show``
  Show a specific policy that is bound to the specified
  cluster.

``cluster-policy-update``
  Update a policy's properties on a cluster.

``cluster-recover``
  Recover the cluster(s).

``cluster-resize``
  Resize a cluster.

``cluster-run``
  Run shell scripts on all nodes of a cluster.

``cluster-scale-in``
  Scale in a cluster by the specified number of nodes.

``cluster-scale-out``
  Scale out a cluster by the specified number of nodes.

``cluster-show``
  Show details of the cluster.

``cluster-update``
  Update the cluster.

``event-list``
  List events.

``event-show``
  Describe the event.

``node-check``
  Check the node(s).

``node-create``
  Create the node.

``node-delete``
  Delete the node(s).

``node-list``
  Show list of nodes.

``node-recover``
  Recover the node(s).

``node-show``
  Show detailed info about the specified node.

``node-update``
  Update the node.

``policy-create``
  Create a policy.

``policy-delete``
  Delete policy(s).

``policy-list``
  List policies that meet the criteria.

``policy-show``
  Show the policy details.

``policy-type-list``
  List the available policy types.

``policy-type-show``
  Get the details about a policy type.

``policy-update``
  Update a policy.

``policy-validate``
  Validate a policy spec.

``profile-create``
  Create a profile.

``profile-delete``
  Delete profile(s).

``profile-list``
  List profiles that meet the criteria.

``profile-show``
  Show the profile details.

``profile-type-list``
  List the available profile types.

``profile-type-show``
  Get the details about a profile type.

``profile-update``
  Update a profile.

``profile-validate``
  Validate a profile.

``receiver-create``
  Create a receiver.

``receiver-delete``
  Delete receiver(s).

``receiver-list``
  List receivers that meet the criteria.

``receiver-show``
  Show the receiver details.

``bash-completion``
  Prints all of the commands and options to stdout.

``help``
  Display help about this program or one of its
  subcommands.

.. _senlin_command_options:

senlin optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Shows the client version and exits.

``-d, --debug``
  Defaults to ``env[SENLINCLIENT_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``--api-timeout API_TIMEOUT``
  Number of seconds to wait for an API response,
  defaults to system socket timeout

``--senlin-api-version SENLIN_API_VERSION``
  Version number for Senlin API to use, Default to "1".

``--os-auth-plugin AUTH_PLUGIN``
  Authentication plugin, default to ``env[OS_AUTH_PLUGIN]``

``--os-auth-url AUTH_URL``
  Defaults to ``env[OS_AUTH_URL]``

``--os-project-id PROJECT_ID``
  Defaults to ``env[OS_PROJECT_ID]``.

``--os-project-name PROJECT_NAME``
  Defaults to ``env[OS_PROJECT_NAME]``.

``--os-tenant-id TENANT_ID``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-tenant-name TENANT_NAME``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-domain-id DOMAIN_ID``
  Domain ID for scope of authorization, defaults to
  ``env[OS_DOMAIN_ID]``.

``--os-domain-name DOMAIN_NAME``
  Domain name for scope of authorization, defaults to
  ``env[OS_DOMAIN_NAME]``.

``--os-project-domain-id PROJECT_DOMAIN_ID``
  Project domain ID for scope of authorization, defaults
  to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name PROJECT_DOMAIN_NAME``
  Project domain name for scope of authorization,
  defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-user-domain-id USER_DOMAIN_ID``
  User domain ID for scope of authorization, defaults to
  ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name USER_DOMAIN_NAME``
  User domain name for scope of authorization, defaults
  to ``env[OS_USER_DOMAIN_NAME]``.

``--os-username USERNAME``
  Defaults to ``env[OS_USERNAME]``.

``--os-user-id USER_ID``
  Defaults to ``env[OS_USER_ID]``.

``--os-password PASSWORD``
  Defaults to ``env[OS_PASSWORD]``

``--os-trust-id TRUST_ID``
  Defaults to ``env[OS_TRUST_ID]``

``--os-cacert CA_BUNDLE_FILE``
  Path of CA TLS certificate(s) used to verify the
  remote server's certificate. Without this option
  senlin looks for the default system CA certificates.

``--verify``
  Verify server certificate (default)

``--insecure``
  Explicitly allow senlinclient to perform "insecure
  SSL" (HTTPS) requests. The server's certificate will
  not be verified against any certificate authorities.
  This option should be used with caution.

``--os-token TOKEN``
  A string token to bootstrap the Keystone database,
  defaults to ``env[OS_TOKEN]``

``--os-access-info ACCESS_INFO``
  Access info, defaults to ``env[OS_ACCESS_INFO]``

``--os-profile HMAC_KEY``
  HMAC key to use for encrypting context data for
  performance profiling of operation. This key should be
  the value of HMAC key configured in osprofiler
  middleware in senlin, it is specified in the paste
  deploy configuration (/etc/senlin/api-paste.ini).
  Without the key, profiling will not be triggered even
  if osprofiler is enabled on server side.

.. _senlin_action-list:

senlin action-list
------------------

.. code-block:: console

   usage: senlin action-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-o <KEY:DIR>]
                             [-l <LIMIT>] [-m <ID>] [-g] [-F]

List actions.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned actions. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of actions returned.

``-m <ID>, --marker <ID>``
  Only return actions that appear after the given node
  ID.

``-g, --global-project``
  Whether actions from all projects should be listed.
  Default to False. Setting this to True may demand for
  an admin privilege.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_action-show:

senlin action-show
------------------

.. code-block:: console

   usage: senlin action-show <ACTION>

Show detailed info about the specified action.

**Positional arguments:**

``<ACTION>``
  Name or ID of the action to show the details for.

.. _senlin_build-info:

senlin build-info
-----------------

.. code-block:: console

   usage: senlin build-info

Retrieve build information.

.. _senlin_cluster-check:

senlin cluster-check
--------------------

.. code-block:: console

   usage: senlin cluster-check <CLUSTER> [<CLUSTER> ...]

Check the cluster(s).

**Positional arguments:**

``<CLUSTER>``
  ID or name of cluster(s) to operate on.

.. _senlin_cluster-collect:

senlin cluster-collect
----------------------

.. code-block:: console

   usage: senlin cluster-collect -p <PATH> [-L] [-F] <CLUSTER>

Collect attributes across a cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster(s) to operate on.

**Optional arguments:**

``-p <PATH>, --path <PATH>``
  A Json path string specifying the attribute to
  collect.

``-L, --list``
  Print a full list that contains both node ids and
  attribute values instead of values only. Default is
  False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_cluster-create:

senlin cluster-create
---------------------

.. code-block:: console

   usage: senlin cluster-create -p <PROFILE> [-n <MIN-SIZE>] [-m <MAX-SIZE>]
                                [-c <DESIRED-CAPACITY>] [-t <TIMEOUT>]
                                [-M <"KEY1=VALUE1;KEY2=VALUE2...">]
                                <CLUSTER_NAME>

Create the cluster.

**Positional arguments:**

``<CLUSTER_NAME>``
  Name of the cluster to create.

**Optional arguments:**

``-p <PROFILE>, --profile <PROFILE>``
  Profile Id or name used for this cluster.

``-n <MIN-SIZE>, --min-size <MIN-SIZE>``
  Min size of the cluster. Default to 0.

``-m <MAX-SIZE>, --max-size <MAX-SIZE>``
  Max size of the cluster. Default to -1, means
  unlimited.

``-c <DESIRED-CAPACITY>, --desired-capacity <DESIRED-CAPACITY>``
  Desired capacity of the cluster. Default to min_size
  if min_size is specified else 0.

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  Cluster creation timeout in seconds.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the cluster. This
  can
  be
  specified
  multiple
  times,
  or
  once
  with
  key-value
  pairs
  separated
  by
  a
  semicolon.

.. _senlin_cluster-delete:

senlin cluster-delete
---------------------

.. code-block:: console

   usage: senlin cluster-delete <CLUSTER> [<CLUSTER> ...]

Delete the cluster(s).

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster(s) to delete.

.. _senlin_cluster-list:

senlin cluster-list
-------------------

.. code-block:: console

   usage: senlin cluster-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-o <KEY:DIR>]
                              [-l <LIMIT>] [-m <ID>] [-g] [-F]

List the user's clusters.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned clusters. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of clusters returned.

``-m <ID>, --marker <ID>``
  Only return clusters that appear after the given
  cluster ID.

``-g, --global-project``
  Indicate that the cluster list should include clusters
  from all projects. This option is subject to access
  policy checking. Default is False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_cluster-node-add:

senlin cluster-node-add
-----------------------

.. code-block:: console

   usage: senlin cluster-node-add -n <NODES> <CLUSTER>

Add specified nodes to cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-n <NODES>, --nodes <NODES>``
  ID of nodes to be added; multiple nodes can be
  separated with ","

.. _senlin_cluster-node-del:

senlin cluster-node-del
-----------------------

.. code-block:: console

   usage: senlin cluster-node-del -n <NODES> [-d <BOOLEAN>] <CLUSTER>

Delete specified nodes from cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-n <NODES>, --nodes <NODES>``
  ID of nodes to be deleted; multiple nodes can be
  separated with ",".

``-d <BOOLEAN>, --destroy-after-deletion <BOOLEAN>``
  Whether nodes should be destroyed after deleted.
  Default is False.

.. _senlin_cluster-node-list:

senlin cluster-node-list
------------------------

.. code-block:: console

   usage: senlin cluster-node-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">]
                                   [-l <LIMIT>] [-m <ID>] [-F]
                                   <CLUSTER>

List nodes from cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to nodes from.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned nodes. This can
  be specified multiple times, or once with parameters
  separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of nodes returned.

``-m <ID>, --marker <ID>``
  Only return nodes that appear after the given node ID.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_cluster-node-replace:

senlin cluster-node-replace
---------------------------

.. code-block:: console

   usage: senlin cluster-node-replace -n <OLD_NODE1=NEW_NODE1> <CLUSTER>

Replace the nodes in cluster with specified nodes.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-n <OLD_NODE1=NEW_NODE1>, --nodes <OLD_NODE1=NEW_NODE1>``
  OLD_NODE is the name or ID of a node to be replaced,
  NEW_NODE is the name or ID of a node as replacement.
  This can be specified multiple times, or once with
  node-pairs separated by a comma ','.

.. _senlin_cluster-policy-attach:

senlin cluster-policy-attach
----------------------------

.. code-block:: console

   usage: senlin cluster-policy-attach -p <POLICY> [-e <BOOLEAN>] <NAME or ID>

Attach policy to cluster.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-p <POLICY>, --policy <POLICY>``
  ID or name of policy to be attached.

``-e <BOOLEAN>, --enabled <BOOLEAN>``
  Whether the policy should be enabled once attached.
  Default to enabled.

.. _senlin_cluster-policy-detach:

senlin cluster-policy-detach
----------------------------

.. code-block:: console

   usage: senlin cluster-policy-detach -p <POLICY> <NAME or ID>

Detach policy from cluster.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-p <POLICY>, --policy <POLICY>``
  ID or name of policy to be detached.

.. _senlin_cluster-policy-list:

senlin cluster-policy-list
--------------------------

.. code-block:: console

   usage: senlin cluster-policy-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">]
                                     [-o <SORT_STRING>] [-F]
                                     <CLUSTER>

List policies from cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to query on.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned results. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-o <SORT_STRING>, --sort <SORT_STRING>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-F, --full-id``
  Print full IDs in list.

.. _senlin_cluster-policy-show:

senlin cluster-policy-show
--------------------------

.. code-block:: console

   usage: senlin cluster-policy-show -p <POLICY> <CLUSTER>

Show a specific policy that is bound to the specified cluster.

**Positional arguments:**

``<CLUSTER>``
  ID or name of the cluster to query on.

**Optional arguments:**

``-p <POLICY>, --policy <POLICY>``
  ID or name of the policy to query on.

.. _senlin_cluster-policy-update:

senlin cluster-policy-update
----------------------------

.. code-block:: console

   usage: senlin cluster-policy-update -p <POLICY> [-e <BOOLEAN>] <NAME or ID>

Update a policy's properties on a cluster.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-p <POLICY>, --policy <POLICY>``
  ID or name of policy to be updated.

``-e <BOOLEAN>, --enabled <BOOLEAN>``
  Whether the policy should be enabled.

.. _senlin_cluster-recover:

senlin cluster-recover
----------------------

.. code-block:: console

   usage: senlin cluster-recover <CLUSTER> [<CLUSTER> ...]

Recover the cluster(s).

**Positional arguments:**

``<CLUSTER>``
  ID or name of cluster(s) to operate on.

.. _senlin_cluster-resize:

senlin cluster-resize
---------------------

.. code-block:: console

   usage: senlin cluster-resize [-c <CAPACITY>] [-a <ADJUSTMENT>]
                                [-p <PERCENTAGE>] [-t <MIN_STEP>] [-s] [-n MIN]
                                [-m MAX]
                                <CLUSTER>

Resize a cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-c <CAPACITY>, --capacity <CAPACITY>``
  The desired number of nodes of the cluster.

``-a <ADJUSTMENT>, --adjustment <ADJUSTMENT>``
  A positive integer meaning the number of nodes to add,
  or a negative integer indicating the number of nodes
  to remove.

``-p <PERCENTAGE>, --percentage <PERCENTAGE>``
  A value that is interpreted as the percentage of size
  adjustment. This value can be positive or negative.

``-t <MIN_STEP>, --min-step <MIN_STEP>``
  An integer specifying the number of nodes for
  adjustment when <PERCENTAGE> is specified.

``-s, --strict A``
  boolean specifying whether the resize should be
  performed on a best-effort basis when the new capacity
  may go beyond size constraints.

``-n MIN, --min-size MIN``
  New lower bound of cluster size.

``-m MAX, --max-size MAX``
  New upper bound of cluster size. A value of -1
  indicates no upper limit on cluster size.

.. _senlin_cluster-run:

senlin cluster-run
------------------

.. code-block:: console

   usage: senlin cluster-run [-p <PORT>] [-t ADDRESS_TYPE] [-n <NETWORK>] [-6]
                             [-u <USER>] [-i IDENTITY_FILE] [-O SSH_OPTIONS] -s
                             <FILE>
                             <CLUSTER>

Run shell scripts on all nodes of a cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of the cluster.

**Optional arguments:**

``-p <PORT>, --port <PORT>``
  Optional flag to indicate the port to use
  (Default=22).

``-t ADDRESS_TYPE, --address-type ADDRESS_TYPE``
  Optional flag to indicate which IP type to use.
  Possible values includes 'fixed' and 'floating' (the
  Default).

``-n <NETWORK>, --network <NETWORK>``
  Network to use for the ssh.

``-6, --ipv6``
  Optional flag to indicate whether to use an IPv6
  address attached to a server. (Defaults to IPv4
  address)

``-u <USER>, --user <USER>``
  Login to use.

``-i IDENTITY_FILE, --identity-file IDENTITY_FILE``
  Private key file, same as the '-i' option to the ssh
  command.

``-O SSH_OPTIONS, --ssh-options SSH_OPTIONS``
  Extra options to pass to ssh. see: man ssh.

``-s <FILE>, --script <FILE>``
  Script file to run.

.. _senlin_cluster-scale-in:

senlin cluster-scale-in
-----------------------

.. code-block:: console

   usage: senlin cluster-scale-in [-c <COUNT>] <CLUSTER>

Scale in a cluster by the specified number of nodes.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-c <COUNT>, --count <COUNT>``
  Number of nodes to be deleted from the specified
  cluster.

.. _senlin_cluster-scale-out:

senlin cluster-scale-out
------------------------

.. code-block:: console

   usage: senlin cluster-scale-out [-c <COUNT>] <CLUSTER>

Scale out a cluster by the specified number of nodes.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to operate on.

**Optional arguments:**

``-c <COUNT>, --count <COUNT>``
  Number of nodes to be added to the specified cluster.

.. _senlin_cluster-show:

senlin cluster-show
-------------------

.. code-block:: console

   usage: senlin cluster-show <CLUSTER>

Show details of the cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to show.

.. _senlin_cluster-update:

senlin cluster-update
---------------------

.. code-block:: console

   usage: senlin cluster-update [-p <PROFILE>] [-P <BOOLEAN>] [-t <TIMEOUT>]
                                [-M <"KEY1=VALUE1;KEY2=VALUE2...">] [-n <NAME>]
                                <CLUSTER>

Update the cluster.

**Positional arguments:**

``<CLUSTER>``
  Name or ID of cluster to be updated.

**Optional arguments:**

``-p <PROFILE>, --profile <PROFILE>``
  ID or name of new profile to use.

``-P <BOOLEAN>, --profile-only <BOOLEAN>``
  Whether the cluster should be updated profile only. If
  false, it will be applied to all existing nodes. If
  true, any newly created nodes will use the new
  profile, but existing nodes will not be changed.
  Default is False.

``-t <TIMEOUT>, --timeout <TIMEOUT>``
  New timeout (in seconds) value for the cluster.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the cluster. This
  can
  be
  specified
  multiple
  times,
  or
  once
  with
  key-value
  pairs
  separated
  by
  a
  semicolon.
  Use
  '{}'
  can
  clean metadata

``-n <NAME>, --name <NAME>``
  New name for the cluster to update.

.. _senlin_event-list:

senlin event-list
-----------------

.. code-block:: console

   usage: senlin event-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-l <LIMIT>]
                            [-m <ID>] [-o <KEY:DIR>] [-g] [-F]

List events.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned events. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of events returned.

``-m <ID>, --marker <ID>``
  Only return events that appear after the given event
  ID.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-g, --global-project``
  Whether events from all projects should be listed.
  Default to False. Setting this to True may demand for
  an admin privilege.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_event-show:

senlin event-show
-----------------

.. code-block:: console

   usage: senlin event-show <EVENT>

Describe the event.

**Positional arguments:**

``<EVENT>``
  ID of event to display details for.

.. _senlin_node-check:

senlin node-check
-----------------

.. code-block:: console

   usage: senlin node-check <NODE> [<NODE> ...]

Check the node(s).

**Positional arguments:**

``<NODE>``
  ID or name of node(s) to check.

.. _senlin_node-create:

senlin node-create
------------------

.. code-block:: console

   usage: senlin node-create -p <PROFILE> [-c <CLUSTER>] [-r <ROLE>]
                             [-M <"KEY1=VALUE1;KEY2=VALUE2...">]
                             <NODE_NAME>

Create the node.

**Positional arguments:**

``<NODE_NAME>``
  Name of the node to create.

**Optional arguments:**

``-p <PROFILE>, --profile <PROFILE>``
  Profile Id or name used for this node.

``-c <CLUSTER>, --cluster <CLUSTER>``
  Cluster Id for this node.

``-r <ROLE>, --role <ROLE>``
  Role for this node in the specific cluster.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the node. This can
  be specified multiple times, or once with key-value
  pairs separated by a semicolon.

.. _senlin_node-delete:

senlin node-delete
------------------

.. code-block:: console

   usage: senlin node-delete <NODE> [<NODE> ...]

Delete the node(s).

**Positional arguments:**

``<NODE>``
  Name or ID of node(s) to delete.

.. _senlin_node-list:

senlin node-list
----------------

.. code-block:: console

   usage: senlin node-list [-c <CLUSTER>] [-f <"KEY1=VALUE1;KEY2=VALUE2...">]
                           [-o <KEY:DIR>] [-l <LIMIT>] [-m <ID>] [-g] [-F]

Show list of nodes.

**Optional arguments:**

``-c <CLUSTER>, --cluster <CLUSTER>``
  ID or name of cluster from which nodes are to be
  listed.

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned nodes. This can
  be specified multiple times, or once with parameters
  separated by a semicolon.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of nodes returned.

``-m <ID>, --marker <ID>``
  Only return nodes that appear after the given node ID.

``-g, --global-project``
  Indicate that this node list should include nodes from
  all projects. This option is subject to access policy
  checking. Default is False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_node-recover:

senlin node-recover
-------------------

.. code-block:: console

   usage: senlin node-recover [-c <BOOLEAN>] <NODE> [<NODE> ...]

Recover the node(s).

**Positional arguments:**

``<NODE>``
  ID or name of node(s) to recover.

**Optional arguments:**

``-c <BOOLEAN>, --check <BOOLEAN>``
  Whether the node(s) should check physical resource
  status before doing node recover.Default is false

.. _senlin_node-show:

senlin node-show
----------------

.. code-block:: console

   usage: senlin node-show [-D] <NODE>

Show detailed info about the specified node.

**Positional arguments:**

``<NODE>``
  Name or ID of the node to show the details for.

**Optional arguments:**

``-D, --details``
  Include physical object details.

.. _senlin_node-update:

senlin node-update
------------------

.. code-block:: console

   usage: senlin node-update [-n <NAME>] [-p <PROFILE ID>] [-r <ROLE>]
                             [-M <"KEY1=VALUE1;KEY2=VALUE2...">]
                             <NODE>

Update the node.

**Positional arguments:**

``<NODE>``
  Name or ID of node to update.

**Optional arguments:**

``-n <NAME>, --name <NAME>``
  New name for the node.

``-p <PROFILE ID>, --profile <PROFILE ID>``
  ID or name of new profile to use.

``-r <ROLE>, --role <ROLE>``
  Role for this node in the specific cluster.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the node. This can
  be specified multiple times, or once with key-value
  pairs separated by a semicolon. Use '{}' can clean
  metadata

.. _senlin_policy-create:

senlin policy-create
--------------------

.. code-block:: console

   usage: senlin policy-create -s <SPEC_FILE> <NAME>

Create a policy.

**Positional arguments:**

``<NAME>``
  Name of the policy to create.

**Optional arguments:**

``-s <SPEC_FILE>, --spec-file <SPEC_FILE>``
  The spec file used to create the policy.

.. _senlin_policy-delete:

senlin policy-delete
--------------------

.. code-block:: console

   usage: senlin policy-delete <POLICY> [<POLICY> ...]

Delete policy(s).

**Positional arguments:**

``<POLICY>``
  Name or ID of policy(s) to delete.

.. _senlin_policy-list:

senlin policy-list
------------------

.. code-block:: console

   usage: senlin policy-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-l <LIMIT>]
                             [-m <ID>] [-o <KEY:DIR>] [-g] [-F]

List policies that meet the criteria.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned policies. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of policies returned.

``-m <ID>, --marker <ID>``
  Only return policies that appear after the given ID.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-g, --global-project``
  Indicate that the list should include policies from
  all projects. This option is subject to access policy
  checking. Default is False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_policy-show:

senlin policy-show
------------------

.. code-block:: console

   usage: senlin policy-show <POLICY>

Show the policy details.

**Positional arguments:**

``<POLICY>``
  Name or ID of the policy to be shown.

.. _senlin_policy-type-list:

senlin policy-type-list
-----------------------

.. code-block:: console

   usage: senlin policy-type-list

List the available policy types.

.. _senlin_policy-type-show:

senlin policy-type-show
-----------------------

.. code-block:: console

   usage: senlin policy-type-show [-F <FORMAT>] <TYPE_NAME>

Get the details about a policy type.

**Positional arguments:**

``<TYPE_NAME>``
  Policy type to retrieve.

**Optional arguments:**

``-F <FORMAT>, --format <FORMAT>``
  The template output format, one of: yaml, json.

.. _senlin_policy-update:

senlin policy-update
--------------------

.. code-block:: console

   usage: senlin policy-update [-n <NAME>] <POLICY>

Update a policy.

**Positional arguments:**

``<POLICY>``
  Name of the policy to be updated.

**Optional arguments:**

``-n <NAME>, --name <NAME>``
  New name of the policy to be updated.

.. _senlin_policy-validate:

senlin policy-validate
----------------------

.. code-block:: console

   usage: senlin policy-validate -s <SPEC_FILE>

Validate a policy spec.

**Optional arguments:**

``-s <SPEC_FILE>, --spec-file <SPEC_FILE>``
  The spec file of the policy to be validated.

.. _senlin_profile-create:

senlin profile-create
---------------------

.. code-block:: console

   usage: senlin profile-create -s <SPEC FILE>
                                [-M <"KEY1=VALUE1;KEY2=VALUE2...">]
                                <PROFILE_NAME>

Create a profile.

**Positional arguments:**

``<PROFILE_NAME>``
  Name of the profile to create.

**Optional arguments:**

``-s <SPEC FILE>, --spec-file <SPEC FILE>``
  The spec file used to create the profile.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the profile. This
  can
  be
  specified
  multiple
  times,
  or
  once
  with
  key-value
  pairs
  separated
  by
  a
  semicolon.

.. _senlin_profile-delete:

senlin profile-delete
---------------------

.. code-block:: console

   usage: senlin profile-delete <PROFILE> [<PROFILE> ...]

Delete profile(s).

**Positional arguments:**

``<PROFILE>``
  Name or ID of profile(s) to delete.

.. _senlin_profile-list:

senlin profile-list
-------------------

.. code-block:: console

   usage: senlin profile-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-l <LIMIT>]
                              [-m <ID>] [-o <KEY:DIR>] [-g] [-F]

List profiles that meet the criteria.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned profiles. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of profiles returned.

``-m <ID>, --marker <ID>``
  Only return profiles that appear after the given ID.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-g, --global-project``
  Indicate that the list should include profiles from
  all projects. This option is subject to access policy
  checking. Default is False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_profile-show:

senlin profile-show
-------------------

.. code-block:: console

   usage: senlin profile-show <PROFILE>

Show the profile details.

**Positional arguments:**

``<PROFILE>``
  Name or ID of profile to show.

.. _senlin_profile-type-list:

senlin profile-type-list
------------------------

.. code-block:: console

   usage: senlin profile-type-list

List the available profile types.

.. _senlin_profile-type-show:

senlin profile-type-show
------------------------

.. code-block:: console

   usage: senlin profile-type-show [-F <FORMAT>] <TYPE_NAME>

Get the details about a profile type.

**Positional arguments:**

``<TYPE_NAME>``
  Profile type to retrieve.

**Optional arguments:**

``-F <FORMAT>, --format <FORMAT>``
  The template output format, one of: yaml, json.

.. _senlin_profile-update:

senlin profile-update
---------------------

.. code-block:: console

   usage: senlin profile-update [-n <NAME>] [-M <"KEY1=VALUE1;KEY2=VALUE2...">]
                                <PROFILE_ID>

Update a profile.

**Positional arguments:**

``<PROFILE_ID>``
  Name or ID of the profile to update.

**Optional arguments:**

``-n <NAME>, --name <NAME>``
  The new name for the profile.

``-M <"KEY1=VALUE1;KEY2=VALUE2...">, --metadata <"KEY1=VALUE1;KEY2=VALUE2...">``
  Metadata values to be attached to the profile. This
  can
  be
  specified
  multiple
  times,
  or
  once
  with
  key-value
  pairs
  separated
  by
  a
  semicolon.
  Use
  '{}'
  can
  clean metadata

.. _senlin_profile-validate:

senlin profile-validate
-----------------------

.. code-block:: console

   usage: senlin profile-validate -s <SPEC FILE>

Validate a profile.

**Optional arguments:**

``-s <SPEC FILE>, --spec-file <SPEC FILE>``
  The spec file of the profile to be validated.

.. _senlin_receiver-create:

senlin receiver-create
----------------------

.. code-block:: console

   usage: senlin receiver-create [-t <TYPE>] [-c <CLUSTER>] [-a <ACTION>]
                                 [-P <"KEY1=VALUE1;KEY2=VALUE2...">]
                                 <NAME>

Create a receiver.

**Positional arguments:**

``<NAME>``
  Name of the receiver to create.

**Optional arguments:**

``-t <TYPE>, --type <TYPE>``
  Type of the receiver to create. Receiver type can be
  "webhook" or "message". Default to "webhook".

``-c <CLUSTER>, --cluster <CLUSTER>``
  Targeted cluster for this receiver. Required if
  receiver type is webhook.

``-a <ACTION>, --action <ACTION>``
  Name or ID of the targeted action to be triggered.
  Required if receiver type is webhook.

``-P <"KEY1=VALUE1;KEY2=VALUE2...">, --params <"KEY1=VALUE1;KEY2=VALUE2...">``
  A dictionary of parameters that will be passed to
  target action when the receiver is triggered.

.. _senlin_receiver-delete:

senlin receiver-delete
----------------------

.. code-block:: console

   usage: senlin receiver-delete <RECEIVER> [<RECEIVER> ...]

Delete receiver(s).

**Positional arguments:**

``<RECEIVER>``
  Name or ID of receiver(s) to delete.

.. _senlin_receiver-list:

senlin receiver-list
--------------------

.. code-block:: console

   usage: senlin receiver-list [-f <"KEY1=VALUE1;KEY2=VALUE2...">] [-l <LIMIT>]
                               [-m <ID>] [-o <KEY:DIR>] [-g] [-F]

List receivers that meet the criteria.

**Optional arguments:**

``-f <"KEY1=VALUE1;KEY2=VALUE2...">, --filters <"KEY1=VALUE1;KEY2=VALUE2...">``
  Filter parameters to apply on returned receivers. This
  can be specified multiple times, or once with
  parameters separated by a semicolon.

``-l <LIMIT>, --limit <LIMIT>``
  Limit the number of receivers returned.

``-m <ID>, --marker <ID>``
  Only return receivers that appear after the given ID.

``-o <KEY:DIR>, --sort <KEY:DIR>``
  Sorting option which is a string containing a list of
  keys separated by commas. Each key can be optionally
  appended by a sort direction (:asc or :desc)

``-g, --global-project``
  Indicate that the list should include receivers from
  all projects. This option is subject to access policy
  checking. Default is False.

``-F, --full-id``
  Print full IDs in list.

.. _senlin_receiver-show:

senlin receiver-show
--------------------

.. code-block:: console

   usage: senlin receiver-show <RECEIVER>

Show the receiver details.

**Positional arguments:**

``<RECEIVER>``
  Name or ID of the receiver to show.

