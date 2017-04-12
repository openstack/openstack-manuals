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
   the RDO repository.

.. only:: ubuntu

   This guide will walk through an installation by using packages
   available through Canonical's Ubuntu Cloud archive repository.

.. only:: obs

   This guide will show you how to install OpenStack by using packages
   on openSUSE Leap 42.1 and SUSE Linux Enterprise Server 12 SP1
   through the Open Build Service Cloud repository.

.. only:: debian

   This guide walks through an installation by using packages
   available through Debian 8 (code name: Jessie).

Explanations of configuration options and sample configuration files
are included.

.. warning::

   This guide documents OpenStack Mitaka release and is frozen
   since OpenStack Mitaka has reached its official end-of-life
   and will not get any updates by the OpenStack project anymore.
   Check the `OpenStack Documentation page
   <http://docs.openstack.org>`_ for newer documents.

Contents
~~~~~~~~

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
   manila.rst
   swift.rst
   heat.rst
   ceilometer.rst
   trove.rst
   launch-instance.rst

.. Pseudo only directive for each distribution used by the build tool.
   This pseudo only directive for toctree only works fine with Tox.
   When you directly build this guide with Sphinx,
   some navigation menu may not work properly.
.. Keep this pseudo only directive not to break translation tool chain
   at the openstack-doc-tools repo until it is changed.
.. only:: obs or rdo or ubuntu
.. only:: debian
.. end of contents

Appendix
~~~~~~~~

.. toctree::
   :maxdepth: 1

   common/app_support.rst

Glossary
~~~~~~~~

.. toctree::
   :maxdepth: 1

   common/glossary.rst

Search in this guide
~~~~~~~~~~~~~~~~~~~~

* :ref:`search`
