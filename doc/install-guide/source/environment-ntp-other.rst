.. _environment-ntp-other:

=============
 Other nodes
=============

Other nodes reference the controller node for clock synchronization.
Perform these steps on all other nodes.

Install and configure components
================================

1. Install the packages.

   For Ubuntu:

   .. code-block:: console

      # apt install chrony

   For RHEL or CentOS:

   .. code-block:: console

      # yum install chrony

   .. end

   For SUSE:

   .. code-block:: console

      # zypper install chrony

   .. end

2. Edit the ``/etc/chrony.conf`` file and comment out or remove all
   but one ``server`` key. Change it to reference the controller node:

   .. path /etc/chrony.conf
   .. code-block:: shell

      server controller iburst

   .. end

3. Comment out the ``pool 2.debian.pool.ntp.org offline iburst`` line.

4. Restart the NTP service.

   For Ubuntu:

   .. code-block:: console

      # service chrony restart

   .. end

   For RHEL, CentOS, or SUSE:

   .. code-block:: console

      # systemctl enable chronyd.service
      # systemctl start chronyd.service

   .. end
