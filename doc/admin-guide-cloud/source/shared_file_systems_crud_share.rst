.. _shared_file_systems_crud_share:

======================
Share basic operations
======================

General concepts
----------------

As general concepts, to create a file share and access it you need to:

#. To create a share, use :command:`manila create` command and
   specify the required arguments: the size of the share and the shared file
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, or ``HDFS`` share file
   system protocols are supported.

#. You can also optionally specify the share network and the share type.

#. After the share becomes available, use the :command:`manila show` command
   to get the share export location.

#. After getting the share export location, you can create an
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
storage life cycle management:

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
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, or ``HDFS`` share file
   system protocols are supported.

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

   * The shared is created using the storage that is specified in the found
     back end.

#. After the share becomes available, use the :command:`manila show` command
   to get the share export location.

In the example to create a share, the created already share type named
``my_type`` with ``driver_handles_share_servers = False`` extra specification
is used.

Check share types that exist, run:

.. code-block:: console

   $ manila type-list

   +------+--------+-----------+------------------------------------+----------------------+
   | ID   | Name   | is_default| required_extra_specs               | optional_extra_specs |
   +------+--------+-----------+------------------------------------+----------------------+
   | le...| my_type| -         | driver_handles_share_servers:False | snapshot_support:True|
   +------+--------+-----------+------------------------------------+----------------------+

Create a private share with ``my_type`` share type, NFS shared file system
protocol, and size 1 GB:

.. code-block:: console

   $ manila create nfs 1 --name Share2 --description "My share" --share-type my_type

   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | None                                 |
   | share_type_name             | my_type                              |
   | description                 | My share                             |
   | availability_zone           | None                                 |
   | share_network_id            | None                                 |
   | export_locations            | []                                   |
   | share_server_id             | None                                 |
   | host                        | None                                 |
   | snapshot_id                 | None                                 |
   | is_public                   | False                                |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | bb9f0f28-4ca7-4fcb-a37c-9e3624584bec |
   | size                        | 1                                    |
   | name                        | Share2                               |
   | share_type                  | 1eafb65f-1987-44a9-9a98-20af91c95662 |
   | created_at                  | 2015-10-01T09:44:59.669010           |
   | export_location             | None                                 |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | None                                 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f     |
   | metadata                    | {}                                   |
   +-----------------------------+--------------------------------------+

New share ``Share2`` should have a status ``available``:

.. code-block:: console

   $ manila show Share2

   +-----------------------------+---------------------------------------------------------------+
   | Property                    | Value                                                         |
   +-----------------------------+---------------------------------------------------------------+
   | status                      | available                                                     |
   | share_type_name             | my_type                                                       |
   | description                 | My share                                                      |
   | availability_zone           | nova                                                          |
   | share_network_id            | None                                                          |
   | export_locations            | 10.254.0.7:/shares/share-d1a66eed-a724-4cbb-a886-2f97926bd3b3 |
   | share_server_id             | None                                                          |
   | host                        | manila@cannes#CANNES                                          |
   | snapshot_id                 | None                                                          |
   | is_public                   | False                                                         |
   | task_state                  | None                                                          |
   | snapshot_support            | True                                                          |
   | id                          | bb9f0f28-4ca7-4fcb-a37c-9e3624584bec                          |
   | size                        | 1                                                             |
   | name                        | Share2                                                        |
   | share_type                  | 1eafb65f-1987-44a9-9a98-20af91c95662                          |
   | created_at                  | 2015-10-01T09:44:59.000000                                    |
   | share_proto                 | NFS                                                           |
   | consistency_group_id        | None                                                          |
   | source_cgsnapshot_member_id | None                                                          |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f                              |
   | metadata                    | {}                                                            |
   +-----------------------------+---------------------------------------------------------------+

.. _create_share_in_share_server_mode:

Create a share in share servers mode
------------------------------------

To create a file share in share servers mode, you need to:

#. To create a share, use :command:`manila create` command and
   specify the required arguments: the size of the share and the shared file
   system protocol. ``NFS``, ``CIFS``, ``GlusterFS``, or ``HDFS`` share file
   system protocols are supported.

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

   +------+--------+-----------+-----------+----------------------------------+----------------------+
   | ID   | Name   | Visibility| is_default| required_extra_specs             | optional_extra_specs |
   +------+--------+-----------+-----------+----------------------------------+----------------------+
   | c0...| default| public    | YES       | driver_handles_share_servers:True| snapshot_support:True|
   +------+--------+-----------+-----------+----------------------------------+----------------------+

Check share networks that exist, run:

.. code-block:: console

   $ manila share-network-list

   +--------------------------------------+--------------+
   | id                                   | name         |
   +--------------------------------------+--------------+
   | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a | my_share_net |
   +--------------------------------------+--------------+

Create a public share with ``my_share_net`` network, ``default``
share type, NFS shared file system protocol, and size 1 GB:

.. code-block:: console

   $ manila create nfs 1 --name "Share1" --description "My first share" --share-type default --share-network my_share_net --metadata aim=testing --public

   +-----------------------------+--------------------------------------+
   | Property                    | Value                                |
   +-----------------------------+--------------------------------------+
   | status                      | None                                 |
   | share_type_name             | default                              |
   | description                 | My first share                       |
   | availability_zone           | None                                 |
   | share_network_id            | None                                 |
   | export_locations            | []                                   |
   | share_server_id             | None                                 |
   | host                        | None                                 |
   | snapshot_id                 | None                                 |
   | is_public                   | True                                 |
   | task_state                  | None                                 |
   | snapshot_support            | True                                 |
   | id                          | aca648eb-8c03-4394-a5cc-755066b7eb66 |
   | size                        | 1                                    |
   | name                        | Share1                               |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86 |
   | created_at                  | 2015-09-24T12:19:06.925951           |
   | export_location             | None                                 |
   | share_proto                 | NFS                                  |
   | consistency_group_id        | None                                 |
   | source_cgsnapshot_member_id | None                                 |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f     |
   | metadata                    | {u'aim': u'testing'}                 |
   +-----------------------------+--------------------------------------+

The share also can be created from a share snapshot. For details, see
:ref:`shared_file_systems_snapshots`.

See the share in a share list:

.. code-block:: console

   $ manila list

   +----+-------+-----+------------+-----------+-------------------------------+----------------------+
   | ID | Name  | Size| Share Proto| Share Type| Export location               | Host                 |
   +----+-------+-----+------------+-----------+-------------------------------+----------------------+
   | a..| Share1| 1   | NFS        | c0086...  | 10.254.0.3:/shares/share-2d5..| manila@generic1#GEN..|
   +----+-------+-----+------------+-----------+-------------------------------+----------------------+

Check the share status and see the share export location. After ``creating``
status share should have status ``available``:

.. code-block:: console

   $ manila show Share1

   +-----------------------------+-------------------------------------------+
   | Property                    | Value                                     |
   +-----------------------------+-------------------------------------------+
   | status                      | available                                 |
   | share_type_name             | default                                   |
   | description                 | My first share                            |
   | availability_zone           | nova                                      |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a      |
   | export_locations            | 10.254.0.3:/shares/share-2d5e2c0a-1f84... |
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961      |
   | host                        | manila@generic1#GENERIC1                  |
   | snapshot_id                 | None                                      |
   | is_public                   | True                                      |
   | task_state                  | None                                      |
   | snapshot_support            | True                                      |
   | id                          | aca648eb-8c03-4394-a5cc-755066b7eb66      |
   | size                        | 1                                         |
   | name                        | Share1                                    |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86      |
   | created_at                  | 2015-09-24T12:19:06.000000                |
   | share_proto                 | NFS                                       |
   | consistency_group_id        | None                                      |
   | source_cgsnapshot_member_id | None                                      |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f          |
   | metadata                    | {u'aim': u'testing'}                      |
   +-----------------------------+-------------------------------------------+

``is_public`` defines the level of visibility for the share: whether other
tenants can or cannot see the share. By default, the share is private.

Update share
------------

Update the name, or description, or level of visibility for all tenants for
the share if you need:

.. code-block:: console

   $ manila update Share1 --description "My first share. Updated" --is-public False

   $ manila show Share1

   +-----------------------------+--------------------------------------------+
   | Property                    | Value                                      |
   +-----------------------------+--------------------------------------------+
   | status                      | available                                  |
   | share_type_name             | default                                    |
   | description                 | My first share. Updated                    |
   | availability_zone           | nova                                       |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a       |
   | export_locations            | 10.254.0.3:/shares/share-2d5e2c0a-1f84-... |
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961       |
   | host                        | manila@generic1#GENERIC1                   |
   | snapshot_id                 | None                                       |
   | is_public                   | False                                      |
   | task_state                  | None                                       |
   | snapshot_support            | True                                       |
   | id                          | aca648eb-8c03-4394-a5cc-755066b7eb66       |
   | size                        | 1                                          |
   | name                        | Share1                                     |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86       |
   | created_at                  | 2015-09-24T12:19:06.000000                 |
   | share_proto                 | NFS                                        |
   | consistency_group_id        | None                                       |
   | source_cgsnapshot_member_id | None                                       |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f           |
   | metadata                    | {u'aim': u'testing'}                       |
   +-----------------------------+--------------------------------------------+

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

.. _share_metadata:

Share metadata
--------------

If you want to set the metadata key-value pairs on the share, run:

.. code-block:: console

   $ manila metadata Share1 set project=my_abc deadline=01/20/16

Get all metadata key-value pairs of the share:

.. code-block:: console

   $ manila metadata-show Share1

   +----------+----------+
   | Property | Value    |
   +----------+----------+
   | aim      | testing  |
   | project  | my_abc   |
   | deadline | 01/20/16 |
   +----------+----------+

You can update the metadata:

.. code-block:: console

   $ manila metadata-update-all Share1 deadline=01/30/16

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

   +-----------------------------+-------------------------------------------+
   | Property                    | Value                                     |
   +-----------------------------+-------------------------------------------+
   | status                      | deleting                                  |
   | share_type_name             | default                                   |
   | description                 | Share from a snapshot.                    |
   | availability_zone           | nova                                      |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a      |
   | export_locations            | []                                        |
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961      |
   | host                        | manila@generic1#GENERIC1                  |
   | snapshot_id                 | 962e8126-35c3-47bb-8c00-f0ee37f42ddd      |
   | is_public                   | False                                     |
   | task_state                  | None                                      |
   | snapshot_support            | True                                      |
   | id                          | b6b0617c-ea51-4450-848e-e7cff69238c7      |
   | size                        | 1                                         |
   | name                        | Share2                                    |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86      |
   | created_at                  | 2015-09-25T06:25:50.000000                |
   | export_location             | 10.254.0.3:/shares/share-1dc2a471-3d47-...|
   | share_proto                 | NFS                                       |
   | consistency_group_id        | None                                      |
   | source_cgsnapshot_member_id | None                                      |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f          |
   | metadata                    | {u'source': u'snapshot'}                  |
   +-----------------------------+-------------------------------------------+

Delete and force-delete share
-----------------------------

You also can force-delete a share.
The shares cannot be deleted in transitional states. The transitional
states are ``creating``, ``deleting``, ``managing``, ``unmanaging``,
``extending``, and ``shrinking`` statuses for the shares. Force-deletion
deletes an object in any state. Use the ``policy.json`` file to grant
permissions for this action to other roles.

.. tip::

   The configuration file ``policy.json`` may be used from different places.
   The path ``/etc/manila/policy.json`` is one of expected paths by default.

Use **manila delete <share_name_or_ID>** command to delete a specified share:

.. code-block:: console

   $ manila delete Share2

.. note::

   If you specified :ref:`the consistency group <shared_file_systems_cgroups>`
   while creating a share, you should provide the :option:`--consistency-group`
   parameter to delete the share:

.. code-block:: console

   $ manila delete ba52454e-2ea3-47fa-a683-3176a01295e6 --consistency-group ffee08d9-c86c-45e5-861e-175c731daca2


If you try to delete the share in one of the transitional
state using soft-deletion you'll get an error:

.. code-block:: console

   $ manila delete b6b0617c-ea51-4450-848e-e7cff69238c7
   Delete for share b6b0617c-ea51-4450-848e-e7cff69238c7 failed: Invalid share: Share status must be one of ('available', 'error', 'inactive'). (HTTP 403) (Request-ID: req-9a77b9a0-17d2-4d97-8a7a-b7e23c27f1fe)
   ERROR: Unable to delete any of the specified shares.

A share cannot be deleted in a transitional status, that it why an error from
``python-manilaclient`` appeared.

Print the list of all shares for all tenants:

.. code-block:: console

   $ manila list --all-tenants

   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+
   | ID   | Name  | Size| Share Proto| Status| Share Type| Export location             | Host        |
   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+
   | aca..| Share1| 1   | NFS        | avai..| c008658...| 10.254.0.3:/shares/share-...| manila@gen..|
   | b6b..| Share2| 1   | NFS        | dele..| c008658...| 10.254.0.3:/shares/share-...| manila@gen..|
   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+

Force-delete Share2 and check that it is absent in the list of shares,
run:

.. code-block:: console

   $ manila force-delete b6b0617c-ea51-4450-848e-e7cff69238c7

   $ manila list

   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+
   | ID   | Name  | Size| Share Proto| Status| Share Type| Export location             | Host        |
   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+
   | aca..| Share1| 1   | NFS        | avai..| c008658...| 10.254.0.3:/shares/share-...| manila@gen..|
   +------+-------+-----+------------+-------+-----------+-----------------------------+-------------+

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

- **cert**. Authenticates an instance through a TLS certificate. Specify the
  TLS identity as the IDENTKEY. A valid value is any string up to 64 characters
  long in the common name (CN) of the certificate. The meaning of a string
  depends on its interpretation.

- **user**. Authenticates by a specified user or group name. A valid value is
  an alphanumeric string that can contain some special characters and is from
  4 to 32 characters long.

Try to mount NFS share with export path
``10.254.0.5:/shares/share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a`` on the
node with IP address ``10.254.0.4``:

.. code-block:: console

   $ sudo mount -v -t nfs 10.254.0.5:/shares/share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a /mnt/
   mount.nfs: timeout set for Tue Oct  6 10:37:23 2015
   mount.nfs: trying text-based options 'vers=4,addr=10.254.0.5,clientaddr=10.254.0.4'
   mount.nfs: mount(2): Permission denied
   mount.nfs: access denied by server while mounting 10.254.0.5:/shares/share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a

An error message "Permission denied" appeared, so you are not allowed to mount
a share without an access rule. Allow access to the share with ``ip`` access
type and ``10.254.0.4`` IP address:

.. code-block:: console

   $ manila access-allow Share2 ip 10.254.0.4 --access-level rw

   +--------------+--------------------------------------+
   | Property     | Value                                |
   +--------------+--------------------------------------+
   | share_id     | 7bcd888b-681b-4836-ac9c-c3add4e62537 |
   | access_type  | ip                                   |
   | access_to    | 10.254.0.4                           |
   | access_level | rw                                   |
   | state        | new                                  |
   | id           | de715226-da00-4cfc-b1ab-c11f3393745e |
   +--------------+--------------------------------------+

Try to mount a share again. This time it is mounted successfully:

.. code-block:: console

   $ sudo mount -v -t nfs 10.254.0.5:/shares/share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a /mnt/

Since it is allowed node on 10.254.0.4 read and write access, try to create
a file on a mounted share:

.. code-block:: console

   $ cd /mnt
   $ ls
   lost+found
   $ touch my_file.txt

Connect via SSH to the 10.254.0.5 node and check new file `my_file.txt`
in the ``/shares/share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a`` directory:

.. code-block:: console

   $ ssh manila@10.254.0.5
   $ cd /shares
   $ ls
   share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a
   $ cd share-5789ddcf-35c9-4b64-a28a-7f6a4a574b6a
   $ ls
   lost+found  my_file.txt

You have successfully created a file from instance that was given access by
its IP address.

Allow access to the share with ``user`` access type:

.. code-block:: console

   $ manila access-allow Share2 user demo --access-level rw

   +--------------+--------------------------------------+
   | Property     | Value                                |
   +--------------+--------------------------------------+
   | share_id     | 7bcd888b-681b-4836-ac9c-c3add4e62537 |
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
   features support mapping <http://docs.openstack.org/developer/manila/devref
   /share_back_ends_feature_support_mapping.html>`_.

To verify that the access rules (ACL) were configured correctly for a share,
you list permissions for a share:

.. code-block:: console

   $ manila access-list Share2

   +--------------------------------------+-------------+------------+--------------+--------+
   | id                                   | access type | access to  | access level | state  |
   +--------------------------------------+-------------+------------+--------------+--------+
   | 4f391c6b-fb4f-47f5-8b4b-88c5ec9d568a | user        | demo       | rw           | error  |
   | de715226-da00-4cfc-b1ab-c11f3393745e | ip          | 10.254.0.4 | rw           | active |
   +--------------------------------------+-------------+------------+--------------+--------+

Deny access to the share and check that deleted access rule is absent in the
access rule list:

.. code-block:: console

   $ manila access-deny Share2 de715226-da00-4cfc-b1ab-c11f3393745e

   $ manila access-list Share2

   +--------------------------------------+-------------+-----------+--------------+-------+
   | id                                   | access type | access to | access level | state |
   +--------------------------------------+-------------+-----------+--------------+-------+
   | 4f391c6b-fb4f-47f5-8b4b-88c5ec9d568a | user        | demo      | rw           | error |
   +--------------------------------------+-------------+-----------+--------------+-------+
