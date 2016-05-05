
==============
Hardware setup
==============

The standard hardware requirements:

- `Provider networks <http://docs.openstack.org/liberty/install-guide-ubuntu/overview.html#networking-option-1-provider-networks>`_
- `Self-service networks <http://docs.openstack.org/liberty/install-guide-ubuntu/overview.html#networking-option-2-self-service-networks>`_

However, OpenStack does not require a significant amount of resources
and the following minimum requirements should support
a proof-of-concept high availability environment
with core services and several instances:

[TODO: Verify that these numbers are good]

+-------------------+------------+----------+-----------+------+
| Node type         | Processor  | Memory   | Storage   | NIC  |
+===================+============+==========+===========+======+
| controller node   | 1-2        | 8 GB     | 100 GB    | 2    |
+-------------------+------------+----------+-----------+------+
| compute node      | 2-4+       | 8+ GB    | 100+ GB   | 2    |
+-------------------+------------+----------+-----------+------+


For demonstrations and studying,
you can set up a test environment on virtual machines (VMs).
This has the following benefits:

- One physical server can support multiple nodes,
  each of which supports almost any number of network interfaces.

- Ability to take periodic "snap shots" throughout the installation process
  and "roll back" to a working configuration in the event of a problem.

However, running an OpenStack environment on VMs
degrades the performance of your instances,
particularly if your hypervisor and/or processor lacks support
for hardware acceleration of nested VMs.

.. note::

   When installing highly-available OpenStack on VMs,
   be sure that your hypervisor permits promiscuous mode
   and disables MAC address filtering on the external network.

