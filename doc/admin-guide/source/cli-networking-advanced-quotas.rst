================================
Manage Networking service quotas
================================

A quota limits the number of available resources. A default
quota might be enforced for all projects. When you try to create
more resources than the quota allows, an error occurs:

.. code-block:: console

   $ openstack network create test_net
    Quota exceeded for resources: ['network']

Per-project quota configuration is also supported by the quota
extension API. See :ref:`cfg_quotas_per_tenant` for details.

Basic quota configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

In the Networking default quota mechanism, all projects have
the same quota values, such as the number of resources that a
project can create.

The quota value is defined in the OpenStack Networking
``/etc/neutron/neutron.conf`` configuration file. This example shows the
default quota values:

.. code-block:: ini

   [quotas]
   # number of networks allowed per tenant, and minus means unlimited
   quota_network = 100

   # number of subnets allowed per tenant, and minus means unlimited
   quota_subnet = 100

   # number of ports allowed per tenant, and minus means unlimited
   quota_port = 500

   # default driver to use for quota checks
   quota_driver = neutron.quota.ConfDriver

OpenStack Networking also supports quotas for L3 resources:
router and floating IP. Add these lines to the
``quotas`` section in the ``/etc/neutron/neutron.conf`` file:

.. code-block:: ini

   [quotas]
   # number of routers allowed per tenant, and minus means unlimited
   quota_router = 10

   # number of floating IPs allowed per tenant, and minus means unlimited
   quota_floatingip = 50

OpenStack Networking also supports quotas for security group
resources: number of security groups and the number of rules for
each security group. Add these lines to the
``quotas`` section in the ``/etc/neutron/neutron.conf`` file:

.. code-block:: ini

   [quotas]
   # number of security groups per tenant, and minus means unlimited
   quota_security_group = 10

   # number of security rules allowed per tenant, and minus means unlimited
   quota_security_group_rule = 100

.. _cfg_quotas_per_tenant:

Configure per-project quotas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OpenStack Networking also supports per-project quota limit by
quota extension API.

Use these commands to manage per-project quotas:

neutron quota-delete
    Delete defined quotas for a specified project

openstack quota show
    Lists defined quotas for all projects

openstack quota show PROJECT_ID
    Shows quotas for a specified project

neutron quota-default-show
    Show default quotas for a specified project

openstack quota set
    Updates quotas for a specified project

Only users with the ``admin`` role can change a quota value. By default,
the default set of quotas are enforced for all projects, so no
:command:`quota-create` command exists.

#. Configure Networking to show per-project quotas

   Set the ``quota_driver`` option in the ``/etc/neutron/neutron.conf`` file.

   .. code-block:: ini

      quota_driver = neutron.db.quota_db.DbQuotaDriver

   When you set this option, the output for Networking commands shows ``quotas``.

#. List Networking extensions.

   To list the Networking extensions, run this command:

   .. code-block:: console

      $ openstack extension list --network

   The command shows the ``quotas`` extension, which provides
   per-project quota management support.

   .. note::

      Many of the extensions shown below are supported in the Mitaka release and later.

   .. code-block:: console

      +------------------------+------------------------+--------------------------+
      | Name                   | Alias                  | Description              |
      +------------------------+------------------------+--------------------------+
      | ...                    | ...                    | ...                      |
      | Quota management       | quotas                 | Expose functions for     |
      | support                |                        | quotas management per    |
      |                        |                        | tenant                   |
      | ...                    | ...                    | ...                      |
      +------------------------+------------------------+--------------------------+

#. Show information for the quotas extension.

   To show information for the ``quotas`` extension, run this command:

   .. code-block:: console

      $ neutron ext-show quotas
      +-------------+---------------------------------------------------+
      | Field       | Value                                             |
      +-------------+---------------------------------------------------+
      | alias       | quotas                                            |
      | description | Expose functions for quotas management per tenant |
      | links       |                                                   |
      | name        | Quota management support                          |
      | updated     | 2012-07-29T10:00:00-00:00                         |
      +-------------+---------------------------------------------------+

   .. note::

      Only some plug-ins support per-project quotas.
      Specifically, Open vSwitch, Linux Bridge, and VMware NSX
      support them, but new versions of other plug-ins might
      bring additional functionality. See the documentation for
      each plug-in.

#. List project's default quotas.

   The :command:`openstack quota show` command lists quotas for the current
   project.

   .. code-block:: console

      $ openstack quota show
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 50                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 100                              |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 500                              |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 100                              |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

#. Show per-project quota values.

   The :command:`openstack quota show` command reports the current
   set of quota limits. Administrators can provide the project ID of a
   specific project with the :command:`openstack quota show` command
   to view quotas for the specific project. If per-project quota
   limits are not enabled for the project, the command shows
   the default set of quotas:

   .. note::

      Additional quotas added in the Mitaka release include ``security_group``,
      ``security_group_rule``, ``subnet``, and ``subnetpool``.

   .. code-block:: console

      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 50                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 100                              |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 500                              |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 100                              |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

#. Update quota values for a specified project.

   Use the :command:`openstack quota set` command to
   update a quota for a specified project.

   .. code-block:: console

      $ openstack quota set --networks 5 e436339c7f9c476cb3120cf3b9667377
      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 50                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 5                                |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 500                              |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 100                              |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

   You can update quotas for multiple resources through one
   command.

   .. code-block:: console

      $ openstack quota set --subnets 5 --ports 20 e436339c7f9c476cb3120cf3b9667377
      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 50                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 5                                |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 50                               |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 10                               |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

   To update the limits for an L3 resource such as, router
   or floating IP, you must define new values for the quotas
   after the ``--`` directive.

   This example updates the limit of the number of floating
   IPs for the specified project.

   .. code-block:: console

      $ openstack quota set --floating-ips 20 e436339c7f9c476cb3120cf3b9667377
      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 20                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 5                                |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 500                              |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 100                              |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

   You can update the limits of multiple resources by
   including L2 resources and L3 resource through one
   command:

   .. code-block:: console

      $ openstack quota set --networks 3 --subnets 3 --ports 3 \
        --floating-ips 3 --routers 3 e436339c7f9c476cb3120cf3b9667377
      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 3                                |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 3                                |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 3                                |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 3                                |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

#. Delete per-project quota values.

   To clear per-project quota limits, use the
   :command:`neutron quota-delete` command.

   .. code-block:: console

      $ neutron quota-delete --tenant_id e436339c7f9c476cb3120cf3b9667377
       Deleted quota: e436339c7f9c476cb3120cf3b9667377

   After you run this command, you can see that quota
   values for the project are reset to the default values.

   .. code-block:: console

      $ openstack quota show e436339c7f9c476cb3120cf3b9667377
      +-----------------------+----------------------------------+
      | Field                 | Value                            |
      +-----------------------+----------------------------------+
      | backup-gigabytes      | 1000                             |
      | backups               | 10                               |
      | cores                 | 20                               |
      | fixed-ips             | -1                               |
      | floating-ips          | 50                               |
      | gigabytes             | 1000                             |
      | gigabytes_lvmdriver-1 | -1                               |
      | health_monitors       | None                             |
      | injected-file-size    | 10240                            |
      | injected-files        | 5                                |
      | injected-path-size    | 255                              |
      | instances             | 10                               |
      | key-pairs             | 100                              |
      | l7_policies           | None                             |
      | listeners             | None                             |
      | load_balancers        | None                             |
      | location              | None                             |
      | name                  | None                             |
      | networks              | 100                              |
      | per-volume-gigabytes  | -1                               |
      | pools                 | None                             |
      | ports                 | 500                              |
      | project               | e436339c7f9c476cb3120cf3b9667377 |
      | project_id            | None                             |
      | properties            | 128                              |
      | ram                   | 51200                            |
      | rbac_policies         | 10                               |
      | routers               | 10                               |
      | secgroup-rules        | 100                              |
      | secgroups             | 10                               |
      | server-group-members  | 10                               |
      | server-groups         | 10                               |
      | snapshots             | 10                               |
      | snapshots_lvmdriver-1 | -1                               |
      | subnet_pools          | -1                               |
      | subnets               | 100                              |
      | volumes               | 10                               |
      | volumes_lvmdriver-1   | -1                               |
      +-----------------------+----------------------------------+

.. note::

   Listing defualt quotas with the OpenStack command line client will
   provide all quotas for networking and other services. Previously,
   the :command:`neutron quota-show --tenant_id` would list only networking
   quotas.
