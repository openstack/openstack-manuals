============
Architecture
============

Map out the dependencies of the expected workloads and the cloud
infrastructures required to support them to architect a solution
for the broadest compatibility between cloud platforms, minimizing
the need to create workarounds and processes to fill identified gaps.

For your chosen cloud management platform, note the relative
levels of support for both monitoring and orchestration.

.. figure:: figures/Multi-Cloud_Priv-AWS4.png
   :width: 100%

Image portability
~~~~~~~~~~~~~~~~~

The majority of cloud workloads currently run on instances using
hypervisor technologies. The challenge is that each of these hypervisors
uses an image format that may not be compatible with the others.
When possible, standardize on a single hypervisor and instance image format.
This may not be possible when using externally-managed public clouds.

Conversion tools exist to address image format compatibility.
Examples include `virt-p2v/virt-v2v <http://libguestfs.org/virt-v2v>`_
and `virt-edit <http://libguestfs.org/virt-edit.1.html>`_.
These tools cannot serve beyond basic cloud instance specifications.

Alternatively, build a thin operating system image as the base for
new instances.
This facilitates rapid creation of cloud instances using cloud orchestration
or configuration management tools for more specific templating.
Remember if you intend to use portable images for disaster recovery,
application diversity, or high availability, your users could move
the images and instances between cloud platforms regularly.

Upper-layer services
~~~~~~~~~~~~~~~~~~~~

Many clouds offer complementary services beyond the
basic compute, network, and storage components.
These additional services often simplify the deployment
and management of applications on a cloud platform.

When moving workloads from the source to the destination
cloud platforms, consider that the destination cloud platform
may not have comparable services. Implement workloads
in a different way or by using a different technology.

For example, moving an application that uses a NoSQL database
service such as MongoDB could cause difficulties in maintaining
the application between the platforms.

There are a number of options that are appropriate for
the hybrid cloud use case:

* Implementing a baseline of upper-layer services across all
  of the cloud platforms. For platforms that do not support
  a given service, create a service on top of that platform
  and apply it to the workloads as they are launched on that cloud.
* For example, through the :term:`Database service <Database service
  (trove)>` for OpenStack (:term:`trove`), OpenStack supports MySQL
  as a service but not NoSQL databases in production.
  To move from or run alongside AWS, a NoSQL workload must use
  an automation tool, such as the Orchestration service (heat),
  to recreate the NoSQL database on top of OpenStack.
* Deploying a :term:`Platform-as-a-Service (PaaS)` technology that
  abstracts the upper-layer services from the underlying cloud platform.
  The unit of application deployment and migration is the PaaS.
  It leverages the services of the PaaS and only consumes the base
  infrastructure services of the cloud platform.
* Using automation tools to create the required upper-layer services
  that are portable across all cloud platforms.

  For example, instead of using database services that are inherent
  in the cloud platforms, launch cloud instances and deploy the
  databases on those instances using scripts or configuration and
  application deployment tools.

Network services
~~~~~~~~~~~~~~~~

Network services functionality is a critical component of
multiple cloud architectures. It is an important factor
to assess when choosing a CMP and cloud provider.
Considerations include:

* Functionality
* Security
* Scalability
* High availability (HA)

Verify and test critical cloud endpoint features.

* After selecting the network functionality framework,
  you must confirm the functionality is compatible.
  This ensures testing and functionality persists
  during and after upgrades.

  .. note::

     Diverse cloud platforms may de-synchronize over time
     if you do not maintain their mutual compatibility.
     This is a particular issue with APIs.

* Scalability across multiple cloud providers determines
  your choice of underlying network framework.
  It is important to have the network API functions presented
  and to verify that the desired functionality persists across
  all chosen cloud endpoint.

* High availability implementations vary in functionality and design.
  Examples of some common methods are active-hot-standby,
  active-passive, and active-active.
  Develop your high availability implementation and a test framework to
  understand the functionality and limitations of the environment.

* It is imperative to address security considerations.
  For example, addressing how data is secured between client and
  endpoint and any traffic that traverses the multiple clouds.
  Business and regulatory requirements dictate what security
  approach to take. For more information, see the
  :ref:`Security requirements <security>` chapter.

Data
~~~~

Traditionally, replication has been the best method of protecting
object store implementations. A variety of replication methods exist
in storage architectures, for example synchronous and asynchronous
mirroring. Most object stores and back-end storage systems implement
methods for replication at the storage subsystem layer.
Object stores also tailor replication techniques
to fit a cloud's requirements.

Organizations must find the right balance between
data integrity and data availability. Replication strategy may
also influence disaster recovery methods.

Replication across different racks, data centers, and geographical
regions increases focus on determining and ensuring data locality.
The ability to guarantee data is accessed from the nearest or
fastest storage can be necessary for applications to perform well.

.. note::

   When running embedded object store methods, ensure that you do not
   instigate extra data replication as this can cause performance issues.
