============
Introduction
============

.. toctree::
   :maxdepth: 2

:term:`OpenStack` is a fully-featured, self-service cloud. This book takes you
through some of the considerations you have to make when designing your
cloud.

Intended audience
~~~~~~~~~~~~~~~~~

This book has been written for architects and designers of OpenStack
clouds. For a guide on deploying and operating OpenStack, please refer
to the
`OpenStack Operations Guide <http://docs.openstack.org/openstack-ops/>`_.

Before reading this book, we recommend:

* Prior knowledge of cloud architecture and principles.
* Experience in enterprise system design.
* Linux and virtualization experience.
* A basic understanding of networking principles and protocols.

How this book is organized
~~~~~~~~~~~~~~~~~~~~~~~~~~

This book follows a structure similar to what system architects would use in
developing cloud architecture design documents. The sections covered are:

*  :doc:`Identifying stakeholders<identifying-stakeholders>`: Discover
   different business requirements and architecture design based on different
   internal and external stakeholders.

*  :doc:`Functional requirements<functional-requirements>`: Information for
   SMEs on deployment methods and how they will affect deployment cost.

*  :doc:`User requirements<user-requirements>`: Information for SMEs on
   business and technical requirements.

*  :doc:`Operator requirements<operator-requirements>`: Information on
   :term:`Service Level Agreement (SLA)` considerations, selecting the right
   hardware for servers and switches, and integration with external
   :term:`identity provider`.

*  :doc:`Capacity planning and scaling<capacity-planning-scaling>`: Information
   on storage and networking.

*  :doc:`High Availability<high-availability>`: Separation of data plane and
   control plane, and how to eliminate single points of failure.

*  :doc:`Security requirements<security-requirements>`: The security
   requirements you will need to consider for the different OpenStack
   scenarios.

*  :doc:`Legal requirements<legal-requirements>`: The legal requirements you
   will need to consider for the different OpenStack scenarios.

*  :doc:`Example architectures<example-architectures>`: An examination of some
   of the most common uses for OpenStack clouds, and explanations of the
   considerations for each use case.
