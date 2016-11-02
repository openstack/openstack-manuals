.. _config-macvtap:

========================
Macvtap mechanism driver
========================

The Macvtap mechanism driver for the ML2 plug-in generally increases
network performance of instances.

Consider the following attributes of this mechanism driver to determine
practicality in your environment:

* Supports only instance ports. Ports for DHCP and layer-3 (routing)
  services must use another mechanism driver such as Linux bridge or
  Open vSwitch (OVS).

* Supports only untagged (flat) and tagged (VLAN) networks.

* Lacks support for security groups including basic (sanity) and
  anti-spoofing rules.

* Lacks support for layer-3 high-availability mechanisms such as
  Virtual Router Redundancy Protocol (VRRP) and Distributed Virtual
  Routing (DVR).

* Only compute resources can be attached via macvtap. Attaching other
  resources like DHCP, Routers and others is not supported. Therefore run
  either OVS or linux bridge in VLAN or flat mode on the controller node.

* Instance migration requires the same values for the
  ``physical_interface_mapping`` configuration option on each compute node.
  For more information, see
  `<https://bugs.launchpad.net/neutron/+bug/1550400>`_.

Prerequisites
~~~~~~~~~~~~~

You can add this mechanism driver to an existing environment using either
the Linux bridge or OVS mechanism drivers with only provider networks or
provider and self-service networks. You can change the configuration of
existing compute nodes or add compute nodes with the Macvtap mechanism
driver. The example configuration assumes addition of compute nodes with
the Macvtap mechanism driver to the :ref:`deploy-lb-selfservice` or
:ref:`deploy-ovs-selfservice` deployment examples.

Add one or more compute nodes with the following components:

* Three network interfaces: management, provider, and overlay.
* OpenStack Networking Macvtap layer-2 agent and any dependencies.

.. note::

   To support integration with the deployment examples, this content
   configures the Macvtap mechanism driver to use the overlay network
   for untagged (flat) or tagged (VLAN) networks in addition to overlay
   networks such as VXLAN. Your physical network infrastructure
   must support VLAN (802.1q) tagging on the overlay network.

Architecture
~~~~~~~~~~~~

The Macvtap mechanism driver only applies to compute nodes. Otherwise,
the environment resembles the prerequisite deployment example.

.. image:: figures/config-macvtap-compute1.png
   :alt: Macvtap mechanism driver - compute node components

.. image:: figures/config-macvtap-compute2.png
   :alt: Macvtap mechanism driver - compute node connectivity

Example configuration
~~~~~~~~~~~~~~~~~~~~~

Use the following example configuration as a template to add support for
the Macvtap mechanism driver to an existing operational environment.

Controller node
---------------

#. In the ``ml2_conf.ini`` file:

   * Add ``macvtap`` to mechanism drivers.

     .. code-block:: ini

        [ml2]
        mechanism_drivers = macvtap

   * Configure network mappings.

     .. code-block:: ini

        [ml2_type_flat]
        flat_networks = provider,macvtap

        [ml2_type_vlan]
        network_vlan_ranges = provider,macvtap:VLAN_ID_START:VLAN_ID_END

     .. note::

        Use of ``macvtap`` is arbitrary. Only the self-service deployment
        examples require VLAN ID ranges. Replace ``VLAN_ID_START`` and
        ``VLAN_ID_END`` with appropriate numerical values.

#. Restart the following services:

   * Server

Network nodes
-------------

No changes.

Compute nodes
-------------

#. Install the Networking service Macvtap layer-2 agent.

#. In the ``neutron.conf`` file, configure common options:

   .. include:: shared/deploy-config-neutron-common.txt

#. In the ``macvtap_agent.ini`` file, configure the layer-2 agent.

   .. code-block:: ini

      [macvtap]
      physical_interface_mappings = macvtap:MACVTAP_INTERFACE

      [securitygroup]
      firewall_driver = noop

   Replace ``MACVTAP_INTERFACE`` with the name of the underlying
   interface that handles Macvtap mechanism driver interfaces.
   If using a prerequisite deployment example, replace
   ``MACVTAP_INTERFACE`` with the name of the underlying interface
   that handles overlay networks. For example, ``eth1``.

#. Start the following services:

   * Macvtap agent

Verify service operation
------------------------

#. Source the administrative project credentials.
#. Verify presence and operation of the agents:

   .. code-block:: console

      $ neutron agent-list
      +--------------------------------------+---------------+----------+-------------------+-------+----------------+---------------------------+
      | id                                   | agent_type    | host     | availability_zone | alive | admin_state_up | binary                |
      +--------------------------------------+--------------------+----------+-------------------+-------+----------------+---------------------------+
      | 7af923a4-8be6-11e6-afc3-3762f3c3cf6e | Macvtap agent | compute1 |                   | :-)   | True           | neutron-macvtap-agent |
      | 80af6934-8be6-11e6-a046-7b842f93bb23 | Macvtap agent | compute2 |                   | :-)   | True           | neutron-macvtap-agent |
      +--------------------------------------+---------------+----------+-------------------+-------+----------------+---------------------------+

Create initial networks
-----------------------

This mechanism driver simply changes the virtual network interface driver
for instances. Thus, you can reference the ``Create initial networks``
content for the prerequisite deployment example.

Verify network operation
------------------------

This mechanism driver simply changes the virtual network interface driver
for instances. Thus, you can reference the ``Verify network operation``
content for the prerequisite deployment example.

Network traffic flow
~~~~~~~~~~~~~~~~~~~~

This mechanism driver simply removes the Linux bridge handling security
groups on the compute nodes. Thus, you can reference the network traffic
flow scenarios for the prerequisite deployment example.
