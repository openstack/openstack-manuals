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

   For SUSE:

   .. code-block:: console

      # zypper install chrony

2. Configure the ``chrony.conf`` file and comment out or remove all
   but one ``server`` key. Change it to reference the controller node.

   For RHEL, CentOS, or SUSE, edit the ``/etc/chrony.conf`` file:

   .. code-block:: ini

      server controller iburst

   For Ubuntu, edit the ``/etc/chrony/chrony.conf`` file:

   .. code-block:: ini

      server controller iburst

3. Comment out the ``pool 2.debian.pool.ntp.org offline iburst`` line.

4. Restart the NTP service.

   For Ubuntu:

   .. code-block:: console

      # service chrony restart

   For RHEL, CentOS, or SUSE:

   .. code-block:: console

      # systemctl enable chronyd.service
      # systemctl start chronyd.service
