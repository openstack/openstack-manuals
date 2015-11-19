=============================================
Verify the libvirt default network is running
=============================================

Before starting a virtual machine with libvirt, verify
that the libvirt ``default`` network has started.
This network must be active for your virtual machine
to be able to connect out to the network.
Starting this network will create a Linux bridge (usually
called ``virbr0``), iptables rules, and a dnsmasq process
that will serve as a DHCP server.

To verify that the libvirt ``default`` network is enabled,
use the :command:`virsh net-list` command and verify
that the ``default`` network is active:

.. code-block:: console

   # virsh net-list
   Name                 State      Autostart
   -----------------------------------------
   default              active     yes

If the network is not active, start it by doing:

.. code-block:: console

   # virsh net-start default
