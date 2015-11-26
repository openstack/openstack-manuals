===============
Compute focused
===============

.. toctree::
   :maxdepth: 2

   compute-focus-technical-considerations.rst
   compute-focus-operational-considerations.rst
   compute-focus-architecture.rst
   compute-focus-prescriptive-examples.rst

Compute-focused clouds are a specialized subset of the general
purpose OpenStack cloud architecture. A compute-focused cloud
specifically supports compute intensive workloads.

.. note::

   Compute intensive workloads may be CPU intensive, RAM intensive,
   or both; they are not typically storage or network intensive.

Compute-focused workloads may include the following use cases:

* High performance computing (HPC)
* Big data analytics using Hadoop or other distributed data stores
* Continuous integration/continuous deployment (CI/CD)
* Platform-as-a-Service (PaaS)
* Signal processing for network function virtualization (NFV)

.. note::

   A compute-focused OpenStack cloud does not typically use raw
   block storage services as it does not host applications that
   require persistent block storage.
