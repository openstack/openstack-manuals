.. _environment-ntp-other:

Other nodes
~~~~~~~~~~~

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

Configure the network and compute nodes to reference the controller
node.

.. only:: ubuntu or debian

   1. Edit the :file:`/etc/chrony/chrony.conf` and comment out or remove all
      but one ``server`` key. Change it to reference the controller node:

      .. code:: ini

         server controller iburst

   2. Restart the NTP service:

      .. code-block:: console

         # service chrony restart

.. only:: rdo or obs

   1. Edit the :file:`/etc/chrony.conf` and comment out or remove all but one
      ``server`` key. Change it to reference the controller node:

      .. code:: ini

         server controller iburst

   2. Start the NTP service and configure it to start when the system boots:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service
