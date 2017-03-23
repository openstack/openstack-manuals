==========================
OpenStack Operations Guide
==========================

Abstract
~~~~~~~~

This guide provides information about operating OpenStack clouds.

We recommend that you turn to the `Installation Tutorials and Guides
<https://docs.openstack.org/project-install-guide/ocata/>`_,
which contains a step-by-step guide on how to manually install the
OpenStack packages and dependencies on your cloud.

While it is important for an operator to be familiar with the steps
involved in deploying OpenStack, we also strongly encourage you to
evaluate `OpenStack deployment tools
<https://docs.openstack.org/developer/openstack-projects.html>`_
and configuration-management tools, such as :term:`Puppet` or
:term:`Chef`, which can help automate this deployment process.

In this guide, we assume that you have successfully deployed an
OpenStack cloud and are able to perform basic operations
such as adding images, booting instances, and attaching volumes.

As your focus turns to stable operations, we recommend that you do skim
this guide to get a sense of the content. Some of this content is useful
to read in advance so that you can put best practices into effect to
simplify your life in the long run. Other content is more useful as a
reference that you might turn to when an unexpected event occurs (such
as a power failure), or to troubleshoot a particular problem.

Contents
~~~~~~~~

.. toctree::
   :maxdepth: 2

   acknowledgements.rst
   preface.rst
   common/conventions.rst
   ops-lay-of-the-land.rst
   ops-projects-users.rst
   ops-user-facing-operations.rst
   ops-maintenance.rst
   ops-network-troubleshooting.rst
   ops-logging-monitoring.rst
   ops-backup-recovery.rst
   ops-customize.rst
   ops-advanced-configuration.rst
   ops-upgrades.rst

Appendix
~~~~~~~~

.. toctree::
   :maxdepth: 1

   app-usecases.rst
   app-crypt.rst
   app-roadmaps.rst
   app-resources.rst
   common/app-support.rst

Glossary
~~~~~~~~

.. toctree::
   :maxdepth: 1

   common/glossary.rst

Search
~~~~~~

* :ref:`search`
