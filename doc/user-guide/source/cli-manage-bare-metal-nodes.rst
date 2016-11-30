=======================
Manage bare-metal nodes
=======================

The bare-metal driver for OpenStack Compute manages provisioning of
physical hardware by using common cloud APIs and tools such as
Orchestration (Heat). The use case for this driver is for single project
clouds such as a high-performance computing cluster, or for deploying
OpenStack itself.

If you use the bare-metal driver, you must create a network interface
and add it to a bare-metal node. Then, you can launch an instance from a
bare-metal image.

You can list and delete bare-metal nodes. When you delete a node, any
associated network interfaces are removed. You can list and remove
network interfaces that are associated with a bare-metal node.

Commands
~~~~~~~~

The following commands can be used to manage bare-metal nodes.

``baremetal-interface-add``
  Adds a network interface to a bare-metal node.

``baremetal-interface-list``
  Lists network interfaces associated with a bare-metal node.

``baremetal-interface-remove``
  Removes a network interface from a bare-metal node.

``baremetal-node-create``
  Creates a bare-metal node.

``baremetal-node-delete``
  Removes a bare-metal node and any associated interfaces.

``baremetal-node-list``
  Lists available bare-metal nodes.

``baremetal-node-show``
  Shows information about a bare-metal node.

Create a bare-metal node
~~~~~~~~~~~~~~~~~~~~~~~~

When you create a bare-metal node, your PM address, user name, and
password should match the information in your hardware's BIOS/IPMI
configuration.

.. code-block:: console

   $ nova baremetal-node-create --pm_address PM_ADDRESS --pm_user PM_USERNAME \
     --pm_password PM_PASSWORD $(hostname -f) 1 512 10 aa:bb:cc:dd:ee:ff

The following example shows the command and results from creating a node
with the PM address ``1.2.3.4``, the PM user name ipmi, and password
``ipmi``.

.. code-block:: console

   $ nova baremetal-node-create --pm_address 1.2.3.4 --pm_user ipmi \
     --pm_password ipmi $(hostname -f) 1 512 10 aa:bb:cc:dd:ee:ff
   +------------------+-------------------+
   | Property         | Value             |
   +------------------+-------------------+
   | instance_uuid    | None              |
   | pm_address       | 1.2.3.4           |
   | interfaces       | []                |
   | prov_vlan_id     | None              |
   | cpus             | 1                 |
   | memory_mb        | 512               |
   | prov_mac_address | aa:bb:cc:dd:ee:ff |
   | service_host     | ubuntu            |
   | local_gb         | 10                |
   | id               | 1                 |
   | pm_user          | ipmi              |
   | terminal_port    | None              |
   +------------------+-------------------+

Add a network interface to the node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For each NIC on the node, you must create an interface, specifying the
interface's MAC address.

.. code-block:: console

   $ nova baremetal-interface-add 1 aa:bb:cc:dd:ee:ff
   +-------------+-------------------+
   | Property    | Value             |
   +-------------+-------------------+
   | datapath_id | 0                 |
   | id          | 1                 |
   | port_no     | 0                 |
   | address     | aa:bb:cc:dd:ee:ff |
   +-------------+-------------------+

Launch an instance from a bare-metal image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A bare-metal instance is an instance created directly on a physical
machine, without any virtualization layer running underneath it. Nova
retains power control via IPMI. In some situations, Nova may retain
network control via Neutron and OpenFlow.

.. code-block:: console

   $ openstack server create --image my-baremetal-image --flavor \
     my-baremetal-flavor test
   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | BUILD                                |
   | id                          | cc302a8f-cd81-484b-89a8-b75eb3911b1b |
   +-----------------------------+--------------------------------------+

  ... wait for instance to become active ...

.. note::

   Set the ``--availability-zone`` parameter to specify which zone or
   node to use to start the server. Separate the zone from the host
   name with a comma. For example:

   .. code-block:: console

      $ openstack server create --availability-zone zone:HOST,NODE

   ``host`` is optional for the ``--availability-zone`` parameter. You
   can simply specify ``zone:,node``, still including the comma.

List bare-metal nodes and interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :command:`nova baremetal-node-list` command to view all bare-metal
nodes and interfaces. When a node is in use, its status includes the
UUID of the instance that runs on it:

.. code-block:: console

   $ nova baremetal-node-list
   +----+--------+------+-----------+---------+-------------------+------+------------+-------------+-------------+---------------+
   | ID | Host   | CPUs | Memory_MB | Disk_GB | MAC Address       | VLAN | PM Address | PM Username | PM Password | Terminal Port |
   +----+--------+------+-----------+---------+-------------------+------+------------+-------------+-------------+---------------+
   | 1  | ubuntu | 1    | 512       | 10      | aa:bb:cc:dd:ee:ff | None | 1.2.3.4    | ipmi        |             | None          |
   +----+--------+------+-----------+---------+-------------------+------+------------+-------------+-------------+---------------+

Show details for a bare-metal node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :command:`nova baremetal-node-show` command to view the details for a
bare-metal node:

.. code-block:: console

   $ nova baremetal-node-show 1
   +------------------+--------------------------------------+
   | Property         | Value                                |
   +------------------+--------------------------------------+
   | instance_uuid    | cc302a8f-cd81-484b-89a8-b75eb3911b1b |
   | pm_address       | 1.2.3.4                              |
   | interfaces       | [{u'datapath_id': u'0', u'id': 1,    |
   |                  | u'port_no': 0,                       |
   |                  | u'address': u'aa:bb:cc:dd:ee:ff'}]   |
   | prov_vlan_id     | None                                 |
   | cpus             | 1                                    |
   | memory_mb        | 512                                  |
   | prov_mac_address | aa:bb:cc:dd:ee:ff                    |
   | service_host     | ubuntu                               |
   | local_gb         | 10                                   |
   | id               | 1                                    |
   | pm_user          | ipmi                                 |
   | terminal_port    | None                                 |
   +------------------+--------------------------------------+
