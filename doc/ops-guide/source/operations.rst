==========
Operations
==========

Congratulations! By now, you should have a solid design for your cloud.
We now recommend that you turn to the `Installation Tutorials and Guides
<https://docs.openstack.org/project-install-guide/ocata/>`_, which contains a
step-by-step guide on how to manually install the OpenStack packages and
dependencies on your cloud.

While it is important for an operator to be familiar with the steps
involved in deploying OpenStack, we also strongly encourage you to
evaluate configuration-management tools, such as :term:`Puppet` or
:term:`Chef`, which can help automate this deployment process.

In the remainder of this guide, we assume that you have successfully
deployed an OpenStack cloud and are able to perform basic operations
such as adding images, booting instances, and attaching volumes.

As your focus turns to stable operations, we recommend that you do skim
the remainder of this book to get a sense of the content. Some of this
content is useful to read in advance so that you can put best practices
into effect to simplify your life in the long run. Other content is more
useful as a reference that you might turn to when an unexpected event
occurs (such as a power failure), or to troubleshoot a particular
problem.

.. toctree::
   :maxdepth: 2

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
