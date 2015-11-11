Networking Option 2: Self-service networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. todo:

   Cannot use bulleted list here due to the following bug:

   https://bugs.launchpad.net/openstack-manuals/+bug/1515377

List agents to verify successful launch of the neutron agents:

.. code-block:: console

   $ neutron agent-list
   +--------------------------------------+--------------------+------------+-------+----------------+---------------------------+
   | id                                   | agent_type         | host       | alive | admin_state_up | binary                    |
   +--------------------------------------+--------------------+------------+-------+----------------+---------------------------+
   | 08905043-5010-4b87-bba5-aedb1956e27a | Linux bridge agent | compute1   | :-)   | True           | neutron-linuxbridge-agent |
   | 27eee952-a748-467b-bf71-941e89846a92 | Linux bridge agent | controller | :-)   | True           | neutron-linuxbridge-agent |
   | 830344ff-dc36-4956-84f4-067af667a0dc | L3 agent           | controller | :-)   | True           | neutron-l3-agent          |
   | dd3644c9-1a3a-435a-9282-eb306b4b0391 | DHCP agent         | controller | :-)   | True           | neutron-dhcp-agent        |
   | f49a4b81-afd6-4b3d-b923-66c8f0517099 | Metadata agent     | controller | :-)   | True           | neutron-metadata-agent    |
   +--------------------------------------+--------------------+------------+-------+----------------+---------------------------+

The output should indicate four agents on the controller node and one
agent on each compute node.
