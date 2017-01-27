.. _shared_file_systems_crud_share:

======================
Share basic operations
======================

General concepts
----------------

To create a file share, and access it, the following general concepts
are prerequisite knowledge:

#. To create a share, use :command:`manila create` command and
   specify the required arguments: the size of the share and the shared file
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, ``HDFS``, or
   ``CephFS`` share file system protocols are supported.

#. You can also optionally specify the share network and the share type.

#. After the share becomes available, use the :command:`manila show` command
   to get the share export locations.

#. After getting the share export locations, you can create an
   :ref:`access rule <access_to_share>` for the share, mount it and work with
   files on the remote file system.

There are big number of the share drivers created by different vendors in the
Shared File Systems service. As a Python class, each share driver can be set
for the :ref:`back end <shared_file_systems_multi_backend>` and run in the back
end to manage the share operations.

Initially there are two driver modes for the back ends:

* no share servers mode
* share servers mode

Each share driver supports one or two of possible back end modes that can be
configured in the ``manila.conf`` file. The configuration option
``driver_handles_share_servers`` in the ``manila.conf`` file sets the share
servers mode or no share servers mode, and defines the driver mode for share
storage lifecycle management:

+------------------+-------------------------------------+--------------------+
| Mode             | Config option                       |  Description       |
+==================+=====================================+====================+
| no share servers | driver_handles_share_servers = False| An administrator   |
|                  |                                     | rather than a share|
|                  |                                     | driver manages the |
|                  |                                     | bare metal storage |
|                  |                                     | with some net      |
|                  |                                     | interface instead  |
|                  |                                     | of the presence of |
|                  |                                     | the share servers. |
+------------------+-------------------------------------+--------------------+
| share servers    | driver_handles_share_servers = True | The share driver   |
|                  |                                     | creates the share  |
|                  |                                     | server and manages,|
|                  |                                     | or handles, the    |
|                  |                                     | share server life  |
|                  |                                     | cycle.             |
+------------------+-------------------------------------+--------------------+

It is :ref:`the share types <shared_file_systems_share_types>` which have the
extra specifications that help scheduler to filter back ends and choose the
appropriate back end for the user that requested to create a share. The
required extra boolean specification for each share type is
``driver_handles_share_servers``. As an administrator, you can create the share
types with the specifications you need. For details of managing the share types
and configuration the back ends, see :ref:`shared_file_systems_share_types` and
:ref:`shared_file_systems_multi_backend` documentation.

You can create a share in two described above modes:

* in a no share servers mode without specifying the share network and
  specifying the share type with ``driver_handles_share_servers = False``
  parameter. See subsection :ref:`create_share_in_no_share_server_mode`.

* in a share servers mode with specifying the share network and the share
  type with ``driver_handles_share_servers = True`` parameter. See subsection
  :ref:`create_share_in_share_server_mode`.

.. _create_share_in_no_share_server_mode:

Create a share in no share servers mode
---------------------------------------

To create a file share in no share servers mode, you need to:

#. To create a share, use :command:`manila create` command and
   specify the required arguments: the size of the share and the shared file
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, ``HDFS``, or
   ``CephFS`` share file system protocols are supported.

#. You should specify the :ref:`share type <shared_file_systems_share_types>`
   with ``driver_handles_share_servers = False`` extra specification.

#. You must not specify the ``share network`` because no share servers are
   created. In this mode the Shared File Systems service expects that
   administrator has some bare metal storage with some net interface.

#. The :command:`manila create` command creates a share. This command does the
   following things:

   * The :ref:`manila-scheduler <shared_file_systems_scheduling>` service will
     find the back end with ``driver_handles_share_servers = False`` mode due
     to filtering the extra specifications of the share type.

   * The share is created using the storage that is specified in the found
     back end.

#. After the share becomes available, use the :command:`manila show` command
   to get the share export locations.

In the example to create a share, the created already share type named
``my_type`` with ``driver_handles_share_servers = False`` extra specification
is used.

Check share types that exist, run:

.. code-block:: console

   $ manila type-list
   +------+---------+------------+------------+--------------------------------------+-------------------------+
   | ID   | Name    | visibility | is_default | required_extra_specs                 | optional_extra_specs    |
   +------+---------+------------+------------+--------------------------------------+-------------------------+
   | %ID% | my_type | public     | -          | driver_handles_share_servers : False | snapshot_support : True |
   +------+---------+------------+------------+--------------------------------------+-------------------------+

Create a private share with ``my_type`` share type, NFS shared file system
protocol, and size 1 GB:

.. code-block:: console

   $ manila create nfs 1 --name Share1 --description "My share" --share-type my_type
   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | creating                             |
   | share_type_name             | my_type                              |
   | description                 | My share                             |
   | availability_zone           | None                                 |
   | share_network_id            | None                                 |
   | share_server_id             | None                                 |
   | host                        |                                      |
   | access_rules_status         | active                               |
   | snapshot_id                 | None                                 |
   | is_public                   | False                                |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 |
   | size                        | 1                                    |
   | name                        | Share1                               |
   | share_type                  | 14ee8575-aac2-44af-8392-d9c9d344f392 |
   | has_replicas                | False                                |
   | replication_type            | None                                 |
   | created_at                  | 2016-03-25T12:02:46.000000           |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | None                                 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 907004508ef4447397ce6741a8f037c1     |
   | metadata                    | {}                                   |
   +-----------------------------+--------------------------------------+

New share ``Share2`` should have a status ``available``:

.. code-block:: console

   $ manila show Share2
   +-----------------------------+----------------------------------------------------------+
   | Property                    | Value                                                    |
   +-----------------------------+----------------------------------------------------------+
   | status                      | available                                                |
   | share_type_name             | my_type                                                  |
   | description                 | My share                                                 |
   | availability_zone           | nova                                                     |
   | share_network_id            | None                                                     |
   | export_locations            |                                                          |
   |                             | path = 10.0.0.4:/shares/manila_share_a5fb1ab7_...        |
   |                             | preferred = False                                        |
   |                             | is_admin_only = False                                    |
   |                             | id = 9e078eee-bcad-40b8-b4fe-1c916cf98ed1                |
   |                             | share_instance_id = a5fb1ab7-0bbd-465b-ac14-05706294b6e9 |
   |                             | path = 172.18.198.52:/shares/manila_share_a5fb1ab7_...   |
   |                             | preferred = False                                        |
   |                             | is_admin_only = True                                     |
   |                             | id = 44933f59-e0e3-4483-bb88-72ba7c486f41                |
   |                             | share_instance_id = a5fb1ab7-0bbd-465b-ac14-05706294b6e9 |
   | share_server_id             | None                                                     |
   | host                        | manila@paris#epsilon                                     |
   | access_rules_status         | active                                                   |
   | snapshot_id                 | None                                                     |
   | is_public                   | False                                                    |
   | task_state                  | None                                                     |
   | snapshot_support            | True                                                     |
   | id                          | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88                     |
   | size                        | 1                                                        |
   | name                        | Share1                                                   |
   | share_type                  | 14ee8575-aac2-44af-8392-d9c9d344f392                     |
   | has_replicas                | False                                                    |
   | replication_type            | None                                                     |
   | created_at                  | 2016-03-25T12:02:46.000000                               |
   | share_proto                 | NFS                                                      |
   | consistency_group_id        | None                                                     |
   | source_cgsnapshot_member_id | None                                                     |
   | project_id                  | 907004508ef4447397ce6741a8f037c1                         |
   | metadata                    | {}                                                       |
   +-----------------------------+----------------------------------------------------------+

.. _create_share_in_share_server_mode:

Create a share in share servers mode
------------------------------------

To create a file share in share servers mode, you need to:

#. To create a share, use :command:`manila create` command and
   specify the required arguments: the size of the share and the shared file
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, ``HDFS``, or
   ``CephFS`` share file system protocols are supported.

#. You should specify the :ref:`share type <shared_file_systems_share_types>`
   with ``driver_handles_share_servers = True`` extra specification.

#. You should specify the
   :ref:`share network <shared_file_systems_share_networks>`.

#. The :command:`manila create` command creates a share. This command does the
   following things:

   * The :ref:`manila-scheduler <shared_file_systems_scheduling>` service will
     find the back end with ``driver_handles_share_servers = True`` mode due to
     filtering the extra specifications of the share type.

   * The share driver will create a share server with the share network. For
     details of creating the resources, see the `documentation <http://docs.
     openstack.org/developer/manila/devref/index.html#share-backends>`_ of the
     specific share driver.

#. After the share becomes available, use the :command:`manila show` command
   to get the share export location.

In the example to create a share, the default share type and the already
existing share network are used.

.. note::

   There is no default share type just after you started manila as the
   administrator. See :ref:`shared_file_systems_share_types` to
   create the default share type. To create a share network, use
   :ref:`shared_file_systems_share_networks`.

Check share types that exist, run:

.. code-block:: console

   $ manila type-list
   +------+---------+------------+------------+--------------------------------------+-------------------------+
   | ID   | Name    | visibility | is_default | required_extra_specs                 | optional_extra_specs    |
   +------+---------+------------+------------+--------------------------------------+-------------------------+
   | %id% | default | public     | YES        | driver_handles_share_servers : True  | snapshot_support : True |
   +------+---------+------------+------------+--------------------------------------+-------------------------+

Check share networks that exist, run:

.. code-block:: console

   $ manila share-network-list
   +--------------------------------------+--------------+
   | id                                   | name         |
   +--------------------------------------+--------------+
   | c895fe26-92be-4152-9e6c-f2ad230efb13 | my_share_net |
   +--------------------------------------+--------------+

Create a public share with ``my_share_net`` network, ``default``
share type, NFS shared file system protocol, and size 1 GB:

.. code-block:: console

   $ manila create nfs 1 \
       --name "Share2" \
       --description "My second share" \
       --share-type default \
       --share-network my_share_net \
       --metadata aim=testing \
       --public
   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | creating                             |
   | share_type_name             | default                              |
   | description                 | My second share                      |
   | availability_zone           | None                                 |
   | share_network_id            | c895fe26-92be-4152-9e6c-f2ad230efb13 |
   | share_server_id             | None                                 |
   | host                        |                                      |
   | access_rules_status         | active                               |
   | snapshot_id                 | None                                 |
   | is_public                   | True                                 |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | 195e3ba2-9342-446a-bc93-a584551de0ac |
   | size                        | 1                                    |
   | name                        | Share2                               |
   | share_type                  | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf |
   | has_replicas                | False                                |
   | replication_type            | None                                 |
   | created_at                  | 2016-03-25T12:13:40.000000           |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | None                                 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 907004508ef4447397ce6741a8f037c1     |
   | metadata                    | {u'aim': u'testing'}                 |
   +-----------------------------+--------------------------------------+

The share also can be created from a share snapshot. For details, see
:ref:`shared_file_systems_snapshots`.

See the share in a share list:

.. code-block:: console

   $ manila list
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | ID                                   | Name    | Size | Share Proto | Status    | Is Public | Share Type Name | Host                 | Availability Zone |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 | Share1  | 1    | NFS         | available | False     | my_type         | manila@paris#epsilon | nova              |
   | 195e3ba2-9342-446a-bc93-a584551de0ac | Share2  | 1    | NFS         | available | True      | default         | manila@london#LONDON | nova              |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+

Check the share status and see the share export locations. After ``creating``
status share should have status ``available``:

.. code-block:: console

   $ manila show Share2
   +----------------------+----------------------------------------------------------------------+
   | Property             | Value                                                                |
   +----------------------+----------------------------------------------------------------------+
   | status               | available                                                            |
   | share_type_name      | default                                                              |
   | description          | My second share                                                      |
   | availability_zone    | nova                                                                 |
   | share_network_id     | c895fe26-92be-4152-9e6c-f2ad230efb13                                 |
   | export_locations     |                                                                      |
   |                      | path = 10.254.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965 |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = False                                                |
   |                      | id = de6d4012-6158-46f0-8b28-4167baca51a7                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   |                      | path = 10.0.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965   |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = True                                                 |
   |                      | id = 602d0f5c-921b-4e45-bfdb-5eec8a89165a                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   | share_server_id      | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                                 |
   | host                 | manila@london#LONDON                                                 |
   | access_rules_status  | active                                                               |
   | snapshot_id          | None                                                                 |
   | is_public            | True                                                                 |
   | task_state           | None                                                                 |
   | snapshot_support     | True                                                                 |
   | id                   | 195e3ba2-9342-446a-bc93-a584551de0ac                                 |
   | size                 | 1                                                                    |
   | name                 | Share2                                                               |
   | share_type           | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                                 |
   | has_replicas         | False                                                                |
   | replication_type     | None                                                                 |
   | created_at           | 2016-03-25T12:13:40.000000                                           |
   | share_proto          | NFS                                                                  |
   | consistency_group_id | None                                                                 |
   | project_id           | 907004508ef4447397ce6741a8f037c1                                     |
   | metadata             | {u'aim': u'testing'}                                                 |
   +----------------------+----------------------------------------------------------------------+

``is_public`` defines the level of visibility for the share: whether other
projects can or cannot see the share. By default, the share is private.

Update share
------------

Update the name, or description, or level of visibility for all projects for
the share if you need:

.. code-block:: console

   $ manila update Share2 --description "My second share. Updated" --is-public False

   $ manila show Share2
   +----------------------+----------------------------------------------------------------------+
   | Property             | Value                                                                |
   +----------------------+----------------------------------------------------------------------+
   | status               | available                                                            |
   | share_type_name      | default                                                              |
   | description          | My second share. Updated                                             |
   | availability_zone    | nova                                                                 |
   | share_network_id     | c895fe26-92be-4152-9e6c-f2ad230efb13                                 |
   | export_locations     |                                                                      |
   |                      | path = 10.254.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965 |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = False                                                |
   |                      | id = de6d4012-6158-46f0-8b28-4167baca51a7                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   |                      | path = 10.0.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965   |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = True                                                 |
   |                      | id = 602d0f5c-921b-4e45-bfdb-5eec8a89165a                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   | share_server_id      | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                                 |
   | host                 | manila@london#LONDON                                                 |
   | access_rules_status  | active                                                               |
   | snapshot_id          | None                                                                 |
   | is_public            | False                                                                |
   | task_state           | None                                                                 |
   | snapshot_support     | True                                                                 |
   | id                   | 195e3ba2-9342-446a-bc93-a584551de0ac                                 |
   | size                 | 1                                                                    |
   | name                 | Share2                                                               |
   | share_type           | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                                 |
   | has_replicas         | False                                                                |
   | replication_type     | None                                                                 |
   | created_at           | 2016-03-25T12:13:40.000000                                           |
   | share_proto          | NFS                                                                  |
   | consistency_group_id | None                                                                 |
   | project_id           | 907004508ef4447397ce6741a8f037c1                                     |
   | metadata             | {u'aim': u'testing'}                                                 |
   +----------------------+----------------------------------------------------------------------+

A share can have one of these status values:

+-----------------------------------+-----------------------------------------+
| Status                            | Description                             |
+===================================+=========================================+
| creating                          | The share is being created.             |
+-----------------------------------+-----------------------------------------+
| deleting                          | The share is being deleted.             |
+-----------------------------------+-----------------------------------------+
| error                             | An error occurred during share creation.|
+-----------------------------------+-----------------------------------------+
| error_deleting                    | An error occurred during share deletion.|
+-----------------------------------+-----------------------------------------+
| available                         | The share is ready to use.              |
+-----------------------------------+-----------------------------------------+
| manage_starting                   | Share manage started.                   |
+-----------------------------------+-----------------------------------------+
| manage_error                      | Share manage failed.                    |
+-----------------------------------+-----------------------------------------+
| unmanage_starting                 | Share unmanage started.                 |
+-----------------------------------+-----------------------------------------+
| unmanage_error                    | Share cannot be unmanaged.              |
+-----------------------------------+-----------------------------------------+
| unmanaged                         | Share was unmanaged.                    |
+-----------------------------------+-----------------------------------------+
| extending                         | The extend, or increase, share size     |
|                                   | request was issued successfully.        |
+-----------------------------------+-----------------------------------------+
| extending_error                   | Extend share failed.                    |
+-----------------------------------+-----------------------------------------+
| shrinking                         | Share is being shrunk.                  |
+-----------------------------------+-----------------------------------------+
| shrinking_error                   | Failed to update quota on share         |
|                                   | shrinking.                              |
+-----------------------------------+-----------------------------------------+
| shrinking_possible_data_loss_error| Shrink share failed due to possible data|
|                                   | loss.                                   |
+-----------------------------------+-----------------------------------------+
| migrating                         | Share migration is in progress.         |
+-----------------------------------+-----------------------------------------+

.. _share_metadata:

Share metadata
--------------

If you want to set the metadata key-value pairs on the share, run:

.. code-block:: console

   $ manila metadata Share2 set project=my_abc deadline=01/20/16

Get all metadata key-value pairs of the share:

.. code-block:: console

   $ manila metadata-show Share2
   +----------+----------+
   | Property | Value    |
   +----------+----------+
   | aim      | testing  |
   | project  | my_abc   |
   | deadline | 01/20/16 |
   +----------+----------+

You can update the metadata:

.. code-block:: console

   $ manila metadata-update-all Share2 deadline=01/30/16
   +----------+----------+
   | Property | Value    |
   +----------+----------+
   | deadline | 01/30/16 |
   +----------+----------+

You also can unset the metadata using
**manila metadata <share_name> unset <metadata_key(s)>**.

Reset share state
-----------------

As administrator, you can reset the state of a share.

Use **manila reset-state [--state <state>] <share>** command to reset share
state, where ``state`` indicates which state to assign the share. Options
include ``available``, ``error``, ``creating``, ``deleting``,
``error_deleting`` states.

.. code-block:: console

   $ manila reset-state Share2 --state deleting

   $ manila show Share2
   +----------------------+----------------------------------------------------------------------+
   | Property             | Value                                                                |
   +----------------------+----------------------------------------------------------------------+
   | status               | deleting                                                             |
   | share_type_name      | default                                                              |
   | description          | My second share. Updated                                             |
   | availability_zone    | nova                                                                 |
   | share_network_id     | c895fe26-92be-4152-9e6c-f2ad230efb13                                 |
   | export_locations     |                                                                      |
   |                      | path = 10.254.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965 |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = False                                                |
   |                      | id = de6d4012-6158-46f0-8b28-4167baca51a7                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   |                      | path = 10.0.0.3:/shares/share-fe874928-39a2-441b-8d24-29e6f0fde965   |
   |                      | preferred = False                                                    |
   |                      | is_admin_only = True                                                 |
   |                      | id = 602d0f5c-921b-4e45-bfdb-5eec8a89165a                            |
   |                      | share_instance_id = fe874928-39a2-441b-8d24-29e6f0fde965             |
   | share_server_id      | 2e9d2d02-883f-47b5-bb98-e053b8d1e683                                 |
   | host                 | manila@london#LONDON                                                 |
   | access_rules_status  | active                                                               |
   | snapshot_id          | None                                                                 |
   | is_public            | False                                                                |
   | task_state           | None                                                                 |
   | snapshot_support     | True                                                                 |
   | id                   | 195e3ba2-9342-446a-bc93-a584551de0ac                                 |
   | size                 | 1                                                                    |
   | name                 | Share2                                                               |
   | share_type           | bf6ada49-990a-47c3-88bc-c0cb31d5c9bf                                 |
   | has_replicas         | False                                                                |
   | replication_type     | None                                                                 |
   | created_at           | 2016-03-25T12:13:40.000000                                           |
   | share_proto          | NFS                                                                  |
   | consistency_group_id | None                                                                 |
   | project_id           | 907004508ef4447397ce6741a8f037c1                                     |
   | metadata             | {u'deadline': u'01/30/16'}                                           |
   +----------------------+----------------------------------------------------------------------+

Delete and force-delete share
-----------------------------

You also can force-delete a share.
The shares cannot be deleted in transitional states. The transitional
states are ``creating``, ``deleting``, ``managing``, ``unmanaging``,
``migrating``, ``extending``, and ``shrinking`` statuses for the shares.
Force-deletion deletes an object in any state. Use the ``policy.json`` file
to grant permissions for this action to other roles.

.. tip::

   The configuration file ``policy.json`` may be used from different places.
   The path ``/etc/manila/policy.json`` is one of expected paths by default.

Use **manila delete <share_name_or_ID>** command to delete a specified share:

.. code-block:: console

   $ manila delete %share_name_or_id%

.. note::

   If you specified :ref:`the consistency group <shared_file_systems_cgroups>`
   while creating a share, you should provide the ``--consistency-group``
   parameter to delete the share:

.. code-block:: console

   $ manila delete %share_name_or_id% --consistency-group %consistency-group-id%


If you try to delete the share in one of the transitional
state using soft-deletion you'll get an error:

.. code-block:: console

   $ manila delete Share2
   Delete for share 195e3ba2-9342-446a-bc93-a584551de0ac failed: Invalid share: Share status must be one of ('available', 'error', 'inactive'). (HTTP 403) (Request-ID: req-9a77b9a0-17d2-4d97-8a7a-b7e23c27f1fe)
   ERROR: Unable to delete any of the specified shares.

A share cannot be deleted in a transitional status, that it why an error from
``python-manilaclient`` appeared.

Print the list of all shares for all projects:

.. code-block:: console

   $ manila list --all-tenants
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | ID                                   | Name    | Size | Share Proto | Status    | Is Public | Share Type Name | Host                 | Availability Zone |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 | Share1  | 1    | NFS         | available | False     | my_type         | manila@paris#epsilon | nova              |
   | 195e3ba2-9342-446a-bc93-a584551de0ac | Share2  | 1    | NFS         | available | False     | default         | manila@london#LONDON | nova              |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+

Force-delete Share2 and check that it is absent in the list of shares,
run:

.. code-block:: console

   $ manila force-delete Share2

   $ manila list
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | ID                                   | Name    | Size | Share Proto | Status    | Is Public | Share Type Name | Host                 | Availability Zone |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+
   | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 | Share1  | 1    | NFS         | available | False     | my_type         | manila@paris#epsilon | nova              |
   +--------------------------------------+---------+------+-------------+-----------+-----------+-----------------+----------------------+-------------------+

.. _access_to_share:

Manage access to share
----------------------

The Shared File Systems service allows to grant or deny access to a specified
share, and list the permissions for a specified share.

To grant or deny access to a share, specify one of these supported share
access levels:

- **rw**. Read and write (RW) access. This is the default value.

- **ro**. Read-only (RO) access.

You must also specify one of these supported authentication methods:

- **ip**. Authenticates an instance through its IP address. A valid
  format is ``XX.XX.XX.XX`` or ``XX.XX.XX.XX/XX``. For example ``0.0.0.0/0``.

- **user**. Authenticates by a specified user or group name. A valid value is
  an alphanumeric string that can contain some special characters and is from
  4 to 32 characters long.

- **cert**. Authenticates an instance through a TLS certificate. Specify the
  TLS identity as the IDENTKEY. A valid value is any string up to 64 characters
  long in the common name (CN) of the certificate. The meaning of a string
  depends on its interpretation.

- **cephx**. Ceph authentication system. Specify the Ceph auth ID that needs
  to be authenticated and authorized for share access by the Ceph back end. A
  valid value must be non-empty, consist of ASCII printable characters, and not
  contain periods.

Try to mount NFS share with export path
``10.0.0.4:/shares/manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9`` on the
node with IP address ``10.0.0.13``:

.. code-block:: console

   $ sudo mount -v -t nfs 10.0.0.4:/shares/manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9 /mnt/
   mount.nfs: timeout set for Tue Oct  6 10:37:23 2015
   mount.nfs: trying text-based options 'vers=4,addr=10.0.0.4,clientaddr=10.0.0.13'
   mount.nfs: mount(2): Permission denied
   mount.nfs: access denied by server while mounting 10.0.0.4:/shares/manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9

An error message "Permission denied" appeared, so you are not allowed to mount
a share without an access rule. Allow access to the share with ``ip`` access
type and ``10.0.0.13`` IP address:

.. code-block:: console

   $ manila access-allow Share1 ip 10.0.0.13 --access-level rw
   +--------------+--------------------------------------+
   | Property     | Value                                |
   +--------------+--------------------------------------+
   | share_id     | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 |
   | access_type  | ip                                   |
   | access_to    | 10.0.0.13                            |
   | access_level | rw                                   |
   | state        | new                                  |
   | id           | de715226-da00-4cfc-b1ab-c11f3393745e |
   +--------------+--------------------------------------+

Try to mount a share again. This time it is mounted successfully:

.. code-block:: console

   $ sudo mount -v -t nfs 10.0.0.4:/shares/manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9 /mnt/

Since it is allowed node on 10.0.0.13 read and write access, try to create
a file on a mounted share:

.. code-block:: console

   $ cd /mnt
   $ ls
   lost+found
   $ touch my_file.txt

Connect via SSH to the ``10.0.0.4`` node and check new file `my_file.txt`
in the ``/shares/manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9`` directory:

.. code-block:: console

   $ ssh 10.0.0.4
   $ cd /shares
   $ ls
   manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9
   $ cd manila_share_a5fb1ab7_0bbd_465b_ac14_05706294b6e9
   $ ls
   lost+found  my_file.txt

You have successfully created a file from instance that was given access by
its IP address.

Allow access to the share with ``user`` access type:

.. code-block:: console

   $ manila access-allow Share1 user demo --access-level rw
   +--------------+--------------------------------------+
   | Property     | Value                                |
   +--------------+--------------------------------------+
   | share_id     | 10f5a2a1-36f5-45aa-a8e6-00e94e592e88 |
   | access_type  | user                                 |
   | access_to    | demo                                 |
   | access_level | rw                                   |
   | state        | new                                  |
   | id           | 4f391c6b-fb4f-47f5-8b4b-88c5ec9d568a |
   +--------------+--------------------------------------+

.. note::

   Different share features are supported by different share drivers.
   For the example, the Generic driver with the Block Storage service as a
   back-end doesn't support ``user`` and ``cert`` authentications methods. For
   details of supporting of features by different drivers, see `Manila share
   features support mapping <https://docs.openstack.org/developer/manila/devref
   /share_back_ends_feature_support_mapping.html>`_.

To verify that the access rules (ACL) were configured correctly for a share,
you list permissions for a share:

.. code-block:: console

   $ manila access-list Share1
   +--------------------------------------+-------------+------------+--------------+--------+
   | id                                   | access type | access to  | access level | state  |
   +--------------------------------------+-------------+------------+--------------+--------+
   | 4f391c6b-fb4f-47f5-8b4b-88c5ec9d568a | user        | demo       | rw           | error  |
   | de715226-da00-4cfc-b1ab-c11f3393745e | ip          | 10.0.0.13  | rw           | active |
   +--------------------------------------+-------------+------------+--------------+--------+

Deny access to the share and check that deleted access rule is absent in the
access rule list:

.. code-block:: console

   $ manila access-deny Share1 de715226-da00-4cfc-b1ab-c11f3393745e

   $ manila access-list Share1
   +--------------------------------------+-------------+-----------+--------------+-------+
   | id                                   | access type | access to | access level | state |
   +--------------------------------------+-------------+-----------+--------------+-------+
   | 4f391c6b-fb4f-47f5-8b4b-88c5ec9d568a | user        | demo      | rw           | error |
   +--------------------------------------+-------------+-----------+--------------+-------+
