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

      .. code-block:: console

         # zypper install chrony

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
