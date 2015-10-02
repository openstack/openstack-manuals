.. _environment-ntp-controller:

Controller node
~~~~~~~~~~~~~~~

Install the NTP service
-----------------------

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

Configure the NTP service
-------------------------

By default, the controller node synchronizes the time via a pool of
public servers. However, you can optionally configure alternative servers such
as those provided by your organization.

.. only:: ubuntu or debian

   #. Edit the :file:`/etc/chrony/chrony.conf` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   #. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   #. Edit the :file:`/etc/chrony.conf` file and add, change, or remove the
      following keys as necessary for your environment:

      .. code:: ini

         server NTP_SERVER iburst

      Replace ``NTP_SERVER`` with the hostname or IP address of a suitable more
      accurate (lower stratum) NTP server. The configuration supports multiple
      ``server`` keys.

   #. To enable other nodes to connect to the chrony daemon on the controller,
      add the following key to :file:`/etc/chrony.conf`:

      .. code:: ini

         allow 10.0.0.0/24

      If necessary, replace ``10.0.0.0/24`` with a description of your subnet.

   #. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service
