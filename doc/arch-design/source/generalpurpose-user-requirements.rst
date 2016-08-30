=================
User requirements
=================

When building a general purpose cloud, you should follow the
:term:`Infrastructure-as-a-Service (IaaS)` model; a platform best suited
for use cases with simple requirements. General purpose cloud user
requirements are not complex. However, it is important to capture them
even if the project has minimum business and technical requirements, such
as a proof of concept (PoC), or a small lab platform.

.. note::
   The following user considerations are written from the perspective
   of the cloud builder, not from the perspective of the end user.

Business requirements
~~~~~~~~~~~~~~~~~~~~~

Cost
 Financial factors are a primary concern for any organization. Cost
 is an important criterion as general purpose clouds are considered
 the baseline from which all other cloud architecture environments
 derive. General purpose clouds do not always provide the most
 cost-effective environment for specialized applications or
 situations. Unless razor-thin margins and costs have been mandated
 as a critical factor, cost should not be the sole consideration when
 choosing or designing a general purpose architecture.

Time to market
 The ability to deliver services or products within a flexible time
 frame is a common business factor when building a general purpose
 cloud. Delivering a product in six months instead of two years is a
 driving force behind the decision to build general purpose clouds.
 General purpose clouds allow users to self-provision and gain access
 to compute, network, and storage resources on-demand thus decreasing
 time to market.

Revenue opportunity
 Revenue opportunities for a cloud will vary greatly based on the
 intended use case of that particular cloud. Some general purpose
 clouds are built for commercial customer facing products, but there
 are alternatives that might make the general purpose cloud the right
 choice.

Technical requirements
~~~~~~~~~~~~~~~~~~~~~~

Technical cloud architecture requirements should be weighted against the
business requirements.

Performance
 As a baseline product, general purpose clouds do not provide
 optimized performance for any particular function. While a general
 purpose cloud should provide enough performance to satisfy average
 user considerations, performance is not a general purpose cloud
 customer driver.

No predefined usage model
 The lack of a pre-defined usage model enables the user to run a wide
 variety of applications without having to know the application
 requirements in advance. This provides a degree of independence and
 flexibility that no other cloud scenarios are able to provide.

On-demand and self-service application
 By definition, a cloud provides end users with the ability to
 self-provision computing power, storage, networks, and software in a
 simple and flexible way. The user must be able to scale their
 resources up to a substantial level without disrupting the
 underlying host operations. One of the benefits of using a general
 purpose cloud architecture is the ability to start with limited
 resources and increase them over time as the user demand grows.

Public cloud
 For a company interested in building a commercial public cloud
 offering based on OpenStack, the general purpose architecture model
 might be the best choice. Designers are not always going to know the
 purposes or workloads for which the end users will use the cloud.

Internal consumption (private) cloud
 Organizations need to determine if it is logical to create their own
 clouds internally. Using a private cloud, organizations are able to
 maintain complete control over architectural and cloud components.

 .. note::
    Users will want to combine using the internal cloud with access
    to an external cloud. If that case is likely, it might be worth
    exploring the possibility of taking a multi-cloud approach with
    regard to at least some of the architectural elements.

 Designs that incorporate the use of multiple clouds, such as a
 private cloud and a public cloud offering, are described in the
 "Multi-Cloud" scenario, see :doc:`multi-site`.

Security
 Security should be implemented according to asset, threat, and
 vulnerability risk assessment matrices. For cloud domains that
 require increased computer security, network security, or
 information security, a general purpose cloud is not considered an
 appropriate choice.
