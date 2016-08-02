================================
Manage Networking service quotas
================================

A quota limits the number of available resources. A default
quota might be enforced for all tenants. When you try to create
more resources than the quota allows, an error occurs:

.. code-block:: ini

   $ neutron net-create test_net
    Quota exceeded for resources: ['network']

Per-tenant quota configuration is also supported by the quota
extension API. See :ref:`cfg_quotas_per_tenant` for details.

Basic quota configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

In the Networking default quota mechanism, all tenants have
the same quota values, such as the number of resources that a
tenant can create.

The quota value is defined in the OpenStack Networking
``/etc/neutron/neutron.conf`` configuration file. This example shows the
default quota values:

.. code-block:: ini

   [quotas]
   # number of networks allowed per tenant, and minus means unlimited
   quota_network = 10

   # number of subnets allowed per tenant, and minus means unlimited
   quota_subnet = 10

   # number of ports allowed per tenant, and minus means unlimited
   quota_port = 50

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

Configure per-tenant quotas
~~~~~~~~~~~~~~~~~~~~~~~~~~~
OpenStack Networking also supports per-tenant quota limit by
quota extension API.

Use these commands to manage per-tenant quotas:

neutron quota-delete
    Delete defined quotas for a specified tenant

neutron quota-list
    Lists defined quotas for all tenants

neutron quota-show
    Shows quotas for a specified tenant

neutron quota-update
    Updates quotas for a specified tenant

Only users with the ``admin`` role can change a quota value. By default,
the default set of quotas are enforced for all tenants, so no
:command:`quota-create` command exists.

#. Configure Networking to show per-tenant quotas

   Set the ``quota_driver`` option in the ``/etc/neutron/neutron.conf`` file.

   .. code-block:: ini

      quota_driver = neutron.db.quota_db.DbQuotaDriver

   When you set this option, the output for Networking commands shows ``quotas``.

#. List Networking extensions.

   To list the Networking extensions, run this command:

   .. code-block:: console

      $ neutron ext-list -c alias -c name

   The command shows the ``quotas`` extension, which provides
   per-tenant quota management support.

   .. code-block:: console

      +-----------------+--------------------------+
      | alias           | name                     |
      +-----------------+--------------------------+
      | agent_scheduler | Agent Schedulers         |
      | security-group  | security-group           |
      | binding         | Port Binding             |
      | quotas          | Quota management support |
      | agent           | agent                    |
      | provider        | Provider Network         |
      | router          | Neutron L3 Router        |
      | lbaas           | LoadBalancing service    |
      | extraroute      | Neutron Extra Route      |
      +-----------------+--------------------------+

#. Show information for the quotas extension.

   To show information for the ``quotas`` extension, run this command:

   .. code-block:: console

      $ neutron ext-show quotas
      +-------------+------------------------------------------------------------+
      | Field       | Value                                                      |
      +-------------+------------------------------------------------------------+
      | alias       | quotas                                                     |
      | description | Expose functions for quotas management per tenant          |
      | links       |                                                            |
      | name        | Quota management support                                   |
      | namespace   | http://docs.openstack.org/network/ext/quotas-sets/api/v2.0 |
      | updated     | 2012-07-29T10:00:00-00:00                                  |
      +-------------+------------------------------------------------------------+

   .. note::

      Only some plug-ins support per-tenant quotas.
      Specifically, Open vSwitch, Linux Bridge, and VMware NSX
      support them, but new versions of other plug-ins might
      bring additional functionality. See the documentation for
      each plug-in.

#. List tenants who have per-tenant quota support.

   The :command:`neutron quota-list` command lists tenants for which the
   per-tenant quota is enabled. The command does not list tenants with default
   quota support. You must be an administrative user to run this command:

   .. code-block:: console

      $ neutron quota-list
      +------------+---------+------+--------+--------+----------------------------------+
      | floatingip | network | port | router | subnet | tenant_id                        |
      +------------+---------+------+--------+--------+----------------------------------+
      |         20 |       5 |   20 |     10 |      5 | 6f88036c45344d9999a1f971e4882723 |
      |         25 |      10 |   30 |     10 |     10 | bff5c9455ee24231b5bc713c1b96d422 |
      +------------+---------+------+--------+--------+----------------------------------+

#. Show per-tenant quota values.

   The :command:`neutron quota-show` command reports the current
   set of quota limits for the specified tenant.
   Non-administrative users can run this command without the
   :option:`--tenant_id` parameter. If per-tenant quota limits are
   not enabled for the tenant, the command shows the default
   set of quotas.

   .. code-block:: console

      $ neutron quota-show --tenant_id 6f88036c45344d9999a1f971e4882723
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 20    |
      | network    | 5     |
      | port       | 20    |
      | router     | 10    |
      | subnet     | 5     |
      +------------+-------+

   The following command shows the command output for a
   non-administrative user.

   .. code-block:: console

      $ neutron quota-show
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 20    |
      | network    | 5     |
      | port       | 20    |
      | router     | 10    |
      | subnet     | 5     |
      +------------+-------+

#. Update quota values for a specified tenant.

   Use the :command:`neutron quota-update` command to
   update a quota for a specified tenant.

   .. code-block:: console

      $ neutron quota-update --tenant_id 6f88036c45344d9999a1f971e4882723 --network 5
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 50    |
      | network    | 5     |
      | port       | 50    |
      | router     | 10    |
      | subnet     | 10    |
      +------------+-------+

   You can update quotas for multiple resources through one
   command.

   .. code-block:: console

      $ neutron quota-update --tenant_id 6f88036c45344d9999a1f971e4882723 --subnet 5 --port 20
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 50    |
      | network    | 5     |
      | port       | 20    |
      | router     | 10    |
      | subnet     | 5     |
      +------------+-------+

   To update the limits for an L3 resource such as, router
   or floating IP, you must define new values for the quotas
   after the ``--`` directive.

   This example updates the limit of the number of floating
   IPs for the specified tenant.

   .. code-block:: console

      $ neutron quota-update --tenant_id 6f88036c45344d9999a1f971e4882723 --floatingip 20
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 20    |
      | network    | 5     |
      | port       | 20    |
      | router     | 10    |
      | subnet     | 5     |
      +------------+-------+

   You can update the limits of multiple resources by
   including L2 resources and L3 resource through one
   command:

   .. code-block:: console

      $ neutron quota-update --tenant_id 6f88036c45344d9999a1f971e4882723 \
        --network 3 --subnet 3 --port 3 --floatingip 3 --router 3
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 3     |
      | network    | 3     |
      | port       | 3     |
      | router     | 3     |
      | subnet     | 3     |
      +------------+-------+

#. Delete per-tenant quota values.

   To clear per-tenant quota limits, use the
   :command:`neutron quota-delete` command.

   .. code-block:: console

      $ neutron quota-delete --tenant_id 6f88036c45344d9999a1f971e4882723
       Deleted quota: 6f88036c45344d9999a1f971e4882723

   After you run this command, you can see that quota
   values for the tenant are reset to the default values.

   .. code-block:: console

      $ neutron quota-show --tenant_id 6f88036c45344d9999a1f971e4882723
      +------------+-------+
      | Field      | Value |
      +------------+-------+
      | floatingip | 50    |
      | network    | 10    |
      | port       | 50    |
      | router     | 10    |
      | subnet     | 10    |
      +------------+-------+
