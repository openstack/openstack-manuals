===========================
Managing Projects and Users
===========================

.. toctree::

   ops-projects.rst
   ops-quotas.rst
   ops-users.rst
   ops-projects-users-summary.rst

An OpenStack cloud does not have much value without users. This chapter
covers topics that relate to managing users, projects, and quotas. This
chapter describes users and projects as described by version 2 of the
OpenStack Identity API.

Projects or Tenants?
~~~~~~~~~~~~~~~~~~~~

In OpenStack user interfaces and documentation, a group of users is
referred to as a :term:`project` or :term:`tenant`.
These terms are interchangeable.

The initial implementation of OpenStack Compute had its own
authentication system and used the term ``project``. When authentication
moved into the OpenStack Identity (keystone) project, it used the term
``tenant`` to refer to a group of users. Because of this legacy, some of
the OpenStack tools refer to projects and some refer to tenants.

.. tip::

   This guide uses the term ``project``, unless an example shows
   interaction with a tool that uses the term ``tenant``.
