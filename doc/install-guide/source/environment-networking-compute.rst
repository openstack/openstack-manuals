Compute node
~~~~~~~~~~~~

Configure network interfaces
----------------------------

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

Configure name resolution
-------------------------

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
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems. **Do not remove the
      127.0.0.1 entry.**
