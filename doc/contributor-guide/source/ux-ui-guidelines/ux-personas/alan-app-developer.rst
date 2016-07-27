.. _alan-app-developer:

============================
Alan - application developer
============================

Alan develops and deploys cloud applications but does not necessarily know
much about the underlying infrastructure of the cloud.

Cloud applications are defined as:

* Applications built using OpenStack SDKs or APIs
* Applications deployed on top of OpenStack using Application Catalog
  service, Orchestration service, or any 3rd-party deployment or
  management tools
* PaaS and container solutions running on top of OpenStack

The cloud instances Alan consumes can use various OpenStack projects.
Alan does not know the project names and goals, and has never
been to an OpenStack Summit.

Alan wishes to deploy his applications to the cloud without issues and to
receive warnings about any issues with the applications before tickets start
coming. Whenever an issue arises during deployment or testing, Alan is
grateful for clear uncomplicated notices. Such notices allow him to resolve
the issues before customers become frustrated. Alan values a consistent API
that makes his development future-proof and backwards-compatible.

Key tasks
~~~~~~~~~

Alan performs the following tasks frequently:

* Development: Develops cloud-based applications with various requirements.

* Management: Controls and changes all aspects of compute instances and file
  storage.

* Testing: Tests developed applications before deploying them. Performs the
  tests in one or multiple cloud instances.

* Deployment: Deploys his applications to one or multiple cloud instances.

Key information
~~~~~~~~~~~~~~~

Alan spends very little to no time researching OpenStack. He does not care
how the cloud instances he uses were installed, as long as they work exactly
as he expects and the needed APIs do not change unexpectedly. He does not
control what tool is used to install and maintain the cloud instances.
However, he determines the requirements for those cloud instances.
Any changes made to the APIs greatly impact Alan's work.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
organization, such as Rifkom or Nikishi University, Alan might be required to
assume some roles and responsibilities of a Domain Operator or a Cloud
Operator. Within a larger organization, like CNBB Securities, Alan will
likely not work alone on an application. Multiple application developers
would need to access a single cloud to develop, test, and deploy the same
application, making user control a requirement for the cloud.

Your development
~~~~~~~~~~~~~~~~

Alan's main concern are the APIs available to him. Alan will not interact
directly with OpenStack, save in rare cases or within small organizations.
Therefore, changes to the GUI and CLI are not relevant to Alan. On the other
hand, even the tiniest changes in APIs have a high impact on his application
development.

Alan assumes that the cloud has the resources his applications need. If the
cloud does not have the resources, Alan expects the cloud to let him know
what resources are missing in such a way, that he can ask a Cloud or Domain
operator to add those resources. Alan will not add the resources himself.
Therefore, ensure that notifications are clear and do not require any
advanced knowledge of OpenStack to identify the issues.
