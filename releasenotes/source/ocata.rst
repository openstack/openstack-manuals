===========================
Next release: Ocata release
===========================

* The documentation sites ``developer.openstack.org`` and
  ``docs.openstack.org`` are now set up with ``https`` and links to
  pages have been changed to use ``https`` by default.

Administrator Guide
~~~~~~~~~~~~~~~~~~~

* Removed legacy commands in favor of the ``openstack`` client commands where
  equivalent functions existed. Legacy commands changed include ``nova``,
  ``neutron``, ``cinder``, ``glance``, and ``manila`` clients.

* Updates to identity and compute content - PCI DSS v3.1
  compliance, and Huge Page functionality, respectively.

* Addressed technical debt: toctree positions, spelling, and grammar.

Command-Line Interface Reference
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Removed the ``sahara`` client in favor of the ``openstack`` client.

Configuration Reference
~~~~~~~~~~~~~~~~~~~~~~~

* Cleaned up content that is not directly configuration options.

* Created a few vendor plug-in sections newly added for Ocata.

End User Guide
~~~~~~~~~~~~~~

* Removed legacy commands in favor of the ``openstack`` client commands where
  equivalent functions existed. Legacy commands changed include ``nova``,
  ``neutron``, ``cinder``, ``glance``, and ``manila`` clients.

* References to default flavors were removed.

* Changes to swift content on ``.rlistings``, and  neutron dnsmasq log file
  content.

Networking Guide
~~~~~~~~~~~~~~~~

* Made progress towards replacing all neutron client commands with OpenStack
  client equivalents.
* Added routed provider networks.
* Added VLAN trunking.
* Added RFC 5737 and 3849 compliance policy.
* Improved Open vSwitch HA DVR deployment.
* Improved Quality of Service (QoS).
* Improved service subnets.
* Improved SR-IOV.
* Improved MTU considerations.
* Improved Load-Balancer-as-a-Service.
