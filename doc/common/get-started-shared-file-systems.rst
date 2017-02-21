====================================
Shared File Systems service overview
====================================

The OpenStack Shared File Systems service (manila) provides file storage to a
virtual machine. The Shared File Systems service provides an infrastructure
for managing and provisioning of file shares. The service also enables
management of share types as well as share snapshots if a driver supports
them.

The Shared File Systems service consists of the following components:

manila-api
  A WSGI app that authenticates and routes requests throughout the Shared File
  Systems service. It supports the OpenStack APIs.

manila-data
  A standalone service whose purpose is to receive requests, process data
  operations such as copying, share migration or backup, and send back a
  response after an operation has been completed.

manila-scheduler
  Schedules and routes requests to the appropriate share service. The
  scheduler uses configurable filters and weighers to route requests. The
  Filter Scheduler is the default and enables filters on things like Capacity,
  Availability Zone, Share Types, and Capabilities as well as custom filters.

manila-share
  Manages back-end devices that provide shared file systems. A manila-share
  process can run in one of two modes, with or without handling of share
  servers. Share servers export file shares via share networks. When share
  servers are not used, the networking requirements are handled outside of
  Manila.

Messaging queue
  Routes information between the Shared File Systems processes.

For more information, see `OpenStack Configuration Reference <https://docs.openstack.org/ocata/config-reference/shared-file-systems/overview.html>`__.
