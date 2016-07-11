=======================
Business considerations
=======================

Cost
~~~~

Financial factors are a primary concern for any organization. Cost
considerations may influence the type of cloud that you build.
For example, a general purpose cloud is unlikely to be the most
cost-effective environment for specialized applications.
Unless business needs dictate that cost is a critical factor,
cost should not be the sole consideration when choosing or designing a cloud.

As a general guideline, increasing the complexity of a cloud architecture
increases the cost of building and maintaining it. For example, a hybrid or
multi-site cloud architecture involving multiple vendors and technical
architectures may require higher setup and operational costs because of the
need for more sophisticated orchestration and brokerage tools than in other
architectures. However, overall operational costs might be lower by virtue of
using a cloud brokerage tool to deploy the workloads to the most cost effective
platform.

Consider the following costs categories when designing a cloud:

*  Compute resources

*  Networking resources

*  Replication

*  Storage

*  Management

*  Operational costs

It is also important to consider how costs will increase as your cloud scales.
Choices that have a negligible impact in small systems may considerably
increase costs in large systems. In these cases, it is important to minimize
capital expenditure (CapEx) at all layers of the stack. Operators of massively
scalable OpenStack clouds require the use of dependable commodity hardware and
freely available open source software components to reduce deployment costs and
operational expenses. Initiatives like OpenCompute (more information available
at http://www.opencompute.org) provide additional information and pointers.
Factors to consider include power, cooling, and the physical design of the
chassis. Through customization, it is possible to optimize your hardware and
systems for specific types of workloads when working at scale.


Time-to-market
~~~~~~~~~~~~~~

The ability to deliver services or products within a flexible time
frame is a common business factor when building a cloud. Allowing users to
self-provision and gain access to compute, network, and
storage resources on-demand may decrease time-to-market for new products
and applications.

You must balance the time required to build a new cloud platform against the
time saved by migrating users away from legacy platforms. In some cases,
existing infrastructure may influence your architecture choices. For example,
using multiple cloud platforms may be a good option when there is an existing
investment in several applications, as it could be faster to tie the
investments together rather than migrating the components and refactoring them
to a single platform.


Revenue opportunity
~~~~~~~~~~~~~~~~~~~

Revenue opportunities vary based on the intent and use case of the cloud.
The requirements of a commercial, customer-facing product are often very
different from an internal, private cloud. You must consider what features
make your design most attractive to your users.


Compliance and geo-location
~~~~~~~~~~~~~~~~~~~~~~~~~~~

An organization may have certain legal obligations and regulatory
compliance measures which could require certain workloads or data to not
be located in certain regions. See :ref:`legal-requirements`.

Compliance considerations are particularly important for multi-site clouds.
Considerations include:

- federal legal requirements
- local jurisdictional legal and compliance requirements
- image consistency and availability
- storage replication and availability (both block and file/object storage)
- authentication, authorization, and auditing (AAA)

Geographical considerations may also impact the cost of building or leasing
data centers. Considerations include:

- floor space
- floor weight
- rack height and type
- environmental considerations
- power usage and power usage efficiency (PUE)
- physical security


Auditing
~~~~~~~~

A well-considered auditing plan is essential for quickly finding issues.
Keeping track of changes made to security groups and tenant changes can be
useful in rolling back the changes if they affect production. For example,
if all security group rules for a tenant disappeared, the ability to quickly
track down the issue would be important for operational and legal reasons.


Security
~~~~~~~~

The importance of security varies based on the type of organization using
a cloud. For example, government and financial institutions often have
very high security requirements. Security should be implemented according to
asset, threat, and vulnerability risk assessment matrices.
See :ref:`security-requirements`.


Service level agreements
~~~~~~~~~~~~~~~~~~~~~~~~

Service level agreements (SLA) must be developed in conjunction with business,
technical, and legal input. Small, private clouds may operate under an informal
SLA, but hybrid or public clouds generally require more formal agreements with
their users.

For a user of a massively scalable OpenStack public cloud, there are no
expectations for control over security, performance, or availability. Users
expect only SLAs related to uptime of API services, and very basic SLAs for
services offered. It is the user's responsibility to address these issues on
their own. The exception to this expectation is the rare case of a massively
scalable cloud infrastructure built for a private or government organization
that has specific requirements.

High performance systems have SLA requirements for a minimum :term:`quality of
service (QoS)` with regard to guaranteed uptime, latency, and bandwidth. The
level of the SLA can have a significant impact on the network architecture and
requirements for redundancy in the systems.

Hybrid cloud designs must accommodate differences in SLAs between providers,
and consider their enforceability.
