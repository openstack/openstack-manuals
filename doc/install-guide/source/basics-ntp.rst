.. highlight:: ini
   :linenothreshold: 1


Configure Network Time Protocol (NTP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should install Chrony, an implementation of
:term:`Network Time Protocol (NTP)`, to properly synchronize services among
nodes. We recommend that you configure the controller node to reference more
accurate (lower stratum) servers and other nodes to reference the controller
node.

Controller node
---------------

**To install the NTP service**

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install chrony

.. only:: rdo

   .. code-block:: console

      # yum install chrony

.. only:: obs

   On openSUSE:

   .. code-block:: console

      # zypper addrepo http://download.opensuse.org/repositories/network:time/openSUSE_13.2/network:time.repo
      # zypper refresh
      # zypper install chrony

   On SLES:

   .. code-block:: console

      # zypper addrepo http://download.opensuse.org/repositories/network:time/SLE_12/network:time.repo
      # zypper refresh
      # zypper install chrony

|

**To configure the NTP service**

By default, the controller node synchronizes the time via a pool of
public servers. However, you can optionally configure alternative servers such
as those provided by your organization.

.. only:: ubuntu or debian

   1. Edit the :file:`/etc/chrony/chrony.conf` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   2. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   1. Edit the :file:`/etc/chrony.conf` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   2. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service

|

.. _basics-ntp-other-nodes:

Other nodes
-----------

**To install the NTP service**

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install chrony

.. only:: rdo

   .. code-block:: console

      # yum install chrony

.. only:: obs

   On openSUSE:

   .. code-block:: console

      # zypper addrepo http://download.opensuse.org/repositories/network:time/openSUSE_13.2/network:time.repo
      # zypper refresh
      # zypper install chrony

   On SLES:

   .. code-block:: console

      # zypper addrepo http://download.opensuse.org/repositories/network:time/SLE_12/network:time.repo
      # zypper refresh
      # zypper install chrony

|

**To configure the NTP service**

Configure the network and compute nodes to reference the controller
node.

.. only:: ubuntu or debian

   1. Edit the :file:`/etc/chrony/chrony.conf` and comment out or remove all but one ``server`` key. Change
      it to reference the controller node:

      .. code:: ini

         server controller iburst

   2. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   1. Edit the :file:`/etc/chrony.conf` and comment out or remove all but one ``server`` key. Change
      it to reference the controller node:

      .. code:: ini

         server controller iburst

   2. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service

|

Verify operation
----------------

We recommend that you verify NTP synchronization before proceeding
further. Some nodes, particularly those that reference the controller
node, can take several minutes to synchronize.

#. Run this command on the *controller* node:

   .. code-block:: console

    # chronyc sources
      210 Number of sources = 2
      MS Name/IP address         Stratum Poll Reach LastRx Last sample
      ===============================================================================
      ^- 192.0.2.11                    2   7    12   137  -2814us[-3000us] +/-   43ms
      ^* 192.0.2.12                    2   6   177    46    +17us[  -23us] +/-   68ms

   Contents in the *Name/IP address* column should indicate the hostname or IP
   address of one or more NTP servers.  Contents in the *S* column should indicate
   *\** for the server to which the NTP service is currently synchronized.

#. Run the same command on *all other* nodes:

   .. code-block:: console

    # chronyc sources
      210 Number of sources = 1
      MS Name/IP address         Stratum Poll Reach LastRx Last sample
      ===============================================================================
      ^* controller                    3    9   377   421    +15us[  -87us] +/-   15ms

   Contents in the *remote* column should indicate the hostname of the controller node.
