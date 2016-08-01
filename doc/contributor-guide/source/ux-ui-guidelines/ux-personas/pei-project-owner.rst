.. _pei-project-owner:

===================
Pei - project owner
===================

Pei manages projects by adding or removing project members' access to the
cloud instance. Pei does not know the underlying infrastructure nor the
OpenStack projects involved. Pei's main concern is to have enough resources
available to support her projects. Therefore, if a project runs out of quota,
she does not want to have to wait for the operators to raise it.

Key tasks
~~~~~~~~~

Pei performs the following tasks very frequently:

* Managing access: adds and removes project members' access to OpenStack
  resources.

* Managing capacity: Requests additional resources through a
  :abbr:`RUR (Resource Usage Request)`.

* Managing projects: Coordinates project resources to ensure its success and
  the OpenStack cloud is another resource among many other.

Key information
~~~~~~~~~~~~~~~

Pei does not know or care about whether OpenStack is being used for the cloud
instance her projects use or not. Her concern is to have the resources she
needs when she needs them. If her requests for additional resources take too
long to be fulfilled she will start looking for alternatives until the needs
of her projects are met.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
company, Pei might be required to assume some of the responsibilities of the
the Domain Operator or maybe even the Cloud Operator. In this case, the
persona does not need to submit requests to manage the cloud's resources but
can rather make the changes needed.

Within a larger organization, multiple individuals could be performing Pei's
tasks. For example, each project could have a different person as a project
owner and the company could have several projects.

Whatever the case, it is highly likely that Pei is an experienced application
developer as well. See the information pertaining to the application
developer persona here: :ref:`alan-app-developer`

Your development
~~~~~~~~~~~~~~~~

When your development affects the behavior of the capacity of cloud
instances, you should consider Pei as an interested party. Ensuring that
changes to the capacity of cloud instances can occur as easily and as quickly
as possible certainly has a positive impact on Pei's work, for example.
However, Pei does not perform those changes in capacity herself.

Finally, consider that Pei is a highly skilled developer with little
knowledge of OpenStack and with little time for long, complex research.
Therefore, your solutions for Pei must be focused on enabling others to
provide the needed resources as quickly as possible.
