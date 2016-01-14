.. This file is manually generated, unlike many of the other chapters.

=================================
neutron-debug command-line client
=================================

The :command:`neutron-debug` client is an extension to the :command:`neutron`
command-line interface (CLI) for the OpenStack neutron-debug tool.

This chapter documents :command:`neutron-debug` version ``2.3.0``.

For help on a specific :command:`neutron-debug` command, enter:

.. code-block:: console

   $ neutron-debug help COMMAND

.. _neutron-debug_usage:

neutron-debug usage
~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug [--version] [-v] [-q] [-h] [-r NUM]
                        [--os-password <auth-password>]
                        [--os-tenant-name <auth-tenant-name>]
                        [--os-tenant-id <auth-tenant-id>] [--os-auth-url <auth-url>]
                        [--os-region-name <region-name>] [--service-type <service-type>]
                        [--service-name <service-name>]
                        [--volume-service-name <volume-service-name>]
                        [--endpoint-type <endpoint-type>]
                        [--os-volume-api-version <volume-api-ver>]
                        [--os-cacert <ca-certificate>] [--retries <retries>]
                        <subcommand> ...

Subcommands
-----------

``probe-create``
  Create probe port - create port and interface within a network namespace.

``probe-list``
  List all probes.

``probe-clear``
  Clear all probes.

``probe-delete``
  Delete probe - delete port then delete the namespace.

``probe-exec``
  Execute commands in the namespace of the probe.

``ping-all``
  ``ping-all`` is an all-in-one command to ping all fixed IPs in a specified
  network.

.. _neutron-debug_optional:

neutron-debug optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Show version number and exit.

``-v, --verbose, --debug``
  Increase verbosity of output and show tracebacks on errors. Can be repeated.

``-q, --quiet``
  Suppress output except warnings and errors

``-h, --help``
  Show this help message and exit

``--os-auth-strategy <auth-strategy>``
  Authentication strategy (Env: ``OS_AUTH_STRATEGY``, default ``keystone``).
  For now, any other value will disable the authentication

``--os-auth-url <auth-url>``
  Authentication URL (Env: ``OS_AUTH_URL``)

``--os-tenant-name <auth-tenant-name>``
  Authentication tenant name (Env: ``OS_TENANT_NAME``)

``--os-tenant-id <auth-tenant-id>``
  Authentication tenant name (Env: ``OS_TENANT_ID``)

``--os-username <auth-username>``
  Authentication username (Env: ``OS_USERNAME``)

``--os-password <auth-password>``
  Authentication password (Env: ``OS_PASSWORD``)

``--os-region-name <auth-region-name>``
  Authentication region name (Env: ``OS_REGION_NAME``)

``--os-token <token>``
  Defaults to ``env[OS_TOKEN]``

``--endpoint-type <endpoint-type>``
  Defaults to ``env[OS_ENDPOINT_TYPE]`` or public URL.

``--os-url <url>``
  Defaults to ``env[OS_URL]``

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS (HTTPS) server
  certificate. Defaults to ``env[OS_CACERT]``

``--insecure``
  Explicitly allow neutron-debug to perform "insecure" SSL (HTTPS) requests.
  The server's certificate will not be verified against any certificate
  authorities. This option should be used with caution.

``--config-file CONFIG_FILE``
  Config file for interface driver (You may also use ``l3_agent.ini``)

neutron-debug probe-create command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug probe-create NET

Create probe port - create port and interface,
then place it into the created network namespace.

Positional arguments
--------------------

``NET ID``
  ID of the network in which the probe will be created.

neutron-debug probe-list command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug probe-list

List probes.

neutron-debug probe-clear command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug probe-clear

Clear all probes.

neutron-debug probe-delete command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug probe-delete <port-id>

Remove a probe.

Positional arguments
--------------------

``<port-id>``
  ID of the probe to delete.

neutron-debug probe-exec command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug probe-exec <port-id> <command>

Execute commands in the namespace of the probe

neutron-debug ping-all command
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug ping-all <port-id> --timeout <number>

All-in-one command to ping all fixed IPs in a specified network.
A probe creation is not needed for this command.
A new probe is created automatically.
It will, however, need to be deleted manually when it is no longer needed.
When there are multiple networks, the newly created probe will be attached
to a random network and thus the ping will take place from within that
random network.

Positional arguments
--------------------

``<port-id>``
  ID of the port to use.

Optional arguments
------------------

``--timeout <timeout in seconds>``
  Optional ping timeout.

neutron-debug example
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-debug create-probe <NET_ID>

Create a probe namespace within the network identified by ``NET_ID``.
The namespace will have the name of qprobe-<UUID of the probe port>

.. note::

   For the following examples to function, the security group rules
   may need to be modified to allow the SSH (TCP port 22) or ping
   (ICMP) traffic into network.

.. code-block:: console

   usage: neutron-debug probe-exec <probe ID> "ssh <IP of instance>"

SSH to an instance within the network.

.. code-block:: console

   usage: neutron-debug ping-all <network ID>

Ping all instances on this network to verify they are responding.

.. code-block:: console

   usage: neutron-debug probe-exec <probe_ID> dhcping <VM_MAC address> -s <IP of DHCP server>

Ping the DHCP server for this network using dhcping to verify it is working.
