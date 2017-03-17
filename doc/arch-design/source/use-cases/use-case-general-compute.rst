.. _general-compute-cloud:

=====================
General compute cloud
=====================

Design model
~~~~~~~~~~~~

An online classified advertising company wants to run web applications
consisting of Tomcat, Nginx, and MariaDB in a private cloud. To meet the
policy requirements, the cloud infrastructure will run in their
own data center. The company has predictable load requirements but
requires scaling to cope with nightly increases in demand. Their current
environment does not have the flexibility to align with their goal of
running an open source API environment. The current environment consists
of the following:

* Between 120 and 140 installations of Nginx and Tomcat, each with 2
  vCPUs and 4 GB of RAM

* A three node MariaDB and Galera cluster, each with 4 vCPUs and 8 GB
  of RAM

The company runs hardware load balancers and multiple web applications
serving their websites and orchestrates environments using combinations
of scripts and Puppet. The website generates large amounts of log data
daily that requires archiving.

The solution would consist of the following OpenStack components:

* A firewall, switches and load balancers on the public facing network
  connections.

* OpenStack Controller service running Image service, Identity service,
  Networking service, combined with support services such as MariaDB and
  RabbitMQ, configured for high availability on at least three controller
  nodes.

* OpenStack compute nodes running the KVM hypervisor.

* OpenStack Block Storage for use by compute instances, requiring
  persistent storage (such as databases for dynamic sites).

* OpenStack Object Storage for serving static objects (such as images).

.. figure:: ../figures/General_Architecture3.png

Running up to 140 web instances and the small number of MariaDB
instances requires 292 vCPUs available, as well as 584 GB of RAM. On a
typical 1U server using dual-socket hex-core Intel CPUs with
Hyperthreading, and assuming 2:1 CPU overcommit ratio, this would
require 8 OpenStack Compute nodes.

The web application instances run from local storage on each of the
OpenStack Compute nodes. The web application instances are stateless,
meaning that any of the instances can fail and the application will
continue to function.

MariaDB server instances store their data on shared enterprise storage,
such as NetApp or Solidfire devices. If a MariaDB instance fails,
storage would be expected to be re-attached to another instance and
rejoined to the Galera cluster.

Logs from the web application servers are shipped to OpenStack Object
Storage for processing and archiving.

Additional capabilities can be realized by moving static web content to
be served from OpenStack Object Storage containers, and backing the
OpenStack Image service with OpenStack Object Storage.

.. note::

   Increasing OpenStack Object Storage means network bandwidth needs to
   be taken into consideration. Running OpenStack Object Storage with
   network connections offering 10 GbE or better connectivity is
   advised.

Leveraging Orchestration and Telemetry services is also a potential
issue when providing auto-scaling, orchestrated web application
environments. Defining the web applications in a
:term:`Heat Orchestration Template (HOT)`
negates the reliance on the current scripted Puppet
solution.

OpenStack Networking can be used to control hardware load balancers
through the use of plug-ins and the Networking API. This allows users to
control hardware load balance pools and instances as members in these
pools, but their use in production environments must be carefully
weighed against current stability.

Requirements
~~~~~~~~~~~~


Network hardware requirements
-----------------------------

For a compute-focus architecture, we recommend designing the network
architecture using a scalable network model that makes it easy to add
capacity and bandwidth. A good example of such a model is the leaf-spline
model. In this type of network design, you can add additional
bandwidth as well as scale out to additional racks of gear. It is important to
select network hardware that supports port count, port speed, and
port density while allowing for future growth as workload demands
increase. In the network architecture, it is also important to evaluate
where to provide redundancy.

Network software requirements
-----------------------------
For a general purpose OpenStack cloud, the OpenStack infrastructure
components need to be highly available. If the design does not include
hardware load balancing, networking software packages like HAProxy will
need to be included.

Component block diagram
~~~~~~~~~~~~~~~~~~~~~~~
