.. _section_nova-compute-node-down:

==================================
Recover from a failed compute node
==================================

If Compute is deployed with a shared file system, and a node fails,
there are several methods to quickly recover from the failure. This
section discusses manual recovery.

Evacuate instances
~~~~~~~~~~~~~~~~~~
If a cloud compute node fails due to a hardware malfunction or another reason,
you can evacuate instances using the :command:`nova evacuate` command. See the
`Admin User Guide
<http://docs.openstack.org/user-guide-admin/cli_nova_evacuate.html>`__.


.. _nova-compute-node-down-manual-recovery:

Manual recovery
~~~~~~~~~~~~~~~
Use this procedure to recover a failed compute node manually:

#. Identify the VMs on the affected hosts. To do this, you can use a
   combination of :command:`nova list` and :command:`nova show` or
   :command:`euca-describe-instances`. For example, this command displays
   information about instance i-000015b9 that is running on node np-rcc54:

   ..  code:: console

       $ euca-describe-instances
       i-000015b9 at3-ui02 running nectarkey (376, np-rcc54) 0 m1.xxlarge 2012-06-19T00:48:11.000Z 115.146.93.60

#. Query the Compute database to check the status of the host. This example
   converts an EC2 API instance ID into an OpenStack ID. If you use the
   :command:`nova` commands, you can substitute the ID directly (the output in
   this example has been truncated):

   .. code:: ini

      mysql> SELECT * FROM instances WHERE id = CONV('15b9', 16, 10) \G;
      *************************** 1. row ***************************
      created_at: 2012-06-19 00:48:11
      updated_at: 2012-07-03 00:35:11
      deleted_at: NULL
      ...
      id: 5561
      ...
      power_state: 5
      vm_state: shutoff
      ...
      hostname: at3-ui02
      host: np-rcc54
      ...
      uuid: 3f57699a-e773-4650-a443-b4b37eed5a06
      ...
      task_state: NULL
      ...

   ..  note::

       The credentials for your database can be found in
       :file:`/etc/nova.conf`.

#. Decide which compute host the affected VM should be moved to, and run
   this database command to move the VM to the new host:

   .. code:: console

      mysql> UPDATE instances SET host = 'np-rcc46' WHERE uuid = '3f57699a-e773-4650-a443-b4b37eed5a06';

#. If you are using a hypervisor that relies on libvirt (such as KVM),
   update the :file:`libvirt.xml` file (found in
   :file:`/var/lib/nova/instances/[instance ID]`) with these changes:

   -  Change the ``DHCPSERVER`` value to the host IP address of the new
      compute host.

   -  Update the VNC IP to `0.0.0.0`

#. Reboot the VM:

   .. code:: console

      $ nova reboot 3f57699a-e773-4650-a443-b4b37eed5a06

The database update and :command:`nova reboot` command should be all that is
required to recover a VM from a failed host. However, if you continue to
have problems try recreating the network filter configuration using
``virsh``, restarting the Compute services, or updating the ``vm_state``
and ``power_state`` in the Compute database.

.. _section_nova-uid-mismatch:

Recover from a UID/GID mismatch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In some cases, files on your compute node can end up using the wrong UID
or GID. This can happen when running OpenStack Compute, using a shared
file system, or with an automated configuration tool. This can cause a
number of problems, such as inability to perform live migrations, or
start virtual machines.

This procedure runs on nova-compute hosts, based on the KVM hypervisor:

#. Set the nova UID in :file:`/etc/passwd` to the same number on all hosts (for
   example, 112).

    .. note::

       Make sure you choose UIDs or GIDs that are not in use for other
       users or groups.

#. Set the ``libvirt-qemu`` UID in :file:`/etc/passwd` to the same number on
   all hosts (for example, 119).

#. Set the ``nova`` group in :file:`/etc/group` file to the same number on all
   hosts (for example, 120).

#. Set the ``libvirtd`` group in :file:`/etc/group` file to the same number on
   all hosts (for example, 119).

#. Stop the services on the compute node.

#. Change all the files owned by user or group nova. For example:

    .. code:: console

       # find / -uid 108 -exec chown nova {} \;
       # note the 108 here is the old nova UID before the change
       # find / -gid 120 -exec chgrp nova {} \;

#. Repeat all steps for the :file:`libvirt-qemu` files, if required.

#. Restart the services.

#. Run the :command:`find` command to verify that all files use the correct
   identifiers.

.. _section_nova-disaster-recovery-process:

Recover cloud after disaster
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section covers procedures for managing your cloud after a disaster,
and backing up persistent storage volumes. Backups are mandatory, even
outside of disaster scenarios.

For a definition of a disaster recovery plan (DRP), see
`http://en.wikipedia.org/wiki/Disaster\_Recovery\_Plan <http://en.wikipedia.org/wiki/Disaster_Recovery_Plan>`_.

A disaster could happen to several components of your architecture (for
example, a disk crash, network loss, or a power failure). In this
example, the following components are configured:

-  A cloud controller (nova-api, nova-objectstore, nova-network)

-  A compute node (nova-compute)

-  A storage area network (SAN) used by OpenStack Block Storage
   (cinder-volumes)

The worst disaster for a cloud is power loss, which applies to all three
components. Before a power loss:

-  Create an active iSCSI session from the SAN to the cloud controller
   (used for the ``cinder-volumes`` LVM's VG).

-  Create an active iSCSI session from the cloud controller to the compute
   node (managed by cinder-volume).

-  Create an iSCSI session for every volume (so 14 EBS volumes requires 14
   iSCSI sessions).

-  Create iptables or ebtables rules from the cloud controller to the
   compute node. This allows access from the cloud controller to the
   running instance.

-  Save the current state of the database, the current state of the running
   instances, and the attached volumes (mount point, volume ID, volume
   status, etc), at least from the cloud controller to the compute node.

After power is recovered and all hardware components have restarted:

-  The iSCSI session from the SAN to the cloud no longer exists.

-  The iSCSI session from the cloud controller to the compute node no
   longer exists.

-  The iptables and ebtables from the cloud controller to the compute
   node are recreated. This is because nova-network reapplies
   configurations on boot.

-  Instances are no longer running.

   Note that instances will not be lost, because neither ``destroy`` nor
   ``terminate`` was invoked. The files for the instances will remain on
   the compute node.

-  The database has not been updated.

**Begin recovery**

..  warning::

    Do not add any extra steps to this procedure, or perform the steps
    out of order.

#. Check the current relationship between the volume and its instance, so
   that you can recreate the attachment.

   This information can be found using the :command:`nova volume-list` command.
   Note that the ``nova`` client also includes the ability to get volume
   information from OpenStack Block Storage.

#. Update the database to clean the stalled state. Do this for every
   volume, using these queries:

   .. code:: console

      mysql> use cinder;
      mysql> update volumes set mountpoint=NULL;
      mysql> update volumes set status="available" where status <>"error_deleting";
      mysql> update volumes set attach_status="detached";
      mysql> update volumes set instance_id=0;

   Use :command:`nova volume-list` commands to list all volumes.

#. Restart the instances using the :command:`nova reboot INSTANCE` command.

   .. important::

      Some instances will completely reboot and become reachable, while
      some might stop at the plymouth stage. This is expected behavior, DO
      NOT reboot a second time.

      Instance state at this stage depends on whether you added an
      `/etc/fstab` entry for that volume. Images built with the
      cloud-init package remain in a ``pending`` state, while others skip
      the missing volume and start. This step is performed in order to ask
      Compute to reboot every instance, so that the stored state is
      preserved. It does not matter if not all instances come up
      successfully. For more information about cloud-init, see
      `help.ubuntu.com/community/CloudInit/ <https://help.ubuntu.com/community/CloudInit/>`__.

#. Reattach the volumes to their respective instances, if required, using
   the :command:`nova volume-attach` command. This example uses a file of
   listed volumes to reattach them:

   .. code:: bash

      #!/bin/bash

      while read line; do
          volume=`echo $line | $CUT -f 1 -d " "`
          instance=`echo $line | $CUT -f 2 -d " "`
          mount_point=`echo $line | $CUT -f 3 -d " "`
              echo "ATTACHING VOLUME FOR INSTANCE - $instance"
          nova volume-attach $instance $volume $mount_point
          sleep 2
      done < $volumes_tmp_file

   Instances that were stopped at the plymouth stage will now automatically
   continue booting and start normally. Instances that previously started
   successfully will now be able to see the volume.

#. Log in to the instances with SSH and reboot them.

   If some services depend on the volume, or if a volume has an entry in
   fstab, you should now be able to restart the instance. Restart directly
   from the instance itself, not through ``nova``:

   .. code:: console

      # shutdown -r now

   When you are planning for and performing a disaster recovery, follow
   these tips:

-  Use the ``errors=remount`` parameter in the :file:`fstab` file to prevent
   data corruption.

   This parameter will cause the system to disable the ability to write
   to the disk if it detects an I/O error. This configuration option
   should be added into the cinder-volume server (the one which performs
   the iSCSI connection to the SAN), and into the instances' :file:`fstab`
   files.

-  Do not add the entry for the SAN's disks to the cinder-volume's
   :file:`fstab` file.

   Some systems hang on that step, which means you could lose access to
   your cloud-controller. To re-run the session manually, run this
   command before performing the mount:

   .. code:: console

      # iscsiadm -m discovery -t st -p $SAN_IP $ iscsiadm -m node --target-name $IQN -p $SAN_IP -l

-  On your instances, if you have the whole ``/home/`` directory on the
   disk, leave a user's directory with the user's bash files and the
   :file:`authorized_keys` file (instead of emptying the ``/home`` directory
   and mapping the disk on it).

   This allows you to connect to the instance even without the volume
   attached, if you allow only connections through public keys.

If you want to script the disaster recovery plan (DRP), a bash script is
available from `https://github.com/Razique <https://github.com/Razique/BashStuff/blob/master/SYSTEMS/OpenStack/SCR_5006_V00_NUAC-OPENSTACK-DRP-OpenStack.sh>`_
which performs the following steps:

#. An array is created for instances and their attached volumes.

#. The MySQL database is updated.

#. All instances are restarted with euca2ools.

#. The volumes are reattached.

#. An SSH connection is performed into every instance using Compute
   credentials.

The script includes a ``test mode``, which allows you to perform that
whole sequence for only one instance.

To reproduce the power loss, connect to the compute node which runs that
instance and close the iSCSI session. Do not detach the volume using the
:command:`nova volume-detach` command, manually close the iSCSI session.
This example closes an iSCSI session with the number 15:

..  code:: console

    # iscsiadm -m session -u -r 15

Do not forget the ``-r`` flag. Otherwise, you will close all sessions.
