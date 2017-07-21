.. meta::
   :description: This guide targets OpenStack Architects
                 for architectural design
   :keywords: Architecture, OpenStack

===================================
OpenStack Architecture Design Guide
===================================

.. important::

   This guide was last updated as of the Ocata release, documenting
   the OpenStack Ocata, Newton, and Mitaka releases. It may
   not apply to EOL releases Kilo and Liberty.

   We advise that you read this at your own discretion when planning
   on your OpenStack cloud.

   This guide is intended as advice only.

   This guide is a work in progress. Contributions are welcome.

Abstract
~~~~~~~~

The Architecture Design Guide provides information on planning and designing
an OpenStack cloud. It explains core concepts, cloud architecture design
requirements, and the design criteria of key components and services in an
OpenStack cloud. The guide also describes five common cloud use cases.

Before reading this book, we recommend:

* Prior knowledge of cloud architecture and principles.
* Linux and virtualization experience.
* A basic understanding of networking principles and protocols.

For information about deploying and operating OpenStack, see the
`Installation Tutorials and Guides <https://docs.openstack.org/project-install-guide/ocata/>`_,
`Deployment Guides <https://docs.openstack.org/ocata/deploy/>`_,
and the `OpenStack Operations Guide <https://docs.openstack.org/ops-guide/>`_.

Contents
~~~~~~~~

.. toctree::
   :maxdepth: 2

   common/conventions.rst
   arch-requirements.rst
   design.rst
   use-cases.rst
   common/appendix.rst
