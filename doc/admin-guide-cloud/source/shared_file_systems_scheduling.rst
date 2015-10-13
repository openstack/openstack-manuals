.. _shared_file_systems_scheduling:

==========
Scheduling
==========

Shared File Systems service provides unified access for variety of different
types of shared file systems. To achieve this, Shared File Systems service
use scheduler. Scheduler collects information from active share services and
take decisions, what share service will be used to create new share. To manage
this process Shared File Systems service provides Share types API.

Share type is a list from key-value pairs called extra-specs. Some of them,
called required and un-scoped extra-specs, scheduler uses for lookup the
share service suitable for new share with specified share type. For more
information about extra-specs and their type see `Capabilities and Extra-Specs
<http://docs.openstack.org/developer/manila/devref/capabilities_and_extra_spec
s.html>`_ section in developer documentation.

In general scheduler workflow looks like:

1) Share services report information about number of existed pools, their
   capacities and capabilities.

2) When request on share creation comes in, scheduler picks a service and pool
   that fits the need best to serve the request, using share type filters and
   back end capabilities. If back end capabilities passes thought all filters
   request to the selected back end where the target pool resides;

3) Share driver gets the message and lets the target pool serve the request
   as scheduler instructed. Share type extra-specs (scoped and un-scoped)
   are available for the driver implementation to use as-needed.
