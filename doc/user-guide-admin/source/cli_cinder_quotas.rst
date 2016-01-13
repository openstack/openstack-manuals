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

   .. code-block:: console

      $ cinder quota-defaults TENANT_ID
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. View Block Storage service quotas for a project.

   .. code-block:: console

      $ cinder quota-show TENANT_NAME

   For example:

   .. code-block:: console

      $ cinder quota-show tenant01
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. Show the current usage of a per-tenant quota:

   .. code-block:: console

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

#. Clear per-tenant quota limits.

   .. code-block:: console

      $ cinder quota-delete tenantID

#. To update a default value for a new project,
   update the property in the :guilabel:`cinder.quota`
   section of the ``/etc/cinder/cinder.conf`` file.
   For more information, see the `Block Storage
   Configuration Reference <http://docs.openstack.org/liberty/config-reference/content/ch_configuring-openstack-block-storage.html>`_.

#. To update Block Storage service quotas, place
   the tenant ID in a variable.

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id tenantName)

#. Update a particular quota value.

   .. code-block:: console

      $ cinder quota-update --quotaName NewValue tenantID

   For example:

   .. code-block:: console

      $ cinder quota-update --volumes 15 $tenant
      $ cinder quota-show tenant01
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   15  |
      +-----------+-------+

#. Clear per-tenant quota limits.

   .. code-block:: console

      $ cinder quota-delete tenantID

Remove a service
~~~~~~~~~~~~~~~~

#. Determine the binary and host of the service you want to remove.

   .. code-block:: console

      $ cinder service-list
      +------------------+----------------------+------+---------+-------+----------------------------+-----------------+
      |      Binary      |         Host         | Zone |  Status | State |         Updated_at         | Disabled Reason |
      +------------------+----------------------+------+---------+-------+----------------------------+-----------------+
      | cinder-scheduler |       devstack       | nova | enabled |   up  | 2015-10-13T15:21:48.000000 |        -        |
      |  cinder-volume   | devstack@lvmdriver-1 | nova | enabled |   up  | 2015-10-13T15:21:52.000000 |        -        |
      +------------------+----------------------+------+---------+-------+----------------------------+-----------------+

#. Disable the service.

   .. code-block:: console

      $ cinder service-disable <host> <binary>

#. Remove the service from the database.

   .. code-block:: console

      $ cinder-manage service remove <binary> <host>
