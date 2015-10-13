.. _shared_file_systems_intro:

============
Introduction
============

The OpenStack File Share service allows you to offer file-share services to
users of an OpenStack installation. The Shared File Systems service can be
configured to run in a single-node configuration or across multiple nodes. The
Shared File Systems service can be configured to provision shares from one or
more back ends, so it is required to declare at least one back end. To
administer the Shared File Systems service, it is helpful to understand a
number of concepts like share networks, shares, multi-tenancy and back ends
that can be configured with the Shared File Systems service. The Shared File
Systems service consists of three types of services, which are similar to
those of the Block Storage service:

- ``manila-api``
- ``manila-scheduler``
- ``manila-share``

Installation of first two - ``manila-api`` and ``manila-scheduler`` is common
for almost all deployments. But configuration of ``manila-share`` is
backend-specific and can differ from deployment to deployment.
