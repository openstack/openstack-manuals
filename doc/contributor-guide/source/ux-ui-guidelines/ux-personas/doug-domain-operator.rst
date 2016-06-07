.. _doug-domain-operator:

======================
Doug - domain operator
======================

Doug manages the relationship with the cloud services provider. This includes
managing quotas, number of users, applicable policies, and support tickets.
He does not have any major concerns about the underlying infrastructure of
the cloud. He ensures that the :abbr:`SLA (Service-Level Agreement)` is
followed.

Doug needs to know about any outages, both scheduled and unscheduled.
Unscheduled outages cause a lot of problems for Doug, as ideally there would
never be an unscheduled outage.

Key tasks
~~~~~~~~~

Doug performs the following tasks very frequently:

* Managing quotas: Defines the amount of resources that the cloud service
  provider must supply and ensures that those resources are being effectively
  used.

* Managing users: Defines the number of users with access to the cloud
  services. He manages the access and rights of users for the entire cloud
  services.

* Ensuring SLA compliance: Monitors the various policies and support tickets
  to ensure that the agreed terms are being fulfilled.

Key information
~~~~~~~~~~~~~~~

Doug spends no time researching OpenStack. It is likely that he does not even
know that the cloud service provider uses OpenStack. He does not care how the
cloud instances are run, as long as they run without unexpected outages. He
expects to be provided with adequate monitoring tools. Adding and removing
users from the provided cloud services should be as easy as possible, in his
opinion.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
organization, such as Rifkom or Nikishi University, Doug might be required to
assume some roles and responsibilities of a Cloud Operator or a Project
Owner. Within a larger organization, like CNBB Securities, Doug's tasks are
performed by the team managing the cloud services provider.

Your development
~~~~~~~~~~~~~~~~

Doug's main concern are the cloud outages. Doug will not interact directly
with OpenStack, save in rare cases or within small organizations. Therefore,
changes that affect the stability and reliability of the cloud services are
his greatest concern.

Doug assumes that the cloud services provider will supply him adequate
monitoring and user management tools. Doug expects the cloud to let him know
the current status of the cloud in such a way, that he can ask the provider
to solve it as quickly as possible. Doug will not fix the problems himself.
Therefore, ensure that error notifications are clear and do not require any
advanced knowledge of OpenStack to identify the issues.

If your development modifies the user management of the cloud, ensure to take
Doug into consideration. User management should be as simple as possible and
it should not require deep knowledge about OpenStack.
