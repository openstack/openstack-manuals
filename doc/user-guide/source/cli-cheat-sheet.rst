============================================
OpenStack command-line interface cheat sheet
============================================

Here is a list of common commands for reference.

Identity (keystone)
~~~~~~~~~~~~~~~~~~~

List all users

.. code-block:: console

   $ openstack user list

List Identity service catalog

.. code-block:: console

   $ openstack catalog list

Images (glance)
~~~~~~~~~~~~~~~

List images you can access

.. code-block:: console

   $ openstack image list

Delete specified image

.. code-block:: console

   $ openstack image delete IMAGE

Describe a specific image

.. code-block:: console

   $ openstack image show IMAGE

Update image

.. code-block:: console

   $ openstack image set IMAGE

Upload kernel image

.. code-block:: console

   $ openstack image create "cirros-threepart-kernel" \
     --disk-format aki --container-format aki --public \
     --file ~/images/cirros-0.3.1~pre4-x86_64-vmlinuz

Upload RAM image

.. code-block:: console

   $ openstack image create "cirros-threepart-ramdisk" \
     --disk-format ari --container-format ari --public \
     --file ~/images/cirros-0.3.1~pre4-x86_64-initrd

Upload three-part image

.. code-block:: console

   $ openstack image create "cirros-threepart" --disk-format ami \
     --container-format ami --public \
     --property kernel_id=$KID-property ramdisk_id=$RID \
     --file ~/images/cirros-0.3.1~pre4-x86_64-blank.img

Register raw image

.. code-block:: console

   $ openstack image create "cirros-raw" --disk-format raw \
     --container-format bare --public \
     --file ~/images/cirros-0.3.1~pre4-x86_64-disk.img

Compute (nova)
~~~~~~~~~~~~~~

List instances, check status of instance

.. code-block:: console

   $ openstack server list

List images

.. code-block:: console

   $ openstack image list

Create a flavor named m1.tiny

.. code-block:: console

   $ openstack flavor create --ram 512 --disk 1 --vcpus 1 m1.tiny

List flavors

.. code-block:: console

   $ openstack flavor list

Boot an instance using flavor and image names (if names are unique)

.. code-block:: console

   $ openstack server create --image IMAGE --flavor FLAVOR INSTANCE_NAME
   $ openstack server create --image cirros-0.3.1-x86_64-uec --flavor m1.tiny \
     MyFirstInstance

Log in to the instance (from Linux)

.. note::

   The :command:`ip` command is available only on Linux. Using :command:`ip netns` provides your
   environment a copy of the network stack with its own routes, firewall
   rules, and network devices for better troubleshooting.

.. code-block:: console

   # ip netns
   # ip netns exec NETNS_NAME ssh USER@SERVER
   # ip netns exec qdhcp-6021a3b4-8587-4f9c-8064-0103885dfba2 \
     ssh cirros@10.0.0.2

.. note::

   In CirrOS, the password for user ``cirros`` is ``cubswin:)``.
   For any other operating system, use SSH keys.

Log in to the instance with a public IP address (from Mac)

.. code-block:: console

   $ ssh cloud-user@128.107.37.150

Show details of instance

.. code-block:: console

   $ openstack server show NAME
   $ openstack server show MyFirstInstance

View console log of instance

.. code-block:: console

   $ openstack console log show MyFirstInstance

Set metadata on an instance

.. code-block:: console

   $ nova meta volumeTwoImage set newmeta='my meta data'

Create an instance snapshot

.. code-block:: console

   $ openstack image create volumeTwoImage snapshotOfVolumeImage
   $ openstack image show snapshotOfVolumeImage

Pause, suspend, stop, rescue, resize, rebuild, reboot an instance
-----------------------------------------------------------------

Pause

.. code-block:: console

   $ openstack server pause NAME
   $ openstack server pause volumeTwoImage

Unpause

.. code-block:: console

   $ openstack server unpause NAME

Suspend

.. code-block:: console

   $ openstack server suspend NAME

Unsuspend

.. code-block:: console

   $ openstack server resume NAME

Stop

.. code-block:: console

   $ openstack server stop NAME

Start

.. code-block:: console

   $ openstack server start NAME

Rescue

.. code-block:: console

   $ openstack server rescue NAME
   $ openstack server rescue NAME --rescue_image_ref RESCUE_IMAGE

Resize

.. code-block:: console

   $ openstack server resize NAME FLAVOR
   $ openstack server resize my-pem-server m1.small
   $ openstack server resize --confirm my-pem-server1

Rebuild

.. code-block:: console

   $ openstack server rebuild NAME IMAGE
   $ openstack server rebuild newtinny cirros-qcow2

Reboot

.. code-block:: console

   $ openstack server reboot NAME
   $ openstack server reboot newtinny

Inject user data and files into an instance

.. code-block:: console

   $ openstack server create --user-data FILE INSTANCE
   $ openstack server create --user-data userdata.txt --image cirros-qcow2 \
     --flavor m1.tiny MyUserdataInstance2

To validate that the file was injected, use ssh to connect to the instance,
and look in ``/var/lib/cloud`` for the file.

Inject a keypair into an instance and access the instance with that
keypair

Create keypair

.. code-block:: console

   $ openstack keypair create test > test.pem
   $ chmod 600 test.pem

Start an instance (boot)

.. code-block:: console

   $ openstack server create --image cirros-0.3.0-x86_64 --flavor m1.small \
     --key-name test MyFirstServer

Use ssh to connect to the instance

.. code-block:: console

   # ip netns exec qdhcp-98f09f1e-64c4-4301-a897-5067ee6d544f \
     ssh -i test.pem cirros@10.0.0.4

Manage security groups

Add rules to default security group allowing ping and SSH between
instances in the default security group

.. code-block:: console

   $ openstack security group rule create default \
       --remote-group default --protocol icmp
   $ openstack security group rule create default \
       --remote-group default --dst-port 22

Networking (neutron)
~~~~~~~~~~~~~~~~~~~~

Create network

.. code-block:: console

   $ openstack network create NETWORK_NAME

Create a subnet

.. code-block:: console

   $ openstack subnet create --subnet-pool SUBNET --network NETWORK SUBNET_NAME
   $ openstack subnet create --subnet-pool 10.0.0.0/29 --network net1 subnet1

Block Storage (cinder)
~~~~~~~~~~~~~~~~~~~~~~

Used to manage volumes and volume snapshots that attach to instances.

Create a new volume

.. code-block:: console

   $ openstack volume create --size SIZE_IN_GB NAME
   $ openstack volume create --size 1 MyFirstVolume

Boot an instance and attach to volume

.. code-block:: console

   $ openstack server create --image cirros-qcow2 --flavor m1.tiny MyVolumeInstance

List all volumes, noticing the volume status

.. code-block:: console

   $ openstack volume list

Attach a volume to an instance after the instance is active, and the
volume is available

.. code-block:: console

   $ openstack server add volume INSTANCE_ID VOLUME_ID
   $ openstack server add volume MyVolumeInstance 573e024d-5235-49ce-8332-be1576d323f8

.. note::

   On the Xen Hypervisor it is possible to provide a specific device name instead of
   automatic allocation. For example:

.. code-block:: console

   $ openstack server add volume --device /dev/vdb MyVolumeInstance 573e024d..1576d323f8

   This is not currently possible when using non-Xen hypervisors with OpenStack.

Manage volumes after login into the instance

List storage devices

.. code-block:: console

   # fdisk -l

Make filesystem on volume

.. code-block:: console

   # mkfs.ext3 /dev/vdb

Create a mountpoint

.. code-block:: console

   # mkdir /myspace

Mount the volume at the mountpoint

.. code-block:: console

   # mount /dev/vdb /myspace

Create a file on the volume

.. code-block:: console

   # touch /myspace/helloworld.txt
   # ls /myspace

Unmount the volume

.. code-block:: console

   # umount /myspace

Object Storage (swift)
~~~~~~~~~~~~~~~~~~~~~~

Display information for the account, container, or object

.. code-block:: console

   $ swift stat
   $ swift stat ACCOUNT
   $ swift stat CONTAINER
   $ swift stat OBJECT

List containers

.. code-block:: console

   $ swift list

