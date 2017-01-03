.. _migration-to-vrrp:

==============================
Add VRRP to an existing router
==============================

This section describes the process of migrating from a classic router to an L3
HA router, which is available starting from the Mitaka release.

Similar to the classic scenario, all network traffic on a project network that
requires routing actively traverses only one network node regardless of the
quantity of network nodes providing HA for the router. Therefore, this
high-availability implementation primarily addresses failure situations instead
of bandwidth constraints that limit performance. However, it supports random
distribution of routers on different network nodes to reduce the chances of
bandwidth constraints and to improve scaling.

This section references parts of :ref:`deploy-lb-ha-vrrp` and
:ref:`deploy-ovs-ha-vrrp`. For details regarding needed infrastructure and
configuration to allow actual L3 HA deployment, read the relevant guide
before continuing with the migration process.

Migration
~~~~~~~~~

The migration process is quite simple, it involves turning down the router by
setting the router's ``admin_state_up`` attribute to ``False``, upgrading the
router to L3 HA and then setting the router's ``admin_state_up`` attribute back
to ``True``.

.. warning::

   Once starting the migration, south-north connections (instances to internet)
   will be severed. New connections will be able to start only when the
   migration is complete.

Here is the router we have used in our demonstration:

.. code-block:: console

   $ openstack router show router1
   +-------------------------+-------------------------------------------+
   | Field                   | Value                                     |
   +-------------------------+-------------------------------------------+
   | admin_state_up          | UP                                        |
   | availability_zone_hints |                                           |
   | availability_zones      | nova                                      |
   | created_at              | 2017-01-02T23:01:47Z                      |
   | description             |                                           |
   | distributed             | False                                     |
   | external_gateway_info   | {"network_id": "c21c0f6a-0341-42ed-b5ff-  |
   |                         | 9f1ff1d8ef56", "enable_snat": true,       |
   |                         | "external_fixed_ips": [{"subnet_id":      |
   |                         | "9a698e72-7707-43fe-ac09-5e05659a1aa5",   |
   |                         | "ip_address": "172.24.4.5"},              |
   |                         | {"subnet_id": "e8223e93-d5f6-48eb-afca-   |
   |                         | 5cc095c1e340", "ip_address":              |
   |                         | "2001:db8::b"}]}                          |
   | flavor_id               | None                                      |
   | ha                      | False                                     |
   | id                      | 6b793b46-d082-4fd5-980f-a6f80cbb0f2a      |
   | name                    | router1                                   |
   | project_id              | bb8b84ab75be4e19bd0dfe02f6c3f5c1          |
   | revision_number         | 7                                         |
   | routes                  |                                           |
   | status                  | ACTIVE                                    |
   | updated_at              | 2017-01-02T23:02:03Z                      |
   +-------------------------+-------------------------------------------+

#. Source the administrative project credentials.
#. Set the admin_state_up to ``False``. This will severe south-north
   connections until admin_state_up is set to ``True`` again.

   .. code-block:: console

      $ openstack router set router1 --disable

#. Set the ``ha`` attribute of the router to ``True``.

   .. code-block:: console

      $ openstack router set router1 --ha

#. Set the admin_state_up to ``True``.
   After this, south-north connections can start.

   .. code-block:: console

      $ openstack router set router1 --enable

#. Make sure that the router's ``ha`` attribute has changed to ``True``.

   .. code-block:: console

      $ openstack router show router1
      +-------------------------+-------------------------------------------+
      | Field                   | Value                                     |
      +-------------------------+-------------------------------------------+
      | admin_state_up          | UP                                        |
      | availability_zone_hints |                                           |
      | availability_zones      | nova                                      |
      | created_at              | 2017-01-02T23:01:47Z                      |
      | description             |                                           |
      | distributed             | False                                     |
      | external_gateway_info   | {"network_id": "c21c0f6a-0341-42ed-b5ff-  |
      |                         | 9f1ff1d8ef56", "enable_snat": true,       |
      |                         | "external_fixed_ips": [{"subnet_id":      |
      |                         | "9a698e72-7707-43fe-ac09-5e05659a1aa5",   |
      |                         | "ip_address": "172.24.4.5"},              |
      |                         | {"subnet_id": "e8223e93-d5f6-48eb-afca-   |
      |                         | 5cc095c1e340", "ip_address":              |
      |                         | "2001:db8::b"}]}                          |
      | flavor_id               | None                                      |
      | ha                      | True                                      |
      | id                      | 6b793b46-d082-4fd5-980f-a6f80cbb0f2a      |
      | name                    | router1                                   |
      | project_id              | bb8b84ab75be4e19bd0dfe02f6c3f5c1          |
      | revision_number         | 7                                         |
      | routes                  |                                           |
      | status                  | ACTIVE                                    |
      | updated_at              | 2017-01-02T23:02:03Z                      |
      +-------------------------+-------------------------------------------+


L3 HA to Legacy
~~~~~~~~~~~~~~~

To return to classic mode, turn down the router again, turning off L3 HA
and starting the router again.

.. warning::

   Once starting the migration, south-north connections (instances to internet)
   will be severed. New connections will be able to start only when the
   migration is complete.

Here is the router we have used in our demonstration:

.. code-block:: console

   $ openstack router show router1
   +-------------------------+-------------------------------------------+
   | Field                   | Value                                     |
   +-------------------------+-------------------------------------------+
   | admin_state_up          | DOWN                                      |
   | availability_zone_hints |                                           |
   | availability_zones      | nova                                      |
   | created_at              | 2017-01-02T23:01:47Z                      |
   | description             |                                           |
   | distributed             | False                                     |
   | external_gateway_info   | {"network_id": "c21c0f6a-0341-42ed-b5ff-  |
   |                         | 9f1ff1d8ef56", "enable_snat": true,       |
   |                         | "external_fixed_ips": [{"subnet_id":      |
   |                         | "9a698e72-7707-43fe-ac09-5e05659a1aa5",   |
   |                         | "ip_address": "172.24.4.5"},              |
   |                         | {"subnet_id": "e8223e93-d5f6-48eb-afca-   |
   |                         | 5cc095c1e340", "ip_address":              |
   |                         | "2001:db8::b"}]}                          |
   | flavor_id               | None                                      |
   | ha                      | True                                      |
   | id                      | 6b793b46-d082-4fd5-980f-a6f80cbb0f2a      |
   | name                    | router1                                   |
   | project_id              | bb8b84ab75be4e19bd0dfe02f6c3f5c1          |
   | revision_number         | 7                                         |
   | routes                  |                                           |
   | status                  | ACTIVE                                    |
   | updated_at              | 2017-01-02T23:02:03Z                      |
   +-------------------------+-------------------------------------------+

#. Source the administrative project credentials.
#. Set the admin_state_up to ``False``. This will severe south-north
   connections until admin_state_up is set to ``True`` again.

   .. code-block:: console

      $ openstack router set router1 --disable

#. Set the ``ha`` attribute of the router to ``True``.

   .. code-block:: console

      $ openstack router set router1 --no-ha

#. Set the admin_state_up to ``True``.
   After this, south-north connections can start.

   .. code-block:: console

      $ openstack router set router1 --enable

#. Make sure that the router's ``ha`` attribute has changed to ``False``.

   .. code-block:: console

      $ openstack router show router1
      +-------------------------+-------------------------------------------+
      | Field                   | Value                                     |
      +-------------------------+-------------------------------------------+
      | admin_state_up          | UP                                        |
      | availability_zone_hints |                                           |
      | availability_zones      | nova                                      |
      | created_at              | 2017-01-02T23:01:47Z                      |
      | description             |                                           |
      | distributed             | False                                     |
      | external_gateway_info   | {"network_id": "c21c0f6a-0341-42ed-b5ff-  |
      |                         | 9f1ff1d8ef56", "enable_snat": true,       |
      |                         | "external_fixed_ips": [{"subnet_id":      |
      |                         | "9a698e72-7707-43fe-ac09-5e05659a1aa5",   |
      |                         | "ip_address": "172.24.4.5"},              |
      |                         | {"subnet_id": "e8223e93-d5f6-48eb-afca-   |
      |                         | 5cc095c1e340", "ip_address":              |
      |                         | "2001:db8::b"}]}                          |
      | flavor_id               | None                                      |
      | ha                      | False                                     |
      | id                      | 6b793b46-d082-4fd5-980f-a6f80cbb0f2a      |
      | name                    | router1                                   |
      | project_id              | bb8b84ab75be4e19bd0dfe02f6c3f5c1          |
      | revision_number         | 7                                         |
      | routes                  |                                           |
      | status                  | ACTIVE                                    |
      | updated_at              | 2017-01-02T23:02:03Z                      |
      +-------------------------+-------------------------------------------+
