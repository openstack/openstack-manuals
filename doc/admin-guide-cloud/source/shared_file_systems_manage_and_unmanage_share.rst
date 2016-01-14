.. _shared_file_systems_manage_and_unmanage_share:

=========================
Manage and unmanage share
=========================

To ``manage`` a share means that an administrator rather than a share driver
manages the storage lifecycle. This approach is appropriate when an
administrator already has the custom non-manila share with its size, shared
file system protocol, export path and so on, and administrator wants to
register it in the Shared File System service.

To ``unmanage`` a share means to unregister a specified share from the Shared
File Systems service. An administrator can manage the custom share back.

.. _unmanage_share:

Unmanage share
--------------
You can ``unmanage`` a share, to unregister it from the Shared File System
service, and take manual control on share lifecycle. The ``unmanage``
operation is not supported for shares that were created on top of share servers
and created with share networks), so share service should have option
``driver_handles_share_servers = False`` in its configuration. You can unmanage
a share that has no dependent snapshots.

To unmanage managed share, run :command:`manila unmanage <share>` command.
Then try to print the information about it. The expected behavior is that
Shared File Systems service won't find the share:

.. code-block:: console

   $ manila unmanage Share3
   $ manila show Share3
   ERROR: No share with a name or ID of 'Share3' exists.

.. _manage_share:

Manage share
------------
To register the non-managed share in File System service you need to run
:command:`manila manage` command which has such arguments:

.. code-block:: console

   manila manage [--name <name>] [--description <description>]
                 [--share_type <share-type>]
                 [--driver_options [<key=value> [<key=value> ...]]]
                 <service_host> <protocol> <export_path>

The positional arguments are:

- service_host. The manage-share service host in this format:
  ``host@backend#POOL`` which consists of the host name for the back end,
  the name of the back end and the pool name for the back end.

- protocol. The Shared File Systems protocol of the share to manage. A valid
  value is NFS, CIFS, GlusterFS, or HDFS.

- export_path. The share export path in the format appropriate for the
  protocol:

  - NFS protocol. 10.0.0.1:/foo_path.

  - CIFS protocol. \\\\10.0.0.1\\foo_name_of_cifs_share.

  - HDFS protocol. hdfs://10.0.0.1:foo_port/foo_share_name.

  - GlusterFS. 10.0.0.1:/foo_volume.

The ``driver_options`` is an optional set of one or more key and value pairs,
that describe driver options. Note that the share type must have
``driver_handles_share_servers = False`` option, so special share type named
``for_managing`` was used in example.

To manage share, run:

.. code-block:: console

   $ manila manage manila@cannes#CANNES nfs 10.254.0.7:/shares/share-d1a66eed-a724-4cbb-a886-2f97926bd3b3 --name Share --description "We manage share." --share_type for_managing
   +-----------------------------+---------------------------------------------------------------+
   | Property                    | Value                                                         |
   +-----------------------------+---------------------------------------------------------------+
   | status                      | manage_starting                                               |
   | share_type_name             | for_managing                                                  |
   | description                 | We manage share.                                              |
   | availability_zone           | None                                                          |
   | share_network_id            | None                                                          |
   | export_locations            | []                                                            |
   | share_server_id             | None                                                          |
   | host                        | manila@cannes#CANNES                                          |
   | snapshot_id                 | None                                                          |
   | is_public                   | False                                                         |
   | task_state                  | None                                                          |
   | snapshot_support            | True                                                          |
   | id                          | 5c1f644a-6521-4699-b480-b03d17e2d21d                          |
   | size                        | None                                                          |
   | name                        | Share3                                                        |
   | share_type                  | 1eafb65f-1987-44a9-9a98-20af91c95662                          |
   | created_at                  | 2015-10-01T10:35:52.000000                                    |
   | export_location             | 10.254.0.7:/shares/share-d1a66eed-a724-4cbb-a886-2f97926bd3b3 |
   | share_proto                 | NFS                                                           |
   | consistency_group_id        | None                                                          |
   | source_cgsnapshot_member_id | None                                                          |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f                              |
   | metadata                    | {}                                                            |
   +-----------------------------+---------------------------------------------------------------+

Check that the share is available:

.. code-block:: console

   $ manila show Share
   +-----------------------------+---------------------------------------------------------------+
   | Property                    | Value                                                         |
   +-----------------------------+---------------------------------------------------------------+
   | status                      | available                                                     |
   | share_type_name             | for_managing                                                  |
   | description                 | We manage share.                                              |
   | availability_zone           | nova                                                          |
   | share_network_id            | None                                                          |
   | export_locations            | 10.254.0.7:/shares/share-d1a66eed-a724-4cbb-a886-2f97926bd3b3 |
   | share_server_id             | None                                                          |
   | host                        | manila@cannes#CANNES                                          |
   | snapshot_id                 | None                                                          |
   | is_public                   | False                                                         |
   | task_state                  | None                                                          |
   | snapshot_support            | True                                                          |
   | id                          | 5c1f644a-6521-4699-b480-b03d17e2d21d                          |
   | size                        | 1                                                             |
   | name                        | Share3                                                        |
   | share_type                  | 1eafb65f-1987-44a9-9a98-20af91c95662                          |
   | created_at                  | 2015-10-01T10:35:52.000000                                    |
   | share_proto                 | NFS                                                           |
   | consistency_group_id        | None                                                          |
   | source_cgsnapshot_member_id | None                                                          |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f                              |
   | metadata                    | {}                                                            |
   +-----------------------------+---------------------------------------------------------------+
