.. _shared_file_systems_scheduling:

==========
Scheduling
==========

The Shared File Systems service provides unified access for a variety of
different types of shared file systems. To achieve this, the Shared File
Systems service uses a scheduler. The scheduler collects information from
the active shared services and makes decisions such as what shared services
will be used to create a new share. To manage this process, the Shared
File Systems service provides Share types API.

A share type is a list from key-value pairs called extra-specs. Some of them,
called required and un-scoped extra-specs, the scheduler uses for lookup of
the shared service suitable for a new share with the specified share type.
For more information about extra-specs and their type, see `Capabilities
and Extra-Specs <http://docs.openstack.org/developer/manila/devref/capabilities_and_extra_specs.html>`_ section in developer documentation.

The general scheduler workflow is described below.

#. Share services report information about the number of existing pools, their
   capacities and capabilities.

#. When a request on share creation comes in, the scheduler picks a service
   and pool that fits the need best to serve the request, using share type
   filters and back end capabilities. If back end capabilities pass through,
   all filters request to the selected back end where the target pool resides.

#. The share driver gets the message and lets the target pool serve the
   request as the scheduler instructs. The scoped and un-scoped share type
   extra-specs are available for the driver implementation to use as needed.
