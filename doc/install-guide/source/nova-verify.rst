Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Compute service.

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. List service components to verify successful launch and
   registration of each process:

   .. code-block:: console

      $ openstack compute service list
      +----+--------------------+------------+----------+---------+-------+----------------------------+
      | Id | Binary             | Host       | Zone     | Status  | State | Updated At                 |
      +----+--------------------+------------+----------+---------+-------+----------------------------+
      |  1 | nova-consoleauth   | controller | internal | enabled | up    | 2016-02-09T23:11:15.000000 |
      |  2 | nova-scheduler     | controller | internal | enabled | up    | 2016-02-09T23:11:15.000000 |
      |  3 | nova-conductor     | controller | internal | enabled | up    | 2016-02-09T23:11:16.000000 |
      |  4 | nova-compute       | compute1   | nova     | enabled | up    | 2016-02-09T23:11:20.000000 |
      +----+--------------------+------------+----------+---------+-------+----------------------------+

   .. note::

      This output should indicate three service components enabled on
      the controller node and one service component enabled on the
      compute node.
