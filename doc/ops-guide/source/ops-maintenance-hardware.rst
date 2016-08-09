=====================
Working with Hardware
=====================

As for your initial deployment, you should ensure that all hardware is
appropriately burned in before adding it to production. Run software
that uses the hardware to its limits—maxing out RAM, CPU, disk, and
network. Many options are available, and normally double as benchmark
software, so you also get a good idea of the performance of your
system.

Adding a Compute Node
~~~~~~~~~~~~~~~~~~~~~

If you find that you have reached or are reaching the capacity limit of
your computing resources, you should plan to add additional compute
nodes. Adding more nodes is quite easy. The process for adding compute
nodes is the same as when the initial compute nodes were deployed to
your cloud: use an automated deployment system to bootstrap the
bare-metal server with the operating system and then have a
configuration-management system install and configure OpenStack Compute.
Once the Compute service has been installed and configured in the same
way as the other compute nodes, it automatically attaches itself to the
cloud. The cloud controller notices the new node(s) and begins
scheduling instances to launch there.

If your OpenStack Block Storage nodes are separate from your compute
nodes, the same procedure still applies because the same queuing and
polling system is used in both services.

We recommend that you use the same hardware for new compute and block
storage nodes. At the very least, ensure that the CPUs are similar in
the compute nodes to not break live migration.

Adding an Object Storage Node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Adding a new object storage node is different from adding compute or
block storage nodes. You still want to initially configure the server by
using your automated deployment and configuration-management systems.
After that is done, you need to add the local disks of the object
storage node into the object storage ring. The exact command to do this
is the same command that was used to add the initial disks to the ring.
Simply rerun this command on the object storage proxy server for all
disks on the new object storage node. Once this has been done, rebalance
the ring and copy the resulting ring files to the other storage nodes.

.. note::

   If your new object storage node has a different number of disks than
   the original nodes have, the command to add the new node is
   different from the original commands. These parameters vary from
   environment to environment.

Replacing Components
~~~~~~~~~~~~~~~~~~~~

Failures of hardware are common in large-scale deployments such as an
infrastructure cloud. Consider your processes and balance time saving
against availability. For example, an Object Storage cluster can easily
live with dead disks in it for some period of time if it has sufficient
capacity. Or, if your compute installation is not full, you could
consider live migrating instances off a host with a RAM failure until
you have time to deal with the problem.
