=============================
Manage Compute service quotas
=============================

As an administrative user, you can use the :command:`nova quota-*`
commands, which are provided by the ``python-novaclient``
package, to update the Compute service quotas for a specific tenant or
tenant user, as well as update the quota defaults for a new tenant.

**Compute quota descriptions**

.. list-table::
   :header-rows: 1
   :widths: 10 40

   * - Quota name
     - Description
   * - cores
     - Number of instance cores (VCPUs) allowed per tenant.
   * - fixed-ips
     - Number of fixed IP addresses allowed per tenant. This number
       must be equal to or greater than the number of allowed
       instances.
   * - floating-ips
     - Number of floating IP addresses allowed per tenant.
   * - injected-file-content-bytes
     - Number of content bytes allowed per injected file.
   * - injected-file-path-bytes
     - Length of injected file path.
   * - injected-files
     - Number of injected files allowed per tenant.
   * - instances
     - Number of instances allowed per tenant.
   * - key-pairs
     - Number of key pairs allowed per user.
   * - metadata-items
     - Number of metadata items allowed per instance.
   * - ram
     - Megabytes of instance ram allowed per tenant.
   * - security-groups
     - Number of security groups per tenant.
   * - security-group-rules
     - Number of rules per security group.

View and update Compute quotas for a tenant (project)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To view and update default quota values
---------------------------------------
#. List all default quotas for all tenants:

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
      +-----------------------------+-------+

#. Update a default value for a new tenant.

   .. code-block:: console

      $ nova quota-class-update --KEY VALUE default

   For example:

   .. code-block:: console

      $ nova quota-class-update --instances 15 default

To view quota values for an existing tenant (project)
-----------------------------------------------------

#. Place the tenant ID in a usable variable.

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. List the currently set quota values for a tenant.

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
      +-----------------------------+-------+

To update quota values for an existing tenant (project)
-------------------------------------------------------

#. Obtain the tenant ID.

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. Update a particular quota value.

   .. code-block:: console

      $ nova quota-update --QUOTA_NAME QUOTA_VALUE TENANT_ID

   For example:

   .. code-block:: console

      $ nova quota-update --floating-ips 20 $tenant
      $ nova quota-show --tenant $tenant
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
      +-----------------------------+-------+

   .. note::

      To view a list of options for the :command:`nova quota-update` command,
      run:

      .. code-block:: console

         $ nova help quota-update

View and update Compute quotas for a tenant user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To view quota values for a tenant user
--------------------------------------

#. Place the user ID in a usable variable.

   .. code-block:: console

      $ tenantUser=$(openstack user show -f value -c id USER_NAME)

#. Place the user's tenant ID in a usable variable, as follows:

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. List the currently set quota values for a tenant user.

   .. code-block:: console

      $ nova quota-show --user $tenantUser --tenant $tenant

   For example:

   .. code-block:: console

      $ nova quota-show --user $tenantUser --tenant $tenant
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
      +-----------------------------+-------+

To update quota values for a tenant user
----------------------------------------

#. Place the user ID in a usable variable.

   .. code-block:: console

      $ tenantUser=$(openstack user show -f value -c id USER_NAME)

#. Place the user's tenant ID in a usable variable, as follows:

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. Update a particular quota value, as follows:

   .. code-block:: console

      $ nova quota-update  --user $tenantUser --QUOTA_NAME QUOTA_VALUE $tenant

   For example:

   .. code-block:: console

      $ nova quota-update --user $tenantUser --floating-ips 12 $tenant
      $ nova quota-show --user $tenantUser --tenant $tenant
      +-----------------------------+-------+
      | Quota                       | Limit |
      +-----------------------------+-------+
      | instances                   | 10    |
      | cores                       | 20    |
      | ram                         | 51200 |
      | floating_ips                | 12    |
      | fixed_ips                   | -1    |
      | metadata_items              | 128   |
      | injected_files              | 5     |
      | injected_file_content_bytes | 10240 |
      | injected_file_path_bytes    | 255   |
      | key_pairs                   | 100   |
      | security_groups             | 10    |
      | security_group_rules        | 20    |
      +-----------------------------+-------+

   .. note::

      To view a list of options for the :command:`nova quota-update` command,
      run:

      .. code-block:: console

         $ nova help quota-update

To display the current quota usage for a tenant user
----------------------------------------------------

Use :command:`nova absolute-limits` to get a list of the
current quota values and the current quota usage:

.. code-block:: console

   $ nova absolute-limits --tenant TENANT_NAME
   +-------------------------+-------+
   | Name                    | Value |
   +-------------------------+-------+
   | maxServerMeta           | 128   |
   | maxPersonality          | 5     |
   | maxImageMeta            | 128   |
   | maxPersonalitySize      | 10240 |
   | maxTotalRAMSize         | 51200 |
   | maxSecurityGroupRules   | 20    |
   | maxTotalKeypairs        | 100   |
   | totalRAMUsed            | 0     |
   | maxSecurityGroups       | 10    |
   | totalFloatingIpsUsed    | 0     |
   | totalInstancesUsed      | 0     |
   | totalSecurityGroupsUsed | 0     |
   | maxTotalFloatingIps     | 10    |
   | maxTotalInstances       | 10    |
   | totalCoresUsed          | 0     |
   | maxTotalCores           | 20    |
   +-------------------------+-------+
