=============================
Manage Compute service quotas
=============================

As an administrative user, you can use the :command:`nova quota-*`
commands, which are provided by the ``python-novaclient``
package, to update the Compute service quotas for a specific project or
project user, as well as update the quota defaults for a new project.

**Compute quota descriptions**

.. list-table::
   :header-rows: 1
   :widths: 10 40

   * - Quota name
     - Description
   * - cores
     - Number of instance cores (VCPUs) allowed per project.
   * - fixed-ips
     - Number of fixed IP addresses allowed per project. This number
       must be equal to or greater than the number of allowed
       instances.
   * - floating-ips
     - Number of floating IP addresses allowed per project.
   * - injected-file-content-bytes
     - Number of content bytes allowed per injected file.
   * - injected-file-path-bytes
     - Length of injected file path.
   * - injected-files
     - Number of injected files allowed per project.
   * - instances
     - Number of instances allowed per project.
   * - key-pairs
     - Number of key pairs allowed per user.
   * - metadata-items
     - Number of metadata items allowed per instance.
   * - ram
     - Megabytes of instance ram allowed per project.
   * - security-groups
     - Number of security groups per project.
   * - security-group-rules
     - Number of security group rules per project.
   * - server-groups
     - Number of server groups per project.
   * - server-group-members
     - Number of servers per server group.

View and update Compute quotas for a project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To view and update default quota values
---------------------------------------
#. List all default quotas for all projects:

   .. code-block:: console

      $ openstack quota show --default

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

#. Update a default value for a new project, for example:

   .. code-block:: console

      $ nova quota-class-update --instances 15 default

To view quota values for an existing project
--------------------------------------------

#. List the currently set quota values for a project:

   .. code-block:: console

      $ openstack quota show TENANT_NAME

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

To update quota values for an existing project
----------------------------------------------

#. Obtain the project ID.

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. Update a particular quota value.

   .. code-block:: console

      $ nova quota-update --QUOTA_NAME QUOTA_VALUE TENANT_ID

   For example:

   .. code-block:: console

      $ nova quota-update --floating-ips 20 TENANT_NAME
      $ openstack quota show TENANT_NAME
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

      To view a list of options for the :command:`nova quota-update` command,
      run:

      .. code-block:: console

         $ nova help quota-update

View and update Compute quotas for a project user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To view quota values for a project user
---------------------------------------

#. Place the user ID in a usable variable.

   .. code-block:: console

      $ tenantUser=$(openstack user show -f value -c id USER_NAME)

#. Place the user's project ID in a usable variable, as follows:

   .. code-block:: console

      $ tenant=$(openstack project show -f value -c id TENANT_NAME)

#. List the currently set quota values for a project user.

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
      | server_groups               | 10    |
      | server_group_members        | 10    |
      +-----------------------------+-------+

To update quota values for a project user
-----------------------------------------

#. Place the user ID in a usable variable.

   .. code-block:: console

      $ tenantUser=$(openstack user show -f value -c id USER_NAME)

#. Place the user's project ID in a usable variable, as follows:

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
      | server_groups               | 10    |
      | server_group_members        | 10    |
      +-----------------------------+-------+

   .. note::

      To view a list of options for the :command:`nova quota-update` command,
      run:

      .. code-block:: console

         $ nova help quota-update

To display the current quota usage for a project user
-----------------------------------------------------

Use :command:`nova absolute-limits` to get a list of the
current quota values and the current quota usage:

.. code-block:: console

   $ nova absolute-limits --tenant TENANT_NAME
   +--------------------+------+-------+
   | Name               | Used | Max   |
   +--------------------+------+-------+
   | Cores              | 0    | 20    |
   | FloatingIps        | 0    | 10    |
   | ImageMeta          | -    | 128   |
   | Instances          | 0    | 10    |
   | Keypairs           | -    | 100   |
   | Personality        | -    | 5     |
   | Personality Size   | -    | 10240 |
   | RAM                | 0    | 51200 |
   | SecurityGroupRules | -    | 20    |
   | SecurityGroups     | 0    | 10    |
   | Server Meta        | -    | 128   |
   | ServerGroupMembers | -    | 10    |
   | ServerGroups       | 0    | 10    |
   +--------------------+------+-------+
