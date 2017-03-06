.. _design:

======
Design
======

Designing an OpenStack cloud requires a understanding of the cloud user's
requirements and needs to determine the best possible configuration. This
chapter provides guidance on the decisions you need to make during the
design process.

To design, deploy, and configure OpenStack, administrators must
understand the logical architecture. OpenStack modules are one of the
following types:

Daemon
 Runs as a background process. On Linux platforms, a daemon is usually
 installed as a service.

Script
 Installs a virtual environment and runs tests.

Command-line interface (CLI)
 Enables users to submit API calls to OpenStack services through commands.

:ref:`logical_architecture` shows one example of the most common
integrated services within OpenStack and how they interact with each
other. End users can interact through the dashboard, CLIs, and APIs.
All services authenticate through a common Identity service, and
individual services interact with each other through public APIs, except
where privileged administrator commands are necessary.

.. _logical_architecture:

.. figure:: common/figures/osog_0001.png
   :width: 100%
   :alt: OpenStack Logical Architecture

   OpenStack Logical Architecture

.. toctree::
   :maxdepth: 2

   design-compute.rst
   design-storage.rst
   design-networking.rst
   design-identity.rst
   design-images.rst
   design-control-plane.rst
   design-cmp-tools.rst
