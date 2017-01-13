=======================================
Search for an instance using IP address
=======================================

You can search for an instance using the IP address parameter, ``--ip``,
with the :command:`openstack server list` command.

.. code-block:: console

   $ openstack server list --ip IP_ADDRESS

The following example shows the results of a search on ``10.0.0.4``.

.. code-block:: console

   $ openstack server list --ip 10.0.0.4
   +------------------+----------------------+--------+------------+-------------+------------------+------------+
   | ID               | Name                 | Status | Task State | Power State | Networks         | Image Name |
   +------------------+----------------------+--------+------------+-------------+------------------+------------+
   | 8a99547e-7385... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 | cirros     |
   +------------------+----------------------+--------+------------+-------------+------------------+------------+
