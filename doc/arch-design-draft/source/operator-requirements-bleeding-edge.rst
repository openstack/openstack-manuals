=================
The bleeding edge
=================

The number of organizations running at massive scales is a small proportion of
the OpenStack community, therefore it is important to share related issues
with the community and be a vocal advocate for resolving them. Some issues
only manifest when operating at large scale, and the number of organizations
able to duplicate and validate an issue is small, so it is important to
document and dedicate resources to their resolution.

In some cases, the resolution to the problem is ultimately to deploy a more
recent version of OpenStack. Alternatively, when you must resolve an issue in
a production environment where rebuilding the entire environment is not an
option, it is sometimes possible to deploy updates to specific underlying
components in order to resolve issues or gain significant performance
improvements. Although this may appear to expose the deployment to increased
risk and instability, in many cases it could be an undiscovered issue.

We recommend building a development and operations organization that is
responsible for creating desired features, diagnosing and resolving issues,
and building the infrastructure for large scale continuous integration tests
and continuous deployment. This helps catch bugs early and makes deployments
faster and easier. In addition to development resources, we also recommend the
recruitment of experts in the fields of message queues, databases, distributed
systems, networking, cloud, and storage.
