.. _model-companies:

===================
The model companies
===================

This page allows you to see how different companies and user ecosystems
influence a specific persona's role. We have identified four model companies
with three organizational models that best exemplify the companies decision
to adopt OpenStack. Use these companies to help refine your use cases for a
specific type of organizational paradigm. The factors we chose to distinguish
the different model companies include the cloud adoption model, operations,
security needs, and compliance.

.. important::

   The institutions described in this document are fictitious and serve only
   as representations of different organizational models.

.. _Nikishi-University:

Nikishi University - research
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At Nikishi university, each cloud user can potentially assume all persona
roles. Although typically each individual specializes in two or more of the
roles.

.. list-table:: **Nikishi University - Key Info**
   :widths: 15 15 15 15
   :header-rows: 1

   *  - Adoption model
      - Process and compliance
      - Skill depth
      - Number of users
   *  - Roll your own
      - Minimal
      - Deep
      - 100 to 999 users

* The roles of :ref:`infrastructure-arch` and :ref:`Cloud-Ops`
  could be assumed by a single individual.
* The roles of :ref:`Domain-Operator`, :ref:`Project-Owner`,
  and :ref:`app-developer` could be merged.

This organizational model has a low staffing budget and is concerned with
capital expenditure, which influenced their decision to create their own
implementation.

.. _CNBB-Securities:

CNBB Securities - large enterprise
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At CNBB Securities, the company's large organization chart represents each of
the personas. Depending on the company's culture of collaboration, the
personas could interact as if they were part of a single entity.

.. list-table:: **CNBB Securities - Key Info**
   :widths: 15 15 15 15
   :header-rows: 1

   *  - Adoption model
      - Process and compliance
      - Skill depth
      - Number of users
   *  - Distribution with professional services
      - High
      - Medium
      - Over 10000 users

* Usually the roles of :ref:`Cloud-Ops` and :ref:`Infrastructure-Arch`
  interact as service providers with the other personas.

The personas within CNBB Securities look for a fast implementation and are
responsible for the operations capital expenditure. The implementation has no
customization and the organization usually outsources its support.

.. _Rifkom:

Rifkom - service provider
~~~~~~~~~~~~~~~~~~~~~~~~~

At Rifkom, employees provide services to external customers that do not want
or have the internal resources. Rifkom customizes solutions and
prioritizes a flexible approach to architecture. The highly skilled staff
represents the largest expenditure for Rifkom.

.. list-table:: **Rifkom - Key Info**
   :widths: 15 15 15 15
   :header-rows: 1

   *  - Adoption model
      - Process and compliance
      - Skill depth
      - Number of users
   *  - Roll your own
      - Medium to High (depends on customer)
      - Deep
      - 1000 to 9999 users

* Only the roles of :ref:`Infrastructure-Arch` and :ref:`Cloud-Ops` exist at
  Rifkom. The other personas are their customers at MOI.

Customers usually interact with Rifkom employees through a ticket system.

.. _MOI:

MOI - customer
~~~~~~~~~~~~~~

At MOI, speed and convenience rule. They do not perform any customization of
the cloud and are willing to sacrifice functionality in order to save some
costs. They interact with their cloud service provider, Rifkom, through a
ticket system in case of problems with their cloud instance.

.. list-table:: **MOI - Key Info**
   :widths: 15 15 15 15
   :header-rows: 1

   *  - Adoption model
      - Process and compliance
      - Skill depth
      - Number of users
   *  - Professional services
      - Medium
      - Minimal
      - No OpenStack users

* MOI's staff encompasses the roles of :ref:`App-Developer`,
  :ref:`Project-Owner`, and :ref:`Domain-Operator`. Other roles are external.

