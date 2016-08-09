=====================================
Storage Node Failures and Maintenance
=====================================

Because of the high redundancy of Object Storage, dealing with object
storage node issues is a lot easier than dealing with compute node
issues.

Rebooting a Storage Node
~~~~~~~~~~~~~~~~~~~~~~~~

If a storage node requires a reboot, simply reboot it. Requests for data
hosted on that node are redirected to other copies while the server is
rebooting.

Shutting Down a Storage Node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you need to shut down a storage node for an extended period of time
(one or more days), consider removing the node from the storage ring.
For example:

.. code-block:: console

   # swift-ring-builder account.builder remove <ip address of storage node>
   # swift-ring-builder container.builder remove <ip address of storage node>
   # swift-ring-builder object.builder remove <ip address of storage node>
   # swift-ring-builder account.builder rebalance
   # swift-ring-builder container.builder rebalance
   # swift-ring-builder object.builder rebalance

Next, redistribute the ring files to the other nodes:

.. code-block:: console

   # for i in s01.example.com s02.example.com s03.example.com
   > do
   > scp *.ring.gz $i:/etc/swift
   > done

These actions effectively take the storage node out of the storage
cluster.

When the node is able to rejoin the cluster, just add it back to the
ring. The exact syntax you use to add a node to your swift cluster with
``swift-ring-builder`` heavily depends on the original options used when
you originally created your cluster. Please refer back to those
commands.

Replacing a Swift Disk
~~~~~~~~~~~~~~~~~~~~~~

If a hard drive fails in an Object Storage node, replacing it is
relatively easy. This assumes that your Object Storage environment is
configured correctly, where the data that is stored on the failed drive
is also replicated to other drives in the Object Storage environment.

This example assumes that ``/dev/sdb`` has failed.

First, unmount the disk:

.. code-block:: console

   # umount /dev/sdb

Next, physically remove the disk from the server and replace it with a
working disk.

Ensure that the operating system has recognized the new disk:

.. code-block:: console

   # dmesg | tail

You should see a message about ``/dev/sdb``.

Because it is recommended to not use partitions on a swift disk, simply
format the disk as a whole:

.. code-block:: console

   # mkfs.xfs /dev/sdb

Finally, mount the disk:

.. code-block:: console

   # mount -a

Swift should notice the new disk and that no data exists. It then begins
replicating the data to the disk from the other existing replicas.
