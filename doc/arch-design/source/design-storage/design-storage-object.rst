==============
Object Storage
==============

Object Storage is implemented in OpenStack by the
OpenStack Object Storage (swift) project. Users access binary objects
through a REST API. If your intended users need to
archive or manage large datasets, you want to provide them with Object
Storage. In addition, OpenStack can store your virtual machine (VM)
images inside of an object storage system, as an alternative to storing
the images on a file system.

OpenStack Object Storage provides a highly scalable, highly available
storage solution by relaxing some of the constraints of traditional file
systems. In designing and procuring for such a cluster, it is important
to understand some key concepts about its operation. Essentially, this
type of storage is built on the idea that all storage hardware fails, at
every level, at some point. Infrequently encountered failures that would
hamstring other storage systems, such as issues taking down RAID cards
or entire servers, are handled gracefully with OpenStack Object
Storage. For more information, see the  `Swift developer
documentation <https://docs.openstack.org/developer/swift/overview_architecture.html>`_

When designing your cluster, you must consider durability and
availability which is dependent on the spread and placement of your data,
rather than the reliability of the hardware.

Consider the default value of the number of replicas, which is three. This
means that before an object is marked as having been written, at least two
copies exist in case a single server fails to write, the third copy may or
may not yet exist when the write operation initially returns. Altering this
number increases the robustness of your data, but reduces the amount of
storage you have available. Look at the placement of your servers. Consider
spreading them widely throughout your data center's network and power-failure
zones. Is a zone a rack, a server, or a disk?

Consider these main traffic flows for an Object Storage network:

* Among :term:`object`, :term:`container`, and
  :term:`account servers <account server>`
* Between servers and the proxies
* Between the proxies and your users

Object Storage frequent communicates among servers hosting data. Even a small
cluster generates megabytes per second of traffic, which is predominantly, “Do
you have the object?” and “Yes I have the object!” If the answer
to the question is negative or the request times out,
replication of the object begins.

Consider the scenario where an entire server fails and 24 TB of data
needs to be transferred "immediately" to remain at three copies — this can
put significant load on the network.

Another consideration is when a new file is being uploaded, the proxy server
must write out as many streams as there are replicas, multiplying network
traffic. For a three-replica cluster, 10 Gbps in means 30 Gbps out. Combining
this with the previous high bandwidth bandwidth private versus public network
recommendations demands of replication is what results in the recommendation
that your private network be of significantly higher bandwidth than your public
network requires. OpenStack Object Storage communicates internally with
unencrypted, unauthenticated rsync for performance, so the private
network is required.

The remaining point on bandwidth is the public-facing portion. The
``swift-proxy`` service is stateless, which means that you can easily
add more and use HTTP load-balancing methods to share bandwidth and
availability between them.

More proxies means more bandwidth, if your storage can keep up.
