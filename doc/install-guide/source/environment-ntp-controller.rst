.. _environment-ntp-controller:

=================
 Controller node
=================

Perform these steps on the controller node.

Install and configure components
================================

1. Install the packages:

   For Ubuntu:

   .. code-block:: console

      # apt install chrony

   For RHEL or CentOS:

   .. code-block:: console

      # dnf install chrony

   For SUSE:

   .. code-block:: console

      # zypper install chrony

2. Edit the ``chrony.conf`` file and add, change, or remove the following keys
   as necessary for your environment.

   For RHEL, CentOS, or SUSE, edit the ``/etc/chrony.conf`` file:

   .. code-block:: ini

      server NTP_SERVER iburst

   For Ubuntu, edit the ``/etc/chrony/chrony.conf`` file:

   .. code-block:: ini

      server NTP_SERVER iburst

   Replace ``NTP_SERVER`` with the hostname or IP address of a
   suitable more accurate (lower stratum) NTP server. The
   configuration supports multiple ``server`` keys.

   .. note::

      By default, the controller node synchronizes the time via a pool of
      public servers. However, you can optionally configure alternative
      servers such as those provided by your organization.

3. To enable other nodes to connect to the chrony daemon on the
   controller node, add this key to the same ``chrony.conf`` file mentioned
   above:

   .. code-block:: ini

      allow 10.0.0.0/24

   If necessary, replace ``10.0.0.0/24`` with a description of your
   subnet.

4. Restart the NTP service:

   For Ubuntu:

   .. code-block:: console

      # service chrony restart

   For RHEL, CentOS, or SUSE:

   .. code-block:: console

      # systemctl enable chronyd.service
      # systemctl start chronyd.service
