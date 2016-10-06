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

         # apt install chrony

      .. end

   .. endonly

   .. only:: rdo

      .. code-block:: console

         # yum install chrony

      .. end

   .. endonly

   .. only:: obs

      On openSUSE:

      .. code-block:: console

         # zypper addrepo -f obs://network:time/openSUSE_Leap_42.2 network_time
         # zypper refresh
         # zypper install chrony

      .. end

      On SLES:

      .. code-block:: console

         # zypper addrepo -f obs://network:time/SLE_12_SP2 network_time
         # zypper refresh
         # zypper install chrony

      .. end

      .. note::

         The packages are signed by GPG key ``17280DDF``. You should
         verify the fingerprint of the imported GPG key before using it.

         .. code-block:: console

            Key Name:         network OBS Project <network@build.opensuse.org>
            Key Fingerprint:  0080689B E757A876 CB7DC269 62EB1A09 17280DDF
            Key Created:      Tue 24 Sep 2013 04:04:12 PM UTC
            Key Expires:      Thu 03 Dec 2015 04:04:12 PM UTC

         .. end

   .. endonly

.. only:: ubuntu or debian

   2. Edit the ``/etc/chrony/chrony.conf`` file and comment out or remove all
      but one ``server`` key. Change it to reference the controller node:

      .. path /etc/chrony/chrony.conf
      .. code-block:: ini

         server controller iburst

      .. end

   3. Comment out the ``pool 2.debian.pool.ntp.org offline iburst`` line.

   4. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

      .. end

.. endonly

.. only:: rdo or obs

   2. Edit the ``/etc/chrony.conf`` file and comment out or remove all but one
      ``server`` key. Change it to reference the controller node:

      .. path /etc/chrony.conf
      .. code-block:: ini

         server controller iburst

      .. end

   3. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service

      .. end

.. endonly
