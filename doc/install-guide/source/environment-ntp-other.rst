.. _environment-ntp-other:

Other nodes
~~~~~~~~~~~

Other nodes reference the controller node for clock synchronization.
Perform these steps on all other nodes.

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

   2. Edit the ``/etc/chrony/chrony.conf`` file and comment out or remove all
      but one ``server`` key. Change it to reference the controller node:

      .. code-block:: ini

         server controller iburst

   3. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   2. Edit the ``/etc/chrony.conf`` file and comment out or remove all but one
      ``server`` key. Change it to reference the controller node:

      .. code-block:: ini

         server controller iburst

   3. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service
