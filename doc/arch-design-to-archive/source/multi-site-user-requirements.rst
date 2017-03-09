=================
User requirements
=================

Workload characteristics
~~~~~~~~~~~~~~~~~~~~~~~~

An understanding of the expected workloads for a desired multi-site
environment and use case is an important factor in the decision-making
process. In this context, ``workload`` refers to the way the systems are
used. A workload could be a single application or a suite of
applications that work together. It could also be a duplicate set of
applications that need to run in multiple cloud environments. Often in a
multi-site deployment, the same workload will need to work identically
in more than one physical location.

This multi-site scenario likely includes one or more of the other
scenarios in this book with the additional requirement of having the
workloads in two or more locations. The following are some possible
scenarios:

For many use cases the proximity of the user to their workloads has a
direct influence on the performance of the application and therefore
should be taken into consideration in the design. Certain applications
require zero to minimal latency that can only be achieved by deploying
the cloud in multiple locations. These locations could be in different
data centers, cities, countries or geographical regions, depending on
the user requirement and location of the users.

Consistency of images and templates across different sites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is essential that the deployment of instances is consistent across
the different sites and built into the infrastructure. If the OpenStack
Object Storage is used as a back end for the Image service, it is
possible to create repositories of consistent images across multiple
sites. Having central endpoints with multiple storage nodes allows
consistent centralized storage for every site.

Not using a centralized object store increases the operational overhead
of maintaining a consistent image library. This could include
development of a replication mechanism to handle the transport of images
and the changes to the images across multiple sites.

High availability
~~~~~~~~~~~~~~~~~

If high availability is a requirement to provide continuous
infrastructure operations, a basic requirement of high availability
should be defined.

The OpenStack management components need to have a basic and minimal
level of redundancy. The simplest example is the loss of any single site
should have minimal impact on the availability of the OpenStack
services.

The `OpenStack High Availability
Guide <https://docs.openstack.org/ha-guide/>`_ contains more information
on how to provide redundancy for the OpenStack components.

Multiple network links should be deployed between sites to provide
redundancy for all components. This includes storage replication, which
should be isolated to a dedicated network or VLAN with the ability to
assign QoS to control the replication traffic or provide priority for
this traffic. Note that if the data store is highly changeable, the
network requirements could have a significant effect on the operational
cost of maintaining the sites.

The ability to maintain object availability in both sites has
significant implications on the object storage design and
implementation. It also has a significant impact on the WAN network
design between the sites.

Connecting more than two sites increases the challenges and adds more
complexity to the design considerations. Multi-site implementations
require planning to address the additional topology used for internal
and external connectivity. Some options include full mesh topology, hub
spoke, spine leaf, and 3D Torus.

If applications running in a cloud are not cloud-aware, there should be
clear measures and expectations to define what the infrastructure can
and cannot support. An example would be shared storage between sites. It
is possible, however such a solution is not native to OpenStack and
requires a third-party hardware vendor to fulfill such a requirement.
Another example can be seen in applications that are able to consume
resources in object storage directly. These applications need to be
cloud aware to make good use of an OpenStack Object Store.

Application readiness
~~~~~~~~~~~~~~~~~~~~~

Some applications are tolerant of the lack of synchronized object
storage, while others may need those objects to be replicated and
available across regions. Understanding how the cloud implementation
impacts new and existing applications is important for risk mitigation,
and the overall success of a cloud project. Applications may have to be
written or rewritten for an infrastructure with little to no redundancy,
or with the cloud in mind.

Cost
~~~~

A greater number of sites increase cost and complexity for a multi-site
deployment. Costs can be broken down into the following categories:

*  Compute resources

*  Networking resources

*  Replication

*  Storage

*  Management

*  Operational costs

Site loss and recovery
~~~~~~~~~~~~~~~~~~~~~~

Outages can cause partial or full loss of site functionality. Strategies
should be implemented to understand and plan for recovery scenarios.

*  The deployed applications need to continue to function and, more
   importantly, you must consider the impact on the performance and
   reliability of the application when a site is unavailable.

*  It is important to understand what happens to the replication of
   objects and data between the sites when a site goes down. If this
   causes queues to start building up, consider how long these queues
   can safely exist until an error occurs.

*  After an outage, ensure the method for resuming proper operations of
   a site is implemented when it comes back online. We recommend you
   architect the recovery to avoid race conditions.

Compliance and geo-location
~~~~~~~~~~~~~~~~~~~~~~~~~~~

An organization may have certain legal obligations and regulatory
compliance measures which could require certain workloads or data to not
be located in certain regions.

Auditing
~~~~~~~~

A well thought-out auditing strategy is important in order to be able to
quickly track down issues. Keeping track of changes made to security
groups and project changes can be useful in rolling back the changes if
they affect production. For example, if all security group rules for a
project disappeared, the ability to quickly track down the issue would be
important for operational and legal reasons.

Separation of duties
~~~~~~~~~~~~~~~~~~~~

A common requirement is to define different roles for the different
cloud administration functions. An example would be a requirement to
segregate the duties and permissions by site.

Authentication between sites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is recommended to have a single authentication domain rather than a
separate implementation for each and every site. This requires an
authentication mechanism that is highly available and distributed to
ensure continuous operation. Authentication server locality might be
required and should be planned for.
