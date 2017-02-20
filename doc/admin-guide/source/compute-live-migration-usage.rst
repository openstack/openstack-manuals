.. _section_live-migration-usage:

=================
Migrate instances
=================

This section discusses how to migrate running instances from one
OpenStack Compute server to another OpenStack Compute server.

Before starting a migration, review the Configure migrations section.
:ref:`section_configuring-compute-migrations`.

.. note::

   Although the :command:`nova` command is called :command:`live-migration`,
   under the default Compute configuration options, the instances
   are suspended before migration. For more information, see
   `Configure migrations
   <https://docs.openstack.org/newton/config-reference/compute/config-options.html>`_.
   in the OpenStack Configuration Reference.

**Migrating instances**

#. Check the ID of the instance to be migrated:

   ..  code-block:: console

       $ openstack server list

       +--------------------------------------+------+--------+-----------------+------------+
       | ID                                   | Name | Status | Networks        | Image Name |
       +--------------------------------------+------+--------+-----------------+------------+
       | d1df1b5a-70c4-4fed-98b7-423362f2c47c | vm1  | ACTIVE | private=a.b.c.d | ...        |
       +--------------------------------------+------+--------+-----------------+------------+
       | d693db9e-a7cf-45ef-a7c9-b3ecb5f22645 | vm2  | ACTIVE | private=e.f.g.h | ...        |
       +--------------------------------------+------+--------+-----------------+------------+

#. Check the information associated with the instance. In this example,
   ``vm1`` is running on ``HostB``:

   ..  code-block:: console

       $ openstack server show d1df1b5a-70c4-4fed-98b7-423362f2c47c

       +----------------------+--------------------------------------+
       | Field                | Value                                |
       +----------------------+--------------------------------------+
       | ...                  | ...                                  |
       | OS-EXT-SRV-ATTR:host | HostB                                |
       | ...                  | ...                                  |
       | addresses            | a.b.c.d                              |
       | flavor               | m1.tiny                              |
       | id                   | d1df1b5a-70c4-4fed-98b7-423362f2c47c |
       | name                 | vm1                                  |
       | status               | ACTIVE                               |
       | ...                  | ...                                  |
       +----------------------+--------------------------------------+

#. Select the compute node the instance will be migrated to. In this
   example, we will migrate the instance to ``HostC``, because
   ``nova-compute`` is running on it:

   .. code-block:: console

      $ openstack compute service list

      +----+------------------+-------+----------+---------+-------+----------------------------+
      | ID | Binary           | Host  | Zone     | Status  | State | Updated At                 |
      +----+------------------+-------+----------+---------+-------+----------------------------+
      |  3 | nova-conductor   | HostA | internal | enabled | up    | 2017-02-18T09:42:29.000000 |
      |  4 | nova-scheduler   | HostA | internal | enabled | up    | 2017-02-18T09:42:26.000000 |
      |  5 | nova-consoleauth | HostA | internal | enabled | up    | 2017-02-18T09:42:29.000000 |
      |  6 | nova-compute     | HostB | nova     | enabled | up    | 2017-02-18T09:42:29.000000 |
      |  7 | nova-compute     | HostC | nova     | enabled | up    | 2017-02-18T09:42:29.000000 |
      +----+------------------+-------+----------+---------+-------+----------------------------+

#. Check that ``HostC`` has enough resources for migration:

   ..  code-block:: console

       # openstack host show HostC

       +-------+------------+-----+-----------+---------+
       | Host  | Project    | CPU | Memory MB | Disk GB |
       +-------+------------+-----+-----------+---------+
       | HostC | (total)    |  16 |     32232 |     878 |
       | HostC | (used_now) |  22 |     21284 |     422 |
       | HostC | (used_max) |  22 |     21284 |     422 |
       | HostC | p1         |  22 |     21284 |     422 |
       | HostC | p2         |  22 |     21284 |     422 |
       +-------+------------+-----+-----------+---------+

   -  ``cpu``: Number of CPUs

   -  ``memory_mb``: Total amount of memory, in MB

   -  ``disk_gb``: Total amount of space for NOVA-INST-DIR/instances, in GB

   In this table, the first row shows the total amount of resources
   available on the physical server. The second line shows the currently
   used resources. The third line shows the maximum used resources. The
   fourth line and below shows the resources available for each project.

#. Migrate the instance using the :command:`openstack server migrate` command:

   .. code-block:: console

      $ openstack server migrate SERVER --live HOST_NAME

   In this example, SERVER can be the ID or name of the instance. Another
   example:

   .. code-block:: console

      $ openstack server migrate d1df1b5a-70c4-4fed-98b7-423362f2c47c --live HostC
      Migration of d1df1b5a-70c4-4fed-98b7-423362f2c47c initiated.

   .. warning::

      When using live migration to move workloads between
      Icehouse and Juno compute nodes, it may cause data loss
      because libvirt live migration with shared block storage
      was buggy (potential loss of data) before version 3.32.
      This issue can be solved when we upgrade to RPC API version 4.0.

#. Check that the instance has been migrated successfully, using
   :command:`openstack server list`. If the instance is still running on
   ``HostB``, check the log files at ``src/dest`` for ``nova-compute`` and
   ``nova-scheduler`` to determine why.
