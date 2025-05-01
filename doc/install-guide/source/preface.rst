=========
 Preface
=========

Abstract
~~~~~~~~

The OpenStack system consists of several key services that are separately
installed. These services work together depending on your cloud
needs and include the Compute, Identity, Networking, Image, Block Storage,
Object Storage, Telemetry, Orchestration, and Database services. You
can install any of these projects separately and configure them stand-alone
or as connected entities.

Explanations of configuration options and sample configuration files
are included.

This guide documents the installation of OpenStack starting with the
Pike release. It covers multiple releases.

.. warning::

   This guide is a work-in-progress and is subject to updates frequently.
   Pre-release packages have been used for testing, and some instructions
   may not work with final versions. Please help us make this guide better
   by reporting any errors you encounter.

Operating systems
~~~~~~~~~~~~~~~~~

Currently, this guide describes OpenStack installation for the following
Linux distributions:

Red Hat Enterprise Linux and CentOS Stream
  You can install OpenStack using packages available for Red Hat
  Enterprise Linux 9, CentOS Stream 9 and their derivatives through
  the RDO repository.

  .. note::

     OpenStack 2023.2 Bobcat, 2024.1 Caracal and 2024.2 Dalmatian are
     available for Red Hat Enterprise Linux 9 and CentOS Stream 9.

Ubuntu
  You can walk through an installation by using packages available through
  Canonical's Ubuntu Cloud archive repository for Ubuntu 22.04+ (LTS).

  .. note::

     The Ubuntu Cloud Archive pockets for Zed, 2023.1 Antelope,
     2023.2 Bobcat and 2024.1 Caracal provides OpenStack packages for
     Ubuntu 22.04 LTS; the Ubuntu Cloud Archive pocket for 2024.2 Dalmatian
     provides OpenStack packages for 24.04 LTS.
