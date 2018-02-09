.. _domain-operator:

========================
Taylor - domain operator
========================

Taylor does not have any major concerns about the underlying
infrastructure of the cloud and ensures that the :abbr:`SLA (Service-Level
Agreement)` is followed.

Taylor spends no time researching OpenStack. It is likely that Taylor does
not even know that the cloud service provider uses OpenStack and does not
care how the cloud instances are run, as long as they run without unexpected
outages. Taylor expects to be provided with adequate monitoring tools. Adding
and removing users from the provided cloud services should be as easy as
possible, in Taylor's opinion.

Key tasks
~~~~~~~~~

Taylor performs the following tasks very frequently:

* Managing quotas: Defines the amount of resources that the cloud service
  provider must supply and ensures that those resources are being effectively
  used.

* Managing users: Defines the number of users with access to the cloud
  services. They manage the access and rights of users for the entire cloud
  services.

* Ensuring SLA compliance: Monitors the various policies and support tickets
  to ensure that the agreed terms are being fulfilled.

Your development
~~~~~~~~~~~~~~~~

Taylor's main concern are the cloud outages. Taylor will not interact
directly with OpenStack, save in rare cases or within small organizations.
Therefore, changes that affect the stability and reliability of the cloud
services are Taylor's greatest concern.

Taylor assumes that the cloud services provider will supply adequate
monitoring and user management tools. Taylor expects the cloud to notify the
current status of the cloud in such a way, that Taylor can ask the provider
to solve it as quickly as possible. Taylor will not fix the problems
directly. Therefore, ensure that error notifications are clear and do not
require any advanced knowledge of OpenStack to identify the issues.

If your development modifies the user management of the cloud, ensure to take
Taylor into consideration. User management should be as simple as possible
and it should not require deep knowledge about OpenStack.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
organization, such as Rifkom or Nikishi University, Taylor might be required
to assume some roles and responsibilities of a Cloud Operator or a Project
Owner. Within a larger organization, like CNBB Securities, Taylor's tasks are
performed by the team managing the cloud services provider. To see more on
how roles change within organizations, see :ref:`model-companies`.

