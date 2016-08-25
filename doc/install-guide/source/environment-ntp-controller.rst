.. _environment-ntp-controller:

Controller node
~~~~~~~~~~~~~~~

Perform these steps on the controller node.

Install and configure components
--------------------------------

1. Install the packages:

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt-get install chrony

   .. only:: rdo

      .. code-block:: console

         # yum install chrony

   .. only:: obs

      On openSUSE:

      .. code-block:: console

         # zypper addrepo -f obs://network:time/openSUSE_Leap_42.1 network_time
         # zypper refresh
         # zypper install chrony

      On SLES:

      .. code-block:: console

         # zypper addrepo -f obs://network:time/SLE_12_SP1 network_time
         # zypper refresh
         # zypper install chrony

      .. note::

         The packages are signed by GPG key ``17280DDF``. You should
         verify the fingerprint of the imported GPG key before using it.

         .. code-block:: console

            Key Name:         network OBS Project <network@build.opensuse.org>
            Key Fingerprint:  0080689B E757A876 CB7DC269 62EB1A09 17280DDF
            Key Created:      Tue 24 Sep 2013 04:04:12 PM UTC
            Key Expires:      Thu 03 Dec 2015 04:04:12 PM UTC

.. only:: ubuntu or debian

   2. Edit the ``/etc/chrony/chrony.conf`` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code-block:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

      .. note::

         By default, the controller node synchronizes the time via a pool of
         public servers. However, you can optionally configure alternative
         servers such as those provided by your organization.

   3. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   2. Edit the ``/etc/chrony.conf`` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code-block:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

      .. note::

         By default, the controller node synchronizes the time via a pool of
         public servers. However, you can optionally configure alternative
         servers such as those provided by your organization.

   3. To enable other nodes to connect to the chrony daemon on the controller node,
      add the following key to the ``/etc/chrony.conf`` file:

      .. code-block:: ini

         allow 10.0.0.0/24

      If necessary, replace ``10.0.0.0/24`` with a description of your subnet.

   4. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service
