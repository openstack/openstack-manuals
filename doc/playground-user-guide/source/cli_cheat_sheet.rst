============================================
OpenStack command-line interface cheat sheet
============================================

Here is a list of common commands for reference.

Identity (keystone)
~~~~~~~~~~~~~~~~~~~

List all users

.. code:: console

    $ keystone user-list

List Identity service catalog

.. code:: console

    $ keystone catalog

Images (glance)
~~~~~~~~~~~~~~~

List images you can access

.. code:: console

    $ glance image-list

Delete specified image

.. code:: console

    $ glance image-delete IMAGE

Describe a specific image

.. code:: console

    $ glance image-show IMAGE

Update image

.. code:: console

    $ glance image-update IMAGE

Upload kernel image

.. code:: console

    $ glance image-create --name "cirros-threepart-kernel" \
      --disk-format aki --container-format aki --is-public False \
      --file ~/images/cirros-0.3.1~pre4-x86_64-vmlinuz

Upload RAM image

.. code:: console

    $ glance image-create --name "cirros-threepart-ramdisk" \
      --disk-format ari --container-format ari --is-public False \
      --file ~/images/cirros-0.3.1~pre4-x86_64-initrd

Upload three-part image

.. code:: console

    $ glance image-create --name "cirros-threepart" --disk-format ami \
      --container-format ami --is-public False \
      --property kernel_id=$KID-property ramdisk_id=$RID \
      --file ~/images/cirros-0.3.1~pre4-x86_64-blank.img

Register raw image

.. code:: console

    $ glance image-create --name "cirros-qcow2" --disk-format qcow2 \
      --container-format bare --is-public False \
      --file ~/images/cirros-0.3.1~pre4-x86_64-disk.img

Compute (nova)
~~~~~~~~~~~~~~

List instances, check status of instance

.. code:: console

    $ nova list

List images

.. code:: console

    $ nova image-list

List flavors

.. code:: console

    $ nova flavor-list

Boot an instance using flavor and image names (if names are unique)

.. code:: console

    $ nova boot --image IMAGE --flavor FLAVOR INSTANCE_NAME
    $ nova boot --image cirros-0.3.1-x86_64-uec --flavor m1.tiny \
      MyFirstInstance

Login to instance

.. code:: console

    # ip netns
    # ip netns exec NETNS_NAME ssh USER@SERVER
    # ip netns exec qdhcp-6021a3b4-8587-4f9c-8064-0103885dfba2 \
      ssh cirros@10.0.0.2

.. note:: In CirrOS the password for user ``cirros`` is "cubswin:)" without
   the quotes.

Show details of instance

.. code:: console

    $ nova show NAME
    $ nova show MyFirstInstance

View console log of instance

.. code:: console

    $ nova console-log MyFirstInstance

Set metadata on an instance

.. code:: console

    $ nova meta volumeTwoImage set newmeta='my meta data'

Create an instance snapshot

.. code:: console

    $ nova image-create volumeTwoImage snapshotOfVolumeImage
    $ nova image-show snapshotOfVolumeImage

Pause, suspend, stop, rescue, resize, rebuild, reboot an instance
-----------------------------------------------------------------

Pause

.. code:: console

    $ nova pause NAME
    $ nova pause volumeTwoImage

Unpause

.. code:: console

    $ nova unpause NAME

Suspend

.. code:: console

    $ nova suspend NAME

Unsuspend

.. code:: console

    $ nova resume NAME

Stop

.. code:: console

    $ nova stop NAME

Start

.. code:: console

    $ nova start NAME

Rescue

.. code:: console

    $ nova rescue NAME
    $ nova rescue NAME --rescue_image_ref RESCUE_IMAGE

Resize

.. code:: console

    $ nova resize NAME FLAVOR
    $ nova resize my-pem-server m1.small
    $ nova resize-confirm my-pem-server1

Rebuild

.. code:: console

    $ nova rebuild NAME IMAGE
    $ nova rebuild newtinny cirros-qcow2

Reboot

.. code:: console

    $ nova reboot NAME
    $ nova reboot newtinny

Inject user data and files into an instance

.. code:: console

    $ nova boot --user-data FILE INSTANCE
    $ nova boot --user-data userdata.txt --image cirros-qcow2 \
      --flavor m1.tiny MyUserdataInstance2

To validate that the file was injected, use ssh to connect to the instance,
and look in ``/var/lib/cloud`` for the file.

Inject a keypair into an instance and access the instance with that
keypair

Create keypair

.. code:: console

    $ nova keypair-add test > test.pem
    $ chmod 600 test.pem

Start an instance (boot)

.. code:: console

    $ nova boot --image cirros-0.3.0-x86_64 --flavor m1.small \
      --key_name test MyFirstServer

Use ssh to connect to the instance

.. code:: console

    # ip netns exec qdhcp-98f09f1e-64c4-4301-a897-5067ee6d544f \
      ssh -i test.pem cirros@10.0.0.4

Manage security groups

Add rules to default security group allowing ping and SSH between
instances in the default security group

.. code:: console

    $ nova secgroup-add-group-rule default default icmp -1 -1
    $ nova secgroup-add-group-rule default default tcp 22 22

Networking (neutron)
~~~~~~~~~~~~~~~~~~~~

Create network

.. code:: console

    $ neutron net-create NAME

Create a subnet

.. code:: console

    $ neutron subnet-create NETWORK_NAME CIDR
    $ neutron subnet-create my-network 10.0.0.0/29

Block Storage (cinder)
~~~~~~~~~~~~~~~~~~~~~~

Used to manage volumes and volume snapshots that attach to instances.

Create a new volume

.. code:: console

    $ cinder create SIZE_IN_GB --display-name NAME
    $ cinder create 1 --display-name MyFirstVolume

Boot an instance and attach to volume

.. code:: console

    $ nova boot --image cirros-qcow2 --flavor m1.tiny MyVolumeInstance

List volumes, notice status of volume

.. code:: console

    $ cinder list

Attach volume to instance after instance is active, and volume is
available

.. code:: console

    $ nova volume-attach INSTANCE_ID VOLUME_ID auto
    $ nova volume-attach MyVolumeInstance /dev/vdb auto

Manage volumes after login into the instance

List storage devices

.. code:: console

    # fdisk -l

Make filesystem on volume

.. code:: console

    # mkfs.ext3 /dev/vdb

Create a mountpoint

.. code:: console

    # mkdir /myspace

Mount the volume at the mountpoint

.. code:: console

    # mount /dev/vdb /myspace

Create a file on the volume

.. code:: console

    # touch /myspace/helloworld.txt
    # ls /myspace

Unmount the volume

.. code:: console

    # umount /myspace

Object Storage (swift)
~~~~~~~~~~~~~~~~~~~~~~

Display information for the account, container, or object

.. code:: console

    $ swift stat
    $ swift stat ACCOUNT
    $ swift stat CONTAINER
    $ swift stat OBJECT

List containers

.. code:: console

    $ swift list

