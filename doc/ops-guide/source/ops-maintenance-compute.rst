=====================================
Compute Node Failures and Maintenance
=====================================

Sometimes a compute node either crashes unexpectedly or requires a
reboot for maintenance reasons.

Planned Maintenance
~~~~~~~~~~~~~~~~~~~

If you need to reboot a compute node due to planned maintenance, such as
a software or hardware upgrade, perform the following steps:

#. Disable scheduling of new VMs to the node, optionally providing a reason
   comment:

   .. code-block:: console

      # openstack compute service set --disable --disable-reason \
      maintenance c01.example.com nova-compute

#. Verify that all hosted instances have been moved off the node:

   * If your cloud is using a shared storage:

     #. Get a list of instances that need to be moved:

        .. code-block:: console

           # openstack server list --host c01.example.com --all-projects

     #. Migrate all instances one by one:

        .. code-block:: console

           # openstack server migrate <uuid> --live c02.example.com

   * If your cloud is not using a shared storage, run:

     .. code-block:: console

        # openstack server migrate <uuid> --live --block-migration c02.example.com

#. Stop the ``nova-compute`` service:

   .. code-block:: console

      # stop nova-compute

   If you use a configuration-management system, such as Puppet, that
   ensures the ``nova-compute`` service is always running, you can
   temporarily move the ``init`` files:

   .. code-block:: console

      # mkdir /root/tmp
      # mv /etc/init/nova-compute.conf /root/tmp
      # mv /etc/init.d/nova-compute /root/tmp

#. Shut down your compute node, perform the maintenance, and turn
   the node back on.

#. Start the ``nova-compute`` service:

   .. code-block:: console

      # start nova-compute

   You can re-enable the ``nova-compute`` service by undoing the commands:

   .. code-block:: console

      # mv /root/tmp/nova-compute.conf /etc/init
      # mv /root/tmp/nova-compute /etc/init.d/

#. Enable scheduling of VMs to the node:

   .. code-block:: console

      # openstack compute service set --enable c01.example.com nova-compute

#. Optionally, migrate the instances back to their original compute node.

After a Compute Node Reboots
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you reboot a compute node, first verify that it booted
successfully. This includes ensuring that the ``nova-compute`` service
is running:

.. code-block:: console

   # ps aux | grep nova-compute
   # status nova-compute

Also ensure that it has successfully connected to the AMQP server:

.. code-block:: console

   # grep AMQP /var/log/nova/nova-compute.log
   2013-02-26 09:51:31 12427 INFO nova.openstack.common.rpc.common [-] Connected to AMQP server on 199.116.232.36:5672

After the compute node is successfully running, you must deal with the
instances that are hosted on that compute node because none of them are
running. Depending on your SLA with your users or customers, you might
have to start each instance and ensure that they start correctly.

Instances
~~~~~~~~~

You can create a list of instances that are hosted on the compute node
by performing the following command:

.. code-block:: console

   # openstack server list --host c01.example.com --all-projects

After you have the list, you can use the :command:`openstack` command to
start each instance:

.. code-block:: console

   # openstack server reboot <server>

.. note::

   Any time an instance shuts down unexpectedly, it might have problems
   on boot. For example, the instance might require an ``fsck`` on the
   root partition. If this happens, the user can use the dashboard VNC
   console to fix this.

If an instance does not boot, meaning ``virsh list`` never shows the
instance as even attempting to boot, do the following on the compute
node:

.. code-block:: console

   # tail -f /var/log/nova/nova-compute.log

Try executing the :command:`openstack server reboot` command again. You should
see an error message about why the instance was not able to boot.

In most cases, the error is the result of something in libvirt's XML
file (``/etc/libvirt/qemu/instance-xxxxxxxx.xml``) that no longer
exists. You can enforce re-creation of the XML file as well as rebooting
the instance by running the following command:

.. code-block:: console

   # openstack server reboot --hard <server>

Inspecting and Recovering Data from Failed Instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In some scenarios, instances are running but are inaccessible through
SSH and do not respond to any command. The VNC console could be
displaying a boot failure or kernel panic error messages. This could be
an indication of file system corruption on the VM itself. If you need to
recover files or inspect the content of the instance, qemu-nbd can be
used to mount the disk.

.. warning::

   If you access or view the user's content and data, get approval first!

To access the instance's disk
(``/var/lib/nova/instances/instance-xxxxxx/disk``), use the following
steps:

#. Suspend the instance using the ``virsh`` command.

#. Connect the qemu-nbd device to the disk.

#. Mount the qemu-nbd device.

#. Unmount the device after inspecting.

#. Disconnect the qemu-nbd device.

#. Resume the instance.

If you do not follow last three steps, OpenStack Compute cannot manage
the instance any longer. It fails to respond to any command issued by
OpenStack Compute, and it is marked as shut down.

Once you mount the disk file, you should be able to access it and treat
it as a collection of normal directories with files and a directory
structure. However, we do not recommend that you edit or touch any files
because this could change the
:term:`access control lists (ACLs) <access control list (ACL)>` that are used
to determine which accounts can perform what operations on files and
directories. Changing ACLs can make the instance unbootable if it is not
already.

#. Suspend the instance using the :command:`virsh` command, taking note of the
   internal ID:

   .. code-block:: console

      # virsh list
      Id Name                 State
      ----------------------------------
       1 instance-00000981    running
       2 instance-000009f5    running
      30 instance-0000274a    running

      # virsh suspend 30
      Domain 30 suspended

#. Find the ID for each instance by listing the server IDs using the
   following command:

   .. code-block:: console

      # openstack server list
      +--------------------------------------+-------+---------+-----------------------------+------------+
      | ID                                   | Name  | Status  | Networks                    | Image Name |
      +--------------------------------------+-------+---------+-----------------------------+------------+
      | 2da14c5c-de6d-407d-a7d2-2dd0862b9967 | try3  | ACTIVE  | finance-internal=10.10.0.4  |            |
      | 223f4860-722a-44a0-bac7-f73f58beec7b | try2  | ACTIVE  | finance-internal=10.10.0.13 |            |
      +--------------------------------------+-------+---------+-----------------------------+------------+

#. Connect the qemu-nbd device to the disk:

   .. code-block:: console

      # cd /var/lib/nova/instances/instance-0000274a
      # ls -lh
      total 33M
      -rw-rw---- 1 libvirt-qemu kvm  6.3K Oct 15 11:31 console.log
      -rw-r--r-- 1 libvirt-qemu kvm   33M Oct 15 22:06 disk
      -rw-r--r-- 1 libvirt-qemu kvm  384K Oct 15 22:06 disk.local
      -rw-rw-r-- 1 nova         nova 1.7K Oct 15 11:30 libvirt.xml
      # qemu-nbd -c /dev/nbd0 `pwd`/disk

#. Mount the qemu-nbd device.

   The qemu-nbd device tries to export the instance disk's different
   partitions as separate devices. For example, if vda is the disk and
   vda1 is the root partition, qemu-nbd exports the device as
   ``/dev/nbd0`` and ``/dev/nbd0p1``, respectively:

   .. code-block:: console

      # mount /dev/nbd0p1 /mnt/

   You can now access the contents of ``/mnt``, which correspond to the
   first partition of the instance's disk.

   To examine the secondary or ephemeral disk, use an alternate mount
   point if you want both primary and secondary drives mounted at the
   same time:

   .. code-block:: console

      # umount /mnt
      # qemu-nbd -c /dev/nbd1 `pwd`/disk.local
      # mount /dev/nbd1 /mnt/
      # ls -lh /mnt/
      total 76K
      lrwxrwxrwx.  1 root root    7 Oct 15 00:44 bin -> usr/bin
      dr-xr-xr-x.  4 root root 4.0K Oct 15 01:07 boot
      drwxr-xr-x.  2 root root 4.0K Oct 15 00:42 dev
      drwxr-xr-x. 70 root root 4.0K Oct 15 11:31 etc
      drwxr-xr-x.  3 root root 4.0K Oct 15 01:07 home
      lrwxrwxrwx.  1 root root    7 Oct 15 00:44 lib -> usr/lib
      lrwxrwxrwx.  1 root root    9 Oct 15 00:44 lib64 -> usr/lib64
      drwx------.  2 root root  16K Oct 15 00:42 lost+found
      drwxr-xr-x.  2 root root 4.0K Feb  3  2012 media
      drwxr-xr-x.  2 root root 4.0K Feb  3  2012 mnt
      drwxr-xr-x.  2 root root 4.0K Feb  3  2012 opt
      drwxr-xr-x.  2 root root 4.0K Oct 15 00:42 proc
      dr-xr-x---.  3 root root 4.0K Oct 15 21:56 root
      drwxr-xr-x. 14 root root 4.0K Oct 15 01:07 run
      lrwxrwxrwx.  1 root root    8 Oct 15 00:44 sbin -> usr/sbin
      drwxr-xr-x.  2 root root 4.0K Feb  3  2012 srv
      drwxr-xr-x.  2 root root 4.0K Oct 15 00:42 sys
      drwxrwxrwt.  9 root root 4.0K Oct 15 16:29 tmp
      drwxr-xr-x. 13 root root 4.0K Oct 15 00:44 usr
      drwxr-xr-x. 17 root root 4.0K Oct 15 00:44 var

#. Once you have completed the inspection, unmount the mount point and
   release the qemu-nbd device:

   .. code-block:: console

      # umount /mnt
      # qemu-nbd -d /dev/nbd0
      /dev/nbd0 disconnected

#. Resume the instance using :command:`virsh`:

   .. code-block:: console

      # virsh list
      Id Name                 State
      ----------------------------------
       1 instance-00000981    running
       2 instance-000009f5    running
      30 instance-0000274a    paused

      # virsh resume 30
      Domain 30 resumed

Managing floating IP addresses between instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In an elastic cloud environment using the ``Public_AGILE`` network, each
instance has a publicly accessible IPv4 & IPv6 address. It does not support
the concept of OpenStack floating IP addresses that can easily be attached,
removed, and transferred between instances. However, there is a workaround
using neutron ports which contain the IPv4 & IPv6 address.

**Create a port that can be reused**

#. Create a port on the ``Public_AGILE`` network:

   .. code-block:: console

      $ openstack port create port1 --network Public_AGILE

      Created a new port:
      +-----------------------+------------------------------------------------------+
      | Field                 | Value                                                |
      +-----------------------+------------------------------------------------------+
      | admin_state_up        | UP                                                   |
      | allowed_address_pairs |                                                      |
      | binding_host_id       | None                                                 |
      | binding_profile       | None                                                 |
      | binding_vif_details   | None                                                 |
      | binding_vif_type      | None                                                 |
      | binding_vnic_type     | normal                                               |
      | created_at            | 2017-02-26T14:23:18Z                                 |
      | description           |                                                      |
      | device_id             |                                                      |
      | device_owner          |                                                      |
      | dns_assignment        | None                                                 |
      | dns_name              | None                                                 |
      | extra_dhcp_opts       |                                                      |
      | fixed_ips             | ip_address='96.118.182.106',                         |
      |                       | subnet_id='4279c70a-7218-4c7e-94e5-7bd4c045644e'     |
      |                       | ip_address='2001:558:fc0b:100:f816:3eff:fefb:45fb',  |
      |                       | subnet_id='11d8087b-6288-4129-95ff-42c3df0c1df0'     |
      | id                    | 3871bf29-e963-4701-a7dd-8888dbaab375                 |
      | ip_address            | None                                                 |
      | mac_address           | fa:16:3e:e2:09:e0                                    |
      | name                  | port1                                                |
      | network_id            | f41bd921-3a59-49c4-aa95-c2e4496a4b56                 |
      | option_name           | None                                                 |
      | option_value          | None                                                 |
      | port_security_enabled | True                                                 |
      | project_id            | 52f0574689f14c8a99e7ca22c4eb572                      |
      | qos_policy_id         | None                                                 |
      | revision_number       | 6                                                    |
      | security_groups       | 20d96891-0055-428a-8fa6-d5aed25f0dc6                 |
      | status                | DOWN                                                 |
      | subnet_id             | None                                                 |
      | updated_at            | 2017-02-26T14:23:19Z                                 |
      +-----------------------+------------------------------------------------------+

#. If you know the fully qualified domain name (FQDN) that will be assigned to
   the IP address, assign the port with the same name:

   .. code-block:: console

      $ openstack port create "example-fqdn-01.sys.example.com" --network Public_AGILE

      Created a new port:
      +-----------------------+------------------------------------------------------+
      | Field                 | Value                                                |
      +-----------------------+------------------------------------------------------+
      | admin_state_up        | UP                                                   |
      | allowed_address_pairs |                                                      |
      | binding_host_id       | None                                                 |
      | binding_profile       | None                                                 |
      | binding_vif_details   | None                                                 |
      | binding_vif_type      | None                                                 |
      | binding_vnic_type     | normal                                               |
      | created_at            | 2017-02-26T14:24:16Z                                 |
      | description           |                                                      |
      | device_id             |                                                      |
      | device_owner          |                                                      |
      | dns_assignment        | None                                                 |
      | dns_name              | None                                                 |
      | extra_dhcp_opts       |                                                      |
      | fixed_ips             | ip_address='96.118.182.107',                         |
      |                       | subnet_id='4279c70a-7218-4c7e-94e5-7bd4c045644e'     |
      |                       | ip_address='2001:558:fc0b:100:f816:3eff:fefb:65fc',  |
      |                       | subnet_id='11d8087b-6288-4129-95ff-42c3df0c1df0'     |
      | id                    | 731c3b28-3753-4e63-bae3-b58a52d6ccca                 |
      | ip_address            | None                                                 |
      | mac_address           | fa:16:3e:fb:65:fc                                    |
      | name                  | example-fqdn-01.sys.example.com                      |
      | network_id            | f41bd921-3a59-49c4-aa95-c2e4496a4b56                 |
      | option_name           | None                                                 |
      | option_value          | None                                                 |
      | port_security_enabled | True                                                 |
      | project_id            | 52f0574689f14c8a99e7ca22c4eb5720                     |
      | qos_policy_id         | None                                                 |
      | revision_number       | 6                                                    |
      | security_groups       | 20d96891-0055-428a-8fa6-d5aed25f0dc6                 |
      | status                | DOWN                                                 |
      | subnet_id             | None                                                 |
      | updated_at            | 2017-02-26T14:24:17Z                                 |
      +-----------------------+------------------------------------------------------+

#. Use the port when creating an instance:

   .. code-block:: console

      $ openstack server create --flavor m1.medium --image ubuntu.qcow2 \
        --key-name team_key --nic port-id=PORT_ID \
        "example-fqdn-01.sys.example.com"

#. Verify the instance has the correct IP address:

   .. code-block:: console

      +--------------------------------------+----------------------------------------------------------+
      | Field                                | Value                                                    |
      +--------------------------------------+----------------------------------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                                                   |
      | OS-EXT-AZ:availability_zone          | nova                                                     |
      | OS-EXT-SRV-ATTR:host                 | os_compute-1                                             |
      | OS-EXT-SRV-ATTR:hypervisor_hostname  | os_compute.ece.example.com                               |
      | OS-EXT-SRV-ATTR:instance_name        | instance-00012b82                                        |
      | OS-EXT-STS:power_state               | Running                                                  |
      | OS-EXT-STS:task_state                | None                                                     |
      | OS-EXT-STS:vm_state                  | active                                                   |
      | OS-SRV-USG:launched_at               | 2016-11-30T08:55:27.000000                               |
      | OS-SRV-USG:terminated_at             | None                                                     |
      | accessIPv4                           |                                                          |
      | accessIPv6                           |                                                          |
      | addresses                            | public=172.24.4.236                                      |
      | config_drive                         |                                                          |
      | created                              | 2016-11-30T08:55:14Z                                     |
      | flavor                               | m1.medium (103)                                          |
      | hostId                               | aca973d5b7981faaf8c713a0130713bbc1e64151be65c8dfb53039f7 |
      | id                                   | f91bd761-6407-46a6-b5fd-11a8a46e4983                     |
      | image                                | Example Cloud Ubuntu 14.04 x86_64 v2.5 (fb49d7e1-273b-...|
      | key_name                             | team_key                                                 |
      | name                                 | example-fqdn-01.sys.example.com                          |
      | os-extended-volumes:volumes_attached | []                                                       |
      | progress                             | 0                                                        |
      | project_id                           | 2daf82a578e9437cab396c888ff0ca57                         |
      | properties                           |                                                          |
      | security_groups                      | [{u'name': u'default'}]                                  |
      | status                               | ACTIVE                                                   |
      | updated                              | 2016-11-30T08:55:27Z                                     |
      | user_id                              | 8cbea24666ae49bbb8c1641f9b12d2d2                         |
      +--------------------------------------+----------------------------------------------------------+

#. Check the port connection using the netcat utility:

   .. code-block:: console

      $ nc -v -w 2 96.118.182.107 22
      Ncat: Version 7.00 ( https://nmap.org/ncat )
      Ncat: Connected to 96.118.182.107:22.
      SSH-2.0-OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.6

**Detach a port from an instance**

#. Find the port corresponding to the instance. For example:

   .. code-block:: console

      $ openstack port list | grep -B1 96.118.182.107

      | 731c3b28-3753-4e63-bae3-b58a52d6ccca | example-fqdn-01.sys.example.com | fa:16:3e:fb:65:fc | ip_address='96.118.182.107', subnet_id='4279c70a-7218-4c7e-94e5-7bd4c045644e' |

#. Run the :command:`openstack port set` command to remove the port from
   the instance:

   .. code-block:: console

      $ openstack port set 731c3b28-3753-4e63-bae3-b58a52d6ccca \
      --device "" --device-owner "" --no-binding-profile

#.  Delete the instance and create a new instance using the
    ``--nic port-id`` option.

**Retrieve an IP address when an instance is deleted before detaching
a port**

The following procedure is a possible workaround to retrieve an IP address
when an instance has been deleted with the port still attached:

#. Launch several neutron ports:

   .. code-block:: console

      $ for i in {0..10}; do openstack port create --network Public_AGILE \
      ip-recovery; done

#. Check the ports for the lost IP address and update the name:

   .. code-block:: console

      $ openstack port set 731c3b28-3753-4e63-bae3-b58a52d6ccca \
      --name "don't delete"

#. Delete the ports that are not needed:

   .. code-block:: console

      $ for port in $(openstack port list | grep -i ip-recovery | \
      awk '{print $2}'); do openstack port delete $port; done

#. If you still cannot find the lost IP address, repeat these steps
   again.

.. _volumes:

Volumes
~~~~~~~

If the affected instances also had attached volumes, first generate a
list of instance and volume UUIDs:

.. code-block:: mysql

   mysql> select nova.instances.uuid as instance_uuid,
          cinder.volumes.id as volume_uuid, cinder.volumes.status,
          cinder.volumes.attach_status, cinder.volumes.mountpoint,
          cinder.volumes.display_name from cinder.volumes
          inner join nova.instances on cinder.volumes.instance_uuid=nova.instances.uuid
          where nova.instances.host = 'c01.example.com';

You should see a result similar to the following:

.. code-block:: mysql

   +--------------+------------+-------+--------------+-----------+--------------+
   |instance_uuid |volume_uuid |status |attach_status |mountpoint | display_name |
   +--------------+------------+-------+--------------+-----------+--------------+
   |9b969a05      |1f0fbf36    |in-use |attached      |/dev/vdc   | test         |
   +--------------+------------+-------+--------------+-----------+--------------+
   1 row in set (0.00 sec)

Next, manually detach and reattach the volumes, where X is the proper
mount point:

.. code-block:: console

   # openstack server remove volume <instance_uuid> <volume_uuid>
   # openstack server add volume <instance_uuid> <volume_uuid> --device /dev/vdX

Be sure that the instance has successfully booted and is at a login
screen before doing the above.

Total Compute Node Failure
~~~~~~~~~~~~~~~~~~~~~~~~~~

Compute nodes can fail the same way a cloud controller can fail. A
motherboard failure or some other type of hardware failure can cause an
entire compute node to go offline. When this happens, all instances
running on that compute node will not be available. Just like with a
cloud controller failure, if your infrastructure monitoring does not
detect a failed compute node, your users will notify you because of
their lost instances.

If a compute node fails and won't be fixed for a few hours (or at all),
you can relaunch all instances that are hosted on the failed node if you
use shared storage for ``/var/lib/nova/instances``.

To do this, generate a list of instance UUIDs that are hosted on the
failed node by running the following query on the nova database:

.. code-block:: mysql

   mysql> select uuid from instances
          where host = 'c01.example.com' and deleted = 0;

Next, update the nova database to indicate that all instances that used
to be hosted on c01.example.com are now hosted on c02.example.com:

.. code-block:: mysql

   mysql> update instances set host = 'c02.example.com'
          where host = 'c01.example.com' and deleted = 0;

If you're using the Networking service ML2 plug-in, update the
Networking service database to indicate that all ports that used to be
hosted on c01.example.com are now hosted on c02.example.com:

.. code-block:: mysql

   mysql> update ml2_port_bindings set host = 'c02.example.com'
          where host = 'c01.example.com';
   mysql> update ml2_port_binding_levels set host = 'c02.example.com'
          where host = 'c01.example.com';

After that, use the :command:`openstack` command to reboot all instances
that were on c01.example.com while regenerating their XML files at the same
time:

.. code-block:: console

   # openstack server reboot --hard <server>

Finally, reattach volumes using the same method described in the section
:ref:`volumes`.

/var/lib/nova/instances
~~~~~~~~~~~~~~~~~~~~~~~

It's worth mentioning this directory in the context of failed compute
nodes. This directory contains the libvirt KVM file-based disk images
for the instances that are hosted on that compute node. If you are not
running your cloud in a shared storage environment, this directory is
unique across all compute nodes.

``/var/lib/nova/instances`` contains two types of directories.

The first is the ``_base`` directory. This contains all the cached base
images from glance for each unique image that has been launched on that
compute node. Files ending in ``_20`` (or a different number) are the
ephemeral base images.

The other directories are titled ``instance-xxxxxxxx``. These
directories correspond to instances running on that compute node. The
files inside are related to one of the files in the ``_base`` directory.
They're essentially differential-based files containing only the changes
made from the original ``_base`` directory.

All files and directories in ``/var/lib/nova/instances`` are uniquely
named. The files in \_base are uniquely titled for the glance image that
they are based on, and the directory names ``instance-xxxxxxxx`` are
uniquely titled for that particular instance. For example, if you copy
all data from ``/var/lib/nova/instances`` on one compute node to
another, you do not overwrite any files or cause any damage to images
that have the same unique name, because they are essentially the same
file.

Although this method is not documented or supported, you can use it when
your compute node is permanently offline but you have instances locally
stored on it.
