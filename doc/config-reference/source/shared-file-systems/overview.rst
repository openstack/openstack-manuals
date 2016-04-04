===============================================
Introduction to the Shared File Systems service
===============================================

The Shared File Systems service provides shared file systems that
Compute instances can consume.

The Shared File Systems service provides:

manila-api
   A WSGI app that authenticates and routes requests
   throughout the Shared File Systems service. It supports the OpenStack
   APIs.

manila-data
  A standalone service whose purpose is to receive requests, process data
  operations with potentially long running time such as copying, share
  migration or backup.

manila-scheduler
   Schedules and routes requests to the appropriate
   share service. The scheduler uses configurable filters and weighers
   to route requests. The Filter Scheduler is the default and enables
   filters on things like Capacity, Availability Zone, Share Types, and
   Capabilities as well as custom filters.

manila-share
   Manages back-end devices that provide shared file
   systems. A manila-share service can run in one of two modes, with or
   without handling of share servers. Share servers export file shares
   via share networks. When share servers are not used, the networking
   requirements are handled outside of Manila.

The Shared File Systems service contains the following components:

**Back-end storage devices**
   The Shared File Services service requires some form of back-end shared file
   system provider that the service is built on. The reference implementation
   uses the Block Storage service (Cinder) and a service VM to provide shares.
   Additional drivers are used to access shared file systems from a variety of
   vendor solutions.

**Users and tenants (projects)**
   The Shared File Systems service can be used by many different cloud
   computing consumers or customers (tenants on a shared system), using
   role-based access assignments.  Roles control the actions that a user is
   allowed to perform. In the default configuration, most actions do not
   require a particular role unless they are restricted to administrators, but
   this can be configured by the system administrator in the appropriate
   ``policy.json`` file that maintains the rules. A user's access to manage
   particular shares is limited by tenant. Guest access to mount and use shares
   is secured by IP and/or user access rules. Quotas used to control resource
   consumption across available hardware resources are per tenant.

   For tenants, quota controls are available to limit:

   -  The number of shares that can be created.

   -  The number of gigabytes that can be provisioned for shares.

   -  The number of share snapshots that can be created.

   -  The number of gigabytes that can be provisioned for share
      snapshots.

   -  The number of share networks that can be created.

   You can revise the default quota values with the Shared File Systems
   CLI, so the limits placed by quotas are editable by admin users.

**Shares, snapshots, and share networks**
   The basic resources offered by the Shared File Systems service are shares,
   snapshots and share networks:

   **Shares**
      A share is a unit of storage with a protocol, a size, and an access list.
      Shares are the basic primitive provided by Manila. All shares exist on a
      backend. Some shares are associated with share networks and share
      servers. The main protocols supported are NFS and CIFS, but other
      protocols are supported as well.

   **Snapshots**
      A snapshot is a point in time copy of a share.  Snapshots can only be
      used to create new shares (containing the snapshotted data). Shares
      cannot be deleted until all associated snapshots are deleted.

   **Share networks**
      A share network is a tenant-defined object that informs Manila about the
      security and network configuration for a group of shares. Share networks
      are only relevant for backends that manage share servers. A share network
      contains a security service and network/subnet.
