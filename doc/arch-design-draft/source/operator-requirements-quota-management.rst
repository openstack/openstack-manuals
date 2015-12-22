================
Quota management
================

Quotas are used to set operational limits to prevent system capacities
from being exhausted without notification. They are currently enforced
at the tenant (or project) level rather than at the user level.

Quotas are defined on a per-region basis. Operators can define identical
quotas for tenants in each region of the cloud to provide a consistent
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
chapter <http://docs.openstack.org/openstack-ops/content/projects_users.html>`__
of the OpenStack Operators Guide.
