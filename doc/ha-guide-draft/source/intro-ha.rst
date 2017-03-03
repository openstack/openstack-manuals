=================================
Introduction to high availability
=================================

High availability systems seek to minimize the following issues:

#. System downtime: Occurs when a user-facing service is unavailable
   beyond a specified maximum amount of time.

#. Data loss: Accidental deletion or destruction of data.

Most high availability systems guarantee protection against system downtime
and data loss only in the event of a single failure.
However, they are also expected to protect against cascading failures,
where a single failure deteriorates into a series of consequential failures.
Many service providers guarantee a :term:`Service Level Agreement (SLA)`
including uptime percentage of computing service, which is calculated based
on the available time and system downtime excluding planned outage time.

.. toctree::
   :maxdepth: 2

   intro-ha-key-concepts.rst
   intro-ha-common-tech.rst
