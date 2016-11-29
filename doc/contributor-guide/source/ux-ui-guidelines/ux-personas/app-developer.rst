.. _app-developer:

=============================
Quinn - application developer
=============================

Quinn spends very little to no time researching OpenStack. Quinn does not
care how the cloud instances used were installed, as long as they work
exactly as expected and the needed APIs do not change unexpectedly. Quinn
does not control what tool is used to install and maintain the cloud
instances. However, Quinn determines the requirements for those cloud
instances. Any changes made to the APIs greatly impact Quinn's work.

Cloud applications are defined as:

* Applications built using OpenStack SDKs or APIs
* Applications deployed on top of OpenStack using Application Catalog
  service, Orchestration service, or any 3rd-party deployment or management
  tools
* PaaS and container solutions running on top of OpenStack

The cloud instances Quinn consumes can use various OpenStack projects. Quinn
does not know the project names and goals, and has never been to an OpenStack
Summit.

Quinn wishes to deploy applications to the cloud without issues and to
receive warnings about any issues with the applications before tickets start
coming. Whenever an issue arises during deployment or testing, Quinn is
grateful for clear uncomplicated notices. Such notices allow Quinn to resolve
the issues before customers become frustrated. Quinn values a consistent API
that makes Quinn's development future-proof and backwards-compatible.

Key tasks
~~~~~~~~~

Quinn performs the following tasks frequently:

* Development: Develops cloud-based applications with various requirements.

* Management: Controls and changes all aspects of compute instances and file
  storage.

* Testing: Tests developed applications before deploying them. Performs the
  tests in one or multiple cloud instances.

* Deployment: Deploys applications to one or multiple cloud instances.

Your development
~~~~~~~~~~~~~~~~

Quinn's main concern are the APIs available. Quinn will not interact directly
with OpenStack, save in rare cases or within small organizations. Therefore,
changes to the GUI and CLI are not relevant to Quinn. On the other hand, even
the tiniest changes in APIs have a high impact on Quinn's application
development.

Quinn assumes that the cloud has the resources the applications need. If the
cloud does not have the resources, Quinn expects the cloud to let inform what
resources are missing in such a way, that Quinn can ask a Cloud or Domain
operator to add those resources. Quinn will not add the resources.
Therefore, ensure that notifications are clear and do not require any
advanced knowledge of OpenStack to identify the issues.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
organization, such as Rifkom or Nikishi University, Quinn might be required
to assume some roles and responsibilities of a Domain Operator or a Cloud
Operator. Within a larger organization, like CNBB Securities, Quinn will
likely not work alone on an application. Multiple application developers
would need to access a single cloud to develop, test, and deploy the same
application, making user control a requirement for the cloud. See
:ref:`model-companies` for more information on how Quinn fits into different
user ecosystems.

