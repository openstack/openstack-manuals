==============================
Introduction to Object Storage
==============================

Object Storage (swift) is a robust, highly scalable and fault tolerant storage
platform for unstructured data such as objects. Objects are stored bits,
accessed through a RESTful, HTTP-based interface. You cannot access data at
the block or file level. Object Storage is commonly used to archive and back
up data, with use cases in virtual machine image, photo, video, and music
storage.

Object Storage provides a high degree of availability, throughput, and
performance with its scale out architecture. Each object is replicated across
multiple servers, residing within the same data center or across data centers,
which mitigates the risk of network and hardware failure. In the event of
hardware failure, Object Storage will automatically copy objects to a new
location to ensure that your chosen number of copies are always available.

Object Storage also employs erasure coding. Erasure coding is a set of
algorithms that allows the reconstruction of missing data from a set of
original data. In theory, erasure coding uses less storage capacity with
similar durability characteristics as replicas. From an application
perspective, erasure coding support is transparent. Object Storage
implements erasure coding as a Storage Policy.

Object Storage is an eventually consistent distributed storage platform;
it sacrifices consistency for maximum availability and partition tolerance.
Object Storage enables you to create a reliable platform by using commodity
hardware and inexpensive storage.

For more information, review the key concepts in the developer documentation
at `docs.openstack.org/developer/swift/
<https://docs.openstack.org/developer/swift/>`__.
