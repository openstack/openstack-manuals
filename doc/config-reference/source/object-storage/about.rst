==============================
Introduction to Object Storage
==============================

Object Storage is a robust, highly scalable and fault tolerant storage platform
for unstructured data such as objects. Objects are stored bits, accessed
through a RESTful, HTTP-based interface. You cannot access data at the block or
file level. Object Storage is commonly used to archive and back up data, with
use cases in virtual machine image, photo, video and music storage.

Object Storage provides a high degree of availability, throughput, and
performance with its scale out architecture. Each object is replicated across
multiple servers, residing within the same data center or across data centers,
which mitigates the risk of network and hardware failure. In the event of
hardware failure, Object Storage will automatically copy objects to a new
location to ensure that there are always three copies available. Object Storage
is an eventually consistent distributed storage platform; it sacrifices
consistency for maximum availability and partition tolerance. Object Storage
enables you to create a reliable platform by using commodity hardware and
inexpensive storage.

For more information, review the key concepts in the developer documentation at
`docs.openstack.org/developer/swift/
<http://docs.openstack.org/developer/swift/>`__.
