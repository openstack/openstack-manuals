.. _storage-cloud:

=============
Storage cloud
=============

Design model
~~~~~~~~~~~~

Storage-focused architecture depends on specific use cases. This section
discusses three example use cases:

*  An object store with a RESTful interface

*  Compute analytics with parallel file systems

*  High performance database


An object store with a RESTful interface
----------------------------------------

The example below shows a REST interface without a high performance
requirement. The following diagram depicts the example architecture:

.. figure:: ../figures/Storage_Object.png

The example REST interface, presented as a traditional Object Store
running on traditional spindles, does not require a high performance
caching tier.

This example uses the following components:

Network:

*  10 GbE horizontally scalable spine leaf back-end storage and front
   end network.

Storage hardware:

*  10 storage servers each with 12x4 TB disks equaling 480 TB total
   space with approximately 160 TB of usable space after replicas.

Proxy:

*  3x proxies

*  2x10 GbE bonded front end

*  2x10 GbE back-end bonds

*  Approximately 60 Gb of total bandwidth to the back-end storage
   cluster

.. note::

   It may be necessary to implement a third party caching layer for some
   applications to achieve suitable performance.



Compute analytics with data processing service
----------------------------------------------

Analytics of large data sets are dependent on the performance of the
storage system. Clouds using storage systems such as Hadoop Distributed
File System (HDFS) have inefficiencies which can cause performance
issues.

One potential solution to this problem is the implementation of storage
systems designed for performance. Parallel file systems have previously
filled this need in the HPC space and are suitable for large scale
performance-orientated systems.

OpenStack has integration with Hadoop to manage the Hadoop cluster
within the cloud. The following diagram shows an OpenStack store with a
high performance requirement:

.. figure:: ../figures/Storage_Hadoop3.png

The hardware requirements and configuration are similar to those of the
High Performance Database example below. In this case, the architecture
uses Ceph's Swift-compatible REST interface, features that allow for
connecting a caching pool to allow for acceleration of the presented
pool.

High performance database with Database service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Databases are a common workload that benefit from high performance
storage back ends. Although enterprise storage is not a requirement,
many environments have existing storage that OpenStack cloud can use as
back ends. You can create a storage pool to provide block devices with
OpenStack Block Storage for instances as well as object interfaces. In
this example, the database I-O requirements are high and demand storage
presented from a fast SSD pool.

A storage system presents a LUN backed by a set of SSDs using a
traditional storage array with OpenStack Block Storage integration or a
storage platform such as Ceph or Gluster.

This system can provide additional performance. For example, in the
database example below, a portion of the SSD pool can act as a block
device to the Database server. In the high performance analytics
example, the inline SSD cache layer accelerates the REST interface.

.. figure:: ../figures/Storage_Database_+_Object5.png

In this example, Ceph presents a swift-compatible REST interface, as
well as a block level storage from a distributed storage cluster. It is
highly flexible and has features that enable reduced cost of operations
such as self healing and auto balancing. Using erasure coded pools are a
suitable way of maximizing the amount of usable space.

.. note::

   There are special considerations around erasure coded pools. For
   example, higher computational requirements and limitations on the
   operations allowed on an object; erasure coded pools do not support
   partial writes.

Using Ceph as an applicable example, a potential architecture would have
the following requirements:

Network:

*  10 GbE horizontally scalable spine leaf back-end storage and
   front-end network

Storage hardware:

*  5 storage servers for caching layer 24x1 TB SSD

*  10 storage servers each with 12x4 TB disks which equals 480 TB total
   space with about approximately 160 TB of usable space after 3
   replicas

REST proxy:

*  3x proxies

*  2x10 GbE bonded front end

*  2x10 GbE back-end bonds

*  Approximately 60 Gb of total bandwidth to the back-end storage
   cluster

Using an SSD cache layer, you can present block devices directly to
hypervisors or instances. The REST interface can also use the SSD cache
systems as an inline cache.


Requirements
~~~~~~~~~~~~

Storage requirements
--------------------

Storage-focused OpenStack clouds must address I/O intensive workloads.
These workloads are not CPU intensive, nor are they consistently network
intensive. The network may be heavily utilized to transfer storage, but
they are not otherwise network intensive.

The selection of storage hardware determines the overall performance and
scalability of a storage-focused OpenStack design architecture. Several
factors impact the design process, including:

Latency
 A key consideration in a storage-focused OpenStack cloud is latency.
 Using solid-state disks (SSDs) to minimize latency and, to reduce CPU
 delays caused by waiting for the storage, increases performance. Use
 RAID controller cards in compute hosts to improve the performance of the
 underlying disk subsystem.

Scale-out solutions
 Depending on the storage architecture, you can adopt a scale-out
 solution, or use a highly expandable and scalable centralized storage
 array. If a centralized storage array meets your requirements, then the
 array vendor determines the hardware selection. It is possible to build
 a storage array using commodity hardware with Open Source software, but
 requires people with expertise to build such a system.

 On the other hand, a scale-out storage solution that uses
 direct-attached storage (DAS) in the servers may be an appropriate
 choice. This requires configuration of the server hardware to support
 the storage solution.

Considerations affecting storage architecture (and corresponding storage
hardware) of a Storage-focused OpenStack cloud include:

Connectivity
 Ensure the connectivity matches the storage solution requirements. We
 recommend confirming that the network characteristics minimize latency
 to boost the overall performance of the design.

Latency
 Determine if the use case has consistent or highly variable latency.

Throughput
 Ensure that the storage solution throughput is optimized for your
 application requirements.

Server hardware
 Use of DAS impacts the server hardware choice and affects host
 density, instance density, power density, OS-hypervisor, and
 management tools.

Component block diagram
~~~~~~~~~~~~~~~~~~~~~~~
