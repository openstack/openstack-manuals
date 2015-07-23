.. only:: nonsense

   .. TODO(ajaeger): Sphinx uses the first title it finds - ignoring
      the only - to create the top most title. Therefore use this
      version. This needs to be revised.

   ============================
   OpenStack Installation Guide
   ============================

.. only:: rdo

   =============================================================================
   OpenStack Installation Guide for Red Hat Enterprise Linux, CentOS, and Fedora
   =============================================================================

.. only:: obs

   .. title: OpenStack Installation Guide for openSUSE and SUSE Linux
      Enterprise

   ===================================================================
   OpenStack Installation Guide for openSUSE and SUSE Linux Enterprise
   ===================================================================

.. only:: ubuntu

   =======================================
   OpenStack Installation Guide for Ubuntu
   =======================================


Abstract
~~~~~~~~

The OpenStack system consists of several key projects that you install
separately. These projects work together depending on your cloud
needs. These projects include Compute, Identity Service, Networking,
Image Service, Block Storage, Object Storage, Telemetry,
Orchestration, and Database. You can install any of these projects
separately and configure them stand-alone or as connected entities.

.. only:: rdo

   This guide shows you how to install OpenStack by using packages
   available through Fedora 21 as well as on Red Hat Enterprise Linux
   7 and its derivatives through the EPEL repository.

.. only:: ubuntu

   This guide walks through an installation by using packages
   available through Ubuntu 14.04.

.. only:: obs

   This guide shows you how to install OpenStack by using packages on
   openSUSE 13.2 and SUSE Linux Enterprise Server 12 through the Open
   Build Service Cloud repository.

Explanations of configuration options and sample configuration files
are included.

This guide documents OpenStack Liberty release.

.. warning:: This guide is a work-in-progress and changing rapidly
   while we continue to test and enhance the guidance. Please note
   where there are open "to do" items and help where you are able.

Contents
~~~~~~~~

.. toctree::
   :maxdepth: 2

   overview.rst
   basic_environment.rst
   keystone.rst
   glance.rst
   nova.rst
   networking.rst
   horizon.rst
   cinder.rst
   swift.rst
   heat.rst
   ceilometer.rst
   launch-instance.rst
   app_reserved_uids.rst

   common/app_support.rst
   common/glossary.rst

Search in this guide
~~~~~~~~~~~~~~~~~~~~

* :ref:`search`
