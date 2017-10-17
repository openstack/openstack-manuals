==========================
Instance storage solutions
==========================

As part of the architecture design for a compute cluster, you must specify
storage for the disk on which the instantiated instance runs. There are three
main approaches to providing temporary storage:

* Off compute node storage—shared file system
* On compute node storage—shared file system
* On compute node storage—nonshared file system

In general, the questions you should ask when selecting storage are as
follows:

* What are my workloads?
* Do my workloads have IOPS requirements?
* Are there read, write, or random access performance requirements?
* What is my forecast for the scaling of storage for compute?
* What storage is my enterprise currently using? Can it be re-purposed?
* How do I manage the storage operationally?

Many operators use separate compute and storage hosts instead of a
hyperconverged solution. Compute services and storage services have different
requirements, and compute hosts typically require more CPU and RAM than storage
hosts. Therefore, for a fixed budget, it makes sense to have different
configurations for your compute nodes and your storage nodes. Compute nodes
will be invested in CPU and RAM, and storage nodes will be invested in block
storage.

However, if you are more restricted in the number of physical hosts you have
available for creating your cloud and you want to be able to dedicate as many
of your hosts as possible to running instances, it makes sense to run compute
and storage on the same machines or use an existing storage array that is
available.

The three main approaches to instance storage are provided in the next
few sections.

Non-compute node based shared file system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this option, the disks storing the running instances are hosted in
servers outside of the compute nodes.

If you use separate compute and storage hosts, you can treat your
compute hosts as "stateless". As long as you do not have any instances
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
* Scalability can be affected by network architecture.

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
* Loss of compute nodes decreases storage availability for all hosts.

On compute node storage—nonshared file system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this option, each compute node is specified with enough disks to store the
instances it hosts.

There are two main advantages:

* Heavy I/O usage on one compute node does not affect instances on other
  compute nodes. Direct I/O access can increase performance.
* Each host can have different storage profiles for hosts aggregation and
  availability zones.

There are several disadvantages:

* If a compute node fails, the data associated with the instances running on
  that node is lost.
* The chassis size of the compute node can limit the number of spindles
  able to be used in a compute node.
* Migrations of instances from one node to another are more complicated
  and rely on features that may not continue to be developed.
* If additional storage is required, this option does not scale.

Running a shared file system on a storage system apart from the compute nodes
is ideal for clouds where reliability and scalability are the most important
factors. Running a shared file system on the compute nodes themselves may be
best in a scenario where you have to deploy to pre-existing servers for which
you have little to no control over their specifications or have specific
storage performance needs but do not have a need for persistent storage.

Issues with live migration
--------------------------

Live migration is an integral part of the operations of the
cloud. This feature provides the ability to seamlessly move instances
from one physical host to another, a necessity for performing upgrades
that require reboots of the compute hosts, but only works well with
shared storage.

Live migration can also be done with non-shared storage, using a feature
known as *KVM live block migration*. While an earlier implementation of
block-based migration in KVM and QEMU was considered unreliable, there
is a newer, more reliable implementation of block-based live migration
as of the Mitaka release.

Live migration and block migration still have some issues:

* Error reporting has received some attention in Mitaka and Newton but there
  are improvements needed.
* Live migration resource tracking issues.
* Live migration of rescued images.

Choice of file system
---------------------

If you want to support shared-storage live migration, you need to
configure a distributed file system.

Possible options include:

* NFS (default for Linux)
* Ceph
* GlusterFS
* MooseFS
* Lustre

We recommend that you choose the option operators are most familiar with.
NFS is the easiest to set up and there is extensive community knowledge
about it.
