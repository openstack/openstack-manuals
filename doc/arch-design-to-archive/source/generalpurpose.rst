===============
General purpose
===============

.. toctree::
   :maxdepth: 2

   generalpurpose-user-requirements.rst
   generalpurpose-technical-considerations.rst
   generalpurpose-operational-considerations.rst
   generalpurpose-architecture.rst
   generalpurpose-prescriptive-example.rst


An OpenStack general purpose cloud is often considered a starting
point for building a cloud deployment. They are designed to balance
the components and do not emphasize any particular aspect of the
overall computing environment. Cloud design must give equal weight
to the compute, network, and storage components. General purpose clouds
are found in private, public, and hybrid environments, lending
themselves to many different use cases.

.. note::

   General purpose clouds are homogeneous deployments.
   They are not suited to specialized environments or edge case situations.

Common uses of a general purpose cloud include:

* Providing a simple database
* A web application runtime environment
* A shared application development platform
* Lab test bed

Use cases that benefit from scale-out rather than scale-up approaches
are good candidates for general purpose cloud architecture.

A general purpose cloud is designed to have a range of potential
uses or functions; not specialized for specific use cases. General
purpose architecture is designed to address 80% of potential use
cases available. The infrastructure, in itself, is a specific use
case, enabling it to be used as a base model for the design process.

General purpose clouds are designed to be platforms that are suited
for general purpose applications.

General purpose clouds are limited to the most basic components,
but they can include additional resources such as:

* Virtual-machine disk image library
* Raw block storage
* File or object storage
* Firewalls
* Load balancers
* IP addresses
* Network overlays or virtual local area networks (VLANs)
* Software bundles
