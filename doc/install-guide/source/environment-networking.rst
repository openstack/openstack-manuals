Host Networking
~~~~~~~~~~~~~~~

.. only:: ubuntu

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://help.ubuntu.com/lts/serverguide/network-configuration.html>`__ .

.. only:: debian

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://wiki.debian.org/NetworkConfiguration>`__ .

.. only:: rdo

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Networking_Guide/sec-Using_the_Command_Line_Interface.html>`__ .

.. only:: obs

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `SLES 12 <https://www.suse.com/documentation/sles-12/book_sle_admin/data/sec_basicnet_manconf.html>`__ or `openSUSE <http://activedoc.opensuse.org/book/opensuse-reference/chapter-13-basic-networking>`__ documentation.

All nodes require Internet access for administrative purposes such as package
installation, security updates, :term:`DNS`, and :term:`NTP`. In most cases,
nodes should obtain internet access through the management network interface.
To highlight the importance of network separation, the example architectures
use `private address space <https://tools.ietf.org/html/rfc1918>`__ for the
management network and assume that the physical network infrastructure
provides Internet access via :term:`NAT` or other method. The example
architectures use routable IP address space for the public network and
assume that the physical network infrastructure provides direct Internet
access. In the provider networks architecture, all instances attach directly
to the public network. In the self-service networks architecture, instances
can attach to a private or public network. Private networks can reside
entirely within OpenStack or provide some level of public network access
using :term:`NAT`.

.. _figure-networklayout:

.. figure:: figures/networklayout.png
   :alt: Network layout

The example architectures assume use of the following networks:

- Management on 10.0.0.0/24 with gateway 10.0.0.1

  .. note::

     This network requires a gateway to provide Internet access to all
     nodes for administrative purposes such as package installation,
     security updates, :term:`DNS`, and :term:`NTP`.

- Public on 203.0.113.0/24 with gateway 203.0.113.1

  .. note::

     This network requires a gateway to provide Internet access to
     instances in your OpenStack environment.

You can modify these ranges and gateways to work with your particular
network infrastructure.

.. note::

   Network interface names vary by distribution. Traditionally,
   interfaces use "eth" followed by a sequential number. To cover all
   variations, this guide simply refers to the first interface as the
   interface with the lowest number and the second interface as the
   interface with the highest number.

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

Controller node
---------------

Configure networking
~~~~~~~~~~~~~~~~~~~~

#. Configure the first interface as the management interface:

   IP address: 10.0.0.11

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

#. Reboot the system to activate the changes.

|

Configure name resolution
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Set the hostname of the node to ``controller``.

#. Edit the :file:`/etc/hosts` file to contain the following:

   .. code-block:: ini

      # controller
      10.0.0.11       controller

      # compute1
      10.0.0.31       compute1

   .. warning::

      Some distributions add an extraneous entry in the :file:`/etc/hosts`
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must commend out or remove this
      entry to prevent name resolution problems. **Do not remove the
      ``127.0.0.1`` entry.**

|

Compute node
------------

Configure networking
~~~~~~~~~~~~~~~~~~~~

#. Configure the first interface as the management interface:

   IP address: 10.0.0.31

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

   .. note::

      Additional compute nodes should use 10.0.0.32, 10.0.0.33, and so on.

#. The public interface uses a special configuration without an IP
   address assigned to it. Configure the second interface as the public
   interface:

   Replace ``INTERFACE_NAME`` with the actual interface name. For example,
   *eth1* or *ens224*.

   .. only:: ubuntu or debian

      a. Edit the :file:`/etc/network/interfaces` file to contain the following:

         .. code-block:: ini

            # The public network interface
            auto INTERFACE_NAME
            iface  INTERFACE_NAME inet manual
            up ip link set dev $IFACE up
            down ip link set dev $IFACE down

   .. only:: rdo

      a. Edit the :file:`/etc/sysconfig/network-scripts/ifcfg-INTERFACE_NAME` file
         to contain the following:

         Do not change the ``HWADDR`` and ``UUID`` keys.

         .. code-block:: ini

            DEVICE=INTERFACE_NAME
            TYPE=Ethernet
            ONBOOT="yes"
            BOOTPROTO="none"

   .. only:: obs

      a. Edit the :file:`/etc/sysconfig/network/ifcfg-INTERFACE_NAME` file to
         contain the following:

         .. code-block:: ini

            STARTMODE='auto'
            BOOTPROTO='static'

#. Reboot the system to activate the changes.

|

Configure name resolution
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Set the hostname of the node to ``compute1``.

#. Edit the :file:`/etc/hosts` file to contain the following:

   .. code-block:: ini

      # controller
      10.0.0.11       controller

      # compute1
      10.0.0.31       compute1

   .. warning::

      Some distributions add an extraneous entry in the :file:`/etc/hosts`
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must commend out or remove this
      entry to prevent name resolution problems. **Do not remove the
      ``127.0.0.1`` entry.**

|

Verify connectivity
-------------------

We recommend that you verify network connectivity to the Internet and
among the nodes before proceeding further.

#. From the *controller* node, test access to the Internet:

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

#. From the *controller* node, test access to the management interface on the
   *compute* node:

   .. code-block:: console

      # ping -c 4 compute1
      PING compute1 (10.0.0.31) 56(84) bytes of data.
      64 bytes from compute1 (10.0.0.31): icmp_seq=1 ttl=64 time=0.263 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=2 ttl=64 time=0.202 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=3 ttl=64 time=0.203 ms
      64 bytes from compute1 (10.0.0.31): icmp_seq=4 ttl=64 time=0.202 ms

      --- compute1 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3000ms
      rtt min/avg/max/mdev = 0.202/0.217/0.263/0.030 ms

#. From the *compute* node, test access to the Internet:

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

#. From the *compute* node, test access to the management interface on the
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

.. note::

   .. only:: rdo or obs

      Your distribution enables a restrictive :term:`firewall` by
      default. During the installation process, certain steps will
      fail unless you alter or disable the firewall. For more
      information about securing your environment, refer to the
      `OpenStack Security Guide <http://docs.openstack.org/sec/>`__.

   .. only:: ubuntu or debian

      Your distribution does not enable a restrictive :term:`firewall`
      by default. For more information about securing your environment,
      refer to the
      `OpenStack Security Guide <http://docs.openstack.org/sec/>`__.
