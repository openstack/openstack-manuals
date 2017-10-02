=============================================
Hardware considerations for high availability
=============================================

When you use high availability, consider the hardware requirements needed
for your application.

Hardware setup
~~~~~~~~~~~~~~

The following are the standard hardware requirements:

- Provider networks: See the *Overview -> Networking Option 1: Provider
  networks* section of the
  `Install Guides <https://docs.openstack.org/ocata/install>`_
  depending on your distribution.
- Self-service networks: See the *Overview -> Networking Option 2:
  Self-service networks* section of the
  `Install Guides <https://docs.openstack.org/ocata/install>`_
  depending on your distribution.

OpenStack does not require a significant amount of resources and the following
minimum requirements should support a proof-of-concept high availability
environment with core services and several instances:

+-------------------+------------------+----------+-----------+------+
| Node type         | Processor Cores  | Memory   | Storage   | NIC  |
+===================+==================+==========+===========+======+
| controller node   | 4                | 12 GB    | 120 GB    | 2    |
+-------------------+------------------+----------+-----------+------+
| compute node      | 8+               | 12+ GB   | 120+ GB   | 2    |
+-------------------+------------------+----------+-----------+------+

We recommended that the maximum latency between any two controller
nodes is 2 milliseconds. Although the cluster software can be tuned to
operate at higher latencies, some vendors insist on this value before
agreeing to support the installation.

You can use the `ping` command to find the latency between two servers.

Virtualized hardware
~~~~~~~~~~~~~~~~~~~~

For demonstrations and studying, you can set up a test environment on virtual
machines (VMs). This has the following benefits:

- One physical server can support multiple nodes,
  each of which supports almost any number of network interfaces.

- You can take periodic snap shots throughout the installation process
  and roll back to a working configuration in the event of a problem.

However, running an OpenStack environment on VMs degrades the performance of
your instances, particularly if your hypervisor or processor lacks
support for hardware acceleration of nested VMs.

.. note::

   When installing highly available OpenStack on VMs,
   be sure that your hypervisor permits promiscuous mode
   and disables MAC address filtering on the external network.
