.. meta::
   :scope: admin_only

=============
Manage quotas
=============

To prevent system capacities from being exhausted without
notification, you can set up quotas. Quotas are operational
limits. For example, the number of gigabytes allowed for each
tenant can be controlled so that cloud resources are optimized.
Quotas can be enforced at both the tenant (or project)
and the tenant-user level.

Using the command-line interface, you can manage quotas for
the OpenStack Compute service, the OpenStack Block Storage service,
and the OpenStack Networking service.

The cloud operator typically changes default values because a
tenant requires more than ten volumes or :guilabel:`&1 TB` on a compute
node.

   .. note::

     To view all tenants (projects), run:

       .. code::

          $ keystone tenant-list
          +----------------------------------+----------+---------+
          |                id                |   name   | enabled |
          +----------------------------------+----------+---------+
          | e66d97ac1b704897853412fc8450f7b9 |  admin   |   True  |
          | bf4a37b885fe46bd86e999e50adad1d3 | services |   True  |
          | 21bd1c7c95234fd28f589b60903606fa | tenant01 |   True  |
          | f599c5cd1cba4125ae3d7caed08e288c | tenant02 |   True  |
          +----------------------------------+----------+---------+

     To display all current users for a tenant, run:

       .. code::

          $ keystone user-list --tenant-id tenantID
          +----------------------------------+--------+---------+-------+
          |                id                |  name  | enabled | email |
          +----------------------------------+--------+---------+-------+
          | ea30aa434ab24a139b0e85125ec8a217 | demo00 |   True  |       |
          | 4f8113c1d838467cad0c2f337b3dfded | demo01 |   True  |       |
          +----------------------------------+--------+---------+-------+


.. toctree::
   :maxdepth: 2

   cli_cinder_quotas.rst

.. TODO add sections when migrated
