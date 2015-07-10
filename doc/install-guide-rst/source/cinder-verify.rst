================
Verify operation
================

This section describes how to verify operation of the Block Storage
service by creating a volume.

For more information about how to manage volumes, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/index.html>`__.

.. note::

   Perform these commands on the controller node.

#. In each client environment script, configure the Block Storage
   client to use API version 2.0:

   .. code-block:: console

      $ echo "export OS_VOLUME_API_VERSION=2" | tee -a admin-openrc.sh demo-openrc.sh

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. List service components to verify successful launch of each process:

   .. code-block:: console

      $ cinder service-list
      +------------------+------------+------+---------+-------+----------------------------+-----------------+
      |      Binary      |    Host    | Zone |  Status | State |         Updated_at         | Disabled Reason |
      +------------------+------------+------+---------+-------+----------------------------+-----------------+
      | cinder-scheduler | controller | nova | enabled |   up  | 2014-10-18T01:30:54.000000 |       None      |
      | cinder-volume    | block1@lvm | nova | enabled |   up  | 2014-10-18T01:30:57.000000 |       None      |
      +------------------+------------+------+---------+-------+----------------------------+-----------------+

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ source demo-openrc.sh

#. Create a 1 GB volume:

   .. code-block:: console

      $ cinder create --name demo-volume1 1
      +---------------------------------------+--------------------------------------+
      |                Property               |                Value                 |
      +---------------------------------------+--------------------------------------+
      |              attachments              |                  []                  |
      |           availability_zone           |                 nova                 |
      |                bootable               |                false                 |
      |          consistencygroup_id          |                 None                 |
      |               created_at              |      2015-04-21T23:46:08.000000      |
      |              description              |                 None                 |
      |               encrypted               |                False                 |
      |                   id                  | 6c7a3d28-e1ef-42a0-b1f7-8d6ce9218412 |
      |                metadata               |                  {}                  |
      |              multiattach              |                False                 |
      |                  name                 |             demo-volume1             |
      |      os-vol-tenant-attr:tenant_id     |   ab8ea576c0574b6092bb99150449b2d3   |
      |   os-volume-replication:driver_data   |                 None                 |
      | os-volume-replication:extended_status |                 None                 |
      |           replication_status          |               disabled               |
      |                  size                 |                  1                   |
      |              snapshot_id              |                 None                 |
      |              source_volid             |                 None                 |
      |                 status                |               creating               |
      |                user_id                |   3a81e6c8103b46709ef8d141308d4c72   |
      |              volume_type              |                 None                 |
      +---------------------------------------+--------------------------------------+

#. Verify creation and availability of the volume:

   .. code-block:: console

      $ cinder list
      +--------------+-----------+--------------+------+-------------+----------+-------------+
      |      ID      |   Status  |     Name     | Size | Volume Type | Bootable | Attached to |
      +--------------+-----------+--------------+------+-------------+----------+-------------+
      | 6c7a3d28-... | available | demo-volume1 |  1   |     None    |  false   |             |
      +--------------+-----------+--------------+------+-------------+----------+-------------+

   If the status does not indicate ``available``,
   check the logs in the :file:`/var/log/cinder` directory
   on the controller and volume nodes for more information.

   .. note::

      The launch an instance chapter includes instructions for
      attaching this volume to an instance.

.. TODO(katomo): add link to launch an instance after creation.
