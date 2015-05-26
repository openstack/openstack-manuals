================
Basic networking
================

Ethernet
~~~~~~~~

VLANs
~~~~~

VLAN is a networking technology that enables a single switch to act as
if it was multiple independent switches. Specifically, two hosts that are
connected to the same switch but on different VLANs will not see each other's
traffic. OpenStack is able to take advantage of VLANs to isolate the traffic of
different tenants, even if the tenants happen to have instances running on the
same compute host. Each VLAN has an associated numerical ID, between 1 and 4095.
We say "VLAN 15" to refer to the VLAN with numerical ID of 15.

To understand how VLANs work, let's consider VLAN applications in a traditional
IT environment, where physical hosts are attached to a physical switch, and no
virtualization is involved. Imagine a scenario where you want three isolated
networks, but you only have a single physical switch. The network administrator
would choose three VLAN IDs, say, 10, 11, and 12, and would configure the switch
to associate switchports with VLAN IDs. For example, switchport 2 might be
associated with VLAN 10, switchport 3 might be associated with VLAN 11, and so
forth. When a switchport is configured for a specific VLAN, it is called an
*access port*. The switch is responsible for ensuring that the network traffic
is isolated across the VLANs.

Now consider the scenario that all of the switchports in the first switch become
occupied, and so the organization buys a second switch and connects it to the first
switch to expand the available number of switchports. The second switch is also
configured to support VLAN IDs 10, 11, and 12. Now imagine host A connected to
switch 1 on a port configured for VLAN ID 10 sends an Ethernet frame intended
for host B connected to switch 2 on a port configured for VLAN ID 10. When switch 1
forwards the Ethernet frame to switch 2, it must communicate that the frame is
associated with VLAN ID 10.

If two switches are to be connected together, and the switches are configured
for VLANs, then the switchports used for cross-connecting the switches must be
configured to allow Ethernet frames from any VLAN to be
forwarded to the other switch. In addition, the sending switch must tag each
Ethernet frame with the VLAN ID so that the receiving switch can ensure that
only hosts on the matching VLAN are eligible to receive the frame.

When a switchport is configured to pass frames from all VLANs and tag them with
the VLAN IDs it is called a *trunk port*. IEEE 802.1Q is the network standard
that describes how VLAN tags are encoded in Ethernet frames when trunking is
being used.

Note that if you are using VLANs on your physical switches to implement tenant
isolation in your OpenStack cloud, you will need to ensure that all of your
switchports are configured as trunk ports.


ARP
~~~

IP
~~

ICMP/TCP/UDP
~~~~~~~~~~~~
