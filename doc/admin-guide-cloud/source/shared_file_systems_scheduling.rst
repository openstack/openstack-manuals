.. _shared_file_systems_scheduling:

==========
Scheduling
==========

The Shared File Systems service provides unified access for variety of
different types of shared file systems. To achieve this, the Shared File
Systems service uses a scheduler. The scheduler collects information from
active share services and takes decisions, what share service will be used to
create a new share. To manage this process, the Shared File Systems service
provides Share types API.

A share type is a list from key-value pairs called extra-specs. Some of them,
called required and un-scoped extra-specs, scheduler uses for lookup the
share service suitable for new share with specified share type. For more
information about extra-specs and their type, see `Capabilities and Extra-Specs
<http://docs.openstack.org/developer/manila/devref/capabilities_and_extra_spec
s.html>`_ section in developer documentation.

The general scheduler workflow in described below.

#. Share services report information about number of existing pools, their
   capacities and capabilities.

#. When request on share creation comes in, scheduler picks a service and pool
   that fits the need best to serve the request, using share type filters and
   back end capabilities. If back end capabilities passes thought all filters
   request to the selected back end where the target pool resides.

#. Share driver gets the message and lets the target pool serve the request
   as scheduler instructed. The scoped and un-scoped share type extra-specs
   are available for the driver implementation to use as needed.
