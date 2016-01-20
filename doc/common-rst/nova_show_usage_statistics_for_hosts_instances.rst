=============================================
Show usage statistics for hosts and instances
=============================================

You can show basic statistics on resource usage for hosts and instances.

.. note::

   For more sophisticated monitoring, see the
   `ceilometer <https://launchpad.net/ceilometer>`__ project. You can
   also use tools, such as `Ganglia <http://ganglia.info/>`__ or
   `Graphite <http://graphite.wikidot.com/>`__, to gather more detailed
   data.

Show host usage statistics
~~~~~~~~~~~~~~~~~~~~~~~~~~

The following examples show the host usage statistics for a host called
``devstack``.

*  List the hosts and the nova-related services that run on them:

   .. code-block:: console

      $ nova host-list
      +-----------+-------------+----------+
      | host_name | service     | zone     |
      +-----------+-------------+----------+
      | devstack  | conductor   | internal |
      | devstack  | compute     | nova     |
      | devstack  | cert        | internal |
      | devstack  | network     | internal |
      | devstack  | scheduler   | internal |
      | devstack  | consoleauth | internal |
      +-----------+-------------+----------+

*  Get a summary of resource usage of all of the instances running on
   the host:

   .. code-block:: console

      $ nova host-describe devstack
      +----------+----------------------------------+-----+-----------+---------+
      | HOST     | PROJECT                          | cpu | memory_mb | disk_gb |
      +----------+----------------------------------+-----+-----------+---------+
      | devstack | (total)                          | 2   | 4003      | 157     |
      | devstack | (used_now)                       | 3   | 5120      | 40      |
      | devstack | (used_max)                       | 3   | 4608      | 40      |
      | devstack | b70d90d65e464582b6b2161cf3603ced | 1   | 512       | 0       |
      | devstack | 66265572db174a7aa66eba661f58eb9e | 2   | 4096      | 40      |
      +----------+----------------------------------+-----+-----------+---------+

   The ``cpu`` column shows the sum of the virtual CPUs for instances
   running on the host.

   The ``memory_mb`` column shows the sum of the memory (in MB)
   allocated to the instances that run on the host.

   The ``disk_gb`` column shows the sum of the root and ephemeral disk
   sizes (in GB) of the instances that run on the host.

   The row that has the value ``used_now`` in the ``PROJECT`` column
   shows the sum of the resources allocated to the instances that run on
   the host, plus the resources allocated to the virtual machine of the
   host itself.

   The row that has the value ``used_max`` in the ``PROJECT`` column
   shows the sum of the resources allocated to the instances that run on
   the host.

   .. note::

      These values are computed by using information about the flavors of
      the instances that run on the hosts. This command does not query the
      CPU usage, memory usage, or hard disk usage of the physical host.

Show instance usage statistics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*  Get CPU, memory, I/O, and network statistics for an instance.

   #. List instances:

      .. code-block:: console

         $ nova list
         +----------+----------------------+--------+------------+-------------+------------------+
         | ID       | Name                 | Status | Task State | Power State | Networks         |
         +----------+----------------------+--------+------------+-------------+------------------+
         | 84c6e... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
         | 8a995... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
         +----------+----------------------+--------+------------+-------------+------------------+

   #. Get diagnostic statistics:

      .. code-block:: console

         $ nova diagnostics myCirrosServer
         +------------------+----------------+
         | Property         | Value          |
         +------------------+----------------+
         | vnet1_rx         | 1210744        |
         | cpu0_time        | 19624610000000 |
         | vda_read         | 0              |
         | vda_write        | 0              |
         | vda_write_req    | 0              |
         | vnet1_tx         | 863734         |
         | vnet1_tx_errors  | 0              |
         | vnet1_rx_drop    | 0              |
         | vnet1_tx_packets | 3855           |
         | vnet1_tx_drop    | 0              |
         | vnet1_rx_errors  | 0              |
         | memory           | 2097152        |
         | vnet1_rx_packets | 5485           |
         | vda_read_req     | 0              |
         | vda_errors       | -1             |
         +------------------+----------------+

*  Get summary statistics for each tenant:

   .. code-block:: console

      $ nova usage-list
      Usage from 2013-06-25 to 2013-07-24:
      +----------------------------------+-----------+--------------+-----------+---------------+
      | Tenant ID                        | Instances | RAM MB-Hours | CPU Hours | Disk GB-Hours |
      +----------------------------------+-----------+--------------+-----------+---------------+
      | b70d90d65e464582b6b2161cf3603ced | 1         | 344064.44    | 672.00    | 0.00          |
      | 66265572db174a7aa66eba661f58eb9e | 3         | 671626.76    | 327.94    | 6558.86       |
      +----------------------------------+-----------+--------------+-----------+---------------+
