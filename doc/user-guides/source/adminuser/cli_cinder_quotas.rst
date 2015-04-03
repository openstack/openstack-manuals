.. meta::
    :scope: admin_only

===================================
Manage Block Storage service quotas
===================================

As an administrative user, you can update the OpenStack Block
Storage service quotas for a project. You can also update the quota
defaults for a new project.

**Block Storage quotas**

===================  ===========================================
 Property name          Defines the number of
===================  ===========================================
 gigabytes              Volume gigabytes allowed for each tenant.
 snapshots              Volume snapshots allowed for each tenant.
 volumes                Volumes allowed for each tenant.
===================  ===========================================

View Block Storage quotas
~~~~~~~~~~~~~~~~~~~~~~~~~

Administrative users can view Block Storage service quotas.

#. List the default quotas for all projects:

   .. code::

      $ cinder quota-defaults TENANT_ID
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. View Block Storage service quotas for a project::

      $ cinder quota-show TENANT_NAME

   For example:

   .. code::

      $ cinder quota-show tenant01
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. Show the current usage of a per-tenant quota:

   .. code::

      $ cinder quota-usage tenantID
      +-----------+--------+----------+-------+
      |    Type   | In_use | Reserved | Limit |
      +-----------+--------+----------+-------+
      | gigabytes |   0    |    0     |  1000 |
      | snapshots |   0    |    0     |   10  |
      |  volumes  |   0    |    0     |   15  |
      +-----------+--------+----------+-------+

Edit and update Block Storage service quotas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Administrative users can edit and update Block Storage
service quotas.

#. Clear per-tenant quota limits::

      $ cinder quota-delete tenantID

#. To update a default value for a new project,
   update the property in the :guilabel:`cinder.quota`
   section of the :file:`/etc/cinder/cinder.conf` file.
   For more information, see the `Block Storage
   Configuration Reference <http://docs.openstack.org/trunk/config-reference/content/ch_configuring-openstack-block-storage.html>`_.

#. To update Block Storage service quotas, place
   the tenant ID in a variable::

      $ tenant=$(keystone tenant-list | awk '/tenantName/ {print $2}')

#. Update a particular quota value::

      $ cinder quota-update --quotaName NewValue tenantID

   For example:

   .. code::

      $ cinder quota-update --volumes 15 $tenant
      $ cinder quota-show tenant01
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   15  |
      +-----------+-------+

#. Clear per-tenant quota limits::

      $ cinder quota-delete tenantID
