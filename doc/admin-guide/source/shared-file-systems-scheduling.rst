.. _shared_file_systems_scheduling:

==========
Scheduling
==========

The Shared File Systems service uses a scheduler to provide unified
access for a variety of different types of shared file systems. The
scheduler collects information from the active shared services, and
makes decisions such as what shared services will be used to create
a new share. To manage this process, the Shared File Systems service
provides Share types API.

A share type is a list from key-value pairs called extra-specs. The
scheduler uses required and un-scoped extra-specs to look up
the shared service most suitable for a new share with the specified share type.
For more information about extra-specs and their type, see `Capabilities
and Extra-Specs <https://docs.openstack.org/developer/manila/devref/capabilities_and_extra_specs.html>`_ section in developer documentation.

The general scheduler workflow:

#. Share services report information about their existing pool number, their
   capacities, and their capabilities.

#. When a request on share creation arrives, the scheduler picks a service
   and pool that best serves the request, using share type
   filters and back end capabilities. If back end capabilities pass through,
   all filters request the selected back end where the target pool resides.

#. The share driver receives a reply on the request status, and lets the
   target pool serve the request as the scheduler instructs. The scoped
   and un-scoped share types are available for the driver implementation
   to use as needed.
