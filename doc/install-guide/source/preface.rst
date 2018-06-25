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

.. note::

   The Training Labs scripts provide an automated way of deploying the
   cluster described in this Installation Guide into VirtualBox or KVM
   VMs. You will need a desktop computer or a laptop with at least 8
   GB memory and 20 GB free storage running Linux, MacOS, or Windows.
   Please see the
   `OpenStack Training Labs <https://docs.openstack.org/training_labs/>`_.

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

openSUSE and SUSE Linux Enterprise Server
  You can install OpenStack by using packages on openSUSE Leap 42.3 and
  SUSE Linux Enterprise Server 12 SP3 through the Open Build Service Cloud
  repository.

Red Hat Enterprise Linux and CentOS
  You can install OpenStack by using packages available on Red Hat
  Enterprise Linux 7 and its derivatives through the RDO repository.

Ubuntu
  You can walk through an installation by using packages available through
  Canonical's Ubuntu Cloud archive repository for Ubuntu 16.04 (LTS).

  .. note::

     The Ubuntu Cloud Archive pockets for Pike and Queens provide
     OpenStack packages for Ubuntu 16.04 LTS; OpenStack Queens is
     installable direct using Ubuntu 18.04 LTS.
