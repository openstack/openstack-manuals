.. _config-ovsfwdriver:

===================================
Native Open vSwitch firewall driver
===================================

.. note::

   Experimental feature or incomplete documentation.

Historically, Open vSwitch (OVS) could not interact directly with *iptables*
to implement security groups. Thus, the OVS agent and Compute service use
a Linux bridge between each instance (VM) and the OVS integration bridge
``br-int`` to implement security groups. The Linux bridge device contains
the *iptables* rules pertaining to the instance. In general, additional
components between instances and physical network infrastructure cause
scalability and performance problems. To alleviate such problems, the OVS
agent includes an optional firewall driver that natively implements security
groups as flows in OVS rather than the Linux bridge device and *iptables*.
This increases scalability and performance.

Prerequisites
~~~~~~~~~~~~~

The native OVS firewall implementation requires kernel and user space support
for *conntrack*, thus requiring minimum versions of the Linux kernel and
Open vSwitch. All cases require Open vSwitch version 2.5 or newer.

* Kernel version 4.3 or newer includes *conntrack* support.
* Kernel version 3.3, but less than 4.3, does not include *conntrack*
  support and requires building the OVS modules.

Enable the native OVS firewall driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* On nodes running the Open vSwitch agent, edit the
  ``openvswitch_agent.ini`` file and enable the firewall driver.

  .. code-block:: ini

     [securitygroup]
     firewall_driver = openvswitch

For more information, see the `Open vSwitch Firewall Driver
<https://docs.openstack.org/developer/neutron/devref/openvswitch_firewall.html>`_
and the `video <https://www.youtube.com/watch?v=SOHeZ3g9yxM>`_.
