======
Quotas
======

To prevent system capacities from being exhausted without notification,
you can set up :term:`quotas <quota>`. Quotas are operational limits. For example,
the number of gigabytes allowed per tenant can be controlled to ensure that
a single tenant cannot consume all of the disk space. Quotas are
currently enforced at the tenant (or project) level, rather than the
user level.

.. warning::

   Because without sensible quotas a single tenant could use up all the
   available resources, default quotas are shipped with OpenStack. You
   should pay attention to which quota settings make sense for your
   hardware capabilities.

Using the command-line interface, you can manage quotas for the
OpenStack Compute service and the Block Storage service.

Typically, default values are changed because a tenant requires more
than the OpenStack default of 10 volumes per tenant, or more than the
OpenStack default of 1 TB of disk space on a compute node.

.. note::

   To view all tenants, run:

   .. code-block:: console

       $ openstack project list
       +---------------------------------+----------+
       | ID                              | Name     |
       +---------------------------------+----------+
       | a981642d22c94e159a4a6540f70f9f8 | admin    |
       | 934b662357674c7b9f5e4ec6ded4d0e | tenant01 |
       | 7bc1dbfd7d284ec4a856ea1eb82dca8 | tenant02 |
       | 9c554aaef7804ba49e1b21cbd97d218 | services |
       +---------------------------------+----------+

Set Image Quotas
~~~~~~~~~~~~~~~~

You can restrict a project's image storage by total number of bytes.
Currently, this quota is applied cloud-wide, so if you were to set an
Image quota limit of 5 GB, then all projects in your cloud will be able
to store only 5 GB of images and snapshots.

To enable this feature, edit the ``/etc/glance/glance-api.conf`` file,
and under the ``[DEFAULT]`` section, add:

.. code-block:: ini

   user_storage_quota = <bytes>

For example, to restrict a project's image storage to 5 GB, do this:

.. code-block:: ini

   user_storage_quota = 5368709120

.. note::

   There is a configuration option in ``/etc/glance/glance-api.conf`` that limits
   the number of members allowed per image, called
   ``image_member_quota``, set to 128 by default. That setting is a
   different quota from the storage quota.

Set Compute Service Quotas
~~~~~~~~~~~~~~~~~~~~~~~~~~

As an administrative user, you can update the Compute service quotas for
an existing tenant, as well as update the quota defaults for a new
tenant. See :ref:`table_compute_quota`.

.. _table_compute_quota:

.. list-table:: Compute quota descriptions
   :widths: 30 40 30
   :header-rows: 1

   * - Quota
     - Description
     - Property name
   * - Fixed IPs
     - Number of fixed IP addresses allowed per project.
       This number must be equal to or greater than the number
       of allowed instances.
     - ``fixed-ips``
   * - Floating IPs
     - Number of floating IP addresses allowed per project.
     - ``floating-ips``
   * - Injected file content bytes
     - Number of content bytes allowed per injected file.
     - ``injected-file-content-bytes``
   * - Injected file path bytes
     - Number of bytes allowed per injected file path.
     - ``injected-file-path-bytes``
   * - Injected files
     - Number of injected files allowed per project.
     - ``injected-files``
   * - Instances
     - Number of instances allowed per project.
     - ``instances``
   * - Key pairs
     - Number of key pairs allowed per user.
     - ``key-pairs``
   * - Metadata items
     - Number of metadata items allowed per instance.
     - ``metadata-items``
   * - RAM
     - Megabytes of instance RAM allowed per project.
     - ``ram``
   * - Security group rules
     - Number of security group rules per project.
     - ``security-group-rules``
   * - Security groups
     - Number of security groups per project.
     - ``security-groups``
   * - VCPUs
     - Number of instance cores allowed per project.
     - ``cores``
   * - Server Groups
     - Number of server groups per project.
     - ``server_groups``
   * - Server Group Members
     - Number of servers per server group.
     - ``server_group_members``

View and update compute quotas for a tenant (project)
-----------------------------------------------------

As an administrative user, you can use the :command:`nova quota-*`
commands, which are provided by the
``python-novaclient`` package, to view and update tenant quotas.

**To view and update default quota values**

#. List all default quotas for all tenants, as follows:

   .. code-block:: console

      $ nova quota-defaults

   For example:

   .. code-block:: console

      $ nova quota-defaults
      +-----------------------------+-------+
      | Quota                       | Limit |
      +-----------------------------+-------+
      | instances                   | 10    |
      | cores                       | 20    |
      | ram                         | 51200 |
      | floating_ips                | 10    |
      | fixed_ips                   | -1    |
      | metadata_items              | 128   |
      | injected_files              | 5     |
      | injected_file_content_bytes | 10240 |
      | injected_file_path_bytes    | 255   |
      | key_pairs                   | 100   |
      | security_groups             | 10    |
      | security_group_rules        | 20    |
      | server_groups               | 10    |
      | server_group_members        | 10    |
      +-----------------------------+-------+

#. Update a default value for a new tenant, as follows:

   .. code-block:: console

      $ nova quota-class-update default key value

   For example:

   .. code-block:: console

      $ nova quota-class-update default --instances 15

**To view quota values for a tenant (project)**

#. Place the tenant ID in a variable:

   .. code-block:: console

      $ tenant=$(openstack project list | awk '/tenantName/ {print $2}')

#. List the currently set quota values for a tenant, as follows:

   .. code-block:: console

      $ nova quota-show --tenant $tenant

   For example:

   .. code-block:: console

      $ nova quota-show --tenant $tenant
      +-----------------------------+-------+
      | Quota                       | Limit |
      +-----------------------------+-------+
      | instances                   | 10    |
      | cores                       | 20    |
      | ram                         | 51200 |
      | floating_ips                | 10    |
      | fixed_ips                   | -1    |
      | metadata_items              | 128   |
      | injected_files              | 5     |
      | injected_file_content_bytes | 10240 |
      | injected_file_path_bytes    | 255   |
      | key_pairs                   | 100   |
      | security_groups             | 10    |
      | security_group_rules        | 20    |
      | server_groups               | 10    |
      | server_group_members        | 10    |
      +-----------------------------+-------+

**To update quota values for a tenant (project)**

#. Obtain the tenant ID, as follows:

   .. code-block:: console

      $ tenant=$(openstack project list | awk '/tenantName/ {print $2}')

#. Update a particular quota value, as follows:

   .. code-block:: console

      # nova quota-update --quotaName quotaValue tenantID

   For example:

   .. code-block:: console

      # nova quota-update --floating-ips 20 $tenant
      # nova quota-show --tenant $tenant
      +-----------------------------+-------+
      | Quota                       | Limit |
      +-----------------------------+-------+
      | instances                   | 10    |
      | cores                       | 20    |
      | ram                         | 51200 |
      | floating_ips                | 20    |
      | fixed_ips                   | -1    |
      | metadata_items              | 128   |
      | injected_files              | 5     |
      | injected_file_content_bytes | 10240 |
      | injected_file_path_bytes    | 255   |
      | key_pairs                   | 100   |
      | security_groups             | 10    |
      | security_group_rules        | 20    |
      | server_groups               | 10    |
      | server_group_members        | 10    |
      +-----------------------------+-------+

   .. note::

      To view a list of options for the ``nova quota-update`` command, run:

      .. code-block:: console

         $ nova help quota-update

Set Object Storage Quotas
~~~~~~~~~~~~~~~~~~~~~~~~~

There are currently two categories of quotas for Object Storage:

Container quotas
    Limit the total size (in bytes) or number of objects that can be
    stored in a single container.

Account quotas
    Limit the total size (in bytes) that a user has available in the
    Object Storage service.

To take advantage of either container quotas or account quotas, your
Object Storage proxy server must have ``container_quotas`` or
``account_quotas`` (or both) added to the ``[pipeline:main]`` pipeline.
Each quota type also requires its own section in the
``proxy-server.conf`` file:

.. code-block:: ini

   [pipeline:main]
   pipeline = catch_errors [...] slo dlo account_quotas proxy-server

   [filter:account_quotas]
   use = egg:swift#account_quotas

   [filter:container_quotas]
   use = egg:swift#container_quotas

To view and update Object Storage quotas, use the :command:`swift` command
provided by the ``python-swiftclient`` package. Any user included in the
project can view the quotas placed on their project. To update Object
Storage quotas on a project, you must have the role of ResellerAdmin in
the project that the quota is being applied to.

To view account quotas placed on a project:

.. code-block:: console

   $ swift stat
      Account: AUTH_b36ed2d326034beba0a9dd1fb19b70f9
   Containers: 0
      Objects: 0
        Bytes: 0
   Meta Quota-Bytes: 214748364800
   X-Timestamp: 1351050521.29419
   Content-Type: text/plain; charset=utf-8
   Accept-Ranges: bytes

To apply or update account quotas on a project:

.. code-block:: console

   $ swift post -m quota-bytes:
        <bytes>

For example, to place a 5 GB quota on an account:

.. code-block:: console

   $ swift post -m quota-bytes:
        5368709120

To verify the quota, run the :command:`swift stat` command again:

.. code-block:: console

   $ swift stat
      Account: AUTH_b36ed2d326034beba0a9dd1fb19b70f9
   Containers: 0
      Objects: 0
        Bytes: 0
   Meta Quota-Bytes: 5368709120
   X-Timestamp: 1351541410.38328
   Content-Type: text/plain; charset=utf-8
   Accept-Ranges: bytes

Set Block Storage Quotas
~~~~~~~~~~~~~~~~~~~~~~~~

As an administrative user, you can update the Block Storage service
quotas for a tenant, as well as update the quota defaults for a new
tenant. See :ref:`table_block_storage_quota`.

.. _table_block_storage_quota:

.. list-table:: Table: Block Storage quota descriptions
   :widths: 50 50
   :header-rows: 1

   * - Property name
     - Description
   * - gigabytes
     - Number of volume gigabytes allowed per tenant
   * - snapshots
     - Number of Block Storage snapshots allowed per tenant.
   * - volumes
     - Number of Block Storage volumes allowed per tenant

View and update Block Storage quotas for a tenant (project)
-----------------------------------------------------------

As an administrative user, you can use the :command:`cinder quota-*`
commands, which are provided by the
``python-cinderclient`` package, to view and update tenant quotas.

**To view and update default Block Storage quota values**

#. List all default quotas for all tenants, as follows:

   .. code-block:: console

      $ cinder quota-defaults tenantID

#. Obtain the tenant ID, as follows:

   .. code-block:: console

      $ tenant=$(openstack project list | awk '/tenantName/ {print $2}')

   For example:

   .. code-block:: console

      $ cinder quota-defaults $tenant
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

#. To update a default value for a new tenant, update the property in the
   ``/etc/cinder/cinder.conf`` file.

**To view Block Storage quotas for a tenant (project)**

#. View quotas for the tenant, as follows:

   .. code-block:: console

      # cinder quota-show  tenantID

   For example:

   .. code-block:: console

      # cinder quota-show $tenant
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   10  |
      +-----------+-------+

**To update Block Storage quotas for a tenant (project)**

#. Place the tenant ID in a variable:

   .. code-block:: console

      $ tenant=$(openstack project list | awk '/tenantName/ {print $2}')

#. Update a particular quota value, as follows:

   .. code-block:: console

      # cinder quota-update --quotaName NewValue tenantID

   For example:

   .. code-block:: console

      # cinder quota-update --volumes 15 $tenant
      # cinder quota-show $tenant
      +-----------+-------+
      |  Property | Value |
      +-----------+-------+
      | gigabytes |  1000 |
      | snapshots |   10  |
      |  volumes  |   15  |
      +-----------+-------+
