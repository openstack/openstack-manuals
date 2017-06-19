.. _environment-ntp-controller:

=================
 Controller node
=================

Perform these steps on the controller node.

Install and configure components
================================

1. Install the packages:

   For Debian or Ubuntu:

      .. code-block:: console

         # apt install chrony

      .. end

   For Red Hat or CentOS:

      .. code-block:: console

         # yum install chrony

      .. end

   For SUSE:

      .. code-block:: console

         # zypper install chrony

      .. end

2. Edit the ``/etc/chrony/chrony.conf`` file and add, change, or remove
   these keys as necessary for your environment:

   .. code-block:: shell

      server NTP_SERVER iburst

   .. end

   Replace ``NTP_SERVER`` with the hostname or IP address of a
   suitable more accurate (lower stratum) NTP server. The
   configuration supports multiple ``server`` keys.

   .. note::

      By default, the controller node synchronizes the time via a pool of
      public servers. However, you can optionally configure alternative
      servers such as those provided by your organization.

3. To enable other nodes to connect to the chrony daemon on the
   controller node, add this key to the ``/etc/chrony/chrony.conf``
   file:

   .. code-block:: shell

      allow 10.0.0.0/24

   .. end

   If necessary, replace ``10.0.0.0/24`` with a description of your
   subnet.

4. Restart the NTP service:

   For Debian or Ubuntu:

      .. code-block:: console

         # service chrony restart

      .. end

   For Red Hat or SUSE:

      .. code-block:: console

         # systemctl enable chronyd.service
         # systemctl start chronyd.service

      .. end
