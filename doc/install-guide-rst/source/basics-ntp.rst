.. highlight:: ini
   :linenothreshold: 1


Network Time Protocol (NTP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must install :term:`Network Time Protocol (NTP)` to properly
synchronize services among nodes. We recommend that you configure
the controller node to reference more accurate (lower stratum)
servers and other nodes to reference the controller node.


Controller node
---------------

**To install the NTP service**

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install ntp

.. only:: rdo

   .. code-block:: console

      # yum install ntp

.. only:: obs

   .. code-block:: console

      # zypper install ntp

|

**To configure the NTP service**

By default, the controller node synchronizes the time via a pool of
public servers. However, you can optionally edit the :file:`/etc/ntp.conf`
file to configure alternative servers such as those provided by your
organization.

1. Edit the :file:`/etc/ntp.conf` file and add, change, or remove the following
   keys as necessary for your environment:

   .. code:: ini

      server NTP_SERVER iburst
      restrict -4 default kod notrap nomodify
      restrict -6 default kod notrap nomodify

   Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
   accurate (lower stratum) NTP server. The configuration supports multiple
   ``server`` keys.

   .. note::

      For the ``restrict`` keys, you essentially remove the ``nopeer``
      and ``noquery`` options.

   .. only:: ubuntu or debian

      .. note::

         Remove the :file:`/var/lib/ntp/ntp.conf.dhcp` file if it exists.

.. only:: ubuntu or debian

   2. Restart the NTP service:

      .. code-block:: console

         # service ntp restart

.. only:: rdo or obs

   2. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable ntpd.service
         # systemctl start ntpd.service

|

.. _basics-ntp-other-nodes:

Other nodes
-----------

**To install the NTP service**

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install ntp

.. only:: rdo

   .. code-block:: console

      # yum install ntp

.. only:: obs

   .. code-block:: console

      # zypper install ntp

|

**To configure the NTP service**

Configure the network and compute nodes to reference the controller
node.

1. Edit the :file:`/etc/ntp.conf` file:

   Comment out or remove all but one ``server`` key and change it to
   reference the controller node.

   .. code:: ini

      server controller iburst

   .. only:: ubuntu or debian

      .. note::

         Remove the :file:`/var/lib/ntp/ntp.conf.dhcp` file if it exists.

.. only:: ubuntu or debian

   2. Restart the NTP service:

      .. code-block:: console

         # service ntp restart

.. only:: rdo or obs

   2. Start the NTP service and configure it to start when the system
      boots:

      .. code-block:: console

         # systemctl enable ntpd.service
         # systemctl start ntpd.service

|

Verify operation
----------------

We recommend that you verify NTP synchronization before proceeding
further. Some nodes, particularly those that reference the controller
node, can take several minutes to synchronize.

#. Run this command on the *controller* node:

   .. code-block:: console

      # ntpq -c peers
        remote           refid      st t when poll reach   delay   offset  jitter
      ===========================================================================
      *ntp-server1     192.0.2.11   2 u  169 1024  377    1.901   -0.611   5.483
      +ntp-server2     192.0.2.12   2 u  887 1024  377    0.922   -0.246   2.864

   Contents in the *remote* column should indicate the hostname or IP
   address of one or more NTP servers.

   .. note::

      Contents in the *refid* column typically reference IP addresses of
      upstream servers.

#. Run this command on the *controller* node:

   .. code-block:: console

      # ntpq -c assoc
      ind assid status  conf reach auth condition  last_event cnt
      ===========================================================
      1   20487  961a   yes   yes  none  sys.peer    sys_peer  1
      2   20488  941a   yes   yes  none candidate    sys_peer  1

   Contents in the *condition* column should indicate ``sys.peer`` for at
   least one server.

#. Run this command on *all other* nodes:

   .. code-block:: console

      # ntpq -c peers
      remote           refid      st t when poll reach   delay   offset  jitter
      =========================================================================
      *controller      192.0.2.21  3 u  47   64   37    0.308   -0.251   0.079

   Contents in the *remote* column should indicate the hostname of the
   controller node.

   .. note::

      Contents in the *refid* column typically reference IP addresses of
      upstream servers.

#. Run this command on *all other* nodes:

   .. code-block:: console

      # ntpq -c assoc
      ind assid status  conf reach auth condition  last_event cnt
      ===========================================================
      1   21181  963a   yes   yes  none  sys.peer    sys_peer  3

   Contents in the *condition* column should indicate ``sys.peer``.
