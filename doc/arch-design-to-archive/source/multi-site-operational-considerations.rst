==========================
Operational considerations
==========================

Multi-site OpenStack cloud deployment using regions requires that the
service catalog contains per-region entries for each service deployed
other than the Identity service. Most off-the-shelf OpenStack deployment
tools have limited support for defining multiple regions in this
fashion.

Deployers should be aware of this and provide the appropriate
customization of the service catalog for their site either manually, or
by customizing deployment tools in use.

.. note::

   As of the Kilo release, documentation for implementing this feature
   is in progress. See this bug for more information:
   https://bugs.launchpad.net/openstack-manuals/+bug/1340509.

Licensing
~~~~~~~~~

Multi-site OpenStack deployments present additional licensing
considerations over and above regular OpenStack clouds, particularly
where site licenses are in use to provide cost efficient access to
software licenses. The licensing for host operating systems, guest
operating systems, OpenStack distributions (if applicable),
software-defined infrastructure including network controllers and
storage systems, and even individual applications need to be evaluated.

Topics to consider include:

* The definition of what constitutes a site in the relevant licenses,
  as the term does not necessarily denote a geographic or otherwise
  physically isolated location.

* Differentiations between "hot" (active) and "cold" (inactive) sites,
  where significant savings may be made in situations where one site is
  a cold standby for disaster recovery purposes only.

* Certain locations might require local vendors to provide support and
  services for each site which may vary with the licensing agreement in
  place.

Logging and monitoring
~~~~~~~~~~~~~~~~~~~~~~

Logging and monitoring does not significantly differ for a multi-site
OpenStack cloud. The tools described in the `Logging and monitoring
chapter <https://docs.openstack.org/ops-guide/ops-logging-monitoring.html>`__
of the OpenStack Operations Guide remain applicable. Logging and monitoring
can be provided on a per-site basis, and in a common centralized location.

When attempting to deploy logging and monitoring facilities to a
centralized location, care must be taken with the load placed on the
inter-site networking links.

Upgrades
~~~~~~~~

In multi-site OpenStack clouds deployed using regions, sites are
independent OpenStack installations which are linked together using
shared centralized services such as OpenStack Identity. At a high level
the recommended order of operations to upgrade an individual OpenStack
environment is (see the `Upgrades
chapter <https://docs.openstack.org/ops-guide/ops-upgrades.html>`__
of the OpenStack Operations Guide for details):

#. Upgrade the OpenStack Identity service (keystone).

#. Upgrade the OpenStack Image service (glance).

#. Upgrade OpenStack Compute (nova), including networking components.

#. Upgrade OpenStack Block Storage (cinder).

#. Upgrade the OpenStack dashboard (horizon).

The process for upgrading a multi-site environment is not significantly
different:

#. Upgrade the shared OpenStack Identity service (keystone) deployment.

#. Upgrade the OpenStack Image service (glance) at each site.

#. Upgrade OpenStack Compute (nova), including networking components, at
   each site.

#. Upgrade OpenStack Block Storage (cinder) at each site.

#. Upgrade the OpenStack dashboard (horizon), at each site or in the
   single central location if it is shared.

Compute upgrades within each site can also be performed in a rolling
fashion. Compute controller services (API, Scheduler, and Conductor) can
be upgraded prior to upgrading of individual compute nodes. This allows
operations staff to keep a site operational for users of Compute
services while performing an upgrade.

Quota management
~~~~~~~~~~~~~~~~

Quotas are used to set operational limits to prevent system capacities
from being exhausted without notification. They are currently enforced
at the project level rather than at the user level.

Quotas are defined on a per-region basis. Operators can define identical
quotas for projects in each region of the cloud to provide a consistent
experience, or even create a process for synchronizing allocated quotas
across regions. It is important to note that only the operational limits
imposed by the quotas will be aligned consumption of quotas by users
will not be reflected between regions.

For example, given a cloud with two regions, if the operator grants a
user a quota of 25 instances in each region then that user may launch a
total of 50 instances spread across both regions. They may not, however,
launch more than 25 instances in any single region.

For more information on managing quotas refer to the `Managing projects
and users
chapter <https://docs.openstack.org/ops-guide/ops-projects-users.html>`__
of the OpenStack Operators Guide.

Policy management
~~~~~~~~~~~~~~~~~

OpenStack provides a default set of Role Based Access Control (RBAC)
policies, defined in a ``policy.json`` file, for each service. Operators
edit these files to customize the policies for their OpenStack
installation. If the application of consistent RBAC policies across
sites is a requirement, then it is necessary to ensure proper
synchronization of the ``policy.json`` files to all installations.

This must be done using system administration tools such as rsync as
functionality for synchronizing policies across regions is not currently
provided within OpenStack.

Documentation
~~~~~~~~~~~~~

Users must be able to leverage cloud infrastructure and provision new
resources in the environment. It is important that user documentation is
accessible by users to ensure they are given sufficient information to
help them leverage the cloud. As an example, by default OpenStack
schedules instances on a compute node automatically. However, when
multiple regions are available, the end user needs to decide in which
region to schedule the new instance. The dashboard presents the user
with the first region in your configuration. The API and CLI tools do
not execute commands unless a valid region is specified. It is therefore
important to provide documentation to your users describing the region
layout as well as calling out that quotas are region-specific. If a user
reaches his or her quota in one region, OpenStack does not automatically
build new instances in another. Documenting specific examples helps
users understand how to operate the cloud, thereby reducing calls and
tickets filed with the help desk.
