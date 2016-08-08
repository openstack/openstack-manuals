.. _shared_file_systems_intro:

============
Introduction
============

The OpenStack File Share service allows you to offer shared file systems
service to OpenStack users in your installation. The Shared File Systems
service can run in a single-node or multiple node configuration.
The Shared File Systems service can be configured to provision shares
from one or more back ends, so it is required to declare at least one
back end. Shared File System service contains several configurable
components.

It is important to understand these components:

* Share networks
* Shares
* Multi-tenancy
* Back ends

The Shared File Systems service consists of four types of services,
most of which are similar to those of the Block Storage service:

- ``manila-api``
- ``manila-data``
- ``manila-scheduler``
- ``manila-share``

Installation of first three - ``manila-api``, ``manila-data``, and
``manila-scheduler`` is common for almost all deployments. But configuration
of ``manila-share`` is backend-specific and can differ from deployment to
deployment.
