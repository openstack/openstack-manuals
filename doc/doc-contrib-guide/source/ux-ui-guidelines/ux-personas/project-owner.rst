.. _project-owner:

===================
Wei - project owner
===================

Wei does not know or care about whether OpenStack is being used for the cloud
instance that the projects use or not. Wei's concern is to have enough
resources whenever they are needed. If Wei's requests for additional
resources take too long to be fulfilled, Wei will start looking for
alternatives until the project's needs are met.
Therefore, if a project runs out of quota, Wei does not want to have to wait
for the operators to raise it.

Key tasks
~~~~~~~~~

Wei performs the following tasks very frequently:

* Managing access: adds and removes project members' access to OpenStack
  resources.

* Managing capacity: Requests additional resources through a
  :abbr:`RUR (Resource Usage Request)`.

* Managing projects: Coordinates project resources to ensure its success and
  the OpenStack cloud is another resource among many other.

Your development
~~~~~~~~~~~~~~~~

When your development affects the behavior of the capacity of cloud
instances, you should consider Wei as an interested party. Ensuring that
changes to the capacity of cloud instances can occur as easily and as quickly
as possible certainly has a positive impact on Wei's work, for example.
However, Wei does not perform those changes in capacity directly.

Finally, consider that Wei is a highly skilled developer with little
knowledge of OpenStack and with little time for long, complex research.
Therefore, your solutions for Wei must be focused on enabling others to
provide the needed resources as quickly as possible.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
company, Wei might be required to assume some of the responsibilities of the
Domain Operator or maybe even the Cloud Operator. In this case, the
persona does not need to submit requests to manage the cloud's resources but
can rather make the changes needed.

Within a larger organization, multiple individuals could be performing Wei's
tasks. For example, each project could have a different person as a project
owner and the company could have several projects.

Whatever the case, it is highly likely that Wei is an experienced application
developer as well. See the information pertaining to the application
developer persona here: :ref:`app-developer`. To see more on
how roles change within organizations, see :ref:`model-companies`.

