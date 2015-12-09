===========
ML2 plug-in
===========

Overview
~~~~~~~~

Architecture
------------

Configuration file organization, relationships, etc.
----------------------------------------------------

Network type drivers
^^^^^^^^^^^^^^^^^^^^

* Flat

* VLAN

* GRE

* VXLAN

Tenant network types
--------------------

Similar info in:
http://docs.openstack.org/admin-guide-cloud/networking_adv-features.html#provider-networks

* Local

* VLAN

  * ID ranges

* GRE

  * Tunnel ID ranges

* VXLAN

  * ID ranges

  * Multicast discovery (L2 population)

Mechanism
---------

* Linux bridge

  * Option stanza/section

* Open vSwitch

  * Option stanza/section

* L2 population

* Specialized

  * Open source

    * Explains that mechanisms such as OpenDaylight and OpenContrail exist

    * Does not cover how to do this

  * Proprietary (vendor)

    * Just specifies that these exist

    * Does not cover how to do this

Security
^^^^^^^^

* Options

Agents
------

L3
^^

* Configuration file

DHCP
^^^^

* Configuration file

Metadata
^^^^^^^^

* Configuration file
