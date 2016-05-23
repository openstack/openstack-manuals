========
Upgrades
========

Running OpenStack with a focus on availability requires striking a balance
between stability and features. For example, it might be tempting to run an
older stable release branch of OpenStack to make deployments easier. However
known issues that may be of some concern or only have minimal impact in smaller
deployments could become pain points as scale increases. Recent releases may
address well known issues. The OpenStack community can help resolve reported
issues by applying the collective expertise of the OpenStack developers.

In multi-site OpenStack clouds deployed using regions, sites are
independent OpenStack installations which are linked together using
shared centralized services such as OpenStack Identity. At a high level
the recommended order of operations to upgrade an individual OpenStack
environment is (see the `Upgrades
chapter <http://docs.openstack.org/openstack-ops/content/ops_upgrades-general-steps.html>`_
of the Operations Guide for details):

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
