===========================
Instance storage solutions
===========================

As part of the procurement for a compute cluster, you must specify some
storage for the disk on which the instantiated instance runs. There are
three main approaches to providing this temporary-style storage, and it
is important to understand the implications of the choice.

They are:

* Off compute node storage—shared file system
* On compute node storage—shared file system
* On compute node storage—nonshared file system

In general, the questions you should ask when selecting storage are as
follows:

* What is the platter count you can achieve?
* Do more spindles result in better I/O despite network access?
* Which one results in the best cost-performance scenario you are aiming for?
* How do you manage the storage operationally?

Many operators use separate compute and storage hosts. Compute services
and storage services have different requirements, and compute hosts
typically require more CPU and RAM than storage hosts. Therefore, for a
fixed budget, it makes sense to have different configurations for your
compute nodes and your storage nodes. Compute nodes will be invested in
CPU and RAM, and storage nodes will be invested in block storage.

However, if you are more restricted in the number of physical hosts you
have available for creating your cloud and you want to be able to
dedicate as many of your hosts as possible to running instances, it
makes sense to run compute and storage on the same machines.

The three main approaches to instance storage are provided in the next
few sections.

Off compute node storage—shared file system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this option, the disks storing the running instances are hosted in
servers outside of the compute nodes.

If you use separate compute and storage hosts, you can treat your
compute hosts as "stateless." As long as you do not have any instances
currently running on a compute host, you can take it offline or wipe it
completely without having any effect on the rest of your cloud. This
simplifies maintenance for the compute hosts.

There are several advantages to this approach:

*  If a compute node fails, instances are usually easily recoverable.
*  Running a dedicated storage system can be operationally simpler.
*  You can scale to any number of spindles.
*  It may be possible to share the external storage for other purposes.

The main disadvantages to this approach are:

* Depending on design, heavy I/O usage from some instances can affect
  unrelated instances.
* Use of the network can decrease performance.

On compute node storage—shared file system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this option, each compute node is specified with a significant amount
of disk space, but a distributed file system ties the disks from each
compute node into a single mount.

The main advantage of this option is that it scales to external storage
when you require additional storage.

However, this option has several disadvantages:

* Running a distributed file system can make you lose your data
  locality compared with nonshared storage.
* Recovery of instances is complicated by depending on multiple hosts.
* The chassis size of the compute node can limit the number of spindles
  able to be used in a compute node.
* Use of the network can decrease performance.

On compute node storage—nonshared file system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this option, each compute node is specified with enough disks to
store the instances it hosts.

There are two main advantages:

* Heavy I/O usage on one compute node does not affect instances on
  other compute nodes.
* Direct I/O access can increase performance.

This has several disadvantages:

* If a compute node fails, the instances running on that node are lost.
* The chassis size of the compute node can limit the number of spindles
  able to be used in a compute node.
* Migrations of instances from one node to another are more complicated
  and rely on features that may not continue to be developed.
* If additional storage is required, this option does not scale.

Running a shared file system on a storage system apart from the computes
nodes is ideal for clouds where reliability and scalability are the most
important factors. Running a shared file system on the compute nodes
themselves may be best in a scenario where you have to deploy to
preexisting servers for which you have little to no control over their
specifications. Running a nonshared file system on the compute nodes
themselves is a good option for clouds with high I/O requirements and
low concern for reliability.

Issues with live migration
--------------------------

Live migration is an integral part of the operations of the
cloud. This feature provides the ability to seamlessly move instances
from one physical host to another, a necessity for performing upgrades
that require reboots of the compute hosts, but only works well with
shared storage.

Live migration can also be done with nonshared storage, using a feature
known as *KVM live block migration*. While an earlier implementation of
block-based migration in KVM and QEMU was considered unreliable, there
is a newer, more reliable implementation of block-based live migration
as of QEMU 1.4 and libvirt 1.0.2 that is also compatible with OpenStack.

Choice of file system
---------------------

If you want to support shared-storage live migration, you need to
configure a distributed file system.

Possible options include:

* NFS (default for Linux)
* GlusterFS
* MooseFS
* Lustre

We recommend that you choose the option operators are most familiar with.
NFS is the easiest to set up and there is extensive community knowledge
about it.
