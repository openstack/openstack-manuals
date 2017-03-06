Operational considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to run efficiently at massive scale, automate as many of the
operational processes as possible. Automation includes the configuration of
provisioning, monitoring and alerting systems. Part of the automation process
includes the capability to determine when human intervention is required and
who should act. The objective is to decrease the ratio of operational staff to
running systems as much as possible in order to reduce maintenance costs. In a
massively scaled environment, it is very difficult for staff to give each
system individual care.

Configuration management tools such as Puppet and Chef enable operations staff
to categorize systems into groups based on their roles and thus create
configurations and system states that the provisioning system enforces.
Systems that fall out of the defined state due to errors or failures are
quickly removed from the pool of active nodes and replaced.

At large scale the resource cost of diagnosing failed individual systems is
far greater than the cost of replacement. It is more economical to replace the
failed system with a new system, provisioning and configuring it automatically
and adding it to the pool of active nodes. By automating tasks that are
labor-intensive, repetitive, and critical to operations, cloud operations
teams can work more efficiently because fewer resources are required for these
common tasks. Administrators are then free to tackle tasks that are not easy
to automate and that have longer-term impacts on the business, for example,
capacity planning.

The bleeding edge
-----------------

Running OpenStack at massive scale requires striking a balance between
stability and features. For example, it might be tempting to run an older
stable release branch of OpenStack to make deployments easier. However, when
running at massive scale, known issues that may be of some concern or only
have minimal impact in smaller deployments could become pain points. Recent
releases may address well known issues. The OpenStack community can help
resolve reported issues by applying the collective expertise of the OpenStack
developers.

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

Growth and capacity planning
----------------------------

An important consideration in running at massive scale is projecting growth
and utilization trends in order to plan capital expenditures for the short and
long term. Gather utilization meters for compute, network, and storage, along
with historical records of these meters. While securing major anchor projects
can lead to rapid jumps in the utilization rates of all resources, the steady
adoption of the cloud inside an organization or by consumers in a public
offering also creates a steady trend of increased utilization.

Skills and training
-------------------

Projecting growth for storage, networking, and compute is only one aspect of a
growth plan for running OpenStack at massive scale. Growing and nurturing
development and operational staff is an additional consideration. Sending team
members to OpenStack conferences, meetup events, and encouraging active
participation in the mailing lists and committees is a very important way to
maintain skills and forge relationships in the community. For a list of
OpenStack training providers in the marketplace, see the `Openstack Marketplace
<https://www.openstack.org/marketplace/training/>`_.
