=======================
Manage Compute services
=======================

You can enable and disable Compute services. The following
examples disable and enable the ``nova-compute`` service.


#. List the Compute services:

   .. code-block:: console

      $ nova service-list
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+
      | Binary           | Host     | Zone     | Status  | State | Updated_at                 | Disabled Reason |
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+
      | nova-conductor   | devstack | internal | enabled | up    | 2013-10-16T00:56:08.000000 | None            |
      | nova-cert        | devstack | internal | enabled | up    | 2013-10-16T00:56:09.000000 | None            |
      | nova-compute     | devstack | nova     | enabled | up    | 2013-10-16T00:56:07.000000 | None            |
      | nova-network     | devstack | internal | enabled | up    | 2013-10-16T00:56:06.000000 | None            |
      | nova-scheduler   | devstack | internal | enabled | up    | 2013-10-16T00:56:04.000000 | None            |
      | nova-consoleauth | devstack | internal | enabled | up    | 2013-10-16T00:56:07.000000 | None            |
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+

#. Disable a nova service:

   .. code-block:: console

      $ nova service-disable localhost.localdomain nova-compute --reason 'trial log'
      +----------+--------------+----------+-------------------+
      | Host     | Binary       | Status   | Disabled Reason   |
      +----------+--------------+----------+-------------------+
      | devstack | nova-compute | disabled | Trial log         |
      +----------+--------------+----------+-------------------+

#. Check the service list:

   .. code-block:: console

      $ nova service-list
      +------------------+----------+----------+---------+-------+----------------------------+------------------+
      | Binary           | Host     | Zone     | Status   | State | Updated_at                 | Disabled Reason |
      +------------------+----------+----------+---------+-------+----------------------------+------------------+
      | nova-conductor   | devstack | internal | enabled  | up    | 2013-10-16T00:56:48.000000 | None            |
      | nova-cert        | devstack | internal | enabled  | up    | 2013-10-16T00:56:49.000000 | None            |
      | nova-compute     | devstack | nova     | disabled | up    | 2013-10-16T00:56:47.000000 | Trial log       |
      | nova-network     | devstack | internal | enabled  | up    | 2013-10-16T00:56:51.000000 | None            |
      | nova-scheduler   | devstack | internal | enabled  | up    | 2013-10-16T00:56:44.000000 | None            |
      | nova-consoleauth | devstack | internal | enabled  | up    | 2013-10-16T00:56:47.000000 | None            |
      +------------------+----------+----------+---------+-------+----------------------------+------------------+

#. Enable the service:

   .. code-block:: console

      $ nova service-enable localhost.localdomain nova-compute
      +----------+--------------+---------+
      | Host     | Binary       | Status  |
      +----------+--------------+---------+
      | devstack | nova-compute | enabled |
      +----------+--------------+---------+

#. Check the service list:

   .. code-block:: console

      $ nova service-list
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+
      | Binary           | Host     | Zone     | Status  | State | Updated_at                 | Disabled Reason |
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+
      | nova-conductor   | devstack | internal | enabled | up    | 2013-10-16T00:57:08.000000 | None            |
      | nova-cert        | devstack | internal | enabled | up    | 2013-10-16T00:57:09.000000 | None            |
      | nova-compute     | devstack | nova     | enabled | up    | 2013-10-16T00:57:07.000000 | None            |
      | nova-network     | devstack | internal | enabled | up    | 2013-10-16T00:57:11.000000 | None            |
      | nova-scheduler   | devstack | internal | enabled | up    | 2013-10-16T00:57:14.000000 | None            |
      | nova-consoleauth | devstack | internal | enabled | up    | 2013-10-16T00:57:07.000000 | None            |
      +------------------+----------+----------+---------+-------+----------------------------+-----------------+
