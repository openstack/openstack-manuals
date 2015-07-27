.. highlight:: ini

==============================
OpenStack Networking (neutron)
==============================

The example architecture with OpenStack Networking (neutron) requires
one controller node, one network node, and at least one compute node.
The controller node contains one network interface on the
:term:`management network`. The network node contains one network interface
on the management network, one on the :term:`instance tunnels network`,
and one on the :term:`external network`. The compute node contains one
network interface on the management network and one on the instance
tunnels network.

The example architecture assumes use of the following networks:

- Management on 10.0.0.0/24 with gateway 10.0.0.1

  .. note::

     This network requires a gateway to provide Internet access to all
     nodes for administrative purposes such as package installation,
     security updates, :term:`DNS`, and :term:`Network Time Protocol (NTP)`.

- Instance tunnels on 10.0.1.0/24 without a gateway

  .. note::

     This network does not require a gateway because communication
     only occurs among network and compute nodes in your OpenStack
     environment.

- External on 203.0.113.0/24 with gateway 203.0.113.1

  .. note::

     This network requires a gateway to provide Internet access to
     instances in your OpenStack environment.

You can modify these ranges and gateways to work with your particular
network infrastructure.

.. note::

   Network interface names vary by distribution. Traditionally,
   interfaces use "eth" followed by a sequential number. To cover all
   variations, this guide simply refers to the first interface as the
   interface with the lowest number, the second interface as the
   interface with the middle number, and the third interface as the
   interface with the highest number.

|

.. figure:: figures/installguidearch-neutron-networks.png
   :alt: Minimal architecture example with OpenStack Networking
         (neutron)—Network layout

   **Minimal architecture example with OpenStack Networking
   (neutron)—Network layout**

|

Unless you intend to use the exact configuration provided in this
example architecture, you must modify the networks in this procedure to
match your environment. Also, each node must resolve the other nodes by
name in addition to IP address. For example, the ``controller`` name must
resolve to ``10.0.0.11``, the IP address of the management interface on
the controller node.

.. warning::

   Reconfiguring network interfaces will interrupt network
   connectivity. We recommend using a local terminal session for these
   procedures.

|

Controller node
---------------

**To configure networking:**

#. Configure the first interface as the management interface:

   IP address: 10.0.0.11

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

#. Reboot the system to activate the changes.

|

**To configure name resolution:**

#. Set the hostname of the node to ``controller``.

#. Edit the :file:`/etc/hosts:` file to contain the following:

   .. code-block:: ini
      :linenos:

      # controller
      10.0.0.11       controller

      # network
      10.0.0.21       network

      # compute1
      10.0.0.31       compute1

   .. warning::

      Some distributions add an extraneous entry in the :file:`/etc/hosts`
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems.

|

Network node
------------

**To configure networking:**

#. Configure the first interface as the management interface:

   IP address: 10.0.0.21

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

#. Configure the second interface as the instance tunnels interface:

   IP address: 10.0.1.21

   Network mask: 255.255.255.0 (or /24)

#. The external interface uses a special configuration without an IP
   address assigned to it. Configure the third interface as the external
   interface:

   Replace ``INTERFACE_NAME`` with the actual interface name. For example,
   *eth2* or *ens256*.

   .. only:: ubuntu or debian

      a. Edit the :file:`/etc/network/interfaces` file to contain the following:

         .. code-block:: ini
            :linenos:

            # The external network interface
            auto INTERFACE_NAME
            iface INTERFACE_NAME inet manual
                  up ip link set dev $IFACE up
                  down ip link set dev $IFACE down

   .. only:: rdo

      a. Edit the :file:`/etc/sysconfig/network-scripts/ifcfg-INTERFACE_NAME` file
         to contain the following:

         Do not change the ``HWADDR`` and ``UUID`` keys.

         .. code-block:: ini
            :linenos:

            DEVICE= INTERFACE_NAME
            TYPE=Ethernet
            ONBOOT="yes"
            BOOTPROTO="none"

   .. only:: obs

      a. Edit the :file:`/etc/sysconfig/network/ifcfg-INTERFACE_NAME` file
         to contain the following:

         .. code-block:: ini
            :linenos:

            STARTMODE='auto'
            BOOTPROTO='static'

4. Reboot the system to activate the changes.

|

**To configure name resolution:**

#. Set the hostname of the node to ``network``.

#. Edit the :file:`/etc/hosts` file to contain the following:

   .. code-block:: ini
      :linenos:

      # network
      10.0.0.21       network

      # controller
      10.0.0.11       controller

      # compute1
      10.0.0.31       compute1

   .. warning::

      Some distributions add an extraneous entry in the :file:`/etc/hosts`
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems.

|

Compute node
------------

**To configure networking:**

#. Configure the first interface as the management interface:

   IP address: 10.0.0.31

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

   .. note::

      Additional compute nodes should use 10.0.0.32, 10.0.0.33, and so on.

#. Configure the second interface as the instance tunnels interface:

   IP address: 10.0.1.31

   Network mask: 255.255.255.0 (or /24)

   .. note::

      Additional compute nodes should use 10.0.1.32, 10.0.1.33, and so on.

#. Reboot the system to activate the changes.

|

**To configure name resolution:**

#. Set the hostname of the node to ``compute1``.

#. Edit the :file:`/etc/hosts` file to contain the following:

   .. code-block:: ini
      :linenos:

      # compute1
      10.0.0.31       compute1

      # controller
      10.0.0.11       controller

      # network
      10.0.0.21       network

   .. warning::

      Some distributions add an extraneous entry in the :file:`/etc/hosts`
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems.

|

Verify connectivity
-------------------

We recommend that you verify network connectivity to the Internet and
among the nodes before proceeding further.

#. From the *controller* node, :command:`ping` a site on the Internet:

   .. code-block:: console

      # ping -c 4 openstack.org
      PING openstack.org (174.143.194.225) 56(84) bytes of data.
      64 bytes from 174.143.194.225: icmp_seq=1 ttl=54 time=18.3 ms
      64 bytes from 174.143.194.225: icmp_seq=2 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=3 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=4 ttl=54 time=17.4 ms

      --- openstack.org ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3022ms
      rtt min/avg/max/mdev = 17.489/17.715/18.346/0.364 ms

#. From the *controller* node, :command:`ping` the management interface
   on the *network* node:

   .. code-block:: console

      # ping -c 4 network
      PING network (10.0.0.21) 56(84) bytes of data.
      64 bytes from network (10.0.0.21): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from network (10.0.0.21): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from network (10.0.0.21): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from network (10.0.0.21): icmp_seq=4 ttl=64 time=0.202 ms

      --- network ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms

#. From the *controller* node, :command:`ping` the management interface on the
   *compute* node:

   .. code-block:: console

      # ping -c 4 compute1
      PING compute1 (10.0.0.31) 56(84) bytes of data.
      64 bytes from compute1 (10.0.0.31): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=4 ttl=64 time=0.202 ms

      --- network ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms

#. From the *network* node, :command:`ping` a site on the Internet:

   .. code-block:: console

      # ping -c 4 openstack.org
      PING openstack.org (174.143.194.225) 56(84) bytes of data.
      64 bytes from 174.143.194.225: icmp_seq=1 ttl=54 time=18.3 ms
      64 bytes from 174.143.194.225: icmp_seq=2 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=3 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=4 ttl=54 time=17.4 ms

      --- openstack.org ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3022ms
      rtt min/avg/max/mdev = 17.489/17.715/18.346/0.364 ms

#. From the *network* node, :command:`ping` the management interface on the
   *controller* node:

   .. code-block:: console

      # ping -c 4 controller
      PING controller (10.0.0.11) 56(84) bytes of data.
      64 bytes from controller (10.0.0.11): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from controller (10.0.0.11): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from controller (10.0.0.11): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from controller (10.0.0.11): icmp_seq=4 ttl=64 time=0.202 ms

      --- controller ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms


#. From the *network* node, :command:`ping` the instance tunnels interface
   on the *compute* node:

   .. code-block:: console

      # ping -c 4 10.0.1.31
      PING 10.0.1.31 (10.0.1.31) 56(84) bytes of data.
      64 bytes from 10.0.1.31 (10.0.1.31): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from 10.0.1.31 (10.0.1.31): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from 10.0.1.31 (10.0.1.31): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from 10.0.1.31 (10.0.1.31): icmp_seq=4 ttl=64 time=0.202 ms

      --- 10.0.1.31 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms

#. From the *compute* node, :command:`ping` a site on the Internet:

   .. code-block:: console

      # ping -c 4 openstack.org
      PING openstack.org (174.143.194.225) 56(84) bytes of data.
      64 bytes from 174.143.194.225: icmp_seq=1 ttl=54 time=18.3 ms
      64 bytes from 174.143.194.225: icmp_seq=2 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=3 ttl=54 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_seq=4 ttl=54 time=17.4 ms

      --- openstack.org ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3022ms
      rtt min/avg/max/mdev = 17.489/17.715/18.346/0.364 ms

#. From the *compute* node, :command:`ping` the management interface on the
   *controller* node:

   .. code-block:: console

      # ping -c 4 controller
      PING controller (10.0.0.11) 56(84) bytes of data.
      64 bytes from controller (10.0.0.11): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from controller (10.0.0.11): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from controller (10.0.0.11): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from controller (10.0.0.11): icmp_seq=4 ttl=64 time=0.202 ms

      --- controller ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms

#. From the *compute* node, :command:`ping` the instance tunnels interface
   on the *network* node:

   .. code-block:: console

      # ping -c 4 10.0.1.21
      PING 10.0.1.21 (10.0.1.21) 56(84) bytes of data.
      64 bytes from 10.0.1.21 (10.0.1.21): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from 10.0.1.21 (10.0.1.21): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from 10.0.1.21 (10.0.1.21): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from 10.0.1.21 (10.0.1.21): icmp_seq=4 ttl=64 time=0.202 ms

      --- 10.0.1.21 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms
