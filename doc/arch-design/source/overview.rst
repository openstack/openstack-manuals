========
Overview
========

:term:`OpenStack` is a fully-featured, self-service cloud. This book takes you
through some of the considerations you have to make when designing your
cloud.

Intended audience
~~~~~~~~~~~~~~~~~

This book has been written for architects and designers of OpenStack
clouds. For information about deploying and operating OpenStack, see the
`OpenStack Operations Guide <https://docs.openstack.org/ops-guide/>`_.

Before reading this book, we recommend:

* Prior knowledge of cloud architecture and principles.
* Experience in enterprise system design.
* Linux and virtualization experience.
* A basic understanding of networking principles and protocols.

How this book is organized
~~~~~~~~~~~~~~~~~~~~~~~~~~

This book examines some of the most common uses for OpenStack clouds, explains
the considerations for each use case, and design criteria for each of the
major OpenStack components. Cloud architects may use this book as a
comprehensive guide by reading all of the use cases, but it is also possible
to read only the chapters which pertain to a specific use case. The sections
covered include:

*  :doc:`Cloud Architecture Use Cases <use-cases>`: An examination of some
   of the most common OpenStack cloud use cases. It covers stakeholder
   requirements, user stories, an explanation of the design models, and
   component block diagrams.

*  :doc:`High availability <high-availability>`: Separation of data plane and
   control plane, and how to eliminate single points of failure.

*  :doc:`Capacity planning and scaling <capacity-planning-scaling>`:
   Information on how to design your cloud architecture for high network
   traffic and scalability.

*  :doc:`Cloud architecture design <design>`: A detailed breakdown of the
   major cloud architecture components, and considerations when designing a
   cloud. This includes storage choices, networking design choices,
   implementing keystone, image creation and management, implementation of
   control plane components, and using Dashboard or cloud management platform
   tools.

.. toctree::
   :maxdepth: 2

   overview-planning
   overview-customer-requirements
   overview-legal-requirements
   overview-software-licensing
   overview-security-requirements
   overview-operator-requirements
