===================================
Manage Block Storage service quotas
===================================

As an administrative user, you can update the OpenStack Block
Storage service quotas for a project. You can also update the quota
defaults for a new project.

**Block Storage quotas**

===================  =============================================
 Property name          Defines the number of
===================  =============================================
 gigabytes              Volume gigabytes allowed for each project.
 snapshots              Volume snapshots allowed for each project.
 volumes                Volumes allowed for each project.
===================  =============================================

View Block Storage quotas
~~~~~~~~~~~~~~~~~~~~~~~~~

Administrative users can view Block Storage service quotas.

#. Obtain the project ID.

   For example:

   .. code-block:: console

      $ project_id=$(openstack project show -f value -c id PROJECT_NAME)

#. List the default quotas for a project:

   .. code-block:: console

      $ cinder quota-defaults PROJECT_ID

   For example:

   .. code-block:: console

      $ cinder quota-defaults $project_id
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. View Block Storage service quotas for a project:

   .. code-block:: console

      $ cinder quota-show PROJECT_ID

   For example:

   .. code-block:: console

      $ cinder quota-show $project_id
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. Show the current usage of a per-project quota:

   .. code-block:: console

      $ cinder quota-usage PROJECT_ID

   For example:

   .. code-block:: console

      $ cinder quota-usage $project_id
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

#. To update a default value for a new project,
   update the property in the :guilabel:`cinder.quota`
   section of the ``/etc/cinder/cinder.conf`` file.
   For more information, see the `Block Storage service
   <https://docs.openstack.org/newton/config-reference/block-storage.html>`_
   in OpenStack Configuration Reference.

#. To update Block Storage service quotas for an existing project

   .. code-block:: console

      $ cinder quota-update --QUOTA_NAME QUOTA_VALUE PROJECT_ID

   Replace ``QUOTA_NAME`` with the quota that is to be updated,
   ``QUOTA_VALUE`` with the required new value, and ``PROJECT_ID``
   with the required project ID.

   For example:

   .. code-block:: console

      $ cinder quota-update --volumes 15 $project_id
      $ cinder quota-show $project_id
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   15  |
      +-----------+-------+


#. To clear per-project quota limits:

   .. code-block:: console

      $ cinder quota-delete PROJECT_ID
