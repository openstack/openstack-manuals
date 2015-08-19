Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Compute service.


.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. List service components to verify successful launch and
   registration of each process:

   .. code-block:: console

      $ nova service-list
      +----+------------------+------------+----------+---------+-------+--------------+-----------------+
      | Id | Binary           | Host       | Zone     | Status  | State | Updated_at   | Disabled Reason |
      +----+------------------+------------+----------+---------+-------+--------------+-----------------+
      | 1  | nova-conductor   | controller | internal | enabled | up    | 2014-09-16.. | -               |
      | 2  | nova-consoleauth | controller | internal | enabled | up    | 2014-09-16.. | -               |
      | 3  | nova-scheduler   | controller | internal | enabled | up    | 2014-09-16.. | -               |
      | 4  | nova-cert        | controller | internal | enabled | up    | 2014-09-16.. | -               |
      | 5  | nova-compute     | compute1   | nova     | enabled | up    | 2014-09-16.. | -               |
      +----+------------------+------------+----------+---------+-------+--------------+-----------------+

   .. note::

      This output should indicate four service components enabled on
      the controller node and one service component enabled on the
      compute node.

#. List API endpoints in the Identity service to verify connectivity
   with the Identity service:

   .. code-block:: console

      $ nova endpoints
      +-----------+------------------------------------------------------------+
      | nova      | Value                                                      |
      +-----------+------------------------------------------------------------+
      | id        | 1fb997666b79463fb68db4ccfe4e6a71                           |
      | interface | public                                                     |
      | region    | RegionOne                                                  |
      | region_id | RegionOne                                                  |
      | url       | http://controller:8774/v2/ae7a98326b9c455588edd2656d723b9d |
      +-----------+------------------------------------------------------------+
      +-----------+------------------------------------------------------------+
      | nova      | Value                                                      |
      +-----------+------------------------------------------------------------+
      | id        | bac365db1ff34f08a31d4ae98b056924                           |
      | interface | admin                                                      |
      | region    | RegionOne                                                  |
      | region_id | RegionOne                                                  |
      | url       | http://controller:8774/v2/ae7a98326b9c455588edd2656d723b9d |
      +-----------+------------------------------------------------------------+
      +-----------+------------------------------------------------------------+
      | nova      | Value                                                      |
      +-----------+------------------------------------------------------------+
      | id        | e37186d38b8e4b81a54de34e73b43f34                           |
      | interface | internal                                                   |
      | region    | RegionOne                                                  |
      | region_id | RegionOne                                                  |
      | url       | http://controller:8774/v2/ae7a98326b9c455588edd2656d723b9d |
      +-----------+------------------------------------------------------------+

      +-----------+----------------------------------+
      | glance    | Value                            |
      +-----------+----------------------------------+
      | id        | 41ad39f6c6444b7d8fd8318c18ae0043 |
      | interface | admin                            |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:9292           |
      +-----------+----------------------------------+
      +-----------+----------------------------------+
      | glance    | Value                            |
      +-----------+----------------------------------+
      | id        | 50ecc4ce62724e319f4fae3861e50f7d |
      | interface | internal                         |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:9292           |
      +-----------+----------------------------------+
      +-----------+----------------------------------+
      | glance    | Value                            |
      +-----------+----------------------------------+
      | id        | 7d3df077a20b4461a372269f603b7516 |
      | interface | public                           |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:9292           |
      +-----------+----------------------------------+

      +-----------+----------------------------------+
      | keystone  | Value                            |
      +-----------+----------------------------------+
      | id        | 88150c2fdc9d406c9b25113701248192 |
      | interface | internal                         |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:5000/v2.0      |
      +-----------+----------------------------------+
      +-----------+----------------------------------+
      | keystone  | Value                            |
      +-----------+----------------------------------+
      | id        | cecab58c0f024d95b36a4ffa3e8d81e1 |
      | interface | public                           |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:5000/v2.0      |
      +-----------+----------------------------------+
      +-----------+----------------------------------+
      | keystone  | Value                            |
      +-----------+----------------------------------+
      | id        | fc90391ae7cd4216aca070042654e424 |
      | interface | admin                            |
      | region    | RegionOne                        |
      | region_id | RegionOne                        |
      | url       | http://controller:35357/v2.0     |
      +-----------+----------------------------------+

#. List images in the Image service catalog to verify connectivity
   with the Image service:

   .. code-block:: console

      $ nova image-list
      +--------------------------------------+---------------------+--------+--------+
      | ID                                   | Name                | Status | Server |
      +--------------------------------------+---------------------+--------+--------+
      | 38047887-61a7-41ea-9b49-27987d5e8bb9 | cirros-0.3.4-x86_64 | ACTIVE |        |
      +--------------------------------------+---------------------+--------+--------+
