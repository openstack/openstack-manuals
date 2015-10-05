.. _environment-ntp-controller:

Controller node
~~~~~~~~~~~~~~~

Install and configure components
--------------------------------

Install the packages:

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install chrony

.. only:: rdo

   .. code-block:: console

      # yum install chrony

.. only:: obs

   On openSUSE 13.2:

   .. code-block:: console

      # zypper addrepo -f http://download.opensuse.org/repositories/network:time/openSUSE_13.2/network:time.repo network_time
      # zypper refresh
      # zypper install chrony

   On SLES 12:

   .. code-block:: console

      # zypper addrepo -f http://download.opensuse.org/repositories/network:time/SLE_12/network:time.repo network_time
      # zypper refresh
      # zypper install chrony

By default, the controller node synchronizes the time via a pool of
public servers. However, you can optionally configure alternative servers such
as those provided by your organization.

.. only:: ubuntu or debian

   #. Edit the ``/etc/chrony/chrony.conf`` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code-block:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   #. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   #. Edit the ``/etc/chrony.conf`` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code-block:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   #. To enable other nodes to connect to the chrony daemon on the controller,
      add the following key to the ``/etc/chrony.conf`` file:

      .. code-block:: ini

         allow 10.0.0.0/24

      If necessary, replace ``10.0.0.0/24`` with a description of your subnet.

   #. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service
