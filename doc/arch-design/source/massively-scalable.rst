==================
Massively scalable
==================

.. toctree::
   :maxdepth: 2

   massively-scalable-user-requirements.rst
   massively-scalable-technical-considerations.rst
   massively-scalable-operational-considerations.rst

A massively scalable architecture is a cloud implementation
that is either a very large deployment, such as a commercial
service provider might build, or one that has the capability
to support user requests for large amounts of cloud resources.

An example is an infrastructure in which requests to service
500 or more instances at a time is common. A massively scalable
infrastructure fulfills such a request without exhausting the
available cloud infrastructure resources. While the high capital
cost of implementing such a cloud architecture means that it
is currently in limited use, many organizations are planning for
massive scalability in the future.

A massively scalable OpenStack cloud design presents a unique
set of challenges and considerations. For the most part it is
similar to a general purpose cloud architecture, as it is built
to address a non-specific range of potential use cases or
functions. Typically, it is rare that particular workloads determine
the design or configuration of massively scalable clouds. The
massively scalable cloud is most often built as a platform for
a variety of workloads. Because private organizations rarely
require or have the resources for them, massively scalable
OpenStack clouds are generally built as commercial, public
cloud offerings.

Services provided by a massively scalable OpenStack cloud
include:

* Virtual-machine disk image library
* Raw block storage
* File or object storage
* Firewall functionality
* Load balancing functionality
* Private (non-routable) and public (floating) IP addresses
* Virtualized network topologies
* Software bundles
* Virtual compute resources

Like a general purpose cloud, the instances deployed in a
massively scalable OpenStack cloud do not necessarily use
any specific aspect of the cloud offering (compute, network, or storage).
As the cloud grows in scale, the number of workloads can cause
stress on all the cloud components. This adds further stresses
to supporting infrastructure such as databases and message brokers.
The architecture design for such a cloud must account for these
performance pressures without negatively impacting user experience.
