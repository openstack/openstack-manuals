======
Hybrid
======

.. toctree::
   :maxdepth: 2

   hybrid-user-requirements.rst
   hybrid-technical-considerations.rst
   hybrid-architecture.rst
   hybrid-operational-considerations.rst
   hybrid-prescriptive-examples.rst

A :term:`hybrid cloud` design is one that uses more than one cloud.
For example, designs that use both an OpenStack-based private
cloud and an OpenStack-based public cloud, or that use an
OpenStack cloud and a non-OpenStack cloud, are hybrid clouds.

:term:`Bursting <bursting>` describes the practice of creating new instances
in an external cloud to alleviate capacity issues in a private cloud.

**Example scenarios suited to hybrid clouds**

* Bursting from a private cloud to a public cloud
* Disaster recovery
* Development and testing
* Federated cloud, enabling users to choose resources from multiple providers
* Supporting legacy systems as they transition to the cloud

Hybrid clouds interact with systems that are outside the
control of the private cloud administrator, and require
careful architecture to prevent conflicts with hardware,
software, and APIs under external control.

The degree to which the architecture is OpenStack-based affects your ability
to accomplish tasks with native OpenStack tools. By definition,
this is a situation in which no single cloud can provide all
of the necessary functionality. In order to manage the entire
system, we recommend using a cloud management platform (CMP).

There are several commercial and open source CMPs available,
but there is no single CMP that can address all needs in all
scenarios, and sometimes a manually-built solution is the best
option. This chapter includes discussion of using CMPs for
managing a hybrid cloud.
