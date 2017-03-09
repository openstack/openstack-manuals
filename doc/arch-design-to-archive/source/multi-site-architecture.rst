============
Architecture
============

:ref:`ms-openstack-architecture` illustrates a high level multi-site
OpenStack architecture. Each site is an OpenStack cloud but it may be
necessary to architect the sites on different versions. For example,
if the second site is intended to be a replacement for the first site,
they would be different. Another common design would be a private
OpenStack cloud with a replicated site that would be used for high
availability or disaster recovery. The most important design decision
is configuring storage as a single shared pool or separate pools, depending
on user and technical requirements.

.. _ms-openstack-architecture:

.. figure:: figures/Multi-Site_shared_keystone_horizon_swift1.png

   **Multi-site OpenStack architecture**


OpenStack services architecture
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service, which is used by all other OpenStack components
for authorization and the catalog of service endpoints, supports the
concept of regions. A region is a logical construct used to group
OpenStack services in close proximity to one another. The concept of
regions is flexible; it may contain OpenStack service endpoints located
within a distinct geographic region or regions. It may be smaller in
scope, where a region is a single rack within a data center, with
multiple regions existing in adjacent racks in the same data center.

The majority of OpenStack components are designed to run within the
context of a single region. The Compute service is designed to manage
compute resources within a region, with support for subdivisions of
compute resources by using availability zones and cells. The Networking
service can be used to manage network resources in the same broadcast
domain or collection of switches that are linked. The OpenStack Block
Storage service controls storage resources within a region with all
storage resources residing on the same storage network. Like the
OpenStack Compute service, the OpenStack Block Storage service also
supports the availability zone construct which can be used to subdivide
storage resources.

The OpenStack dashboard, OpenStack Identity, and OpenStack Object
Storage services are components that can each be deployed centrally in
order to serve multiple regions.

Storage
~~~~~~~

With multiple OpenStack regions, it is recommended to configure a single
OpenStack Object Storage service endpoint to deliver shared file storage
for all regions. The Object Storage service internally replicates files
to multiple nodes which can be used by applications or workloads in
multiple regions. This simplifies high availability failover and
disaster recovery rollback.

In order to scale the Object Storage service to meet the workload of
multiple regions, multiple proxy workers are run and load-balanced,
storage nodes are installed in each region, and the entire Object
Storage Service can be fronted by an HTTP caching layer. This is done so
client requests for objects can be served out of caches rather than
directly from the storage modules themselves, reducing the actual load
on the storage network. In addition to an HTTP caching layer, use a
caching layer like Memcache to cache objects between the proxy and
storage nodes.

If the cloud is designed with a separate Object Storage service endpoint
made available in each region, applications are required to handle
synchronization (if desired) and other management operations to ensure
consistency across the nodes. For some applications, having multiple
Object Storage Service endpoints located in the same region as the
application may be desirable due to reduced latency, cross region
bandwidth, and ease of deployment.

.. note::

   For the Block Storage service, the most important decisions are the
   selection of the storage technology, and whether a dedicated network
   is used to carry storage traffic from the storage service to the
   compute nodes.

Networking
~~~~~~~~~~

When connecting multiple regions together, there are several design
considerations. The overlay network technology choice determines how
packets are transmitted between regions and how the logical network and
addresses present to the application. If there are security or
regulatory requirements, encryption should be implemented to secure the
traffic between regions. For networking inside a region, the overlay
network technology for project networks is equally important. The overlay
technology and the network traffic that an application generates or
receives can be either complementary or serve cross purposes. For
example, using an overlay technology for an application that transmits a
large amount of small packets could add excessive latency or overhead to
each packet if not configured properly.

Dependencies
~~~~~~~~~~~~

The architecture for a multi-site OpenStack installation is dependent on
a number of factors. One major dependency to consider is storage. When
designing the storage system, the storage mechanism needs to be
determined. Once the storage type is determined, how it is accessed is
critical. For example, we recommend that storage should use a dedicated
network. Another concern is how the storage is configured to protect the
data. For example, the Recovery Point Objective (RPO) and the Recovery
Time Objective (RTO). How quickly recovery from a fault can be
completed, determines how often the replication of data is required.
Ensure that enough storage is allocated to support the data protection
strategy.

Networking decisions include the encapsulation mechanism that can be
used for the project networks, how large the broadcast domains should be,
and the contracted SLAs for the interconnects.
