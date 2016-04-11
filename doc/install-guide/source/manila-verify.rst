.. _manila-verify:

Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Shared File Systems service.

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. List service components to verify successful launch of each process:

   For deployments using option 1:

   .. code-block:: console

      $ manila service-list
      +----+------------------+-------------+------+---------+-------+----------------------------+
      | Id | Binary           | Host        | Zone | Status  | State | Updated_at                 |
      +----+------------------+-------------+------+---------+-------+----------------------------+
      | 1  | manila-scheduler | controller  | nova | enabled | up    | 2016-03-30T20:17:28.000000 |
      | 2  | manila-share     | storage@lvm | nova | enabled | up    | 2016-03-30T20:17:29.000000 |
      +----+------------------+-------------+------+---------+-------+----------------------------+

   For deployments using option 2:

   .. code-block:: console

      $ manila service-list
      +----+------------------+-----------------+------+---------+-------+----------------------------+
      | Id | Binary           | Host            | Zone | Status  | State | Updated_at                 |
      +----+------------------+-----------------+------+---------+-------+----------------------------+
      | 1  | manila-scheduler | controller      | nova | enabled | up    | 2016-03-30T20:17:28.000000 |
      | 2  | manila-share     | storage@generic | nova | enabled | up    | 2016-03-30T20:17:29.000000 |
      +----+------------------+-----------------+------+---------+-------+----------------------------+
