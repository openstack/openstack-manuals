===========================
Handling a Complete Failure
===========================

A common way of dealing with the recovery from a full system failure,
such as a power outage of a data center, is to assign each service a
priority, and restore in order.
:ref:`table_example_priority` shows an example.

.. _table_example_priority:

.. list-table:: Table. Example service restoration priority list
   :header-rows: 1

   * - Priority
     - Services
   * - 1
     - Internal network connectivity
   * - 2
     - Backing storage services
   * - 3
     - Public network connectivity for user virtual machines
   * - 4
     - ``nova-compute``, cinder hosts
   * - 5
     - User virtual machines
   * - 10
     - Message queue and database services
   * - 15
     - Keystone services
   * - 20
     - ``cinder-scheduler``
   * - 21
     - Image Catalog and Delivery services
   * - 22
     - ``nova-scheduler`` services
   * - 98
     - ``cinder-api``
   * - 99
     - ``nova-api`` services
   * - 100
     - Dashboard node

Use this example priority list to ensure that user-affected services are
restored as soon as possible, but not before a stable environment is in
place. Of course, despite being listed as a single-line item, each step
requires significant work. For example, just after starting the
database, you should check its integrity, or, after starting the nova
services, you should verify that the hypervisor matches the database and
fix any mismatches.
