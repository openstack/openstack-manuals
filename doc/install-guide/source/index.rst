.. title:: OpenStack Installation Guide

.. Don't remove or change title tag manually, which is used by the build tool.

.. only:: rdo

   ====================================================================
   OpenStack Installation Guide for Red Hat Enterprise Linux and CentOS
   ====================================================================

.. only:: obs

   ===================================================================
   OpenStack Installation Guide for openSUSE and SUSE Linux Enterprise
   ===================================================================

.. only:: ubuntu

   =======================================
   OpenStack Installation Guide for Ubuntu
   =======================================

.. only:: debian

   =======================================
   OpenStack Installation Guide for Debian
   =======================================


Abstract
~~~~~~~~

The OpenStack system consists of several key services that are separately
installed. These services work together depending on your cloud
needs. These services include Compute service, Identity service,
Networking service, Image service, Block Storage service, Object Storage
service, Telemetry service, Orchestration service, and Database service. You
can install any of these projects separately and configure them stand-alone
or as connected entities.

.. only:: rdo

   This guide will show you how to install OpenStack by using packages
   available on Red Hat Enterprise Linux 7 and its derivatives through
   the EPEL repository.

.. only:: ubuntu

   This guide will walk through an installation by using packages
   available through Canonical's Ubuntu Cloud archive repository.

.. only:: obs

   This guide will show you how to install OpenStack by using packages on
   openSUSE 13.2 and SUSE Linux Enterprise Server 12 through the Open
   Build Service Cloud repository.

.. only:: debian

   This guide walks through an installation by using packages
   available through Debian 8 (code name: Jessie).

Explanations of configuration options and sample configuration files
are included.

This guide documents OpenStack Liberty release.

.. warning::

   This guide is a work-in-progress and is subject to updates frequently.
   Pre-release packages have been used for testing, and some instructions
   may not work with final versions. Please help us make this guide better
   by reporting any errors you encounter.

Contents
~~~~~~~~

.. Pseudo only directive for each distribution used by the build tool.
   This pseudo only directive for toctree only works fine with Tox.
   When you directly build this guide with Sphinx,
   some navigation menu may not work properly.

.. only:: obs or rdo or ubuntu

   .. toctree::
      :maxdepth: 2

      common/conventions.rst
      overview.rst
      environment.rst
      keystone.rst
      glance.rst
      nova.rst
      neutron.rst
      horizon.rst
      cinder.rst
      swift.rst
      heat.rst
      ceilometer.rst
      launch-instance.rst

      common/app_support.rst
      common/glossary.rst

.. only:: debian

   .. toctree::
      :maxdepth: 2

      common/conventions.rst
      overview.rst
      environment.rst
      debconf/debconf.rst
      keystone.rst
      glance.rst
      nova.rst
      neutron.rst
      horizon.rst
      cinder.rst
      swift.rst
      heat.rst
      ceilometer.rst
      launch-instance.rst

      common/app_support.rst
      common/glossary.rst

.. end of contents

Search in this guide
~~~~~~~~~~~~~~~~~~~~

* :ref:`search`
